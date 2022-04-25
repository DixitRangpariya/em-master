import 'package:expanse_manage/common_widget/common_text.dart';
import 'package:expanse_manage/common_widget/common_textbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonAlertDialog {
  final String description;
  final BuildContext context;

  CommonAlertDialog(this.description, this.context);

  Future buildAlertDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: CustomText('Error'),
            content: CustomText(description),
            actions: [
              CommonTextButton(
                onPressed: () {
                  Get.back();
                },
                text: 'Ok',
              )
            ],
          );
        });
  }
}
