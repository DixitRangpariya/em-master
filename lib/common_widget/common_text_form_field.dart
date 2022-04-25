import 'package:expanse_manage/res/app_color.dart';
import 'package:flutter/material.dart';

class CommonTextFormField extends StatelessWidget {
  final double? fontSize;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final EdgeInsetsGeometry? padding;
  final TextStyle? suffixStyle;
  final bool border;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validation;
  final bool autofocus;
  final bool underLineBorder;
  final int maxLines;
  final AutovalidateMode? autovalidateMode;

  const CommonTextFormField(
      {Key? key,
      required this.hintText,
      this.suffixIcon,
      this.prefixIcon,
      this.controller,
      this.padding,
      this.suffixStyle,
      this.fontSize,
      this.border = true,
      this.keyboardType,
      this.validation,
      this.maxLines = 1,
      this.underLineBorder = true,
      this.autofocus = false,
      this.autovalidateMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: autovalidateMode,
      controller: controller,
      keyboardType: keyboardType,
      autofocus: autofocus,
      style: TextStyle(fontSize: fontSize),
      validator: validation,
      maxLines: maxLines,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        labelText: hintText,
        labelStyle: const TextStyle(
            color: AppColor.textColorDark,
            fontSize: 16,
            fontWeight: FontWeight.w500),
        alignLabelWithHint: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        hintStyle: TextStyle(
          color: AppColor.textGrey,
          fontSize: fontSize,
        ),
        border: border
            ? underLineBorder
                ? _commonUnderlineBorder(borderColor: AppColor.textColorDark)
                : _commonOutlineBorder(borderColor: AppColor.textColorDark)
            : InputBorder.none,
        errorBorder: underLineBorder
            ? _commonUnderlineBorder(borderColor: AppColor.red)
            : _commonOutlineBorder(borderColor: AppColor.red),
        focusedBorder: underLineBorder
            ? _commonUnderlineBorder(borderColor: AppColor.textColorDark)
            : _commonOutlineBorder(borderColor: AppColor.textColorDark),
        enabledBorder: underLineBorder
            ? _commonUnderlineBorder(borderColor: AppColor.textColorDark)
            : _commonOutlineBorder(borderColor: AppColor.textColorDark),
      ),
      cursorColor: AppColor.textColorDark,
    );
  }

  InputBorder _commonOutlineBorder({required Color borderColor}) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: borderColor, width: 2));
  }

  InputBorder _commonUnderlineBorder({required Color borderColor}) {
    return UnderlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: borderColor, width: 3));
  }
}
