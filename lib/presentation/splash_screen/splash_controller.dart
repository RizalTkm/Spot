import 'package:get/get.dart';
import 'package:spot/infrastructure/wrapper.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(
        const Duration(seconds: 3), () => Get.offAll(const Wrapper()));
  }
}
