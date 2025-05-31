import 'package:get/get.dart';

class Task {
  final String title;
  final String description;
  final String status;
  final String time;
  final String priority;

  Task({
    required this.title,
    required this.description,
    required this.status,
    required this.time,
    required this.priority,
  });
}

class TaskController extends GetxController {
  final tasks = <Task>[
    Task(
      title: " 5 New Loan Applications",
      description: "Reviewed and validated 5 loan applications submitted today",
      status: "Completed",
      time: "10:00 AM",
      priority: "High",
    ),
    Task(
      title: "Approved 3 Eligible Loans",
      description: "Cross-checked documents and approved 3 valid applications",
      status: "Completed",
      time: "11:30 AM",
      priority: "Medium",
    ),
    Task(
      title: "Called 4 Loan Applicants",
      description: "Followed up with applicants to verify employment and income details",
      status: "Completed",
      time: "1:00 PM",
      priority: "Low",
    ),
    Task(
      title: "Updated Loan Status",
      description: "Marked approved,s rejected, and pending statuses for 10 loans",
      status: "Completed",
      time: "3:00 PM",
      priority: "Medium",
    ),
    Task(
      title: "Generated EMI Plan",
      description: "Calculated and saved EMI schedules based on tenure and rate",
      status: "Completed",
      time: "4:30 PM",
      priority: "Low",
    ),

  ].obs;
}
