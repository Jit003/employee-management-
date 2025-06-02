import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kredipal/constant/app_images.dart';

import '../constant/app_color.dart';
import '../controller/login-controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.find<AuthController>();
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
                      child: Form(
                        key: _formKey,
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
                              'Login with your email and password',
                              style: TextStyle(fontSize: 16, color: Colors.white70),
                            ),
                            const SizedBox(height: 24),
                            CustomTextField(
                              controller: controller.emailController,
                              label: 'Email',
                              prefixIcon: Icons.phone,
                              validator:(value){
                                if(value == null || value.isEmpty){
                                  return 'Email id Required';
                                }
                                return null;
                              } ,
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                              controller: controller.passwordController,
                              label: 'Password',
                              prefixIcon: Icons.lock,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty ) {
                                  return 'Password require';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 24),
                           Obx(()=> CustomButton(
                             isLoading: controller.isLoading.value,
                             text: 'Login',
                             onPressed:(){
                               if(_formKey.currentState!.validate()){
                                 controller.loginUser();
                               }
                             },
                           ),),
                            const SizedBox(height: 16),
                          ],
                        ),
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
