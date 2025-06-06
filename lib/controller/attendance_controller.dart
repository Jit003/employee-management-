import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:kredipal/controller/login-controller.dart';
import 'package:kredipal/services/attendance_api_service.dart';
import '../models/attendance_model.dart';

enum AttendanceState {
  initial,
  camera,
  processing,
  checkedIn,
  checkedOut,
  error
}

class AttendanceController extends GetxController {
  final ApiService _apiService = Get.put(ApiService());
  final AuthController authController = Get.find<AuthController>();

  // Auth token - you should get this from your auth controller

  // Observable variables
  final Rx<AttendanceState> currentState = AttendanceState.initial.obs;
  final RxString errorMessage = ''.obs;
  final RxInt countdown = 3.obs; // Reduced countdown for better UX
  final RxString currentLocation = ''.obs;
  final RxString currentCoordinates = ''.obs;
  final Rx<AttendanceRecord?> todayAttendance = Rx<AttendanceRecord?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isCheckingIn = false.obs;
  final RxBool isCheckingOut = false.obs;
  final RxBool isLocationLoading = false.obs;

  // Camera related
  CameraController? cameraController;
  final RxBool isCameraInitialized = false.obs;
  Timer? countdownTimer;

  @override
  void onInit() {
    super.onInit();
    // Set token - replace with actual token from auth
    // Auto-fetch location on init
  }

  @override
  void onClose() {
    cameraController?.dispose();
    countdownTimer?.cancel();
    super.onClose();
  }

