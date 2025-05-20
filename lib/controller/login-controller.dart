import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kredipal/views/home_screen.dart';

class LoginController extends GetxController {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void login() {
    final phone = phoneController.text.trim();
    final password = passwordController.text;

    // Your login logic here
    Get.to(()=>MainScaffold());
    print('Phone: $phone, Password: $password');
  }
}
