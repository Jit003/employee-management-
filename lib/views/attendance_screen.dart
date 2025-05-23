import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kredipal/constant/app_color.dart';
import 'package:kredipal/controller/attendance_controller.dart';
import 'package:kredipal/widgets/custom_header.dart';

import '../controller/animation_controller.dart';
import '../widgets/attendance_time_widget.dart';

class AttendanceScreen extends StatelessWidget {
  AttendanceScreen({super.key});

  final AttendanceController controller = Get.put(AttendanceController());
  final PunchAnimationController animController =
      Get.put(PunchAnimationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          customHeader("Welcome Back", ""),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header
                const Text(
                  "Ready to mark your attendance?",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 40),

                // Punch In/Out Button
                AnimatedBuilder(
                  animation: animController.animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: animController.scaleAnimation.value,
                      child: GestureDetector(
                        onTap: controller.togglePunch,
                        child: Obx(() => Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: controller.isPunchedIn.value
                                      ? [
                                          Colors.red.shade400,
                                          Colors.red.shade600
                                        ]
                                      : [
                                          Colors.green.shade400,
                                          Colors.green.shade600
                                        ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: (controller.isPunchedIn.value
                                            ? Colors.red
                                            : Colors.green)
                                        .withOpacity(0.6),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                                border: Border.all(
                                    width: 10, color: Colors.white38),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      controller.isPunchedIn.value
                                          ? Icons.logout
                                          : Icons.login,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      controller.isPunchedIn.value
                                          ? "Punch Out"
                                          : "Punch In",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30),

                // Total Duration
                Obx(() => punchInfoCard(
                      icon: Icons.access_time,
                      iconColor: Colors.blue,
                      label: "Total Time",
                      time: controller.totalDuration.value.isEmpty
                          ? '--:--'
                          : controller.totalDuration.value,
                    )),
                const SizedBox(height: 10),

                Obx(() => punchInfoCard(
                      icon: Icons.login,
                      iconColor: Colors.green,
                      label: "Punch In",
                      time: controller.formatTime(controller.punchInTime.value),
                    )),

                Obx(() => punchInfoCard(
                      icon: Icons.logout,
                      iconColor: Colors.red,
                      label: "Punch Out",
                      time:
                          controller.formatTime(controller.punchOutTime.value),
                    )),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
