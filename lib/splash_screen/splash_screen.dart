import 'package:expanse_manage/common_widget/common_text.dart';
import 'package:expanse_manage/res/app_color.dart';
import 'package:expanse_manage/splash_screen/splash_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/splashScreen';
  SplashScreen({Key? key}) : super(key: key);
  final SplashScreenController splashScreenController =
      Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(
      init: splashScreenController,
      builder: (controller) {
        int commonIndex = splashScreenController.commonIndex.value;
        var listSplash = splashScreenController.listSplash[commonIndex];
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  '${listSplash['image']}',
                  height: Get.height / 2,
                  width: Get.width,
                  fit: BoxFit.contain,
                ),
              ),
              CustomText(
                '${listSplash['titleText']}',
                fontWeight: FontWeight.bold,
                size: 25,
                color: AppColor.textColorDark,
                textAlign: TextAlign.center,
              ),
              CustomText(
                '${listSplash['explainText']}',
                size: 14,
                color: AppColor.textColor,
                height: 2,
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0;
                      i < splashScreenController.listSplash.length;
                      i++)
                    AnimatedContainer(
                      duration: 300.milliseconds,
                      width: i == commonIndex ? Get.width / 15 : Get.width / 36,
                      height: 9,
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: i == commonIndex
                              ? AppColor.darkBlue
                              : AppColor.lightBlue),
                    )
                ],
              ),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            elevation: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                splashScreenController.commonIndex.value == 0
                    ? nextButton(commonIndex)
                    : backButton(commonIndex),
                if (splashScreenController.commonIndex.value != 0)
                  nextButton(commonIndex)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget nextButton(int commonIndex) {
    return TextButton(
      onPressed: splashScreenController.onNext,
      child: Container(
        child: CustomText(
          '${splashScreenController.listSplash[commonIndex]['buttonText']}',
          size: 16,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.bold,
          color: AppColor.white,
        ),
        height: Get.height / 15,
        width: splashScreenController.commonIndex.value == 0
            ? Get.width / 1.5
            : Get.width / 2.5,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: AppColor.shadowColor,
                offset: Offset(0, 10),
                blurRadius: 5)
          ],
          gradient: AppColor.buttonGradient,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
    );
  }

  Widget backButton(int commonIndex) {
    return TextButton(
      onPressed: splashScreenController.onBack,
      child: const CustomText(
        'Back',
        size: 16,
        color: AppColor.textColorDark,
      ),
      style: TextButton.styleFrom(
          fixedSize: const Size(150, 50),
          splashFactory: NoSplash.splashFactory),
    );
  }
}
