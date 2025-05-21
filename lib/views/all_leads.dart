import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:kredipal/views/lead_details_screen.dart';
import 'package:kredipal/widgets/custom_header.dart';
import '../controller/allleads_controller.dart';

class AllLeadsScreen extends StatelessWidget {
  AllLeadsScreen({super.key});

  final LeadsController leadsController = Get.put(LeadsController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        customHeader('All Leads List'),
        Expanded(
          child: Obx(() => ListView.builder(
            itemCount: leadsController.leads.length,
            itemBuilder: (context, index) {
              final lead = leadsController.leads[index];
              return Slidable(
                key: ValueKey(lead['name']),

                // Swipe to delete
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  dismissible: DismissiblePane(
                    onDismissed: () {
                      leadsController.deleteLead(index);
                      Get.snackbar('Deleted', '${lead['name']} removed',
                          snackPosition: SnackPosition.BOTTOM);
                    },
                  ),
                  children: [
                    SlidableAction(
                      onPressed: (_) => leadsController.deleteLead(index),
                      backgroundColor: Colors.red.shade400,
                      foregroundColor: Colors.white,
                      icon: Icons.delete_outline,
                      label: 'Delete',
                    ),
                  ],
                ),

                // Swipe to update status
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (_) =>
                          leadsController.markAsCompleted(index),
                      backgroundColor: Colors.green.shade600,
                      foregroundColor: Colors.white,
                      icon: Icons.check_circle_outline,
                      label: 'Completed',
                    ),
                    SlidableAction(
                      onPressed: (_) =>
                          leadsController.markAsNotCompleted(index),
                      backgroundColor: Colors.orange.shade400,
                      foregroundColor: Colors.white,
                      icon: Icons.cancel_outlined,
                      label: 'Pending',
                    ),
                  ],
                ),

                child: GestureDetector(
                  onTap: () => Get.to(() => LeadDetailsScreen(lead: lead)),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                      border: Border.all(color: Colors.teal.shade100),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.teal.shade100,
                          child: const Icon(Icons.person, color: Colors.red),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lead['name'] ?? '',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Status: ${lead['status']}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: lead['status'] == 'Completed'
                                      ? Colors.green
                                      : Colors.orange,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios,
                            size: 16, color: Colors.teal),
                      ],
                    ),
                  ),
                ),
              );
            },
          )),
        ),
      ],
    );
  }
}
