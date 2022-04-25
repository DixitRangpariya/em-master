
import 'package:expanse_manage/res/app_color.dart';
import 'package:flutter/material.dart';


class CommonTabBar extends StatelessWidget {
  final List<Widget> tabs;
  final TabController? controller;

  const CommonTabBar({Key? key, required this.tabs, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TabBar(
          labelColor: AppColor.white,
          labelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
          unselectedLabelColor: AppColor.textColorDark,
          indicator: BoxDecoration(
              color: AppColor.darkBlue,
              gradient: AppColor.buttonGradient,
              borderRadius: BorderRadius.circular(15),
              shape: BoxShape.rectangle),
          controller: controller,
          tabs: tabs,
        ),

    );
  }
}
