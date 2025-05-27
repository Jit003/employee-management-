import 'package:flutter/material.dart';
import 'package:kredipal/constant/app_color.dart';
import 'package:kredipal/widgets/custom_app_bar.dart';

import '../widgets/attendance_history_widget.dart';

class AttendanceHistoryScreen extends StatelessWidget {
  const AttendanceHistoryScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: CustomAppBar(title: 'Attendance History'),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => AttendanceCard(
          index: index,
          date: "2025-05-${index + 1}",
          checkIn: "09:00 AM",
          checkOut: "05:00 PM",
          status: index % 2 == 0 ? "Present" : "Absent",
        ),
      ),
    );
  }

}
