
import 'package:expanse_manage/res/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final double iconSize;
  final double padding;

  const CommonIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.iconSize = 20,
    this.padding = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  IconButton(
          onPressed: onPressed,
          padding: EdgeInsets.all(padding),
          iconSize: iconSize,
          icon: Icon(
            icon,
            color: AppColor.white,
          ));

  }
}
