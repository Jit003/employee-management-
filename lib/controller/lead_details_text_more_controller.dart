import 'package:get/get.dart';

class MoreTextController extends GetxController {
  var isMore = false.obs;

  moreText(){
    isMore.value = !isMore.value;
  }
}