import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../routes/app_routes.dart';
import '../services/api_services.dart';
import 'login-controller.dart';

class AddLeadsController extends GetxController {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final locationController = TextEditingController();
  final companyNameController = TextEditingController();
  final leadAmountController = TextEditingController();
  final salaryController = TextEditingController();
  final remarksController = TextEditingController();

  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  RxString selectedSuccessRatio = ''.obs;
  RxString selectedMonth = ''.obs;
  final AuthController authController = Get.put(AuthController());

  List<String> successPer = ['50', '60', '70', '80', '90', '100'];
  List<String> expectedMonth = ['2025-11-01', '2025-12-01', '2026-01-01'];

  final isLoading = false.obs;

  void setDate(DateTime date) {
    selectedDate.value = date;
  }

  Future<void> createLead() async {
    if (selectedDate.value == null ||
        selectedSuccessRatio.value.isEmpty ||
        selectedMonth.value.isEmpty) {
      Get.snackbar("Error", "Please complete all fields",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    try {
      final body = {
        "name": nameController.text.trim(),
        "phone": phoneController.text.trim(),
        "email": emailController.text.trim(),
        "dob": DateFormat("yyyy-MM-dd").format(selectedDate.value!),
        "location": locationController.text.trim(),
        "company_name": companyNameController.text.trim(),
        "lead_amount": double.tryParse(leadAmountController.text) ?? 0.0,
        "salary": double.tryParse(salaryController.text) ?? 0.0,
        "success_percentage": int.tryParse(selectedSuccessRatio.value) ?? 0,
        "expected_month": selectedMonth.value,
        "remarks": remarksController.text.trim(),
        "status": "pending",
        "team_lead_id": authController.userData['team_lead_id'], // from login
      };
      print("Sending lead data: $body"); // 👈 Add this line


      final response = await ApiService().createLead(
        token: authController.token.value,
        leadData: body,
      );

      Get.snackbar("Success", response['message'],
          backgroundColor: Colors.green, colorText: Colors.white);

      Get.toNamed(AppRoutes.leadSavedSuccess);
    } catch (e) {
      print("Error during createLead: $e"); // 👈 Print error
      Get.snackbar("Error", "Failed to save  lead",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
