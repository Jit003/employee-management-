import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kredipal/controller/login-controller.dart';
import 'package:kredipal/routes/app_routes.dart';
import 'package:kredipal/views/apply_leave_screen.dart';
import '../constant/app_color.dart';
import '../widgets/profile_option_tile.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final AuthController authController = Get.find<AuthController>(); // ✅ Use Get.find

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor.withOpacity(0.03),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Obx(()=>
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                decoration: BoxDecoration(
                  color: AppColor.appBarColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.shade100,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Image
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    // Name
                    Text(
                      '${authController.userData['name']}',
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // Designation
                    Text(
                      '${authController.userData['designation']}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Contact Info
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.email, color: Colors.white70, size: 18),
                        SizedBox(width: 6),
                        Text(
                          '${authController.userData['email']}',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.phone, color: Colors.white70, size: 18),
                        SizedBox(width: 6),
                        Text(
                          '${authController.userData['phone'] ?? 'Phone Number'}',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

          ),
          const SizedBox(height: 30),
          // Profile and Options
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
              
                    const SizedBox(height: 20),
                    OptionTile(
                      icon: Icons.add,
                      title: "Apply for Leave",
                      onTap: () {
                        // Navigate or show dialog
                        Get.to(()=>ApplyLeavePage());
                      },
                    ),
              
                    const SizedBox(height: 20),
                    OptionTile(
                      icon: Icons.receipt_long,
                      title: "Salary Slip",
                      onTap: () {
                        // Navigate or show dialog
                        Get.toNamed(AppRoutes.salarySlip);
                      },
                    ),
                    const SizedBox(height: 16),
                    OptionTile(
                      icon: Icons.history,
                      title: "Leave History",
                      onTap: () {
                        Get.toNamed(AppRoutes.leaveHistory);
                      },
                    ),
                    const SizedBox(height: 16),
                    OptionTile(
                      icon: Icons.history,
                      title: "Change Password",
                      onTap: () {
                        Get.toNamed(AppRoutes.password);
                      },
                    ),
                    const SizedBox(height: 16),
                    OptionTile(
                      icon: Icons.edit,
                      title: "Edit Profile",
                      onTap: () {
                        Get.toNamed(AppRoutes.editProfile);
                      },
                    ),
                    const SizedBox(height: 16),
                    OptionTile(
                      icon: Icons.logout,
                      title: "Logout",
                      onTap: () {
                        authController.logoutUser();
                      },
                      iconColor: Colors.red,
                      textColor: Colors.red,
                    ),
                    const SizedBox(height: 100), // for bottom padding
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
