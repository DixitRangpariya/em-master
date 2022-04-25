import 'package:expanse_manage/res/app_color.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SizeBoxV extends StatelessWidget {
  final double size;

  const SizeBoxV([this.size = 4]) : super(key: null);

  @override
  Widget build(BuildContext context) => SizedBox(width: size);
}

class SizeBoxH extends StatelessWidget {
  final double size;

  const SizeBoxH([this.size = 4]) : super(key: null);

  @override
  Widget build(BuildContext context) => SizedBox(height: size);
}

class CircleImageFromAsset extends StatelessWidget {
  final String image;
  final double size;
  final BoxFit fit;
  final Color? color;
  final bool matchTextDirection;

  const CircleImageFromAsset(
    this.image, {
    this.size = 24,
    this.fit = BoxFit.contain,
    this.color,
    this.matchTextDirection = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.asset(
        image,
        fit: fit,
        color: color,
        width: size,
        height: size,
        matchTextDirection: matchTextDirection,
      ),
    );
  }
}

class SquareSvgImageFromAsset extends StatelessWidget {
  final String image;
  final double size;
  final BoxFit fit;
  final Color? color;
  final bool matchTextDirection;

  const SquareSvgImageFromAsset(this.image,
      {this.size = 24,
      this.fit = BoxFit.contain,
      this.color,
      this.matchTextDirection = true,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(image,
        fit: fit,
        color: color,
        width: size,
        height: size,
        matchTextDirection: matchTextDirection);
  }
}

class CommonBg extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final String? image;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  const CommonBg(
      {Key? key,
      required this.child,
      this.color = AppColor.white,
      this.image,
      this.margin = const EdgeInsets.all(0),
      this.padding = const EdgeInsets.all(0)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      width: Get.width,
      child: child,
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 30,
                spreadRadius: 10)
          ]),
    );
  }
}
