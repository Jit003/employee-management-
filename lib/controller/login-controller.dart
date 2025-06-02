import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kredipal/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api_services.dart';

class AuthController extends GetxController {
  final ApiService apiService = ApiService();
  var isLoading = false.obs;
  var userData = {}.obs;
  var token = ''.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString('token') ?? '';
  }

  void loginUser() async {
    isLoading.value = true;
    final result = await apiService.logIn(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    isLoading.value = false;

    if (result['success']) {
      userData.value = result['user'];
      token.value = result['token'];
      // ✅ Save token using SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', result['token']);


      Get.snackbar(backgroundColor: Colors.green,'Success', result['message']);
      Get.offNamed(AppRoutes.home);
      // Navigate to home/dashboard
    } else {
      Get.snackbar('Error', result['message'], backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  void logoutUser() async {
    // Clear token and user data
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    userData.value = {};
    token.value = '';

    // Navigate to login screen and remove all previous routes
    Get.offAllNamed(AppRoutes.login);

    // Optional: Show a message
    Get.snackbar('Logged Out', 'You have been successfully logged out');
  }

}
