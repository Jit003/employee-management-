import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kredipal/constant/app_color.dart';
import 'package:kredipal/widgets/custom_app_bar.dart';
import '../controller/task_controller.dart';
import '../widgets/task_card_widget.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({super.key});

  final TaskController controller = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FD),
      appBar: const CustomAppBar(title: 'Task List'),
      body: Obx(() => ListView.builder(
        padding: const EdgeInsets.only(top: 20, bottom: 30),
        itemCount: controller.tasks.length,
        itemBuilder: (context, index) {
          final task = controller.tasks[index];
          return TaskCard(
            title: task.title ?? '',
            description: task.description ?? '',
            status: task.status ?? '',
            time: task.createdAt ?? '',
            priority: task.status ?? '',
          );
        },
      )),
    );
  }
}
