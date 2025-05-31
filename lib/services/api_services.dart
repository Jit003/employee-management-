import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://192.168.29.183:8000';

  Future<http.Response> logIn(String email, String password) async {
    final url = Uri.parse('$baseUrl/api/auth/login');

    try {
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'email': email,
            'password': password,
          }));
      return response;
    } catch (error) {
      throw Exception('failed to login ${error}');
    }
  }
}
