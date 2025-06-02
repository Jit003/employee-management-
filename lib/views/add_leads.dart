import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kredipal/controller/addleads_controller.dart';
import 'package:kredipal/widgets/custom_app_bar.dart';
import 'package:kredipal/widgets/custom_button.dart';
import 'package:kredipal/widgets/custom_text_field_addlead.dart';
import '../routes/app_routes.dart';
import '../widgets/custom_dropdown_widget.dart';

class AddLeadsPage extends StatelessWidget {
  AddLeadsPage({super.key});

  final AddLeadsController addLeadsController = Get.put(AddLeadsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Add Lead'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // ✅ Name field with controller
            buildTextField(
              label: 'Name',
              controller: addLeadsController.nameController,
              icon: Icons.person,
            ),

            // ✅ Phone
            buildTextField(
              label: 'Phone',
              controller: addLeadsController.phoneController,
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
            ),

            // ✅ Email
            buildTextField(
              label: 'Email',
              controller: addLeadsController.emailController,
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),

            // ✅ DOB Picker
            Obx(() {
              final date = addLeadsController.selectedDate.value;
              return InkWell(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    addLeadsController.setDate(picked);
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade100,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 20),
                      const SizedBox(width: 12),
                      Text(
                        date == null
                            ? "Date Of Birth"
                            : DateFormat.yMMMd().format(date),
                      ),
                    ],
                  ),
                ),
              );
            }),

            // ✅ Location
            buildTextField(
              label: 'Location',
              controller: addLeadsController.locationController,
              icon: Icons.location_on,
            ),

            // ✅ Company Name
            buildTextField(
              label: 'Company Name',
              controller: addLeadsController.companyNameController,
              icon: Icons.business,
            ),

            // ✅ Lead Amount
            buildTextField(
              label: 'Lead Amount',
              controller: addLeadsController.leadAmountController,
              icon: Icons.currency_rupee,
              keyboardType: TextInputType.number,
            ),

            // ✅ Salary
            buildTextField(
              label: 'Salary',
              controller: addLeadsController.salaryController,
              icon: Icons.currency_rupee,
              keyboardType: TextInputType.number,
            ),

            // ✅ Success %
            Obx(() => CustomDropdownField(
                  label: 'Success %',
                  icon: Icons.percent,
                  value: addLeadsController.selectedSuccessRatio.value,
                  items: addLeadsController.successPer,
                  onChanged: (val) {
                    addLeadsController.selectedSuccessRatio.value = val ?? '';
                  },
                )),

            // ✅ Expected Month
            Obx(() => CustomDropdownField(
                  label: 'Expected Month',
                  icon: Icons.calendar_month,
                  value: addLeadsController.selectedMonth.value,
                  items: addLeadsController.expectedMonth,
                  onChanged: (val) {
                    addLeadsController.selectedMonth.value = val ?? '';
                  },
                )),

            // ✅ Remarks
            buildTextField(
              label: 'Remarks',
              controller: addLeadsController.remarksController,
              icon: Icons.note,
              maxLines: 2,
            ),

            const SizedBox(height: 25),

            // ✅ Save Button
            Obx(() => CustomButton(
                text: addLeadsController.isLoading.value
                    ? 'Saving...'
                    : 'Save Lead',
                onPressed: () {
                  addLeadsController.createLead();
                })),
          ],
        ),
      ),
    );
  }
}
