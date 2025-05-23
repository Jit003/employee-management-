import 'package:get/get.dart';
import 'package:kredipal/constant/app_images.dart';
import 'package:video_player/video_player.dart';
import '../routes/app_routes.dart'; // Import your route config

class SplashController extends GetxController {
  late VideoPlayerController videoController;
  var isInitialized = false.obs;

  @override
  void onInit() {
    super.onInit();
    videoController = VideoPlayerController.asset(AppImages.splashVdo)
      ..initialize().then((_) {
        isInitialized.value = true;
        videoController.play();
        update();

        // Listen for video end
        videoController.addListener(() {
          if (videoController.value.position >= videoController.value.duration) {
            navigateToNext();
          }
        });
      });
  }

  void navigateToNext() {
    Get.offNamed(AppRoutes.login); // Navigate to login or your next screen
  }

  @override
  void onClose() {
    videoController.dispose();
    super.onClose();
  }
}
