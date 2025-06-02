import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/all_leads_list.dart';
import '../services/api_services.dart';
import 'login-controller.dart';

class LeadsController extends GetxController {
  var isLoading = false.obs;
  var leadsList = <Data>[].obs;

  final AuthController authController = Get.find();

  @override
  void onInit() {
    fetchLeads();
    super.onInit();
  }

  Future<void> fetchLeads() async {
    try {
      isLoading.value = true;
      final result = await ApiService().fetchAllLeads(token: authController.token.value);
      leadsList.value = result.data ?? [];
    } catch (e) {
      Get.snackbar("Error", "Failed to load leads", backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
