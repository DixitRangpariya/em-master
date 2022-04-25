import 'package:expanse_manage/Bugest/addtrip.dart';
import 'package:expanse_manage/common_widget/common_appbar.dart';
import 'package:expanse_manage/common_widget/common_iconbutton.dart';
import 'package:expanse_manage/common_widget/common_text.dart';
import 'package:expanse_manage/common_widget/widget.dart';
import 'package:expanse_manage/res/app_color.dart';
import 'package:expanse_manage/res/app_image.dart';
import 'package:expanse_manage/screens/addbill.dart';
import 'package:expanse_manage/screens/addbudget.dart';
import 'package:expanse_manage/screens/addintrest.dart';
import 'package:expanse_manage/screens/addloan.dart';
import 'package:expanse_manage/screens/loandetails.dart';
import 'package:expanse_manage/screens/tips.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

import '../common_widget/common_textbutton.dart';
import 'addinvestment.dart';

class Wallet extends StatelessWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar(
          title: 'More',
          hasBackIcon: false,
        ),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(Addloan());
                  },
                  child: Container(
                    decoration: boxDecoration(),
                    // height: 100,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText('Loan Detail',
                              fontWeight: FontWeight.w500,
                              size: 20,
                              color: AppColor.white),
                          Icon(
                            Icons.arrow_circle_right,
                            size: 30,
                            color: AppColor.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(Investment());
                  },
                  child: Container(
                    decoration: boxDecoration(),
                    // height: 100,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText('Investment Detail',
                              fontWeight: FontWeight.w500,
                              size: 20,
                              color: AppColor.white),
                          Icon(
                            Icons.arrow_circle_right,
                            size: 30,
                            color: AppColor.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(Intrest());
                  },
                  child: Container(
                    decoration: boxDecoration(),
                    // height: 100,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText('Intrest Detail',
                              fontWeight: FontWeight.w500,
                              size: 20,
                              color: AppColor.white),
                          Icon(
                            Icons.arrow_circle_right,
                            size: 30,
                            color: AppColor.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(Addbill());
                  },
                  child: Container(
                    decoration: boxDecoration(),
                    // height: 100,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText('Bill Detail',
                              fontWeight: FontWeight.w500,
                              size: 20,
                              color: AppColor.white),
                          Icon(
                            Icons.arrow_circle_right,
                            size: 30,
                            color: AppColor.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(Addtrip());
                  },
                  child: Container(
                    decoration: boxDecoration(),
                    // height: 100,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText('bugest',
                              fontWeight: FontWeight.w500,
                              size: 20,
                              color: AppColor.white),
                          Icon(
                            Icons.arrow_circle_right,
                            size: 30,
                            color: AppColor.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            )));

    //     SingleChildScrollView(
    //   child: Column(
    //     children: [
    //       CommonTextButton(
    //         onPressed: () {
    //           Get.to(Addloan());
    //         },
    //         // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: [
    //             SizedBox(width: 10),
    //             Image.asset(
    //               AppImage.loan,
    //               width: Get.width / 13,
    //               height: Get.width / 13,
    //             ),
    //             SizedBox(width: 10),
    //             const CustomText(
    //               'Loan Detail',
    //               size: 18,
    //               fontWeight: FontWeight.w600,
    //             ),
    //             SizedBox(width: 20),
    //             Icon(Icons.arrow_circle_right, color: AppColor.black)
    //           ],
    //         ),
    //         buttonColor: Color.fromARGB(255, 241, 233, 233),
    //         withBorder: true,
    //         elevation: 2,
    //       ),
    //       CommonTextButton(
    //         onPressed: () {
    //           Get.to(Investment());
    //         },
    //         // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: [
    //             Image.asset(
    //               AppImage.salary,
    //               width: Get.width / 13,
    //               height: Get.width / 13,
    //             ),
    //             SizedBox(width: 20),
    //             const CustomText(
    //               'Investment Details',
    //               size: 18,
    //               fontWeight: FontWeight.w600,
    //             ),
    //             SizedBox(width: 20),
    //             Icon(Icons.arrow_circle_right, color: AppColor.black)
    //           ],
    //         ),
    //         buttonColor: Color.fromARGB(255, 241, 233, 233),
    //         withBorder: true,
    //         elevation: 2,
    //       ),
    //       CommonTextButton(
    //         onPressed: () {
    //           Get.to(Intrest());
    //         },
    //         // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: [
    //             Image.asset(
    //               AppImage.loan,
    //               width: Get.width / 13,
    //               height: Get.width / 13,
    //             ),
    //             SizedBox(width: 20),
    //             const CustomText(
    //               'Intrest Detail',
    //               size: 18,
    //               fontWeight: FontWeight.w600,
    //             ),
    //             // Icon(Icons.arrow_right_sharp)
    //           ],
    //         ),
    //         buttonColor: Color.fromARGB(255, 241, 233, 233),
    //         withBorder: true,
    //         elevation: 2,
    //       ),
    //       CommonTextButton(
    //         onPressed: () {
    //           Get.to(Tips());
    //         },
    //         // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: [
    //             Image.asset(
    //               AppImage.loan,
    //               width: Get.width / 13,
    //               height: Get.width / 13,
    //             ),
    //             SizedBox(width: 20),
    //             const CustomText(
    //               'Bill Detail',
    //               size: 18,
    //               fontWeight: FontWeight.w600,
    //             ),
    //             // Icon(Icons.arrow_right_sharp)
    //           ],
    //         ),
    //         buttonColor: Color.fromARGB(255, 241, 233, 233),
    //         withBorder: true,
    //         elevation: 2,
    //       ),
    //       CommonTextButton(
    //         onPressed: () {
    //           Get.to(Tips());
    //         },
    //         // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: [
    //             Image.asset(
    //               AppImage.loan,
    //               width: Get.width / 13,
    //               height: Get.width / 13,
    //             ),
    //             SizedBox(width: 20),
    //             const CustomText(
    //               'Saving Tips',
    //               size: 18,
    //               fontWeight: FontWeight.w600,
    //             ),
    //             // Icon(Icons.arrow_right_sharp)
    //           ],
    //         ),
    //         buttonColor: Color.fromARGB(255, 241, 233, 233),
    //         withBorder: true,
    //         elevation: 2,
    //       ),
    //     ],
    //   ),
    // ));
  }
}

boxDecoration() {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(
        stops: [
          0.13,
          0.90,
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color.fromARGB(255, 62, 82, 137),
          Color.fromARGB(255, 80, 114, 172),
        ],
      ));
}
