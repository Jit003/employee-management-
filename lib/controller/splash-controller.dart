import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class SplashController extends GetxController {
  var showLogo = false.obs;

  @override
  void onInit() {
    super.onInit();
    // After 2 seconds show logo
    Future.delayed(const Duration(seconds: 2), () {
      showLogo.value = true;
    });
    // Navigate after total 4 seconds
  }
}
