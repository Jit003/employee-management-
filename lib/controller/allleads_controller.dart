import 'package:get/get.dart';

class LeadsController extends GetxController {
  var leads = <Map<String, String>>[
    {'name': 'John Doe', 'status': 'Pending'},
    {'name': 'Jane Smith', 'status': 'Pending'},
    {'name': 'Alex Johnson', 'status': 'Pending'},
  ].obs;
  var selectedStatus = 'All'.obs;


  List<Map<String,String>> get filteredLeads{
    if(selectedStatus.value == 'All') {
      return leads;
    } else{
      return leads.where((lead)=>lead['status'] == selectedStatus.value).toList();
    }
  }

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
