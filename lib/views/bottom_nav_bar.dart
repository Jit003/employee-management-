import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kredipal/routes/app_routes.dart';
import '../constant/app_color.dart';
import '../controller/bottom_nav_controller.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavController controller = Get.find();
    final double screenWidth = MediaQuery.of(context).size.width;

    final List<IconData> icons = [
      Icons.home,
      Icons.leaderboard,
      Icons.present_to_all,
      Icons.person,
    ];

    final List<String> labels = [
      'Home',
      'Leads',
      'Attendance',
      'Profile',
    ];

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 75,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: AppColor.btmNavBarColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
          ),
          child: Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (index) {
                final isSelected = controller.selectedIndex.value == index;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => controller.changePage(index),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: screenWidth * 0.015,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.elasticOut,
                            width: screenWidth * 0.12,
                            height: screenWidth * 0.10,
                            decoration: BoxDecoration(
                              gradient: isSelected
                                  ? LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  AppColor.btnColor,
                                  AppColor.btnColor.withOpacity(0.8),
                                ],
                              )
                                  : null,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: AnimatedScale(
                              scale: isSelected ? 1.1 : 1.0,
                              duration: const Duration(milliseconds: 200),
                              child: Icon(
                                icons[index],
                                size: isSelected
                                    ? screenWidth * 0.065
                                    : screenWidth * 0.055,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.7),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 200),
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.7),
                              fontSize: screenWidth * 0.028,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                            child: Text(labels[index]),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            );
          }),
        ),

        // Center FAB Button
        Positioned(
          top: -28,
          left: 0,
          right: 0,
          child: Center(
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.addLead);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: screenWidth * 0.15,
                height: screenWidth * 0.15,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColor.btnColor,
                      AppColor.btnColor.withOpacity(0.8),
                    ],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.btnColor.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.white.withOpacity(0.2),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 1.0],
                    ),
                  ),
                  child: Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                    size: screenWidth * 0.07,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
