import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kredipal/services/voice_service.dart';

import '../services/api_services.dart';
import 'login-controller.dart';

class AttendanceController extends GetxController {
  var isPunchedIn = false.obs;
  var punchInTime = Rxn<DateTime>();
  var punchOutTime = Rxn<DateTime>();
  var totalDuration = "".obs;
  var isProcessingLogin = false.obs;
  var isCameraInitialized = false.obs;
  final AuthController authController = Get.put(AuthController());

  CameraController? cameraController;

  /// Main function to handle both login and logout
  Future<void> togglePunch() async {
    isProcessingLogin.value = true;

    await startCamera();

    // Wait for 5 seconds simulating face detection
    await Future.delayed(const Duration(seconds: 5));

    // Take a picture BEFORE stopping the camera
    XFile? imageFile = await cameraController?.takePicture();

    await stopCamera();

    if (!isPunchedIn.value) {
      punchInTime.value = DateTime.now();
      punchOutTime.value = null;
      totalDuration.value = "";
      isPunchedIn.value = true;

      try {
        // Use imageFile?.path to get the local file path
        final response = await ApiService.markAttendanceCheckIn(
          token: authController.token.value,
          checkinImage: imageFile?.path ?? "", // You may need to upload this
          location: "Office Building, Bhubaneswar",
          coordinates: "19.0760, 72.8777",
          notes: "Checked in on time",
        );

        if (response['status'] == 'success') {
          speak("Login Successful");
          Fluttertoast.showToast(
            msg: "Log-in Successful",
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
        } else {
          Fluttertoast.showToast(msg: response['message']);
        }
      } catch (e) {
        print('the error is ${e.toString()}');
        Fluttertoast.showToast(msg: 'API Error: $e');
      }

    } else {
      punchOutTime.value = DateTime.now();
      calculateDuration();
      isPunchedIn.value = false;

      speak("Logout Successful");
      Fluttertoast.showToast(
        msg: "Log-out Successful",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }

    isProcessingLogin.value = false;
  }

  void calculateDuration() {
    if (punchInTime.value != null && punchOutTime.value != null) {
      final diff = punchOutTime.value!.difference(punchInTime.value!);
      final h = diff.inHours;
      final m = diff.inMinutes % 60;
      final s = diff.inSeconds % 60;
      totalDuration.value = "${h}h ${m}m ${s}s";
    }
  }

  String formatTime(DateTime? time) {
    if (time == null) return "--:--";
    return DateFormat('hh:mm:ss a').format(time);
  }

  Future<void> startCamera() async {
    try {
      final cameras = await availableCameras();
      final frontCam = cameras.firstWhere(
            (c) => c.lensDirection == CameraLensDirection.front,
      );

      cameraController = CameraController(frontCam, ResolutionPreset.medium);
      await cameraController!.initialize();

      isCameraInitialized.value = true;
    } catch (e) {
      isCameraInitialized.value = false;
      Fluttertoast.showToast(msg: 'Camera error: $e');
    }
  }

  Future<void> stopCamera() async {
    await cameraController?.dispose();
    cameraController = null;
    isCameraInitialized.value = false;
  }

  @override
  void onClose() {
    stopCamera();
    super.onClose();
  }
}
