import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final Color? backColor;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? height;
  final double? letterSpacing;
  final TextDecoration? textDecoration;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final String? fontFamily;
  final Paint? foreGround;

  const CustomText(this.text,
      {Key? key,
      this.size = 12,
      this.color = Colors.black,
      this.textAlign,
      this.overflow,
      this.maxLines,
      this.height = 1,
      this.letterSpacing,
      this.textDecoration = TextDecoration.none,
      this.fontWeight,
      this.fontStyle,
      this.fontFamily = 'Poppins',
      this.foreGround,
      this.backColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var child = Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
          fontStyle: fontStyle,
          color: color,
          fontSize: size,
          fontWeight: fontWeight,
          height: height,
          letterSpacing: letterSpacing,
          decoration: textDecoration,
          fontFamily: fontFamily,
          foreground: foreGround,
          backgroundColor: backColor),
    );

    return child;
  }
}
