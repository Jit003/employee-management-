import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kredipal/constant/app_images.dart';

import '../constant/app_color.dart';
import '../controller/login-controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // this helps shift UI when keyboard appears
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration:  const BoxDecoration(
         color: AppColor.bgColor
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 250,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage(AppImages.loginImg),
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Welcome Back!',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Login with your phone and password',
                            style: TextStyle(fontSize: 16, color: Colors.white70),
                          ),
                          const SizedBox(height: 24),
                          CustomTextField(
                            controller: controller.phoneController,
                            label: 'Phone Number',
                            prefixIcon: Icons.phone,
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: controller.passwordController,
                            label: 'Password',
                            prefixIcon: Icons.lock,
                            obscureText: true,
                          ),
                          const SizedBox(height: 24),
                          CustomButton(
                            text: 'Login',
                            onPressed: controller.login,
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
