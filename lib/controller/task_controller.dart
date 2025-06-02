import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/all_task_model.dart';
import '../services/api_services.dart';

class TaskController extends GetxController {
  var tasks = <Data>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    isLoading.value = true;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';

      final response = await ApiService.getTaskDetails(token);

      if (response['status'] == 'success') {
        final taskList = AllTaskList.fromJson(response);
        if (taskList.data != null && taskList.data!.isNotEmpty) {
          tasks.assignAll(taskList.data!);  // Add all tasks to observable list
        } else {
          tasks.clear();
        }
      } else {
        Get.snackbar('Error', response['message'] ?? 'Failed to load tasks');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load tasks: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
