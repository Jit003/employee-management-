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

  Future<AllLeadsList> getAllLeads() async {
    try {
      final response = await _dio.get('/api/leads');

      if (response.statusCode == 200) {
        print('the all leads list is ${response.data}');
        return AllLeadsList.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch leads: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<Leads> getLeadDetails(int leadId) async {
    try {
      final response = await _dio.get('/leads/$leadId');

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
}
