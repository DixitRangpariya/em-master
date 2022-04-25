import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final TextEditingController validEmail = TextEditingController();

  sendEmail() async {
    if (validEmail.text.isNotEmpty) {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: validEmail.text);
        Get.snackbar('Forgot Link', 'Email has been sent to your MailBox');
      } catch (e) {
        debugPrint('Caught Error during Reset Password :: $e');
      }
    }
  }
}
