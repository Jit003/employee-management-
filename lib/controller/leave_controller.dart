import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveController extends GetxController {
  var leaveType = ''.obs;
  var startDate = Rxn<DateTime>();
  var endDate = Rxn<DateTime>();
  TextEditingController reasonController = TextEditingController();
  final options = ['Sick Leave', 'Casual Leave', 'Paid Leave', 'Emergency'];

  void pickDate(BuildContext context, bool isStart) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      if (isStart) {
        startDate.value = picked;
      } else {
        endDate.value = picked;
      }
    }
  }

   submitForm(GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate() &&
        leaveType.value.isNotEmpty &&
        startDate.value != null &&
        endDate.value != null) {
      Get.snackbar("Success", "Leave Applied Successfully!",
          backgroundColor: Colors.green, colorText: Colors.white);
      // Add backend logic here
    } else {
      Get.snackbar("Error", "Please fill all fields",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }
}
