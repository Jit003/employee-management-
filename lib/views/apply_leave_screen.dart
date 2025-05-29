import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kredipal/constant/app_color.dart';
import 'package:kredipal/widgets/custom_button.dart';
import '../controller/leave_controller.dart';
import '../widgets/date_picker_widget.dart';

class ApplyLeavePage extends StatelessWidget {
  final LeaveController controller = Get.put(LeaveController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              const SizedBox(width: 12),
              Text(
                'Apply for Leave',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 10),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => DropdownButtonFormField<String>(
                            value: controller.leaveType.value.isEmpty
                                ? null
                                : controller.leaveType.value,
                            hint: Text('Select Leave Type'),
                            items: controller.options
                                .map((type) => DropdownMenuItem<String>(
                                      value: type,
                                      child: Text(type),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                controller.leaveType.value = value;
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          )),

                      const SizedBox(height: 8),
                      // Start Date
                      const Text(
                        "Start Date",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Obx(() => DatePickerTile(
                            label: controller.startDate.value == null
                                ? 'Select Start Date'
                                : DateFormat('yyyy-MM-dd')
                                    .format(controller.startDate.value!),
                            icon: Icons.calendar_today,
                            onTap: () => controller.pickDate(context, true),
                          )),
                      const SizedBox(height: 20),

                      // End Date
                      const Text(
                        "End Date",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Obx(() => DatePickerTile(
                            label: controller.endDate.value == null
                                ? 'Select End Date'
                                : DateFormat('yyyy-MM-dd')
                                    .format(controller.endDate.value!),
                            icon: Icons.calendar_today_outlined,
                            onTap: () => controller.pickDate(context, false),
                          )),
                      const SizedBox(height: 20),

                      // Reason
                      const Text(
                        "Reason",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: controller.reasonController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Type your reason here...',
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter a reason'
                            : null,
                      ),

                      const SizedBox(height: 30),

                      CustomButton(
                        text: 'Submit Application',
                        onPressed: () {
                          controller.submitForm(_formKey);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

