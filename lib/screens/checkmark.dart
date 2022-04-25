import 'package:expanse_manage/common_widget/common_text.dart';
import 'package:expanse_manage/common_widget/common_textbutton.dart';
import 'package:expanse_manage/res/app_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common_bottom_bar/common_bottom_bar.dart';

class Chekmark extends StatefulWidget {
  const Chekmark({Key? key}) : super(key: key);

  @override
  State<Chekmark> createState() => _ChekmarkState();
}

class _ChekmarkState extends State<Chekmark> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.,
          children: [
            CustomText(
              'Success',
              size: 25,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: 50,
            ),
            CustomText(
              'Your Task is Completed',
              size: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.5),
            ),
            SizedBox(
              height: 20,
            ),
            Image.asset(
              AppImage.check,
              height: 300.0,
              width: double.infinity,
            ),
            CommonTextButton(
              onPressed: () {
                // Get.to(CommonBottomBar());
              },
              text: 'Back TO Home',
            )
          ],
        ),
      ),
    ));
  }
}
