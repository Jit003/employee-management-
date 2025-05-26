import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kredipal/services/voice_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AttendanceController extends GetxController {
  var isPunchedIn = false.obs;
  var punchInTime = Rxn<DateTime>();
  var punchOutTime = Rxn<DateTime>();
  var totalDuration = "".obs;

  void togglePunch() {
    if (!isPunchedIn.value) {
      punchInTime.value = DateTime.now();
      punchOutTime.value = null;
      totalDuration.value = "";
      speak('Login Successfull');
      Fluttertoast.showToast(
          msg: "Log-in Successfull",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
      punchOutTime.value = DateTime.now();
      calculateDuration();
      speak('Logout Successfull');
      Fluttertoast.showToast(
          msg: "Log-Out Successfull",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    isPunchedIn.value = !isPunchedIn.value;
  }

  void calculateDuration() {
    if (punchInTime.value != null && punchOutTime.value != null) {
      final diff = punchOutTime.value!.difference(punchInTime.value!);
      final hours = diff.inHours;
      final minutes = diff.inMinutes % 60;
      final seconds = diff.inSeconds % 60;
      totalDuration.value = "${hours}h ${minutes}m ${seconds}s";
    }
  }

  String formatTime(DateTime? time) {
    if (time == null) return "--:--";
    return DateFormat('hh:mm:ss a').format(time);
  }
}
