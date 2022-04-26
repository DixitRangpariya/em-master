import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expanse_manage/login_screen/login_screen.dart';
import 'package:expanse_manage/res/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfileController extends GetxController {
  TextEditingController changePassword = TextEditingController();
  final myProFormKey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  var currentUser = FirebaseAuth.instance.currentUser;
  var fireStore = FirebaseFirestore.instance;
  final Stream<QuerySnapshot> userStream =
      FirebaseFirestore.instance.collection('user').snapshots();

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    await FirebaseFirestore.instance
        .doc('users/${currentUser!.uid}')
        .get()
        .then(
      (value) {
        username = value.data()!['username'];
        email = value.data()!['email'];
        debugPrint('$username\n$email');
      },
    );
    update();
  }

  logOut() async {
    final pref = await SharedPreferences.getInstance();
    await FirebaseAuth.instance.signOut();
    Get.offAll(LoginScreen());
    pref.remove('uid');
    Get.snackbar('You Are Logged Out', 'Please Login Again',
        backgroundColor: Colors.indigo.withOpacity(0.2),
        colorText: Colors.white);
  }

  newPassword() async {
    try {
      await currentUser?.updatePassword(changePassword.text);
      Get.snackbar('Password Change', 'Please login Again',
          backgroundColor: AppColor.backgroundColor);
      Get.offAll(LoginScreen());
    } catch (e) {
      debugPrint('Error Caught during Change Password :: $e');
    }
  }
}
