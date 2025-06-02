import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String status;
  final String time;
  final String priority;

  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.status,
    required this.time,
    required this.priority,
  });

  Color getPriorityColor() {
    switch (priority) {
      case "High":
        return Colors.redAccent;
      case "Medium":
        return Colors.orangeAccent;
      case "Low":
        return Colors.green;
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and priority
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Chip(
                  backgroundColor: getPriorityColor().withOpacity(0.2),
                  label: Text(
                    priority,
                    style: TextStyle(color: getPriorityColor()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Description
            Text(
              description,
              style: const TextStyle(color: Colors.black87),
            ),
            const SizedBox(height: 12),

            // Time and status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 18, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(time),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
