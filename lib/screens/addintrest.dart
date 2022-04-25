import 'package:expanse_manage/common_widget/common_text.dart';
import 'package:expanse_manage/common_widget/common_text_form_field.dart';
import 'package:expanse_manage/common_widget/common_textbutton.dart';
import 'package:expanse_manage/controller/feture_controller.dart';
import 'package:expanse_manage/res/app_image.dart';
import 'package:expanse_manage/screens/checkmark.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common_widget/common_appbar.dart';
import '../res/app_color.dart';

class Intrest extends StatefulWidget {
  const Intrest({Key? key}) : super(key: key);

  @override
  State<Intrest> createState() => _IntrestState();
}

class _IntrestState extends State<Intrest> {
  final controller = Get.put(FeaturesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar(
          title: 'Add Intrest',
          hasBackIcon: true,
        ),
        body: SingleChildScrollView(
          child: Column(
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
                          'Add Intrest',
                          size: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          'Creat Your Intrest Recods just a second.',
                          size: 15,
                          // fontWeight: FontWeight.normal,
                          color: Colors.black.withOpacity(0.4),
                        ),
                        CommonTextButton(
                          onPressed: () {
                            DraggableScrollableSheet(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.add_box_rounded,
                                  size: 25, color: AppColor.white),
                              Text(
                                'Create Intrest',
                                style: TextStyle(
                                    fontSize: 22, color: AppColor.white),
                              )
                              // CustomText('Create Loan',
                              //     size: 20, color: AppColor.white)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                // color: Color.fromARGB(255, 50, 67, 114),
                margin: const EdgeInsets.all(20),
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                // child: Padding(
                // padding: EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        stops: [
                          0.13,
                          0.90,
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color.fromARGB(255, 50, 67, 114),
                          Color.fromARGB(255, 80, 114, 172),
                        ],
                      )),
                  // height: 180,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        CustomText(
                          'Money Leader Name : Car Loan',
                          size: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          'Mobail No. : \$5000',
                          size: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          'Reference Person : \$200',
                          size: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          'Reference No : 5%',
                          size: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          'Amount: 3/5/2022',
                          size: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          'Percentage: 10%',
                          size: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          'Pay Date: ',
                          size: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          'Return Date: ',
                          size: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          'Description : ',
                          size: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void DraggableScrollableSheet(BuildContext context) {
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
                height: 500,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListView(
                    children: [
                      Image.asset(AppImage.loan, width: 50, height: 50),
                      SizedBox(
                        height: 10,
                      ),
                      CustomText(
                        'Enter Your Intrest Detail',
                        size: 22,
                        fontWeight: FontWeight.w500,
                        color: AppColor.black.withOpacity(0.5),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CommonTextFormField(
                        controller: controller.money_leadername,
                        hintText: 'Money Leader Name',
                      ),
                      CommonTextFormField(
                        hintText: 'Mobile No',
                        controller: controller.mobail_number,
                        keyboardType: TextInputType.number,
                      ),
                      CommonTextFormField(
                        hintText: 'Amount',
                        controller: controller.amountintrest,
                      ),
                      CommonTextFormField(
                        hintText: 'Percentage',
                        controller: controller.percentageinrest,
                      ),
                      CommonTextButton(
                          // text: 'Pay Date',
                          radius: 8,
                          onPressed: () => controller.selectDate(context),
                          buttonColor: Color.fromARGB(226, 255, 255, 255),
                          vertical: 10,
                          // horizontal: Get.width * 0.001,
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
                          buttonHeight: 3),
                      CommonTextButton(
                          // text: 'Pay Date',
                          radius: 8,
                          onPressed: () => controller.selectDate(context),
                          buttonColor: Color.fromARGB(226, 255, 255, 255),
                          vertical: 10,
                          // horizontal: Get.width * 0.001,
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
                          buttonHeight: 3),
                      CommonTextButton(
                        onPressed: () {
                          controller.createIntrest();
                          // Get.to(Chekmark());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Add Intrest',
                              style: TextStyle(
                                  fontSize: 22, color: AppColor.white),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          );
        });
  }
}
