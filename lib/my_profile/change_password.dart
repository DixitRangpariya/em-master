import 'package:expanse_manage/common_widget/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common_widget/common_text_form_field.dart';
import '../common_widget/common_textbutton.dart';
import '../signup_screen/signup_controller.dart';
import 'my_profile_controller.dart';

class ChangePassword extends StatelessWidget {
  final myProfileController = Get.find<MyProfileController>();
  final signUpController = Get.find<Signupcontroller>();

  ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Change Password'),
      body: Column(children: [
        Form(
          key: myProfileController.myProFormKey,
          child: CommonTextFormField(
              hintText: 'Change Password',
              controller: myProfileController.changePassword,
              validation: (String? value) {
                return signUpController.passwordValidation(value!);
              }),
        ),
        CommonTextButton(
          onPressed: () {
            myProfileController.myProFormKey.currentState!.validate();
            myProfileController.newPassword();
          },
          text: 'Change Password',
        )
      ]),
    );
  }
}
