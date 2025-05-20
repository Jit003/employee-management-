import 'package:flutter/material.dart';
import 'package:kredipal/constant/app_images.dart';
import 'package:kredipal/widgets/custom_header.dart';
import '../constant/app_color.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor.withOpacity(0.03),
      body: Column(
        children: [
          customHeader('My Profile'),
          const SizedBox(height: 30),
          const SizedBox(height: 20),

          // Modern Profile Card
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 12,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(AppImages.loginImg),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dillip Kumar Pradhan",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 6),
                      Text("Flutter Developer", style: TextStyle(color: Colors.black54)),
                      SizedBox(height: 4),
                      Text("7064888156", style: TextStyle(color: Colors.black45)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Options
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                OptionTile(
                  icon: Icons.receipt_long,
                  title: "Salary Slip",
                  onTap: () {
                    // Navigate or show dialog
                  },
                ),
                const SizedBox(height: 16),
                OptionTile(
                  icon: Icons.history,
                  title: "Leave History",
                  onTap: () {},
                ),
                const SizedBox(height: 16),
                OptionTile(
                  icon: Icons.edit,
                  title: "Edit Profile",
                  onTap: () {},
                ),
                const SizedBox(height: 16),
                OptionTile(
                  icon: Icons.logout,
                  title: "Logout",
                  onTap: () {},
                  iconColor: Colors.red,
                  textColor: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? textColor;

  const OptionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 10,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor ?? AppColor.primaryColor, size: 24),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: textColor ?? Colors.black87,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
