import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../constant/api_url.dart';
import '../models/all_leads_model.dart';
import '../models/all_task_model.dart';

class ApiService {

  Future<Map<String, dynamic>> logIn(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiUrl.baseUrl}/api/auth/login'),
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

  Future<Map<String, dynamic>> getUserProfile(String token) async {
    final response = await http.get(
      Uri.parse('${ApiUrl.baseUrl}/api/user'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data; // This will be your user object
    } else {
      throw Exception('Failed to load user profile');
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
      Uri.parse('${ApiUrl.baseUrl}/api/profile'),
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

  static Future<Map<String, dynamic>> updateProfilePhoto(
      File file, String token) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${ApiUrl.baseUrl}/api/profile/photo'),
    );

    request.headers['Authorization'] = 'Bearer $token';
    request.files
        .add(await http.MultipartFile.fromPath('profile_photo', file.path));

    final response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 422) {
      final resString = await response.stream.bytesToString();
      return jsonDecode(resString);
    } else {
      throw Exception('Failed to upload image');
    }
  }

  Future<Map<String, dynamic>> changePassword({
    required String token,
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final uri =
        Uri.parse("${ApiUrl.baseUrl}/api/change-password"); // Adjust endpoint if needed

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
    String? filePath,
  }) async {
    var uri = Uri.parse('${ApiUrl.baseUrl}/api/leads');
    var request = http.MultipartRequest('POST', uri);

    request.headers['Authorization'] = 'Bearer $token';

    // Add form fields
    leadData.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    // Attach voice file if present
    if (filePath != null && File(filePath).existsSync()) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'voice_recording', // your backend field name
          filePath,
        ),
      );
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('the voice error is ${response.body}');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create lead: ${response.statusCode} - ${response.body}');
    }
  }



  Future<AllLeadsList> fetchAllLeads({required String token}) async {
    final response = await http.get(
      Uri.parse('${ApiUrl.baseUrl}/api/leads'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      print('${response.body}');
      return AllLeadsList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch leads');
    }
  }

  static Future<Map<String, dynamic>> markAttendanceCheckIn({
    required String token,
    required String checkinImage,
    required String location,
    required String coordinates,
    required String notes,
  }) async {
    var uri = Uri.parse("${ApiUrl.baseUrl}/api/attendances");

    var request = http.MultipartRequest("POST", uri);
    request.headers['Authorization'] = 'Bearer $token';
    request.fields['location'] = location;
    request.fields['coordinates'] = coordinates;
    request.fields['notes'] = notes;

    // Attach image
    request.files
        .add(await http.MultipartFile.fromPath('checkin_image', checkinImage));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    print('the checkin msg is ${response.body}');

    if (response.statusCode == 200) {
      return {
        'status': 'success',
        'message': 'Checked in successfully',
      };
    } else {
      return {
        'status': 'error',
        'message': 'Check-in failed: ${response.body}',
      };
    }
  }

  // Get all tasks
  Future<List<Task>> getTasks(String token) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiUrl.baseUrl}/api/tasks'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['status'] == 'success') {
          final List<dynamic> tasksJson = jsonData['data'];
          return tasksJson.map((json) => Task.fromJson(json)).toList();
        } else {
          throw Exception('Failed to load tasks: ${jsonData['message']}');
        }
      } else {
        throw Exception('Failed to load tasks: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching tasks: $e');
    }
  }

  // Update task status and progress

  static Future<bool> updateTask(
      String taskId, Map<String, dynamic> body, String token) async {
    final url = Uri.parse('${ApiUrl.baseUrl}/api/tasks/$taskId');

    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json', // 👈 Add this
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      print('the task edit ${response.body}');
      return true;
    } else {
      print("Update failed: ${response.body}");
      return false;
    }
  }
}
