import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../models/all_leads_list.dart';

class ApiService {
  static const String baseUrl = 'https://crm.kredipal.com';

  Future<Map<String, dynamic>> logIn(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/auth/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200 && data['status'] == 'success') {
        return {
          'success': true,
          'user': data['user'],
          'token': data['token'],
          'message': data['message'],
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Login failed',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Exception: $e',
      };
    }
  }

  Future<Map<String, dynamic>> updateProfile({
    required String token,
    required String name,
    required String phone,
    required String address,
    File? imageFile,
  }) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/profile'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'name': name,
        'phone': phone,
        'address': address,
      }),
    );

    final data = json.decode(response.body);
    if (response.statusCode == 200 && data['status'] == 'success') {
      return {
        'success': true,
        'message': data['message'],
        'user': data['user'],
        'profile_photo_url': data['profile_photo_url'],
      };
    } else {
      return {
        'success': false,
        'message': data['message'] ?? 'Profile update failed',
      };
    }
  }

  // api_services.dart
  Future<Map<String, dynamic>> changePassword({
    required String token,
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final uri =
        Uri.parse("$baseUrl/api/change-password"); // Adjust endpoint if needed

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'current_password': currentPassword,
        'password': newPassword,
        'password_confirmation': confirmPassword,
      }),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && data['status'] == 'success') {
      return {'success': true, 'message': data['message']};
    } else {
      return {
        'success': false,
        'message': data['message'] ?? 'Something went wrong'
      };
    }
  }

  Future<Map<String, dynamic>> createLead({
    required String token,
    required Map<String, dynamic> leadData,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/leads'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(leadData),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('${response.body}');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create lead');
    }
  }

  Future<AllLeadsList> fetchAllLeads({required String token}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/leads'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      print('${response.body}');
      return AllLeadsList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch leads');
    }
  }

  static Future<dynamic> getTaskDetails(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/tasks'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body); // This might be List<dynamic>
      } else {
        throw Exception('Failed to load tasks');
      }
    } catch (e) {
      throw Exception('Failed to load tasks: $e');
    }
  }

  static Future<dynamic> markAttendanceCheckIn({
    required String token,
    required String checkinImage,
    required String location,
    required String coordinates,
    required String notes,
  }) async {
    var url = Uri.parse('$baseUrl/api/attendances');

    var request = http.MultipartRequest('POST', url);
    request.headers.addAll({
      'Authorization': 'Bearer $token',
    });

    request.fields['check_in_location'] = location;
    request.fields['check_in_coordinates'] = coordinates;
    request.fields['notes'] = notes;

    if (checkinImage.isNotEmpty) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'checkin_image',
          checkinImage,
        ),
      );
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('the attendance check in body is ${response.body}');
      return json.decode(response.body);
    } else {
      throw Exception('Failed to mark attendance: ${response.body}');
    }
  }
}
