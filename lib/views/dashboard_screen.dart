import 'package:flutter/material.dart';
import 'package:kredipal/constant/app_color.dart';

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
            expandedHeight: 150,
            pinned: true,
            backgroundColor: AppColor.appBarColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Gradient Background
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColor.appBarColor, Colors.teal.shade300],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  // Optional: Blur/Overlay for effect
                  Container(
                    color: Colors.black.withOpacity(0.2),
                  ),
                  // App Bar Content
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 60, 16, 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile Image
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            'https://i.pravatar.cc/100?img=4', // Replace with your asset or network image
                          ),
                        ),
                        SizedBox(width: 16),
                        // Welcome Texts
                        Expanded(
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
                        // Notification Icon
                        Icon(Icons.notifications_none, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
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
                      _dashboardCard(
                          icon: Icons.access_time,
                          label: "Attendance",
                          color: Colors.blue),
                      _dashboardCard(
                          icon: Icons.person_outline,
                          label: "Profile",
                          color: Colors.deepPurple),
                      _dashboardCard(
                          icon: Icons.task_outlined,
                          label: "Tasks",
                          color: Colors.orange),
                    ],
                  ),

                  const SizedBox(height: 30),

                  /// Today’s Highlights
                  Text(
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

                  const SizedBox(height: 30),


                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Reusable Dashboard Card
  Widget _dashboardCard({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.8), color.withOpacity(0.5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 30),
            const SizedBox(height: 8),
            Text(label,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
