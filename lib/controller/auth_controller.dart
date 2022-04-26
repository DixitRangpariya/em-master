import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expanse_manage/common_bottom_bar/common_bottom_bar.dart';
import 'package:expanse_manage/login_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AuthController extends GetxController {
  final _auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController conformPassword = TextEditingController();
  bool passwordBool = true;
  bool conformPasswordBool = true;
  bool logPasswordBool = true;

  //Signup screen Form Key
  final formKey = GlobalKey<FormState>();

  //Login Screen Auth Screen
  final loginFormKey = GlobalKey<FormState>();

  final String emailRegExp =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  final String passwordRegExp =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

  bool validateEmail(String email) {
    RegExp regExp = RegExp(emailRegExp);
    return regExp.hasMatch(email);
  }

  bool validatePassword(String password) {
    RegExp regExp = RegExp(passwordRegExp);
    return regExp.hasMatch(password);
  }

  bool passMatch(String value) {
    return value == password.text;
  }

  bool get matchAllField {
    return formKey.currentState!.validate();
  }

  bool get matchLoginForm {
    return loginFormKey.currentState!.validate();
  }

  bool get showPassword {
    var value = passwordBool = !passwordBool;
    debugPrint('$value');
    update();
    return value;
  }

  bool get showConPassword {
    var value = conformPasswordBool = !conformPasswordBool;
    debugPrint('$value');
    update();
    return value;
  }

  bool get showLogPassword {
    var value = logPasswordBool = !logPasswordBool;
    debugPrint('$value');
    update();
    return value;
  }

  emailValidation(String value) {
    if (value.isEmpty) {
      return 'Email Required';
    } else if (!validateEmail(value)) {
      return 'Please Enter Valid Email';
    } else {
      return null;
    }
  }

  userNameValidation(String value) {
    if (value.isEmpty) {
      return "Name Required";
    } else {
      return null;
    }
  }

  passwordValidation(String value) {
    if (value.isEmpty) {
      //debugPrint('Password :: ${validatePassword(value)}');
      return "Password Required";
    } else if (!validatePassword(value)) {
      //debugPrint('Password :: ${validatePassword(value)}');
      return "Enter Valid Password";
    } else {
      return null;
    }
  }

  confPassValidation(String value) {
    if (value.isEmpty) {
      return "Please Conform Password";
    } else if (!passMatch(value)) {
      return "Password Doesn't Match";
    } else {
      return null;
    }
  }

  clearAllField() {
    username.clear();
    email.clear();
    password.clear();
    conformPassword.clear();
  }

  Future<void> submitForm(
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential userCredential;
    isLoading.value = true;
    try {
      debugPrint('$isLogin');
      if (!isLogin) {
        if (matchAllField) {
          userCredential = await _auth.createUserWithEmailAndPassword(
            email: email.text,
            password: password.text,
          );
          isLoading.value = false;
          await FirebaseFirestore.instance
              .collection('users')
              .doc(_auth.currentUser!.uid)
              .set({
            'username': username.text,
            'email': email.text,
          }).then((_) {
            FocusScope.of(ctx).unfocus();
            clearAllField();
            Get.toNamed(LoginScreen.routeName);
            isLoading.value = false;
          });
        }
      } else {
        print('Login Form ${matchLoginForm}');
        if (matchLoginForm) {
          userCredential = await _auth.signInWithEmailAndPassword(
            email: email.text,
            password: password.text,
          );
          FocusScope.of(ctx).unfocus();
          Get.toNamed(CommonBottomBar.routeName);
          isLoading.value = false;
          clearAllField();
        }
      }
    } on FirebaseAuthException catch (e) {
      var message = ' An error occurred, please check credentials!';
      if (e.message != null) {
        message = e.message!;
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
          ),
        );
      }
      isLoading.value = false;
    } catch (otherError) {
      log(
        'Other Error ::',
        error: otherError,
        stackTrace: StackTrace.current,
      );
      isLoading.value = false;
    }
  }
}
