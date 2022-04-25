import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expanse_manage/common_bottom_bar/common_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common_widget/common_text.dart';
import '../common_widget/common_textbutton.dart';

class LoginController extends GetxController {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  String userId = '';

  String getUid = '';
  String getUsername = '';
  String documentId = '';
  String loginError = '';

  final String emailRegExp =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  final String passwordRegExp =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

  final loginFormKey = GlobalKey<FormState>();
  bool success = false;
  late UserCredential userCredential;
  RxBool loginStatus = false.obs;

  @override
  void onInit() {
    super.onInit();
    debugPrint('init Called');
    isLoggedIn();
  }

  bool validateAllField() {
    success = loginFormKey.currentState!.validate();
    return success;
  }

  bool validateEmail(String email) {
    RegExp regExp = RegExp(emailRegExp);
    return regExp.hasMatch(email);
  }

  bool validatePassword(String password) {
    RegExp regExp = RegExp(passwordRegExp);
    return regExp.hasMatch(password);
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

  userNameValidation(String value) {
    if (value.isEmpty) {
      return "Name Required";
    } else {
      return null;
    }
  }

  userLogin(BuildContext context) async {
    if (validateAllField()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: email.text, password: password.text);
        userId = userCredential.user!.uid;
        final pref = await SharedPreferences.getInstance();
        pref.setString('uid', userCredential.user!.uid);
        debugPrint(
            'Uid :: ${pref.getString('uid')}\nUsername :: ${pref.getString('username')}');
        loginError = '';
        addDataToCollection();
        Get.offAll(CommonBottomBar());
      } on FirebaseAuthException catch (e) {
        authException(e.code);
        buildAlertDialog(context, loginError);
        debugPrint("Error Caught During Login :: $e");
      }
    } else {
      success = false;
    }

    update();
  }

  authException(String e) {
    if (e == 'user-not-found') {
      loginError = 'No User Found Please Sign in';
      update();
    } else if (e == 'unknown') {
      loginError = 'No User Found Please Sign in';
      update();
    } else if (e == 'wrong-password') {
      loginError = 'Username Or Password is wrong';
      update();
    } else if (e == 'too-many-requests') {
      loginError = 'Please Try Again Later';
      update();
    } else {
      loginError = '';
    }
    update();
  }

  Future<bool> isLoggedIn() async {
    final pref = await SharedPreferences.getInstance();
    //getUid = pref.getString('uid')!;
    //getUsername = pref.getString('username')!;
    debugPrint("User ID :: $getUid");
    return getUid.isEmpty;
  }

  Future<void> addDataToCollection() async {
    CollectionReference user = FirebaseFirestore.instance.collection('user');
    final pref = await SharedPreferences.getInstance();
    getUsername = pref.getString('username')!;
    debugPrint('User Name ::::::: $getUsername');

    user.add(
      {'userId': userId, 'username': getUsername},
    ).then((value) {
      debugPrint('User added :: ${value.path} User ID ::${value.id}');
      pref.setString('path', value.path);
    }).catchError((error) => debugPrint('Fail to add User :: $error'));
  }

  Future<void> buildAlertDialog(BuildContext context, String content) {
    debugPrint('Alert sadDialog build');
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
}
