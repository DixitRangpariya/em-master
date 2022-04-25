import 'package:flutter/material.dart';

class AppColor {
  static const shadowColor = Color(0xffcadefe);
  static const backgroundColor = Color(0xFFF3F5FC);
  static const backgroundColor2 = Color(0xDCF3F5FC);

  static const purple5 = Color(0xffD2DAFD);
  static const purple = Color(0xff5F79F8);
  static const purple10 = Color(0xff806CF8);

  static const lightSkyBlue = Color(0xff3371db);
  static const skyBlue = Color(0xff33C9FF);
  static const darkBlue = Color(0xff0f35a0);
  static const lightBlue = Color(0xff75bee8);
  static const blueShade50 = Color(0xE3F2FDFF);
  static const lightBlueExtra = Color(0xff5adaf5);

  static const backGroundLight = Color(0xff2e4690);

  static const textColor = Color(0xdd9dade8);
  static const textColorLight = Color(0xD2D9EEFF);
  static const textColorDark = Color(0xff1A2C66);
  static MaterialColor colorDark = Colors.indigo.shade900 as MaterialColor;
  static const textPrimaryMedium = Color(0xFF4C5B7D);

  static const white = Color(0xffFAFAFA);
  static const textGrey = Color(0xff717171);
  static const black = Color(0xff000000);

  static const red = Color(0xFFFF0000);
  static const green = Color(0xFF4CAF50);

  static const buttonGradient =
      LinearGradient(colors: [Color(0xff0f35a0), Color(0xff3371db)]);
  static const lineGradiant =
      LinearGradient(colors: [Color(0xff69c8ec), Color(0xffFFFFFF)]);

  static const lineExpanseGradiant =
      LinearGradient(colors: [Color(0xFFF12F2F), Color(0xF3FFFFFF)]);

  static final Shader linearGradient = const LinearGradient(
    colors: <Color>[red, green],
  ).createShader(Rect.fromLTWH(50, 0.0, 200.0, 70.0));
}
