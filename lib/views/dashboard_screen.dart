import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kredipal/constant/app_color.dart';
import 'package:kredipal/routes/app_routes.dart';

import '../widgets/dashboard_widget.dart';
import '../widgets/leads_bar_chart.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          /// Sliver App Bar (remains same)
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 140,
            pinned: true,
            backgroundColor: AppColor.appBarColor,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                // Check the current height of the app bar
                var top = constraints.biggest.height;

                return FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding: EdgeInsets.only(left: 10, bottom: 16),
                  title: top <= kToolbarHeight + 50
                      ? Row(
                          children: [
                            const CircleAvatar(
                              radius: 17,
                              backgroundImage: NetworkImage(
                                  'https://i.pravatar.cc/100?img=4'),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              "Welcome Back 👋",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ],
                        )
                      : null,
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: BoxDecoration(color: AppColor.appBarColor),
                      ),
                      Container(
                        color: Colors.black.withOpacity(0.2),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 60, 16, 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  'https://i.pravatar.cc/100?img=4'),
                            ),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Welcome Back 👋",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Hope you're having a productive day!",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Get.toNamed(AppRoutes.notification);
                              },
                              icon: const Icon(Icons.notifications,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          /// Unique Body Design
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Quick Actions Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      dashboardCard(
                          icon: Icons.access_time,
                          label: "Attendance",
                          color: Colors.blue),
                      dashboardCard(
                          icon: Icons.person_outline,
                          label: "Profile",
                          color: Colors.deepPurple),
                      dashboardCard(
                          icon: Icons.task_outlined,
                          label: "Tasks",
                          color: Colors.orange),
                    ],
                  ),

                  const SizedBox(height: 30),
                  Text(
                    "Leads Achieved This Week",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColor.appBarColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 220,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 6,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: LeadsBarChart(), // Custom chart widget you defined
                  ),
                  const SizedBox(height: 30),

                  /// Today’s Highlights
                  const Text(
                    "Today's Overview",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColor.appBarColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green.shade50, Colors.green.shade100],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.shade100,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.insights, color: Colors.green, size: 30),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "2 tasks completed today.\nKeep up the good work!",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// Add a new section below “Today’s Overview”

                  /// Motivation Box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.format_quote,
                            color: Colors.purple, size: 30),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "“Success is not final, failure is not fatal: It is the courage to continue that counts.”",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
