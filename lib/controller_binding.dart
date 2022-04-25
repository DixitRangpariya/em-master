import 'package:expanse_manage/common_bottom_bar/bottom_bar_controller.dart';
import 'package:expanse_manage/controller/auth_controller.dart';
import 'package:expanse_manage/splash_screen/splash_screen_controller.dart';
import 'package:get/get.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(()=>AuthController());
  }
}

class OnBoardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>SplashScreenController());
  }
}

class BottomBarBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>BottomBarController());
  }
}
