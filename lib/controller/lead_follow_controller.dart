import 'package:get/get.dart';

class LeadFollowController extends GetxController {
  var isFollowing = false.obs;

  void toggleFollow(){
    isFollowing.value = !isFollowing.value;
  }
}