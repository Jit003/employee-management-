import 'package:get/get.dart';

class AttendanceHistoryController extends GetxController {
  final RxMap<int, bool> expandedCards = <int, bool>{}.obs;

  void toggleCard(int index) {
    expandedCards[index] = !(expandedCards[index] ?? false);
  }

  bool isExpanded(int index) {
    return expandedCards[index] ?? false;
  }
}
