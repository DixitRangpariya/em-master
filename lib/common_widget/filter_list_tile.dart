import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/app_color.dart';
import 'common_text.dart';

class FilterListTile extends StatelessWidget {
  final String title;
  final String date;
  final String month;
  final VoidCallback onTap;

  const FilterListTile({
    Key? key,
    required this.date,
    required this.month,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: CustomText(
        title,
        fontWeight: FontWeight.w500,
        size: 16,
      ),
      leading: SizedBox(
        height: Get.height/8,
        child: Card(
          elevation: 3,

          child: Column(
            children: [
              Card(
                child: CustomText(
                  '   $month   ',
                  color: AppColor.white,
                  height: 1.3,
                ),
                color: AppColor.textColorDark,
                margin: EdgeInsets.zero,
              ),
              CustomText(
                '\n$date',
                size: 10,
                fontWeight: FontWeight.w600,
              )
            ],
          ),
        ),
      ),
      subtitle: CustomText(
        '$month  $date',
        size: 15,
        height: 1.5,
      ),
    );
  }
}
