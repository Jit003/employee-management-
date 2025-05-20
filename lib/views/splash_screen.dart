import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kredipal/constant/app_images.dart';
import 'package:kredipal/views/login_screen.dart';
import '../constant/app_color.dart';
import '../controller/splash-controller.dart';

class SplashScreen extends StatelessWidget {

  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient background (Dark Blue -> Red)
      body: Container(
        decoration: BoxDecoration(
          color: AppColor.bgColor
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(onPressed: (){
                Get.to(()=>LoginScreen());
              }, icon: Icon(Icons.add)),
              // Animated tagline
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Welcome to',
                    textStyle: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontFamily: 'Poppins'),
                    speed: const Duration(milliseconds: 120),
                  ),
                ],
                totalRepeatCount: 1,
              ),

              const SizedBox(height: 8),

              Obx(() {
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 800),
                  opacity: controller.showLogo.value ? 1 : 0,
                  child: Image.asset(
                    AppImages.appLogo,
                  ),
                );
              }),

              const SizedBox(height: 12),

              // Tagline with subtle color emphasis

              const SizedBox(height: 40),

              // Logo with fade & scale animation controlled by Obx & AnimationController
            ],
          ),
        ),
      ),
    );
  }
}
