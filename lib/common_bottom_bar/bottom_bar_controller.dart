import 'package:expanse_manage/analytics/analytics.dart';
import 'package:expanse_manage/home_page/home_page.dart';
import 'package:expanse_manage/my_profile/profile.dart';
import 'package:expanse_manage/screens/wallet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  PageController pageController = PageController();
  late AnimationController animationController;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  Duration duration = const Duration(microseconds: 300);
  Curve curve = Curves.ease;
  int currentIndex = 0;

  void bottomTaped(int index) {
    currentIndex = index;
    pageController.animateToPage(index, duration: duration, curve: curve);
    update();
  }

  List<IconData> icons = [Icons.logout, Icons.login];

  List<Widget> pageView = [
    HomePage(),
    Analytics(),
    const Wallet(),
    Profile(),
  ];
}
