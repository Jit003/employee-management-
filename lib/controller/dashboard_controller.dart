import 'package:get/get.dart';
import 'package:kredipal/controller/login-controller.dart';
import '../models/dashboard_model.dart';
import '../services/dashboard_api_services.dart';

class DashboardController extends GetxController {
  var dashboardData = DashboardModel().obs;
  var isLoading = true.obs;
  var selectedLeadType = 'all'.obs;
  var selectedStatus = 'all'.obs;
  var startDate = ''.obs;
  var endDate = ''.obs;
  var dateFilter = 'this_month'.obs; // default: "date_range"

  final AuthController authController = Get.find<AuthController>();

  final DashboardApiService _apiService = DashboardApiService();

  @override
  void onInit() {
    if (authController.token.value.isNotEmpty) {
      loadDashboardData();
      // Auto-refresh on filter change
      ever(selectedLeadType, (_) => loadDashboardData());
      ever(selectedStatus, (_) => loadDashboardData());
      ever(dateFilter, (_) => loadDashboardData());
      ever(startDate, (_) => loadDashboardData());
      ever(endDate, (_) => loadDashboardData());

      super.onInit();
    }
    super.onInit();
  }

  Future<void> loadDashboardData() async {
    try {
      isLoading(true);
      final result = await _apiService.fetchDashboardData(
        token: authController.token.value,
        dateFilter: dateFilter.value,
        startDate: startDate.value.isNotEmpty ? startDate.value : null,
        endDate: endDate.value.isNotEmpty ? endDate.value : null,
        leadType: selectedLeadType.value,
        status: selectedStatus.value,
      );
      dashboardData(result);
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
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
}
