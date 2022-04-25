import 'package:expanse_manage/common_widget/common_text.dart';
import 'package:expanse_manage/common_widget/common_text_form_field.dart';
import 'package:expanse_manage/common_widget/common_textbutton.dart';
import 'package:expanse_manage/res/app_image.dart';
import 'package:expanse_manage/screens/checkmark.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common_widget/common_appbar.dart';
import '../res/app_color.dart';

class Tips extends StatefulWidget {
  const Tips({Key? key}) : super(key: key);

  @override
  State<Tips> createState() => _TipsState();
}

class _TipsState extends State<Tips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar(
            title: 'Add Loan', hasBackIcon: true, actionIcon: Icon(Icons.add)),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        stops: [
                          0.13,
                          0.90,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color.fromARGB(255, 50, 67, 114),
                          Color.fromARGB(255, 80, 114, 172),
                        ],
                      )),
                  // height: 100,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: CustomText('Create a Financial Calendar',
                              fontWeight: FontWeight.w500,
                              size: 15,
                              color: AppColor.white),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.arrow_circle_right,
                          size: 30,
                          color: AppColor.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
