import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kredipal/controller/dashboard_controller.dart';
import 'package:kredipal/controller/voice_record_controller.dart';

import '../routes/app_routes.dart';
import '../services/api_services.dart';
import 'allleads_controller.dart';
import 'login-controller.dart';

class AddLeadsController extends GetxController {
  final AllLeadsController allLeadsController = Get.find<AllLeadsController>();
  final DashboardController dashboardController =
      Get.find<DashboardController>();

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
  RxString leadTypeValue = 'personal_loan'.obs;
  RxString selectedMonth = ''.obs;
  RxString selectedLocation = ''.obs;
  RxString voiceFilePath = ''.obs;
  final authController = Get.find<AuthController>();
  final VoiceRecorderController voiceRecorderController =
      Get.put(VoiceRecorderController());

  List<String> odishaDistricts = [
    'Angul',
    'Balangir',
    'Balasore',
    'Bargarh',
    'Bhadrak',
    'Boudh',
    'Cuttack',
    'Deogarh',
    'Dhenkanal',
    'Gajapati',
    'Ganjam',
    'Jagatsinghpur',
    'Jajpur',
    'Jharsuguda',
    'Kalahandi',
    'Kandhamal',
    'Kendrapara',
    'Kendujhar',
    'Khordha',
    'Koraput',
    'Malkangiri',
    'Mayurbhanj',
    'Nabarangpur',
    'Nayagarh',
    'Nuapada',
    'Puri',
    'Rayagada',
    'Sambalpur',
    'Subarnapur',
    'Sundargarh',
  ];

  // Controller
  final RxList<String> selectedBanks = <String>[].obs;

  List<String> availableBanks = [
    'HDFC Bank',
    'ICICI Bank',
    'Axis Bank',
    'SBI',
    'Kotak Mahindra',
    'Yes Bank',
    'Bank of Baroda',
    'IndusInd Bank',
  ];

  List<String> successPer = ['50', '60', '70', '80', '90', '100'];
  List<String> expectedMonth = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  List<String> leadType = [
    'personal_loan',
    'business_loan',
    'home_loan',
    'creditcard_loan',
  ];

  final isLoading = false.obs;

  void setDate(DateTime date) {
    selectedDate.value = date;
  }

  Future<void> createLead() async {
    isLoading.value = true;

    try {
      Map<String, dynamic> body = {
        "lead_type": leadTypeValue.value,
        "status": "pending",
        "team_lead_id": authController.userData['team_lead_id'].toString(),
      };

      final leadType = leadTypeValue.value;

      if (leadType == 'personal_loan' || leadType == 'home_loan') {
        body.addAll({
          "name": nameController.text.trim(),
          "phone": phoneController.text.trim(),
          "email": emailController.text.trim(),
          "location": selectedLocation.value,
          "company_name": companyNameController.text.trim(),
          "lead_amount": (double.tryParse(leadAmountController.text) ?? 0.0).toString(),
          "salary": (double.tryParse(salaryController.text) ?? 0.0).toString(),
          "success_percentage": (int.tryParse(selectedSuccessRatio.value) ?? 0).toString(),
          "expected_month": selectedMonth.value,
          "remarks": remarksController.text.trim(),
        });

        if (selectedDate.value != null) {
          body["dob"] = DateFormat("yyyy-MM-dd").format(selectedDate.value!);
        }
      }

      else if (leadType == 'business_loan') {
        body.addAll({
          "business_name": companyNameController.text.trim(),
          "phone": phoneController.text.trim(),
          "email": emailController.text.trim(),
          "location": selectedLocation.value,
          "lead_amount": (double.tryParse(leadAmountController.text) ?? 0.0).toString(),
          "turnover_amount": (double.tryParse(salaryController.text) ?? 0.0).toString(), // assuming salaryController used as turnover input
          "vintage_year": (selectedDate.value?.year != null)
              ? (DateTime.now().year - selectedDate.value!.year).toString()
              : "0",
          "success_percentage": (int.tryParse(selectedSuccessRatio.value) ?? 0).toString(),
          "remarks": remarksController.text.trim(),
        });
      }

      else if (leadType == 'creditcard_loan') {
        body.addAll({
          "name": nameController.text.trim(),
          "phone": phoneController.text.trim(),
          "email": emailController.text.trim(),
          "bank_name": selectedBanks.join(', ') // Convert list to string like: "HDFC, ICICI"
        });
      }

      print("Sending lead data: $body");

      final response = await ApiService().createLead(
        token: authController.token.value,
        leadData: body,
        filePath: voiceRecorderController.recordedFilePath.toString(),
      );

      Get.snackbar("Success", response['message'],
          backgroundColor: Colors.green, colorText: Colors.white);

      clearForm(leadType: leadTypeValue.value);
      Get.toNamed(AppRoutes.leadSavedSuccess);
      allLeadsController.fetchAllLeads();
      dashboardController.loadDashboardData();
    } catch (e) {
      print("Error during createLead: $e");
      Get.snackbar("Error", "Failed to save lead: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  void clearForm({String leadType = 'personal_loan'}) {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    locationController.clear();
    companyNameController.clear();
    leadAmountController.clear();
    salaryController.clear();
    remarksController.clear();
    selectedDate.value = null;
    selectedSuccessRatio.value = '';
    leadTypeValue.value = leadType;
    selectedMonth.value = '';
    selectedLocation.value = '';
    voiceFilePath.value = '';
    voiceRecorderController
        .onClose(); // you can clear your recorded file path also if needed
  }
}