  Future<void> initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final frontCamera = cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      cameraController = CameraController(
        frontCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await cameraController!.initialize();
      isCameraInitialized.value = true;
      currentState.value = AttendanceState.camera;

      // Ensure location is available before starting countdown
      if (currentLocation.value.isEmpty || currentLocation.value == 'Fetching location...') {
        await getCurrentLocation();
      }

      // Start countdown for auto-capture
      startCountdown();
    } catch (e) {
      errorMessage.value = 'Failed to initialize camera: $e';
      currentState.value = AttendanceState.error;
    }
  }

  void startCountdown() {
    countdown.value = 3; // Reduced to 3 seconds
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 1) {
        countdown.value--;
      } else {
        timer.cancel();
        if (isCheckingIn.value) {
          captureAndCheckIn();
        } else if (isCheckingOut.value) {
          captureAndCheckOut();
        }
      }
    });
  }

  Future<void> startCheckIn() async {
    isCheckingIn.value = true;
    isCheckingOut.value = false;
    currentState.value = AttendanceState.initial;

    // Auto-fetch location before opening camera
    await getCurrentLocation();
    await initializeCamera();
  }

  Future<void> startCheckOut() async {
    // Check if we have a check-in record with ID
    if (todayAttendance.value?.id == null) {
      Get.snackbar(
        'Error',
        'No check-in record found. Please check-in first.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isCheckingIn.value = false;
    isCheckingOut.value = true;
    currentState.value = AttendanceState.initial;

    // Auto-fetch location before opening camera
    await getCurrentLocation();
    await initializeCamera();
  }

  Future<void> captureAndCheckIn() async {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      errorMessage.value = 'Camera not initialized';
      currentState.value = AttendanceState.error;
      return;
    }

    // Check if location is available
    if (currentLocation.value.isEmpty || currentLocation.value == 'Location unavailable') {
      errorMessage.value = 'Location not available. Please enable location services.';
      currentState.value = AttendanceState.error;
      return;
    }

    try {
      currentState.value = AttendanceState.processing;
      isLoading.value = true;

      // Capture image
      final XFile imageFile = await cameraController!.takePicture();

      // Perform check-in
      final response = await _apiService.checkIn(
        token: authController.token.value,
        image: File(imageFile.path),
        location: currentLocation.value,
        coordinates: currentCoordinates.value,
        notes: 'Checked in on time',
      );

      if (response.status == 'success') {
        todayAttendance.value = response.data;
        currentState.value = AttendanceState.checkedIn;

        // Show success dialog with check-in details
        _showSuccessDialog(
          'Check-in Successful!',
          'Time: ${_formatTime(response.data?.checkIn ?? '')}',
          'Location: ${response.data?.checkInLocation ?? ''}',
          Icons.login,
          Colors.green,
        );
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
      currentState.value = AttendanceState.error;
      Get.snackbar(
        'Check-in Failed',
        errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 4),
      );
    } finally {
      isLoading.value = false;
      isCheckingIn.value = false;
      cameraController?.dispose();
    }
  }

  Future<void> captureAndCheckOut() async {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      errorMessage.value = 'Camera not initialized';
      currentState.value = AttendanceState.error;
      return;
    }

    // Check if location is available
    if (currentLocation.value.isEmpty || currentLocation.value == 'Location unavailable') {
      errorMessage.value = 'Location not available. Please enable location services.';
      currentState.value = AttendanceState.error;
      return;
    }

    // Check if we have attendance ID
    if (todayAttendance.value?.id == null) {
      errorMessage.value = 'No check-in record found. Cannot check-out.';
      currentState.value = AttendanceState.error;
      return;
    }

    try {
      currentState.value = AttendanceState.processing;
      isLoading.value = true;

      // Capture image
      final XFile imageFile = await cameraController!.takePicture();

      // Perform check-out using the attendance ID
      final response = await _apiService.checkOut(
        token:authController. token.value,
        attendanceId: todayAttendance.value!.id!, // Pass the attendance ID
        image: File(imageFile.path),
        location: currentLocation.value,
        coordinates: currentCoordinates.value,
        notes: 'Checked out successfully',
      );

      if (response.status == 'success') {
        todayAttendance.value = response.data;
        currentState.value = AttendanceState.checkedOut;

        // Show success dialog with check-out details
        _showSuccessDialog(
          'Check-out Successful!',
          'Time: ${_formatTime(response.data?.checkOut ?? '')}',
          'Total Hours: ${_calculateWorkHours()}',
          Icons.logout,
          Colors.red,
        );
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
      currentState.value = AttendanceState.error;
      Get.snackbar(
        'Check-out Failed',
        errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 4),
      );
    } finally {
      isLoading.value = false;
      isCheckingOut.value = false;
      cameraController?.dispose();
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      isLocationLoading.value = true;
      currentLocation.value = 'Fetching location...';

      // Check permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied. Please enable in settings.');
      }

      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled. Please enable location services.');
      }

      // Get current position with high accuracy
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      currentCoordinates.value = '${position.latitude},${position.longitude}';

      // Get readable address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address = '';

        if (place.name != null && place.name!.isNotEmpty) {
          address += place.name!;
        }
        if (place.locality != null && place.locality!.isNotEmpty) {
          if (address.isNotEmpty) address += ', ';
          address += place.locality!;
        }
        if (place.administrativeArea != null && place.administrativeArea!.isNotEmpty) {
          if (address.isNotEmpty) address += ', ';
          address += place.administrativeArea!;
        }

        currentLocation.value = address.isNotEmpty ? address : 'Unknown Location';
      } else {
        currentLocation.value = 'Unknown Location';
      }

      print('Location fetched: ${currentLocation.value}');
      print('Coordinates: ${currentCoordinates.value}');

    } catch (e) {
      currentLocation.value = 'Location unavailable';
      currentCoordinates.value = '0.0,0.0';
      print('Location error: $e');

      Get.snackbar(
        'Location Error',
        e.toString(),
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLocationLoading.value = false;
    }
  }

  void _showSuccessDialog(String title, String time, String location, IconData icon, Color color) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(width: 12),
            Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(time, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Text(location, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  String _formatTime(String timeString) {
    if (timeString.isEmpty) return '--:--';
    try {
      DateTime dateTime = DateTime.parse(timeString).toLocal(); // 🔥 Convert to local time
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return '--:--';
    }
  }


  String _calculateWorkHours() {
    if (todayAttendance.value?.checkIn == null || todayAttendance.value?.checkOut == null) {
      return '--:--';
    }

    try {
      DateTime checkIn = DateTime.parse(todayAttendance.value!.checkIn!);
      DateTime checkOut = DateTime.parse(todayAttendance.value!.checkOut!);

      Duration difference = checkOut.difference(checkIn);
      int hours = difference.inHours;
      int minutes = difference.inMinutes.remainder(60);

      return '${hours}h ${minutes}m';
    } catch (e) {
      return '--:--';
    }
  }

  void resetState() {
    currentState.value = AttendanceState.initial;
    errorMessage.value = '';
    isCheckingIn.value = false;
    isCheckingOut.value = false;
    countdownTimer?.cancel();
    cameraController?.dispose();
  }



  // Getters for UI state
  bool get canCheckIn => todayAttendance.value?.checkIn == null;
  bool get canCheckOut => todayAttendance.value?.checkIn != null && todayAttendance.value?.checkOut == null;
  bool get isAttendanceComplete => todayAttendance.value?.checkIn != null && todayAttendance.value?.checkOut != null;
}
