import 'package:get/get.dart';

class LeadsController extends GetxController {
  var leads = <Map<String, String>>[
    {'name': 'John Doe', 'status': 'Pending'},
    {'name': 'Jane Smith', 'status': 'Pending'},
    {'name': 'Alex Johnson', 'status': 'Pending'},
  ].obs;

  void deleteLead(int index) {
    leads.removeAt(index);
  }

  void markAsCompleted(int index) {
    leads[index]['status'] = 'Completed';
    leads.refresh();
  }

  void markAsNotCompleted(int index) {
    leads[index]['status'] = 'Not Completed';
    leads.refresh();
  }
}
