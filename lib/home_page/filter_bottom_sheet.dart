import 'package:expanse_manage/controller/dashbord_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common_widget/common_text.dart';
import '../common_widget/filter_list_tile.dart';
import '../common_widget/widget.dart';
import '../res/app_color.dart';

final controller = Get.find<DashBoardController>();

Future buildCalenderSheet(BuildContext context) async {
  showModalBottomSheet(
    backgroundColor: AppColor.backgroundColor2,
    enableDrag: true,
    isScrollControlled: true,
    constraints:
        BoxConstraints(minWidth: Get.width, maxHeight: Get.height / 1.8),
    context: context,
    builder: (context) {
      final String currentMoth = controller.months[DateTime.now().month - 1];
      final String lastMonth = controller.months[DateTime.now().month - 2];
      DateTime now = DateTime.now();
      DateTime lastDayOfMonth = DateTime(now.year, now.month, 0);
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: const [
                Expanded(
                    child: CustomText(
                  'Sort by Date',
                  size: 18,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ))
              ],
            ),
            const SizeBoxH(),
            FilterListTile(
              title: 'Today',
              date: "${DateTime.now().day}",
              month: currentMoth,
              onTap: () {},
            ),
            FilterListTile(
              title: 'Yesterday',
              date: "${DateTime.now().day - 1}",
              month: currentMoth,
              onTap: () {},
            ),
            FilterListTile(
              title: 'Last Week',
              date:
                  "${DateTime.april.days.inDays} - ${DateTime.april.days.inDays + DateTime.daysPerWeek - 1}",
              month: currentMoth,
              onTap: () {},
            ),
            FilterListTile(
              title: 'Last Month',
              date: "${lastDayOfMonth.day}",
              month: lastMonth,
              onTap: () {},
            ),
            FilterListTile(
              title: 'Custom Range',
              date: "${lastDayOfMonth.day}",
              month: lastMonth,
              onTap: () {},
            ),
          ],
        ),
      );
    },
  );
}
