import 'package:expanse_manage/common_widget/common_text.dart';
import 'package:expanse_manage/common_widget/common_text_form_field.dart';
import 'package:expanse_manage/common_widget/common_textbutton.dart';
import 'package:expanse_manage/res/app_image.dart';
import 'package:expanse_manage/screens/checkmark.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common_widget/common_appbar.dart';
import '../controller/feture_controller.dart';
import '../res/app_color.dart';

class Addtrip extends StatefulWidget {
  const Addtrip({Key? key}) : super(key: key);

  @override
  State<Addtrip> createState() => _AddtripState();
}

class _AddtripState extends State<Addtrip> {
  final controller = Get.put(FeaturesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar(
          title: 'Add Bugest',
          hasBackIcon: true,
        ),
        body: Column(
          children: [
            Card(
              color: Color.fromARGB(245, 235, 242, 252),
              margin: const EdgeInsets.all(20),
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  // height: 100,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      CustomText(
                        'Make a Bugest',
                        size: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomText(
                        'Creat Your Bugest just a second.',
                        size: 15,
                        // fontWeight: FontWeight.normal,
                        color: Colors.black.withOpacity(0.4),
                      ),
                      CommonTextButton(
                        onPressed: () {
                          bottomsheets(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.add_box_rounded,
                                size: 25, color: AppColor.white),
                            Text(
                              'Create Bugest',
                              style: TextStyle(
                                  fontSize: 22, color: AppColor.white),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              color: Color.fromARGB(245, 235, 242, 252),
              margin: const EdgeInsets.all(20),
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: Padding(
                padding: EdgeInsets.all(Get.width / 20),
                child: Column(children: [
                  CustomText(
                    'Budget Name',
                    size: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColor.textColorDark.withOpacity(0.5),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          '\$2000.26',
                          size: 25,
                          fontWeight: FontWeight.w600,
                        ),
                        CustomText(
                          '\$5000.00',
                          size: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.5),
                        )
                      ]),
                  const SizedBox(
                    height: 20,
                  ),
                  const LinearProgressIndicator(
                    value: 0.7,
                    minHeight: 5,
                    color: AppColor.darkBlue,
                    backgroundColor: Colors.grey,
                  )
                ]),
              ),
            )
          ],
        ));
  }

  void bottomsheets(BuildContext context) {
    showModalBottomSheet(
        barrierColor: Color.fromARGB(255, 87, 87, 87).withOpacity(0.5),
        elevation: 10,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30.0),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          DateTime selectedDate = controller.transactiondate;
          return GetBuilder<FeaturesController>(
            init: controller,
            builder: (controller) => Container(
                height: Get.height / 1.7,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Image.asset(AppImage.loan, width: 50, height: 50),
                      SizedBox(
                        height: 10,
                      ),
                      CustomText(
                        'Enter Your Bugest Detail',
                        size: 22,
                        fontWeight: FontWeight.w500,
                        color: AppColor.black.withOpacity(0.5),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CommonTextFormField(
                        hintText: 'Select Category',
                      ),
                      CommonTextFormField(
                        hintText: 'Amount',
                        keyboardType: TextInputType.number,
                      ),
                      CommonTextFormField(
                        hintText: 'Note',
                      ),

                      CommonTextButton(
                        onPressed: () {
                          Get.to(Chekmark());
                        },
                        text: 'Add Bugest',
                      )
                    ],
                  ),
                )),
          );
        });
  }
}
