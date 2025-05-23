import 'package:flutter/material.dart';
import 'package:kredipal/constant/app_color.dart';
import 'package:kredipal/widgets/custom_button.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';
import 'package:get/get.dart';

class LeadDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> lead = Get.arguments;

   LeadDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColor.appBarColor,
        title: Text(
          lead['name'] ?? 'Lead Details',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Card
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      WidgetCircularAnimator(
                        size: 100,
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey[200]),
                          child: CircleAvatar(
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        lead['name'] ?? 'Unknown',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        lead['status'] ?? 'Status not available',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColor.appBarColor.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Detail Tiles
            detailTile(Icons.phone, "Phone", lead['phone'] ?? "Not Provided"),
            const SizedBox(height: 15),
            detailTile(Icons.email, "Email", lead['email'] ?? "Not Provided"),
            const SizedBox(height: 15),
            detailTile(Icons.location_on, "Location",
                lead['location'] ?? "Not Provided"),
            const SizedBox(height: 15),
            detailTile(
                Icons.note, "Note", lead['note'] ?? "No additional notes"),
            const SizedBox(height: 15),
            detailTile(Icons.calendar_today, "Created On",
                lead['createdAt'] ?? "Unknown"),

            const SizedBox(height: 30),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Call',
                    onPressed: () {
                      // Implement call logic
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    text: 'Message',
                    onPressed: () {
                      // Implement message logic
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    text: 'Edit',
                    onPressed: () {
                      // Implement edit logic
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget detailTile(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.red, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 4),
              Text(value,
                  style: const TextStyle(fontSize: 15, color: Colors.black87)),
            ],
          ),
        ),
      ],
    );
  }

  Widget actionButton(IconData icon, String label, VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(
        icon,
        size: 18,
        color: Colors.white,
      ),
      label: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.btnColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
