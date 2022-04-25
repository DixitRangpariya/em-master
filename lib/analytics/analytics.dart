import 'package:expanse_manage/analytics/analytics_controller.dart';
import 'package:expanse_manage/common_view/common_analytics_view.dart';
import 'package:expanse_manage/common_widget/common_appbar.dart';
import 'package:expanse_manage/common_widget/common_text.dart';
import 'package:expanse_manage/common_widget/widget.dart';
import 'package:expanse_manage/modal/chart_data.dart';
import 'package:expanse_manage/res/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Analytics extends StatelessWidget {
  final AnalyticsController analyticsController =
      Get.put(AnalyticsController());

  Analytics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Analytics', hasBackIcon: false),
      //bottomNavigationBar: CommonBottomBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              elevation: 10,
              // color: AppColor.blueShade50,
              shadowColor: AppColor.shadowColor,
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none),
              //margin: const EdgeInsets.all(20),
              child: SfCartesianChart(
                  title: ChartTitle(text: 'Net Balance'),
                  margin: const EdgeInsets.all(20),
                  series: <ChartSeries>[
                    LineSeries<ChartData, int>(
                        dataSource: analyticsController.chartData,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y),
                    LineSeries<ChartData, int>(
                        dataSource: analyticsController.incomeData,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y),
                  ]),
            ),
            SizeBoxH(Get.height / 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonCard(
                    icon: Icons.login,
                    color: AppColor.green,
                    title: 'Income',
                    bodyTitle: '',
                    onTap: () {
                      analyticsController.fetchData(false);
                      Get.to(() => CommonAnalyticsView(
                            isExpanse: false,
                          ));
                    }),
                commonCard(
                    icon: Icons.logout,
                    color: AppColor.red,
                    title: 'Expanse',
                    bodyTitle: '',
                    onTap: () {
                      analyticsController.fetchData(true);
                      Get.to(() => CommonAnalyticsView(
                            isExpanse: true,
                          ));
                    })
              ],
            ),
            SizedBox(
              height: Get.height / 8,
            )
          ],
        ),
      ),
    );
  }

  Widget commonCard(
      {required IconData icon,
      required Color color,
      required String title,
      required String bodyTitle,
      required GestureTapCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: Get.height / 4,
        width: Get.width / 2.3,
        child: Card(
          shadowColor: AppColor.shadowColor,
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Padding(
            padding: EdgeInsets.all(Get.width / 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  child: Icon(
                    icon,
                    size: 30,
                    color: AppColor.white,
                  ),
                  backgroundColor: color,
                  radius: 25,
                ),
                Wrap(
                  direction: Axis.vertical,
                  children: [
                    CustomText(
                      title,
                      color: AppColor.textGrey,
                      size: 15,
                    ),
                    const SizeBoxH(),
                    CustomText(
                      '\$$bodyTitle',
                      size: 25,
                      fontWeight: FontWeight.bold,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
