import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kredipal/views/add_leads.dart';
import '../constant/app_color.dart';
import '../controller/bottom_nav_controller.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavController controller = Get.find();

    final List<IconData> icons = [
      Icons.home,
      Icons.leaderboard,
      Icons.present_to_all,
      Icons.person,
    ];

    final List<String> labels = [
      'Home',
      'Leads',
      'Attendance',
      'Profile',
    ];

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 60,
          decoration:  const BoxDecoration(
            color: AppColor.btmNavBarColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(4, (index) {
                final isSelected = controller.selectedIndex.value == index;
                return GestureDetector(
                  onTap: () => controller.changePage(index),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: isSelected ? Colors.red : Colors.transparent,
                        ),
                        child: Icon(
                          icons[index],
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        labels[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                );
              }),
            );
          }),
        ),
        // Floating Action Button Positioned
        Positioned(
          top: -30,
          left: 0,
          right: 0,
          child: Center(
            child: GestureDetector(
              onTap: () {
                print('Custom FAB pressed');
                Get.to(()=>const AddLeadsPage());
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.red, // FAB background color
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: Colors.white, width: 4), // Optional white border
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white, // Icon color
                  size: 30,
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}
