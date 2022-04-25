import 'package:expanse_manage/res/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common_text.dart';

class CommonTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double radius;
  final Widget? child;
  final bool onlyText;
  final Color color;
  final Color buttonColor;
  final FontWeight fontWeight;
  final double textSize;
  final TextAlign textAlign;
  final double vertical;
  final double horizontal;
  final double? buttonWidth;
  final double? buttonHeight;
  final bool withBorder;
  double? elevation;

  CommonTextButton(
      {Key? key,
      this.text = '',
      required this.onPressed,
      this.radius = 15,
      this.child,
      this.onlyText = false,
      this.color = AppColor.white,
      this.fontWeight = FontWeight.bold,
      this.textSize = 18,
      this.textAlign = TextAlign.center,
      this.vertical = 30,
      this.horizontal = 20,
      this.buttonColor = AppColor.darkBlue,
      this.buttonHeight,
      this.buttonWidth,
      this.elevation,
      this.withBorder = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      child: TextButton(
        onPressed: onPressed,
        child: text.isEmpty
            ? child!
            : CustomText(
                text,
                size: textSize,
                textAlign: textAlign,
                fontWeight: fontWeight,
                color: color,
              ),
        style: onlyText
            ? TextButton.styleFrom(
                primary: Colors.white,
              )
            : TextButton.styleFrom(
                backgroundColor: buttonColor,
                elevation: elevation,
                splashFactory: InkSplash.splashFactory,
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius),
                    side: BorderSide(
                        style:
                            withBorder ? BorderStyle.solid : BorderStyle.none,
                        color: AppColor.black)),
                fixedSize: buttonHeight == null
                    ? Size(Get.width, Get.height / 15)
                    : Size(buttonWidth!, buttonHeight!),
              ),
      ),
    );
  }
}
