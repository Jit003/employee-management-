import 'dart:ui';
import 'package:get/get.dart';
import 'package:kredipal/routes/app_routes.dart';
import '../models/all_leads_model.dart';
import '../services/lead_api_service.dart';

class AllLeadsController extends GetxController {
  final LeadsApiService _apiService = Get.put(LeadsApiService());

  final RxList<Leads> allLeads = <Leads>[].obs;
  final Rx<Aggregates?> aggregates = Rx<Aggregates?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchQuery = ''.obs;
  final RxString selectedStatus = 'all'.obs;

  // Filtered leads based on search and status
  List<Leads> get filteredLeads {
    List<Leads> leads = allLeads;

    // Filter by status
    if (selectedStatus.value != 'all') {
      leads = leads.where((lead) =>
      lead.status?.toLowerCase() == selectedStatus.value.toLowerCase()
      ).toList();
    }

    // Filter by search query
    if (searchQuery.value.isNotEmpty) {
      leads = leads.where((lead) =>
      lead.name?.toLowerCase().contains(searchQuery.value.toLowerCase()) == true ||
          lead.phone?.contains(searchQuery.value) == true ||
          lead.email?.toLowerCase().contains(searchQuery.value.toLowerCase()) == true ||
          lead.companyName?.toLowerCase().contains(searchQuery.value.toLowerCase()) == true
      ).toList();
    }

    return leads;
  }

  @override
  void onInit() {
    super.onInit();
    fetchAllLeads();
  }

  Future<void> fetchAllLeads() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _apiService.getAllLeads();

      if (response.status == 'success' && response.data != null) {
        allLeads.value = response.data!.leads ?? [];
        aggregates.value = response.data!.aggregates;
      } else {
        throw Exception(response.message ?? 'Failed to fetch leads');
      }

    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to fetch leads: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void updateStatusFilter(String status) {
    selectedStatus.value = status;
  }

  Color getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'approved':
        return const Color(0xFF27AE60);
      case 'pending':
        return const Color(0xFFE67E22);
      case 'disbursed':
        return const Color(0xFF9B59B6);
      case 'rejected':
        return const Color(0xFFE74C3C);
      default:
        return const Color(0xFF95A5A6);
    }
  }

  String formatCurrency(dynamic amount) {
    if (amount == null) return '₹0';

    try {
      double value;

      if (amount is int) {
        value = amount.toDouble();
      } else if (amount is double) {
        value = amount;
      } else if (amount is String) {
        value = double.parse(amount);
      } else {
        return '₹0';
      }

      if (value >= 10000000) {
        return '₹${(value / 10000000).toStringAsFixed(1)}Cr';
      } else if (value >= 100000) {
        return '₹${(value / 100000).toStringAsFixed(1)}L';
      } else if (value >= 1000) {
        return '₹${(value / 1000).toStringAsFixed(1)}K';
      } else {
        return '₹${value.toStringAsFixed(0)}';
      }
    } catch (e) {
      return '₹0';
    }
  }

  void navigateToLeadDetails(Leads lead) {
    Get.toNamed(AppRoutes.leadDetails, arguments: lead);
  }
}
