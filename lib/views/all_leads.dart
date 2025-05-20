import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
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

        // Reactive leads list
        Expanded(
          child: Obx(() => ListView.builder(
            itemCount: leadsController.leads.length,
            itemBuilder: (context, index) {
              final lead = leadsController.leads[index];
              return Slidable(
                key: ValueKey(lead['name']),

                // Slide Right to Delete
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
                      onPressed: (_) =>
                          leadsController.deleteLead(index),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),

                // Slide Left to Complete/Not Complete
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (_) =>
                          leadsController.markAsCompleted(index),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      icon: Icons.check,
                      label: 'Completed',
                    ),
                    SlidableAction(
                      onPressed: (_) =>
                          leadsController.markAsNotCompleted(index),
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      icon: Icons.close,
                      label: 'Not Completed',
                    ),
                  ],
                ),

                child: Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(lead['name'] ?? ''),
                    subtitle: Text("Status: ${lead['status']}"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14),
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
