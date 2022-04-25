import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expanse_manage/login_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:shared_preferences/shared_preferences.dart';

class Signupcontroller extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController conformPassword = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  late final String getFireBaseId;
  String authError = '';
  final formKey = GlobalKey<FormState>();
  final String emailRegExp =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  final String passwordRegExp =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

  String getUsername = '';
  bool fireBaseError = false;
  CollectionReference user = FirebaseFirestore.instance.collection('user');

  @override
  void onInit() {
    super.onInit();
    getUserName();
  }

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

  bool? matchAllField() {
    return formKey.currentState?.validate();
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
    name.clear();
    email.clear();
    password.clear();
    conformPassword.clear();
  }

  registration() async {
    /**
     * 1. check validation for all fields
     * 2. Create user in firebasse and get firebaseId
     * 3. create entry in users collection with documentId same as firebase ID
     * 4. Return users collection entry data
     */
    if (matchAllField()!) {
      try {
        await auth.createUserWithEmailAndPassword(
            email: email.text, password: password.text);
      } on FirebaseAuthException catch (e) {
        debugPrint('Caught Error during creating User :: ${e.code}');
      }
      authError.isEmpty ? {clearAllField(), Get.to(LoginScreen())} : null;
      update();
    }
  }

  getUserName() async {
    final pref = await SharedPreferences.getInstance();
    pref.getString('username');
  }
}
