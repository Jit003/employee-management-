import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/addleads_controller.dart';
import 'modern_dropdown.dart';
import 'modern_text_field.dart';

Widget buildContactInfoSection() {
  final AddLeadsController addLeadsController = Get.find<AddLeadsController>();
  return Column(
    children: [
      buildModernTextField(
        label: 'Phone Number',
        controller: addLeadsController.phoneController,
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the phone number';
          }
          return null;
        },
      ),
      const SizedBox(height: 20),
      Obx(() => buildModernDropdown(
        label: 'Location',
        value: addLeadsController.selectedLocation.value,
        items: addLeadsController.odishaDistricts,
        onChanged: (val) {
          addLeadsController.selectedLocation.value = val ?? '';
        },
      )),
    ],
  );
}
