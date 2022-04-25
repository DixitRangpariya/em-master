import 'package:expanse_manage/common_widget/common_appbar.dart';
import 'package:expanse_manage/common_widget/common_text.dart';
import 'package:expanse_manage/common_widget/common_text_form_field.dart';
import 'package:expanse_manage/common_widget/common_textbutton.dart';
import 'package:expanse_manage/controller/auth_controller.dart';
import 'package:expanse_manage/forgot_password/forgot_password.dart';
import 'package:expanse_manage/res/app_color.dart';
import 'package:expanse_manage/res/app_image.dart';
import 'package:expanse_manage/signup_screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final authController = Get.put(AuthController());
  static const routeName = '/loginScreen';

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppImage.logoL,
              width: Get.width / 3,
              alignment: Alignment.center,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                '\n  Login to Your Account   ',
                size: 23,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w600,
              ),
            ),
            Form(
              key: authController.loginFormKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [
                  CommonTextFormField(
                    hintText: 'Username',
                    underLineBorder: true,
                    controller: authController.email,
                    validation: (String? value) =>
                        authController.userNameValidation(value!),
                  ),
                  CommonTextFormField(
                    hintText: 'Password',
                    controller: authController.password,
                    suffixIcon: Icon(Icons.remove_red_eye),
                    validation: (String? value) =>
                        authController.passwordValidation(value!),
                    underLineBorder: true,
                  ),
                ],
              ),
            ),
            Obx(
              () => authController.isLoading.value
                  ? const Padding(
                      padding: EdgeInsets.all(12),
                      child: CircularProgressIndicator(),
                    )
                  : CommonTextButton(
                      onPressed: () {
                        authController.matchLoginForm;
                        if (authController.matchLoginForm) {
                          authController.submitForm(true, context);
                        }
                      },
                      text: 'Login',
                      elevation: 2,
                      horizontal: Get.width / 30,
                      vertical: Get.height / 40,
                    ),
            ),
            CommonTextButton(
              onPressed: () {
                Get.to(ForgotPassword());
              },
              text: 'Forgot Password ?',
              color: AppColor.black,
              textSize: 15,
              fontWeight: FontWeight.w500,
              vertical: 0,
              onlyText: true,
            )
          ],
        ),
      )),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return CommonAppBar(
      title: 'Expanse Manager',
      hasBackIcon: false,
      actionIcon: TextButton(
        onPressed: () {
          authController.clearAllField();
          Get.offAll(SignUpScreen());
        },
        child: const CustomText(
          'SignUp',
          color: AppColor.textColorDark,
          fontWeight: FontWeight.w400,
          size: 15,
        ),
      ),
    );
  }
}
/*   const CustomText(
              'Or With',
              fontWeight: FontWeight.w600,
              color: AppColor.textGrey,
              textAlign: TextAlign.center,
              size: 15,
            ),
            CommonTextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImage.google,
                    width: Get.width / 13,
                    height: Get.width / 13,
                  ),
                  const CustomText(
                    '    Login with Google',
                    size: 18,
                    fontWeight: FontWeight.w600,
                  )
                ],
              ),
              buttonColor: AppColor.white,
              horizontal: Get.width / 30,
              vertical: Get.height / 40,
              withBorder: true,
              elevation: 2,
            ),*/
