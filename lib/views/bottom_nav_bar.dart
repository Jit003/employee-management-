import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kredipal/constant/app_color.dart';
import 'package:kredipal/routes/app_routes.dart';
import '../controller/bottom_nav_controller.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavController controller = Get.find();

    // Define navigation items with icons and labels
    final List<Map<String, dynamic>> navItems = [
      {'icon': Icons.home_rounded, 'label': 'Dashboard'},
      {'icon': Icons.list_alt_rounded, 'label': 'All Leads'},
      {'icon': Icons.event_available_rounded, 'label': 'Attendance'},
      {'icon': Icons.person_rounded, 'label': 'Account'},
    ];

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        // Custom shaped bottom navigation bar
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width, 90),
          painter: BottomNavBarPainter(),
          child: SizedBox(
            height: 70,
            width: double.infinity,
            child: Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(navItems.length, (index) {
                  final isSelected = controller.selectedIndex.value == index;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => controller.changePage(index),
                      behavior: HitTestBehavior.translucent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 8),
                          Icon(
                            navItems[index]['icon'],
                            size: 20,
                            color: isSelected ? Colors.orange : Colors.white70,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            navItems[index]['label'],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                              color: isSelected ? Colors.orange : Colors.white54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              );
            }),
          ),
        ),

        // Center FAB Button
        Positioned(
          top: -35, // Move FAB up to sit within the curve
          child: GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.addLead);
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Custom painter for the curved navigation bar
class BottomNavBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColor.appBarColor
      ..style = PaintingStyle.fill;

    Path path = Path();

    // Start from the left bottom corner
    path.moveTo(0, 0);

    // Draw line to the start of the curve
    path.lineTo(size.width * 0.35, 0);

    // Draw a smoother, deeper curve for the FAB
    path.quadraticBezierTo(
      size.width * 0.40, 0,
      size.width * 0.42, 40,
    );
    path.quadraticBezierTo(
      size.width * 0.0, 70,
      size.width * 0.0, 40,
    );
    path.quadraticBezierTo(
      size.width * 0.0, 0,
      size.width * 0.0, 0,
    );

    // Draw line to the right bottom corner
    path.lineTo(size.width, 0);

    // Draw line to the right top corner
    path.lineTo(size.width, size.height);

    // Draw line to the left top corner
    path.lineTo(0, size.height);

    // Close the path
    path.close();

    // Draw shadow
    Paint shadowPaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    canvas.drawPath(path, shadowPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// Scaffold implementation example
class BottomNavScaffold extends StatelessWidget {
  final Widget body;

  const BottomNavScaffold({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: body,
      bottomNavigationBar: const CustomBottomNavBar(),
      extendBody: true, // Allow content to extend behind the nav bar
    );
  }
}