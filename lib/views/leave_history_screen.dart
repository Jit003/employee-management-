import 'package:flutter/material.dart';
import 'package:kredipal/constant/app_color.dart';
import 'package:kredipal/widgets/custom_app_bar.dart';

class LeaveHistoryScreen extends StatelessWidget {
  const LeaveHistoryScreen({super.key});

  final List<Map<String, String>> leaveHistory = const [
    {
      'type': 'Sick Leave',
      'from': '2025-05-01',
      'to': '2025-05-03',
      'reason': 'Fever and weakness',
      'status': 'Approved'
    },
    {
      'type': 'Casual Leave',
      'from': '2025-04-20',
      'to': '2025-04-21',
      'reason': 'Family function',
      'status': 'Pending'
    },
    {
      'type': 'Paid Leave',
      'from': '2025-03-10',
      'to': '2025-03-12',
      'reason': 'Vacation trip',
      'status': 'Rejected'
    },
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      case 'Pending':
      default:
        return Colors.orange;
    }
  }

  IconData getLeaveIcon(String type) {
    switch (type) {
      case 'Sick Leave':
        return Icons.local_hospital;
      case 'Casual Leave':
        return Icons.event;
      case 'Paid Leave':
        return Icons.card_giftcard;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Leave History'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: leaveHistory.length,
        itemBuilder: (context, index) {
          final leave = leaveHistory[index];
          return Card(
            elevation: 5,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.teal.shade100,
                        child: Icon(getLeaveIcon(leave['type']!), color: Colors.teal),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        leave['type'] ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Chip(
                        label: Text(leave['status']!),
                        backgroundColor: getStatusColor(leave['status']!).withOpacity(0.2),
                        labelStyle: TextStyle(
                          color: getStatusColor(leave['status']!),
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.date_range, size: 16, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text(
                        "${leave['from']} to ${leave['to']}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    leave['reason'] ?? '',
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
