import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:kredipal/constant/api_url.dart';
import '../models/attendance_model.dart';

class ApiService extends GetxService {


  Map<String, String> _getMultipartHeaders(String token) {
    return {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<AttendanceResponse> checkIn({
    required String token,
    required File image,
    required String location,
    required String coordinates,
    String? notes,
  }) async {
    try {
      final uri = Uri.parse('${ApiUrl.baseUrl}/api/attendances');

      print('Making check-in request to: $uri');

      var request = http.MultipartRequest('POST', uri);

      // Add headers
      request.headers.addAll(_getMultipartHeaders(token));

      // Add image file
      request.files.add(
        await http.MultipartFile.fromPath(
          'checkin_image',
          image.path,
          filename: 'checkin_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ),
      );

      // Add form fields
      request.fields['check_in_location'] = location;
      request.fields['check_in_coordinates'] = coordinates;
      if (notes != null && notes.isNotEmpty) {
        request.fields['notes'] = notes;
      }

      print('Request fields: ${request.fields}');

      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Request timeout');
        },
      );

      final response = await http.Response.fromStream(streamedResponse);

      print('Check-in response status: ${response.statusCode}');
      print('Check-in response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return AttendanceResponse.fromJson(jsonData);
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);
        throw Exception(errorData['message'] ?? 'Failed to check in: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in checkIn: $e');
      if (e.toString().contains('SocketException') || e.toString().contains('TimeoutException')) {
        throw Exception('Network error: Please check your internet connection');
      } else {
        throw Exception('Check-in failed: $e');
      }
    }
  }

  Future<AttendanceResponse> checkOut({
    required String token,
    required int attendanceId, // Add attendance ID parameter
    required File image,
    required String location,
    required String coordinates,
    String? notes,
  }) async {
    try {
      // Use attendance ID in the URL
      final uri = Uri.parse('${ApiUrl.baseUrl}/api/attendances/$attendanceId');

      print('Making check-out request to: $uri');

      var request = http.MultipartRequest('PUT', uri);

      // Add headers
      request.headers.addAll(_getMultipartHeaders(token));

      // Add image file
      request.files.add(
        await http.MultipartFile.fromPath(
          'checkout_image',
          image.path,
          filename: 'checkout_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ),
      );

      // Add form fields
      request.fields['check_out_location'] = location;
      request.fields['check_out_coordinates'] = coordinates;
      if (notes != null && notes.isNotEmpty) {
        request.fields['notes'] = notes;
      }

      print('Request fields: ${request.fields}');

      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Request timeout');
        },
      );

      final response = await http.Response.fromStream(streamedResponse);

      print('Check-out response status: ${response.statusCode}');
      print('Check-out response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return AttendanceResponse.fromJson(jsonData);
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);
        throw Exception(errorData['message'] ?? 'Failed to check out: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in checkOut: $e');
      if (e.toString().contains('SocketException') || e.toString().contains('TimeoutException')) {
        throw Exception('Network error: Please check your internet connection');
      } else {
        throw Exception('Check-out failed: $e');
      }
    }
  }
}
