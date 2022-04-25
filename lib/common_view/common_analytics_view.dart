import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expanse_manage/common_widget/common_appbar.dart';
import 'package:expanse_manage/common_widget/common_text.dart';
import 'package:expanse_manage/common_widget/widget.dart';
import 'package:expanse_manage/modal/monthely_data.dart';
import 'package:expanse_manage/res/app_color.dart';
import 'package:expanse_manage/res/app_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart' as a;

import '../analytics/analytics_controller.dart';

class CommonAnalyticsView extends StatelessWidget {
  final bool isExpanse;
  final AnalyticsController analyticsController = Get.find();

  CommonAnalyticsView({Key? key, this.isExpanse = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<MonthlyData> monthlyData = analyticsController.monthIncome;
    return Scaffold(
      appBar: CommonAppBar(
        title: isExpanse ? 'Expense' : 'Income',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: Get.height / 5,
              child: ListView.builder(
                itemCount: monthlyData.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var list = monthlyData[index];
                  return SizedBox(
                      width: Get.width * 0.9,
                      child: Card(
                        color: isExpanse ? AppColor.red : AppColor.skyBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        child: Stack(
                          children: [
                            Positioned(
                                right: 20,
                                child: a.GradientSelectableText(
                                  '₹',
                                  gradient: isExpanse
                                      ? AppColor.lineExpanseGradiant
                                      : AppColor.lineGradiant,
                                  style: const TextStyle(
                                    fontSize: 200,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: Get.height * 0.025,
                                  horizontal: Get.width * 0.05),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        list.month,
                                        color: AppColor.white,
                                        size: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        color: AppColor.white,
                                      )
                                    ],
                                  ),
                                  CustomText(
                                    '\n₹${list.total}',
                                    color: AppColor.white,
                                    size: 30,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  Container(
                                    height: Get.height * 0.005,
                                    decoration: BoxDecoration(
                                        gradient: isExpanse
                                            ? AppColor.lineExpanseGradiant
                                            : AppColor.lineGradiant),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ));
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width / 18, vertical: Get.height * 0.02),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    '\nTransaction',
                    size: 18,
                    textAlign: TextAlign.start,
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: analyticsController.fetchData(isExpanse),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: Text('Sorry No Data Found'),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.data?.docs == null) {
                          return const Center(
                            child: Text("Loading...."),
                          );
                        }
                        final data = snapshot.data!.docs;
                        return ListView.separated(
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              minLeadingWidth: 12,
                              leading: const CircleImageFromAsset(
                                  AppImage.noData2,
                                  size: 12),
                              title: CustomText(
                                data[index]['categoryName'],
                                size: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              subtitle: CustomText(
                                data[index]['description'],
                                overflow: TextOverflow.ellipsis,
                                color: AppColor.textGrey,
                                size: 18,
                              ),
                              trailing: CustomText(
                                '₹${data[index]['amount']}',
                                overflow: TextOverflow.ellipsis,
                                size: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Container(
                                height: Get.height * 0.005,
                                decoration: BoxDecoration(
                                    gradient: isExpanse
                                        ? AppColor.lineExpanseGradiant
                                        : AppColor.lineGradiant));
                          },
                        );
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
/*Card(
                        color: AppColor.skyBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        /*margin: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.02,
                            vertical: Get.height / 2.8),*/
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: Get.height * 0.025,
                              horizontal: Get.width * 0.05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    list[index].month,
                                    color: AppColor.white,
                                    size: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_sharp,
                                    color: AppColor.white,
                                  )
                                ],
                              ),
                              CustomText(
                                '\n${list[index].total}',
                                color: AppColor.white,
                                size: 30,
                                fontWeight: FontWeight.w600,
                              ),
                              Container(
                                height: Get.height*0.005,
                                decoration: BoxDecoration(
                                    gradient: AppColor.lineGradiant),
                              )
                            ],
                          ),
                        ),
                      ),*/
