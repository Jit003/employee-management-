import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../models/finance_model.dart';
import '../services/finance_api_service.dart';

class FinanceDashboardController extends GetxController {
  final FinanceDashboardApiService _apiService = Get.put(FinanceDashboardApiService());

  // Token - should be passed from auth controller
  final RxString token = ''.obs;

  // Observable variables
  final Rx<FinanceDashboardData?> dashboardData = Rx<FinanceDashboardData?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxList<String> motivationalQuotes = <String>[
    "Your financial freedom starts with a single step forward! 💪",
    "Every loan approved brings dreams closer to reality! 🌟",
    "Success in finance is built on trust and dedication! 🏆",
    "Today's effort is tomorrow's financial security! 💰",
    "Excellence in service creates lasting relationships! 🤝",
  ].obs;

  final RxInt currentQuoteIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Set token - replace with actual token from auth controller
    token.value = 'your_auth_token_here';
    fetchDashboardData();
    _startQuoteRotation();
  }

  void _startQuoteRotation() {
    // Rotate quotes every 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      if (currentQuoteIndex.value < motivationalQuotes.length - 1) {
        currentQuoteIndex.value++;
      } else {
        currentQuoteIndex.value = 0;
      }
      _startQuoteRotation();
    });
  }

  Future<void> fetchDashboardData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _apiService.getDashboardData(token: token.value);
      dashboardData.value = response;

    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  String formatCurrency(String amount) {
    try {
      double value = double.parse(amount);
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

  Color getColorFromString(String colorString) {
    switch (colorString.toLowerCase()) {
      case 'blue':
        return const Color(0xFF3B82F6);
      case 'green':
        return const Color(0xFF10B981);
      case 'orange':
        return const Color(0xFFF59E0B);
      case 'purple':
        return const Color(0xFF8B5CF6);
      case 'red':
        return const Color(0xFFEF4444);
      case 'indigo':
        return const Color(0xFF6366F1);
      case 'pink':
        return const Color(0xFFEC4899);
      case 'teal':
        return const Color(0xFF14B8A6);
      default:
        return const Color(0xFF6B7280);
    }
  }

  IconData getIconFromString(String iconString) {
    switch (iconString.toLowerCase()) {
      case 'person':
        return Icons.person_outline_rounded;
      case 'business':
        return Icons.business_center_outlined;
      case 'home':
        return Icons.home_outlined;
      case 'credit_card':
        return Icons.credit_card_outlined;
      case 'calculator':
        return Icons.calculate_outlined;
      case 'chart':
        return Icons.bar_chart_rounded;
      case 'support':
        return Icons.support_agent_outlined;
      case 'document':
        return Icons.description_outlined;
      default:
        return Icons.help_outline_rounded;
    }
  }

  // Method to set token from auth controller
  void setToken(String authToken) {
    token.value = authToken;
    fetchDashboardData();
  }

  void navigateToLoanProduct(String route) {
    Get.toNamed(route);
  }

  void navigateToQuickAction(String route) {
    Get.toNamed(route);
  }
}
