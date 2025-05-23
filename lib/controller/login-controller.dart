import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kredipal/routes/app_routes.dart';
import 'package:kredipal/views/home_screen.dart';

class LoginController extends GetxController {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    print('LoginController Initialized');
  }

  // @override
  // void onClose() {
  //   print('LoginController Disposed');
  //   phoneController.dispose();
  //   passwordController.dispose();
  //   super.onClose();
  // }


  void login() {
    final phone = phoneController.text.trim();
    final password = passwordController.text;

    // Your login logic here
    Get.toNamed(AppRoutes.home);
    print('Phone: $phone, Password: $password');
  }

  void clearFields() {
    phoneController.clear();
    passwordController.clear();
  }


}
