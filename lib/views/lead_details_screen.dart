import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kredipal/constant/app_color.dart';
import 'package:kredipal/widgets/custom_app_bar.dart';
import 'package:kredipal/widgets/custom_button.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

import '../controller/lead_follow_controller.dart';
import '../widgets/follow_up_bottom_sheet.dart';
import '../widgets/lead_details_tile_widget.dart';

class LeadDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> lead = Get.arguments;
  final LeadFollowController followController = Get.put(LeadFollowController());

  LeadDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: lead['name'] ?? 'Lead Details',
        actions: [
          Obx(() {
            return IconButton(
              icon: Icon(
                followController.isFollowing.value
                    ? Icons.star
                    : Icons.star_border,
                color: Colors.white,
              ),
              onPressed: () {
                followController.toggleFollow();
                // Optional: send to backend or local DB
              },
            );
          }),

        ],
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
                          child: const CircleAvatar(),
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
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    text: 'Follow Up',
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                          ),
                          builder: (_) => FollowUpBottomSheet(leadId: lead['id'].toString()),
                        );
                      }

                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
