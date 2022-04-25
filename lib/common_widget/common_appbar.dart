import 'package:expanse_manage/common_widget/widget.dart';
import 'package:expanse_manage/res/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common_text.dart';

class CommonAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget? titleWidget;
  final String title;
  final String heading;
  final VoidCallback? onBackTap;
  final PreferredSizeWidget? bottom;
  final bool hasBackIcon;
  final Widget? actionIcon;
  final Radius radius = const Radius.circular(20);

  CommonAppBar({
    Key? key,
    this.heading = "",
    this.title = "",
    this.onBackTap,
    this.bottom,
    this.hasBackIcon = true,
    this.actionIcon,
    this.titleWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (hasBackIcon)
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        padding: const EdgeInsets.all(15),
                        iconSize: 20,
                        onPressed: onBackTap ?? () => Get.back(),
                        splashRadius: 24,
                        color: AppColor.textColorDark,
                      )
                    else
                      const SizeBoxV(25),
                    if (titleWidget != null)
                      Expanded(
                        child: titleWidget!,
                      ),
                    if (heading.isNotEmpty || title.isNotEmpty)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (heading.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: CustomText(
                                  heading,
                                  size: 13,
                                  color: AppColor.textColorDark,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            if (title.isNotEmpty)
                              CustomText(
                                title,
                                size: 20,
                                color: AppColor.textColorDark,
                                fontWeight: FontWeight.w600,
                                textAlign: TextAlign.center,
                              ),
                          ],
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: actionIcon ?? const SizeBoxV(20),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(70 + (bottom?.preferredSize.height ?? 0));
}
