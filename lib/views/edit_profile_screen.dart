import 'package:flutter/material.dart';
import 'package:kredipal/constant/app_color.dart';
import 'package:kredipal/widgets/custom_button.dart';

class EditProfileScreen extends StatelessWidget {
  final TextEditingController nameController =
      TextEditingController(text: "Dillip Kumar Pradhan");

  final TextEditingController designationController =
      TextEditingController(text: "Flutter Developer");

  final TextEditingController emailController =
      TextEditingController(text: "dillip@example.com");

  Widget _buildTextField(
      String label, IconData icon, TextEditingController controller,
      {TextInputType type = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Colors.teal;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: AppColor.appBarColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey.shade300,
                ),
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: GestureDetector(
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: themeColor,
                      child:
                          const Icon(Icons.edit, size: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            _buildTextField("Full Name", Icons.person, nameController),
            const SizedBox(height: 20),
            _buildTextField("Designation", Icons.badge, designationController),
            const SizedBox(height: 20),
            _buildTextField("Email Address", Icons.email, emailController,
                type: TextInputType.emailAddress),
            const SizedBox(height: 30),
            CustomButton(text: 'Save Changes', onPressed:(){

            })
          ],
        ),
      ),
    );
  }
}
