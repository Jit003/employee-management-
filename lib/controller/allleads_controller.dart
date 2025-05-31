import 'package:get/get.dart';

class LeadsController extends GetxController {
  var leads = <RxMap<String, String>>[
    RxMap({'name': 'John Doe', 'status': 'Pending'}),
    RxMap({'name': 'Jane Smith', 'status': 'Pending'}),
    RxMap({'name': 'Alex Johnson', 'status': 'Pending'}),
    RxMap({'name': 'John Doe', 'status': 'Pending'}),
    RxMap({'name': 'Jane Smith', 'status': 'Pending'}),
    RxMap({'name': 'Alex Johnson', 'status': 'Pending'}),
  ].obs;

  var selectedStatus = 'All'.obs;

  // Reactive filtered list
  var filteredLeads = <RxMap<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initially fill filteredLeads
    updateFilteredLeads();

    // Listen to selectedStatus changes and update filtered list accordingly
    ever(selectedStatus, (_) {
      updateFilteredLeads();
    });
  }

  void updateFilteredLeads() {
    if (selectedStatus.value == 'All') {
      filteredLeads.assignAll(leads);
    } else {
      filteredLeads.assignAll(
          leads.where((lead) => lead['status']!.toLowerCase() == selectedStatus.value.toLowerCase())
      );
    }
  }

  void deleteLead(int index) {
    // Remove from leads list, which triggers update in filteredLeads if you re-call updateFilteredLeads()
    leads.removeAt(index);
    updateFilteredLeads();
  }

  void markAsForward(int index) {
    // Update status reactively
    filteredLeads[index]['status'] = 'forward to TL';
    filteredLeads.refresh();

    // Also update the main leads list
    int mainIndex = leads.indexWhere((lead) => lead['name'] == filteredLeads[index]['name']);
    if (mainIndex != -1) {
      leads[mainIndex]['status'] = 'forward to TL';
      leads.refresh();
    }

    updateFilteredLeads();
  }

  void markAsRejected(int index) {
    filteredLeads[index]['status'] = 'Rejected';
    filteredLeads.refresh();

    int mainIndex = leads.indexWhere((lead) => lead['name'] == filteredLeads[index]['name']);
    if (mainIndex != -1) {
      leads[mainIndex]['status'] = 'Rejected';
      leads.refresh();
    }

    updateFilteredLeads();
  }
}
