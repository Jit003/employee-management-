import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../services/api_services.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isLoading = false.obs;

  final ApiService _apiService = ApiService();

  Future<void> handleLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill in all fields");
      return;
    }

    isLoading.value = true;

    try {
      final response = await _apiService.logIn(email, password);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // You can store token or user info here
        Fluttertoast.showToast(msg: "Login successful");
        // Get.offNamed('/home'); // Navigate to home if needed
      } else {
        final error = jsonDecode(response.body);
        Fluttertoast.showToast(msg: error['message'] ?? "Login failed");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
