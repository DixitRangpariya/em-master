import 'package:cloud_firestore/cloud_firestore.dart';
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

class Addloan extends StatefulWidget {
  const Addloan({Key? key}) : super(key: key);

  @override
  State<Addloan> createState() => _AddloanState();
}

class _AddloanState extends State<Addloan> {
  final controller = Get.put(FeaturesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar(
          title: 'Add Loan',
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
                        'Make a Loans',
                        size: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomText(
                        'Creat Your Loan Recods just a second.',
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
            StreamBuilder<QuerySnapshot>(
              stream: controller.fetchloan(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text('No Data available');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index];
                        DateTime date = DateTime.parse(data['date']);
                        return Container(
                          margin: const EdgeInsets.all(20),

                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              //elevation:2,
                              gradient: const LinearGradient(
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
                              children: [
                                CustomText(
                                  'Loan Name : ${data['loan_name']}',
                                  size: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomText(
                                  'Amount : ₹${data['amount']}',
                                  size: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomText(
                                  'Installment : ₹${data['installment']}',
                                  size: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomText(
                                  'Amount : ${data['percentage']}%',
                                  size: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomText(
                                  'Installment Date : ${date.day}/${date.month}/${date.year}',
                                  size: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                );
              },
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
                height: Get.height / 1.2,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(AppImage.loan, width: 50, height: 50),
                      SizedBox(
                        height: 10,
                      ),
                      CustomText(
                        'Enter Your Loan Detail',
                        size: 22,
                        fontWeight: FontWeight.w500,
                        color: AppColor.black.withOpacity(0.5),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CommonTextFormField(
                        hintText: 'Loan Name',
                        controller: controller.loanName,
                      ),
                      CommonTextFormField(
                        hintText: 'Amount',
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
                        onPressed: () async {
                          await controller.createLoan();
                          Get.back();
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
