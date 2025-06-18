import 'package:http/http.dart' as http;
import 'package:kredipal/constant/api_url.dart';
import 'dart:convert';
import '../models/dashboard_model.dart';

class DashboardApiService {

  Future<DashboardModel> fetchDashboardData({
    required String token,
    String? dateFilter,
    String? startDate,
    String? endDate,
    String? leadType,
    String? status,
  }) async {
    final queryParameters = {
      if (dateFilter != null) 'date_filter': dateFilter,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (leadType != null) 'lead_type': leadType,
      if (status != null) 'status': status,
    };

    final url = Uri.parse('${ApiUrl.baseUrl}/api/dashboard').replace(queryParameters: queryParameters);

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print('Filtered dashboard data: ${response.body}');
      return DashboardModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load filtered dashboard');
    }
  }
}
