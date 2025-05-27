import 'package:flutter/material.dart';
import 'package:kredipal/constant/app_color.dart';
import 'package:kredipal/widgets/custom_app_bar.dart';
import 'package:kredipal/widgets/custom_button.dart';

class SalarySlipScreen extends StatelessWidget {
  const SalarySlipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final salaryDetails = {
      'Employee Name': 'Dillip Kumar Pradhan',
      'Designation': 'Flutter Developer',
      'Month': 'May 2025',
      'Employee ID': 'KP1023',
      'Basic Salary': 25000,
      'HRA': 10000,
      'Other Allowances': 5000,
      'Deductions': 3000,
      'Net Salary': 37000,
    };

    return Scaffold(
     appBar: CustomAppBar(title: 'Salary Slip'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.teal, width: 1.2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Employee Name: ${salaryDetails['Employee Name']}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text('Designation: ${salaryDetails['Designation']}'),
                  Text('Month: ${salaryDetails['Month']}'),
                  Text('Employee ID: ${salaryDetails['Employee ID']}'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Salary Breakdown
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  buildRow(
                      'Basic Salary', salaryDetails['Basic Salary'] as int),
                  buildRow('HRA', salaryDetails['HRA'] as int),
                  buildRow('Other Allowances',
                      salaryDetails['Other Allowances'] as int),
                  const Divider(height: 24, thickness: 1),
                  buildRow('Deductions', salaryDetails['Deductions'] as int,
                      isNegative: true),
                  const Divider(height: 24, thickness: 1),
                  buildRow('Net Salary', salaryDetails['Net Salary'] as int,
                      isBold: true),
                ]),
              ),
            ),

            const SizedBox(height: 30),

            // Download/Share Button
          CustomButton(text: 'Download Pdf', onPressed: (){})
          ],
        ),
      ),
    );
  }

  Widget buildRow(String label, int value,
      {bool isNegative = false, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                fontSize: isBold ? 16 : 14,
              )),
          Text(
            '${isNegative ? '-' : ''}₹$value',
            style: TextStyle(
              color: isNegative ? Colors.red : Colors.black,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }
}
