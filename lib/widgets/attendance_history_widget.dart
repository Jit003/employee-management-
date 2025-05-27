import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/attendance_history_controller.dart';

class AttendanceCard extends StatelessWidget {
  final int index;
  final String date;
  final String checkIn;
  final String checkOut;
  final String status;

  AttendanceCard({
    required this.index,
    required this.date,
    required this.checkIn,
    required this.checkOut,
    required this.status,
  });

  final AttendanceHistoryController controller = Get.put(AttendanceHistoryController());

  @override
  Widget build(BuildContext context) {
    final Color statusColor = status == "Present"
        ? Colors.green
        : status == "Late"
            ? Colors.orange
            : Colors.red;

    return Obx(() {
      final bool isExpanded = controller.isExpanded(index);

      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: InkWell(
          onTap: () => controller.toggleCard(index),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                /// Always visible row
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: statusColor.withOpacity(0.2),
                      child: Icon(
                        status == "Present"
                            ? Icons.check_circle
                            : status == "Late"
                                ? Icons.access_time
                                : Icons.cancel,
                        color: statusColor,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        date,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        border: Border.all(color: statusColor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),

                /// Expanded content
                if (isExpanded) ...[
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.login, size: 16, color: Colors.grey),
                          const SizedBox(width: 6),
                          Text("In: $checkIn"),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.logout,
                              size: 16, color: Colors.grey),
                          const SizedBox(width: 6),
                          Text("Out: $checkOut"),
                        ],
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      );
    });
  }
}
