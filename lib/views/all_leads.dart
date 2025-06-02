import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kredipal/widgets/custom_header.dart';
import '../controller/allleads_controller.dart';
import '../routes/app_routes.dart';

class AllLeadsScreen extends StatelessWidget {
  final LeadsController controller = Get.put(LeadsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          customHeader('All Leads List'),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
            
              if (controller.leadsList.isEmpty) {
                return const Center(child: Text("No leads available"));
              }
            
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.leadsList.length,
                itemBuilder: (context, index) {
                  final lead = controller.leadsList[index];
                  return Card(
                    child: ListTile(
                      onTap: () =>
                          Get.toNamed(AppRoutes.leadDetails, arguments: lead),
                      title: Text(lead.name ?? 'No Name'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Status: ${lead.status ?? ''}"),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
