import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/leads_chart_controller.dart';

class LeadsBarChart extends StatelessWidget {
  final List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  final leadsController = Get.put(ChartLeadsController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return BarChart(
        BarChartData(
          barTouchData: BarTouchData(enabled: true),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= 0 && value.toInt() < days.length) {
                    return Text(days[value.toInt()], style: TextStyle(fontSize: 10));
                  } else {
                    return Text('');
                  }
                },
                interval: 1,
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(
            leadsController.leadsData.length,
                (index) => BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: leadsController.leadsData[index].toDouble(),
                  width: 16,
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(6),
                ),
              ],
            ),
          ),
        ),
        swapAnimationDuration: const Duration(milliseconds: 800),
        swapAnimationCurve: Curves.easeInOut,
      );
    });
  }
}
