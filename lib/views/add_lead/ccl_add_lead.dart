import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/addleads_controller.dart';
import '../../widgets/add_lead_widget/business_info_section.dart';
import '../../widgets/add_lead_widget/contact_info_section.dart';
import '../../widgets/add_lead_widget/lead_details_section.dart';
import '../../widgets/add_lead_widget/modern_dropdown.dart';
import '../../widgets/add_lead_widget/modern_text_field.dart';
import '../../widgets/add_lead_widget/personal_info_section.dart';
import '../../widgets/add_lead_widget/section_tile.dart';

Widget buildCreditCardLoanBody() {

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle('Personal Information'),
      const SizedBox(height: 16),
      buildPersonalInfoSection(),
      const SizedBox(height: 32),
      buildSectionTitle('Contact Information'),
      const SizedBox(height: 16),
      buildContactInfoSectionForCC(),
      // Lead Details
      const SizedBox(height: 32),
      const SizedBox(height: 100),
    ],
  );
}

Widget buildContactInfoSectionForCC() {
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
      buildModernTextField(
        label: 'Email',
        controller: addLeadsController.emailController,
      ),
      const SizedBox(height: 20),
      Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Select Bank(s)", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          InkWell(
            onTap: () => _showBankMultiSelectDialog(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      addLeadsController.selectedBanks.isEmpty
                          ? 'Select Bank(s)'
                          : addLeadsController.selectedBanks.join(', '),
                      style: TextStyle(
                        color: addLeadsController.selectedBanks.isEmpty
                            ? Colors.grey
                            : Colors.black,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ],
      ))

    ],
  );
}

void _showBankMultiSelectDialog() {
  final AddLeadsController addLeadsController = Get.find<AddLeadsController>();

  Get.defaultDialog(
    title: "Select Bank(s)",
    content: SizedBox(
      width: double.maxFinite,
      child: Obx(() => Wrap(
        spacing: 10,
        children: addLeadsController.availableBanks.map((bank) {
          final isSelected = addLeadsController.selectedBanks.contains(bank);
          return FilterChip(
            label: Text(bank),
            selected: isSelected,
            onSelected: (selected) {
              if (selected) {
                addLeadsController.selectedBanks.add(bank);
              } else {
                addLeadsController.selectedBanks.remove(bank);
              }
            },
          );
        }).toList(),
      )),
    ),
    confirm: ElevatedButton(
      onPressed: () {
        Get.back();
      },
      child: const Text("Done"),
    ),
  );
}

