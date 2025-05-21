import 'package:flutter/material.dart';
import 'package:kredipal/constant/app_images.dart';
import 'package:kredipal/widgets/custom_header.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';
import '../constant/app_color.dart';
import '../widgets/profile_option_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor.withOpacity(0.03),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColor.appBarColor, Colors.teal.shade300],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
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
                  backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1598618356794-eb1720430eb4?ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80',
                  ),
                ),
                const SizedBox(height: 16),
                // Name
                const Text(
                  'Shamim Miah',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                // Designation
                Text(
                  'Project Manager',
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
                    const SizedBox(width: 6),
                    Text(
                      'shamimmiah@gmail.com',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.phone, color: Colors.white70, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      '+91 9876543210',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          // Profile and Options
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [

                const SizedBox(height: 20),
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
                const SizedBox(height: 30), // for bottom padding
              ],
            ),
          ),
        ],
      ),
    );
  }
}
