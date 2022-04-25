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
            title: 'Add Loan', hasBackIcon: true, actionIcon: Icon(Icons.add)),
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
                        'Make a Trip',
                        size: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomText(
                        'Creat Your Trip just a second.',
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
                              'Create Loan',
                              style: TextStyle(
                                  fontSize: 22, color: AppColor.white),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
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
                height: Get.height / 1.2,
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
                        'Enter Your Trip Detail',
                        size: 22,
                        fontWeight: FontWeight.w500,
                        color: AppColor.black.withOpacity(0.5),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CommonTextFormField(
                        hintText: 'Location',
                        controller: controller.loanName,
                      ),
                      CommonTextFormField(
                        hintText: 'Trip Budgest',
                        controller: controller.amunt,
                        keyboardType: TextInputType.number,
                      ),
                      CommonTextFormField(
                        hintText: 'Installment',
                        controller: controller.installment,
                        keyboardType: TextInputType.number,
                      ),
                      CommonTextFormField(
                        hintText: 'Percentage',
                        controller: controller.percentage,
                      ),
                      CommonTextButton(
                          radius: 8,
                          onPressed: () => controller.selectDate(context),
                          buttonColor: AppColor.blueShade50,
                          elevation: 3,
                          vertical: Get.height / 20,
                          horizontal: Get.width * 0.001,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                '''${selectedDate.day} / ${selectedDate.month} / ${selectedDate.year}''',
                                color: AppColor.textColorDark,
                                size: 18,
                              ),
                              const Icon(
                                Icons.calendar_today_outlined,
                                color: AppColor.textColorDark,
                              )
                            ],
                          ),
                          buttonWidth: Get.width,
                          buttonHeight: Get.height / 14),
                      // CommonTextButton(onPressed: (){},),
                      CommonTextButton(
                        onPressed: () {
                          controller.createLoan();
                          Get.to(Chekmark());
                        },
                        text: 'Add Loan',
                      )
                    ],
                  ),
                )),
          );
        });
  }
}
