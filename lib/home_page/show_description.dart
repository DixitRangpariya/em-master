import 'package:expanse_manage/common_widget/widget.dart';
import 'package:expanse_manage/res/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common_widget/common_text.dart';

Future buildDetailSheet({
  required BuildContext context,
  required String categoryName,
  required String amount,
  required String url,
  required bool isExpanse,
  required String description,
  required DateTime date,
}) async {
  return showModalBottomSheet(
    context: context,
    constraints: BoxConstraints(maxHeight: Get.height/2,maxWidth: Get.width/1.3),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            CustomText(
              '${date.day} / ${date.month} / ${date.year}',
              size: 18,
              fontWeight: FontWeight.w600,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  labelPadding: const EdgeInsets.all(2.0),
                  elevation: 6.0,
                  backgroundColor: AppColor.textColorDark,
                  shadowColor: AppColor.shadowColor,
                  padding: const EdgeInsets.all(8.0),
                  label: CustomText(
                    '  $categoryName  ',
                    size: 22,
                    color: AppColor.white,
                  ),
                ),
                CustomText(
                  amount,
                  size: 22,
                  color: isExpanse ? AppColor.red : AppColor.green,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            if(description.isNotEmpty)
            CustomText(description),
            SizeBoxH(),
            url.isEmpty
                ? const CustomText('\n\nNo Attachment were found')
                : Card(child: Image.network(url,height: 150,width: 150)),
          ],
        ),
      );
    },
  );
}
