import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart' as getx;

import '../models/finance_model.dart';

class FinanceDashboardApiService extends getx.GetxService {
  static const String baseUrl = 'http://crm.kredipal.com/api';

  Map<String, String> _getHeaders(String token) {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<FinanceDashboardData> getDashboardData({
    required String token,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/dashboard');

      print('Making dashboard request to: $uri');

      final response = await http.get(
        uri,
        headers: _getHeaders(token),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Request timeout');
        },
      );

      print('Dashboard response status: ${response.statusCode}');
      print('Dashboard response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return FinanceDashboardData.fromJson(jsonData['data']);
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Please login again');
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);
        throw Exception(errorData['message'] ?? 'Failed to fetch dashboard data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getDashboardData: $e');
      if (e.toString().contains('SocketException') || e.toString().contains('TimeoutException')) {
        throw Exception('Network error: Please check your internet connection');
      } else if (e.toString().contains('FormatException')) {
        throw Exception('Invalid response format from server');
      } else {
        throw Exception('Failed to fetch dashboard data: $e');
      }
    }
  }
}
