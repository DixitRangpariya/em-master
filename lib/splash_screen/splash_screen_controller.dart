import 'package:expanse_manage/res/app_image.dart';
import 'package:expanse_manage/signup_screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  RxBool isSelected = false.obs;
  RxInt commonIndex = 0.obs;

  var listSplash = [
    {
      'image': AppImage.oB1,
      'titleText': '\nBe easier to manage\n your own money\n',
      'explainText':
          'Just using your phone ,you can manage\n all your cash flow more easy and detail\n',
      'buttonText': 'Next'
    },
    {
      'image': AppImage.oB2,
      'titleText': '\nBe more flexible\n and secure\n',
      'explainText':
          'Use this platform in all your device ,\n  don\'t worry we will protect you\n',
      'buttonText': 'Next'
    },
    {
      'image': AppImage.oB3,
      'titleText': '\nBe more mindful spending\n So, let\'s get started !\n',
      'explainText':
          'Just using your phone ,you can manage\n all your cash flow more easy and detail\n',
      'buttonText': 'Get Started'
    }
  ];

  showSplashScreen() {
    if (commonIndex < listSplash.length && isSelected.value) {
      commonIndex.value = commonIndex.value + 1;
      debugPrint('index ${commonIndex.value}');
      update();
    } else if (!isSelected.value) {
      if (commonIndex.value == 0) {
        return commonIndex.value = 0;
      }
      commonIndex.value = commonIndex.value - 1;

      update();
    } else {
      return null;
    }
  }

  void onNext() {
    isSelected.value = true;
    commonIndex.value == 2 ? Get.to(SignUpScreen()) : showSplashScreen();
    debugPrint('Common Index ::${commonIndex.value}');
  }

  void onBack() {
    isSelected.value = false;
    showSplashScreen();
    debugPrint('Common Index ::${commonIndex.value}');
  }
}
