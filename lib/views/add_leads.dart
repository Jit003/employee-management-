import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kredipal/constant/app_color.dart';
import '../controller/addleads_controller.dart';
import '../controller/voice_record_controller.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_text_field_addlead.dart';
import '../widgets/custom_dropdown_widget.dart';

class AddLeadsPage extends StatelessWidget {
  final String? preselectedLeadType;

  AddLeadsPage({super.key, this.preselectedLeadType});

  final AddLeadsController addLeadsController = Get.put(AddLeadsController());
  final VoiceRecorderController voiceRecorderController = Get.put(VoiceRecorderController());
  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    // Set only if not already set
    if (preselectedLeadType != null && addLeadsController.leadTypeValue.value.isEmpty) {
      addLeadsController.leadTypeValue.value = preselectedLeadType!;
    }
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: CustomAppBar(title: 'Add New Lead'),
      body: Column(
        children: [
          // Voice Recording Section
          _buildVoiceRecordingSection(),

          // Form Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Personal Information
                    _buildSectionTitle('Personal Information'),
                    const SizedBox(height: 16),
                    _buildPersonalInfoSection(),

                    const SizedBox(height: 32),

                    // Contact Information
                    _buildSectionTitle('Contact Information'),
                    const SizedBox(height: 16),
                    _buildContactInfoSection(),

                    const SizedBox(height: 32),

                    // Business Information
                    _buildSectionTitle('Business Information'),
                    const SizedBox(height: 16),
                    _buildBusinessInfoSection(),

                    const SizedBox(height: 32),

                    // Lead Details
                    _buildSectionTitle('Lead Details'),
                    const SizedBox(height: 16),
                    _buildLeadDetailsSection(),

                    const SizedBox(height: 100), // Space for floating button
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _buildSaveButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildVoiceRecordingSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFE5E5E5), width: 1),
        ),
      ),
      child: Obx(() => Row(
        children: [
          // Recording Button
          GestureDetector(
            onTap: () {
              voiceRecorderController.isRecording.value
                  ? voiceRecorderController.stopRecording()
                  : voiceRecorderController.startRecording();
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: voiceRecorderController.isRecording.value
                    ? const Color(0xFFFF4444)
                    : AppColor.btnColor,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: (voiceRecorderController.isRecording.value
                        ? const Color(0xFFFF4444)
                        : const Color(0xFF1A1A1A)).withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                voiceRecorderController.isRecording.value ? Icons.stop_rounded : Icons.mic_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Recording Status
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  voiceRecorderController.isRecording.value
                      ? 'Recording in progress...'
                      : 'Tap to start voice recording',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: voiceRecorderController.isRecording.value
                        ? const Color(0xFFFF4444)
                        : const Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  voiceRecorderController.isRecording.value
                      ? 'Swipe to stop recording'
                      : 'Record lead details for better accuracy',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ),

          // Recording Indicator
          if (voiceRecorderController.isRecording.value)
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: const Color(0xFFFF4444),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Center(
                child: SizedBox(
                  width: 6,
                  height: 6,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
            ),
        ],
      )),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1A1A1A),
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
    return Column(
      children: [
        _buildModernTextField(
          label: 'Full Name',
          controller: addLeadsController.nameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter the name';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        _buildModernDatePicker(),
      ],
    );
  }

  Widget _buildContactInfoSection() {
    return Column(
      children: [
        _buildModernTextField(
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
        _buildModernTextField(
          label: 'Email Address',
          controller: addLeadsController.emailController,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter the email';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        _buildModernTextField(
          label: 'Location',
          controller: addLeadsController.locationController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter the location';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildBusinessInfoSection() {
    return Column(
      children: [
        _buildModernTextField(
          label: 'Company Name',
          controller: addLeadsController.companyNameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter the company name';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        _buildModernTextField(
          label: 'Salary',
          controller: addLeadsController.salaryController,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter the salary';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildLeadDetailsSection() {
    return Column(
      children: [
        Obx(() => _buildModernDropdown(
          label: 'Lead Type',
          value: addLeadsController.leadTypeValue.value,
          items: addLeadsController.leadType,
          onChanged: (val) {
            addLeadsController.leadTypeValue.value = val ?? '';
          },
        )),
        const SizedBox(height: 20),
        _buildModernTextField(
          label: 'Lead Amount',
          controller: addLeadsController.leadAmountController,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter the lead amount';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        Obx(() => _buildModernDropdown(
          label: 'Success Percentage',
          value: addLeadsController.selectedSuccessRatio.value,
          items: addLeadsController.successPer,
          onChanged: (val) {
            addLeadsController.selectedSuccessRatio.value = val ?? '';
          },
        )),
        const SizedBox(height: 20),
        Obx(() => _buildModernDropdown(
          label: 'Expected Month',
          value: addLeadsController.selectedMonth.value,
          items: addLeadsController.expectedMonth,
          onChanged: (val) {
            addLeadsController.selectedMonth.value = val ?? '';
          },
        )),
        const SizedBox(height: 20),
        _buildModernTextField(
          label: 'Remarks',
          controller: addLeadsController.remarksController,
          maxLines: 4,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter the remarks';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildModernTextField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF1A1A1A),
          ),
          decoration: InputDecoration(
            hintText: 'Enter $label',
            hintStyle: const TextStyle(
              fontSize: 16,
              color: Color(0xFF999999),
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE5E5E5), width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE5E5E5), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF1A1A1A), width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFFF4444), width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFFF4444), width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildModernDropdown({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE5E5E5), width: 1),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value.isEmpty ? null : value,
              hint: Text(
                'Select $label',
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF999999),
                ),
              ),
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF1A1A1A),
              ),
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Color(0xFF666666),
              ),
              isExpanded: true,
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModernDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Date of Birth',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 8),
        Obx(() {
          final date = addLeadsController.selectedDate.value;
          return GestureDetector(
            onTap: () async {
              final picked = await showDatePicker(
                context: Get.context!,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: Color(0xFF1A1A1A),
                        onPrimary: Colors.white,
                        surface: Colors.white,
                        onSurface: Color(0xFF1A1A1A),
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (picked != null) {
                addLeadsController.setDate(picked);
              }
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5E5E5), width: 1),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      date == null
                          ? "Select Date of Birth"
                          : DateFormat.yMMMd().format(date),
                      style: TextStyle(
                        fontSize: 16,
                        color: date == null ? const Color(0xFF999999) : const Color(0xFF1A1A1A),
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.calendar_today_outlined,
                    color: Color(0xFF666666),
                    size: 20,
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildSaveButton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Obx(() => ElevatedButton(
        onPressed: addLeadsController.isLoading.value
            ? null
            : () {
          if (_formKey.currentState!.validate()) {
            addLeadsController.createLead();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.btnColor,
          disabledBackgroundColor: const Color(0xFFCCCCCC),
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (addLeadsController.isLoading.value)
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            else
              const Icon(Icons.save_outlined, size: 20),
            const SizedBox(width: 12),
            Text(
              addLeadsController.isLoading.value ? 'Saving Lead...' : 'Save Lead',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
