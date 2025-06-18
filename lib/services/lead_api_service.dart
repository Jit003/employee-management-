import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:get/get.dart';
import 'package:kredipal/constant/api_url.dart';
import 'package:kredipal/controller/login-controller.dart';
import '../models/all_leads_model.dart';

class LeadsApiService extends getx.GetxService {
  late Dio _dio;
  AuthController authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    _dio = Dio(BaseOptions(
      baseUrl: ApiUrl.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'Authorization': 'Bearer ${authController.token.value}'},

    ));

    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (obj) => print(obj),
    ));
  }

  Future<AllLeadsList> getAllLeads({
    String? leadType,
    String? status,
    String? dateFilter,
    String? startDate, // Add this
    String? endDate,   // Add this
  }) async {
    try {
      Map<String, dynamic> queryParams = {};

      if (leadType != null && leadType != 'All') {
        queryParams['lead_type'] = leadType;
      }
      if (status != null && status.toLowerCase() != 'all') {
        queryParams['status'] = status;
      }

      if (startDate != null && startDate.isNotEmpty) {
        queryParams['start_date'] = startDate; // Format: 'YYYY-MM-DD'
      }
      if (endDate != null && endDate.isNotEmpty) {
        queryParams['end_date'] = endDate;
      }

      // Add date_filter only if date range is selected
      if ((startDate != null && startDate.isNotEmpty) &&
          (endDate != null && endDate.isNotEmpty)) {
        queryParams['date_filter'] = 'date_range';
      }

      final response = await _dio.get('/api/leads', queryParameters: queryParams);

      if (response.statusCode == 200) {
        return AllLeadsList.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch leads: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Error fetching leads: $e');
    }
  }

  Future<Leads> getLeadDetails(int leadId) async {
    try {
      final response = await _dio.get('/api/leads/$leadId');

      if (response.statusCode == 200) {
        return Leads.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to fetch lead details: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }



  // GET lead details for editing
  Future<Leads> getLeadForEdit(int leadId) async {
    try {
      final response = await _dio.get('/api/leads/$leadId/edit');
      if (response.statusCode == 200 &&
          response.data['status'] == 'success') {
        return Leads.fromJson(response.data['data']['lead']);
      } else {
        throw Exception('Failed to fetch lead: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error fetching lead: $e');
    }
  }

  // PUT update lead
  Future<void> updateLead(int leadId, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/leads/$leadId', data: data);
      if (response.statusCode != 200 || response.data['status'] != 'success') {
        throw Exception('Failed to update lead: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Error updating lead: $e');
    }
  }




}
