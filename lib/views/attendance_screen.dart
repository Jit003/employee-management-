import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kredipal/controller/current_time_controller.dart';
import 'package:kredipal/controller/voice%20controller.dart';
import 'package:kredipal/widgets/custom_header.dart';
import 'package:kredipal/controller/animation_controller.dart';

import '../widgets/check_in_out_container.dart'; // <-- New import

class AttendanceScreen extends StatelessWidget {
  AttendanceScreen({super.key});

  final TimeController timeController = Get.put(TimeController());
  final VoiceController voiceController = Get.put(VoiceController());
  final PulseAnimationController pulseController = Get.put(PulseAnimationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          // Gradient Header
          customHeader("Welcome Back!", ""),

          const SizedBox(height: 30),

          // Attendance Status Display
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                  onPressed: () {
                    if (!voiceController.isListening.value) {
                      voiceController.startListening();
                    } else {
                      voiceController.stopListening();
                    }
                  },

                  child: Text('Speak')),
                  const Text(
                    "Your Attendance",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),

                  AnimatedBuilder(
                    animation: pulseController.animationController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: pulseController.scaleAnimation.value,
                        child: InkWell(
                          onTap: (){
                            Get.snackbar("Check-in", "Tapped");
                          },
                          child: buildStatusCircle(
                            color: Colors.green,
                            icon: Icons.login,
                            label: "Check-In",
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 30),

                  AnimatedBuilder(
                    animation: pulseController.animationController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: pulseController.scaleAnimation.value,
                        child: buildStatusCircle(
                          color: Colors.red,
                          icon: Icons.logout,
                          label: "Check-Out ",
                        ),
                      );
                    },
                  ),

                ],
              ),
            ),
          ),

          const SizedBox(height: 40),

          // Tip or Footer
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              "* Please check in/out only when at your work location",
              style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
            ),
          ),
        ],
      ),
    );
  }
}
