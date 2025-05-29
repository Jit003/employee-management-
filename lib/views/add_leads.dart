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

  AddLeadsController addLeadsController = Get.put(AddLeadsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Add Lead'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 10),
            buildTextField(label: 'Name', icon: Icons.person),
            buildTextField(
                label: 'Phone',
                icon: Icons.phone,
                keyboardType: TextInputType.phone),
            buildTextField(
                label: 'Email',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress),
            Obx(() {
              final date = addLeadsController.selectedDate.value;
              return InkWell(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(const Duration(days: 1)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (picked != null) {
                    addLeadsController.setDate(picked);
                  }
                },
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade100),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade100
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.calendar_today, size: 20),
                      const SizedBox(width: 12,),
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

            buildTextField(label: 'Location', icon: Icons.location_on),
            buildTextField(label: 'Company Name', icon: Icons.business),
            buildTextField(
                label: 'Lead Amount',
                icon: Icons.currency_rupee,
                keyboardType: TextInputType.number),
            buildTextField(
                label: 'Salary',
                icon: Icons.currency_rupee,
                keyboardType: TextInputType.number),
            Obx(
              () => CustomDropdownField(
                label: 'Success %',
                icon: Icons.percent,
                value: addLeadsController.selectedSuccessRatio.value,
                items: addLeadsController.successPer,
                onChanged: (val) {
                  addLeadsController.selectedSuccessRatio.value = val ?? '';
                },
              ),
            ),
            Obx(
              () => CustomDropdownField(
                label: 'Expected Month',
                icon: Icons.calendar_month,
                value: addLeadsController.selectedMonth.value,
                items: addLeadsController.expectedMonth,
                onChanged: (val) {
                  addLeadsController.selectedMonth.value = val ?? '';
                },
              ),
            ),
            buildTextField(label: 'Remarks', icon: Icons.note, maxLines: 2),
            const SizedBox(height: 25),
            CustomButton(
                text: 'Save Lead',
                onPressed: () {
                  Get.toNamed(AppRoutes.leadSavedSuccess);
                })
          ],
        ),
      ),
    );
  }
}
