import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:kredipal/constant/app_color.dart';
import 'package:kredipal/widgets/custom_header.dart';
import '../controller/allleads_controller.dart';
import '../routes/app_routes.dart';

class AllLeadsScreen extends StatelessWidget {
  AllLeadsScreen({super.key});

  final LeadsController leadsController = Get.put(LeadsController());

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'forward to tl':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey.shade600;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        customHeader('All Leads List'),
        const SizedBox(height: 30),
        // Filter Dropdown
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Obx(() {
            return DropdownButtonFormField<String>(
              value: leadsController.selectedStatus.value,
              items: ['All', 'Rejected', 'forward to TL']
                  .map(
                    (status) => DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  leadsController.selectedStatus.value = value;
                }
              },
              decoration: InputDecoration(
                labelText: 'Filter by Status',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            );
          }),
        ),

        Expanded(
          child: Obx(() => ListView.builder(
                itemCount: leadsController.filteredLeads.length,
                itemBuilder: (context, index) {
                  final lead = leadsController.filteredLeads[index];
                  final status = (lead['status'] ?? '').toString();

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
                              leadsController.markAsForward(index),
                          backgroundColor: Colors.green.shade700,
                          foregroundColor: Colors.white,
                          icon: Icons.send,
                          label: 'Forward',
                        ),
                        SlidableAction(
                          onPressed: (_) =>
                              leadsController.markAsRejected(index),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.cancel_outlined,
                          label: 'Reject',
                        ),
                      ],
                    ),

                    child: GestureDetector(
                      onTap: () =>
                          Get.toNamed(AppRoutes.leadDetails, arguments: lead),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.appBarColor.withOpacity(0.1),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 18),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    lead['name'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(status)
                                          .withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'Status: $status',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: _getStatusColor(status),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: Colors.blueAccent,
                            ),
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
