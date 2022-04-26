import 'package:expanse_manage/common_widget/common_appbar.dart';
import 'package:expanse_manage/common_widget/common_text.dart';
import 'package:expanse_manage/common_widget/common_text_form_field.dart';
import 'package:expanse_manage/common_widget/common_textbutton.dart';
import 'package:expanse_manage/controller/auth_controller.dart';
import 'package:expanse_manage/login_screen/login_screen.dart';
import 'package:expanse_manage/res/app_color.dart';
import 'package:expanse_manage/res/app_image.dart';
import 'package:expanse_manage/signup_screen/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  final Signupcontroller signupController = Get.put(Signupcontroller());
  static const routeName = '/signupScreen';
  final authController = Get.put(AuthController());

  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: _buildAppBar(),
          body: GetBuilder<AuthController>(
            init: authController,
            builder: (controller) => SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(AppImage.logoL, width: Get.width / 3),
                    const CustomText(
                      '\n    SignUp with Expanse Manager   ',
                      size: 20,
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.w600,
                    ),
                    const CustomText(
                      '\n      Keep your financial data store to our server\n    so that you can access from anywhere you want    ',
                      size: 13,
                      height: 1.3,
                      textAlign: TextAlign.center,
                    ),
                    Form(
                      key: authController.formKey,
                      child: Column(
                        children: [
                          CommonTextFormField(
                            hintText: 'Your Name',
                            controller: authController.username,
                            validation: (String? value) {
                              return authController.userNameValidation(value!);
                            },
                          ),
                          CommonTextFormField(
                            hintText: 'Email',
                            controller: authController.email,
                            validation: (String? value) =>
                                authController.emailValidation(value!),
                          ),
                          CommonTextFormField(
                              hintText: 'Password',
                              controller: authController.password,
                              obscureText: authController.passwordBool,
                              suffixIcon: IconButton(
                                onPressed: () => authController.showPassword,
                                icon: Icon(
                                 !authController.passwordBool
                                      ? Icons.remove_red_eye
                                      : Icons.visibility_off,
                                ),
                              ),
                              validation: (String? value) {
                                return authController
                                    .passwordValidation(value!);
                              }),
                          CommonTextFormField(
                            hintText: 'Conform Password',
                            controller: authController.conformPassword,
                            obscureText: authController.conformPasswordBool,
                              suffixIcon: IconButton(
                                onPressed: () => authController.showConPassword,
                                icon: Icon(
                                 !authController.conformPasswordBool
                                      ? Icons.remove_red_eye
                                      : Icons.visibility_off,
                                ),
                              ),
                            validation: (String? value) {
                              return authController.confPassValidation(value!);
                            },
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => authController.isLoading.value
                          ? const Padding(
                              padding: EdgeInsets.all(13),
                              child: CircularProgressIndicator(),
                            )
                          : CommonTextButton(
                              onPressed: () {
                                authController.matchAllField;
                                //  authController.formKey.currentState?.validate();
                                if (authController.matchAllField) {
                                  authController.submitForm(false, context);
                                }
                              },
                              text: 'Sign Up',
                              elevation: 2,
                              horizontal: Get.width / 30,
                              vertical: Get.height / 40,
                            ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Future buildAlertDialog(BuildContext context, String content) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: CustomText('Error', size: 25, fontWeight: FontWeight.w600),
            content: CustomText(content, size: 19),
            actions: [
              CommonTextButton(
                onPressed: () {
                  Get.back();
                },
                text: 'Ok',
              )
            ],
          );
        });
  }

  PreferredSizeWidget _buildAppBar() {
    return CommonAppBar(
      title: 'Expanse Manager',
      hasBackIcon: false,
      actionIcon: TextButton(
        onPressed: () {
          //debugPrint('Button Pressed');
          Get.offAll(LoginScreen());
        },
        child: const CustomText(
          'Login',
          fontWeight: FontWeight.w400,
          color: AppColor.textColorDark,
          size: 15,
        ),
      ),
    );
  }

/* void signup() {
    signupcontroller.ragister(name.text, email.text, password.text);
  }*/
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
                            '    Sign Up with Google',
                            size: 18,
                            fontWeight: FontWeight.w600,
                          )
                        ],
                      ),
                      horizontal: Get.width / 30,
                      vertical: Get.height / 40,
                      buttonColor: AppColor.white,
                      withBorder: true,
                      elevation: 2,
                    )*/
