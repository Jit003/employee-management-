import 'package:flutter/material.dart';
import 'package:kredipal/constant/app_color.dart';

class AttendanceHistoryScreen extends StatelessWidget {
  const AttendanceHistoryScreen({super.key});

  final List<Map<String, String>> dummyData = const [
    {
      "date": "2025-05-21",
      "checkIn": "09:15 AM",
      "checkOut": "06:00 PM",
      "status": "Present",
    },
    {
      "date": "2025-05-20",
      "checkIn": "10:45 AM",
      "checkOut": "04:30 PM",
      "status": "Late",
    },
    {
      "date": "2025-05-19",
      "checkIn": "—",
      "checkOut": "—",
      "status": "Absent",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColor.appBarColor,
        title: const Text(
          "Attendance History",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: dummyData.length,
        itemBuilder: (context, index) {
          final item = dummyData[index];
          return _attendanceCard(
            date: item["date"]!,
            checkIn: item["checkIn"]!,
            checkOut: item["checkOut"]!,
            status: item["status"]!,
          );
        },
      ),
    );
  }

  Widget _attendanceCard({
    required String date,
    required String checkIn,
    required String checkOut,
    required String status,
  }) {
    final Color statusColor = status == "Present"
        ? Colors.green
        : status == "Late"
        ? Colors.orange
        : Colors.red;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.grey.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: statusColor.withOpacity(0.2),
            child: Icon(
              status == "Present"
                  ? Icons.check_circle
                  : status == "Late"
                  ? Icons.access_time
                  : Icons.cancel,
              color: statusColor,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const SizedBox(width: 4),
                    Text("In: $checkIn"),
                    const SizedBox(width: 1),
                    const SizedBox(width: 4),
                    Text("Out: $checkOut"),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
