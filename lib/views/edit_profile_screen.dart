import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kredipal/controller/edit_profile_controller.dart';

import '../controller/image_picker_controller.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';

class EditProfileScreen extends StatelessWidget {

  final ProfileUpdateController updateController = Get.put(ProfileUpdateController());
  final ImagePickerController controller = Get.put(ImagePickerController());


  Widget _buildTextField(
      String label,
      IconData icon,
      TextEditingController controller, {
        TextInputType type = TextInputType.text,
      }) {
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
    const themeColor = Colors.teal;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Edit Profile'),
      body: Obx(() => updateController.isUpdating.value
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Stack(
              children: [
                Obx(() => CircleAvatar(
                  radius: 60,
                  backgroundImage: controller.pickedImagePath.value == ''
                      ? null
                      : FileImage(
                    File(controller.pickedImagePath.value),
                  ) as ImageProvider,
                  backgroundColor: Colors.grey.shade300,
                  child: controller.pickedImagePath.value == ''
                      ? Icon(Icons.person, size: 60, color: Colors.white54)
                      : null,
                )),
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: GestureDetector(
                    onTap: () {
                      controller.pickImage();
                    },
                    child: const CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.blue, // use your themeColor here
                      child: Icon(Icons.edit, size: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            _buildTextField("Full Name", Icons.person, updateController.nameController),
            const SizedBox(height: 20),
            _buildTextField("Phone Number", Icons.phone, updateController.phoneController),
            const SizedBox(height: 20),
            _buildTextField("Address", Icons.location_pin, updateController.addressController,
                type: TextInputType.emailAddress),
            const SizedBox(height: 30),
            CustomButton(
              text: 'Save Changes',
              onPressed: () => updateController.updateProfile(),
            ),
          ],
        ),
      )),
    );
  }
}
