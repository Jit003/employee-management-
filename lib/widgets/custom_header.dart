import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kredipal/controller/current_time_controller.dart';
import '../constant/app_color.dart';

Widget customHeader(String text, [String? time]) {
  final TimeController timeController = Get.put(TimeController());
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
    decoration: BoxDecoration(
     color: AppColor.appBarColor,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(24),
        bottomRight: Radius.circular(24),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        if (time != null)
          Obx(() {
            return Text(
              'Time ${timeController.currentTime.value}',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            );
          }),
      ],
    ),
  );
}
