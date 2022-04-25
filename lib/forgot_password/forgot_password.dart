import 'package:expanse_manage/common_widget/common_appbar.dart';
import 'package:expanse_manage/common_widget/common_text.dart';
import 'package:expanse_manage/common_widget/common_text_form_field.dart';
import 'package:expanse_manage/common_widget/common_textbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../forgot_password/forgot_password_controller.dart';

class ForgotPassword extends StatelessWidget {
  final ForgotPasswordController forgotPasswordController =
      Get.put(ForgotPasswordController());

  ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Forgot Password',
      ),
      body: Column(
        children: [
          CustomText(
            '\nEnter Valid Email\n',
            size: 20,
          ),
          CommonTextFormField(
            hintText: 'Enter Email',
            controller: forgotPasswordController.validEmail,
          ),
          CommonTextButton(
            onPressed: () {
              forgotPasswordController.sendEmail();
            },
            text: 'Submit',
          )
        ],
      ),
    );
  }
}
