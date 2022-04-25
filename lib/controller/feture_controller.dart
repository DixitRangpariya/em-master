import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expanse_manage/utils/color_ext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/app_color.dart';

class FeaturesController extends GetxController {
  TextEditingController loanName = TextEditingController();
  TextEditingController amunt = TextEditingController();
  TextEditingController installment = TextEditingController();
  TextEditingController percentage = TextEditingController();
  var currentUser = FirebaseAuth.instance.currentUser;

  TextEditingController product_name = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController description = TextEditingController();

  TextEditingController businessName = TextEditingController();
  TextEditingController businessType = TextEditingController();
  TextEditingController businessAddress = TextEditingController();
  TextEditingController amountin = TextEditingController();
  TextEditingController descriptionin = TextEditingController();

  DateTime transactiondate = DateTime.now();
  Future<void> createLoan() async {
    CollectionReference expanse =
        FirebaseFirestore.instance.collection('users/${currentUser!.uid}/loan');
    await expanse
        .add({
          'loan_name': loanName.text,
          'amount': amunt.text,
          'installment': installment.text,
          'percentage': percentage.text,
          'date': DateTime.now().toIso8601String(),
        })
        .then((value) => debugPrint('Value added :: ${value.id}'))
        .catchError((error) => debugPrint('Value added :: $error'));
  }

  Future<void> createBill() async {
    CollectionReference expanse =
        FirebaseFirestore.instance.collection('users/${currentUser!.uid}/bill');
    await expanse
        .add({
          'product_name': product_name.text,
          'amount': amount.text,
          'date': DateTime.now(),
          'description': description.text,
        })
        .then((value) => debugPrint('Value added :: ${value.id}'))
        .catchError((error) => debugPrint('Value added :: $error'));
  }

  Future<void> createInvestment() async {
    CollectionReference expanse = FirebaseFirestore.instance
        .collection('users/${currentUser!.uid}/investment');
    await expanse
        .add({
          'business_name': businessName.text,
          'business_type': businessName.text,
          'business_address': businessAddress.text,
          'amount': amountin.text,
          'date': DateTime.now(),
          'description': descriptionin.text,
        })
        .then((value) => debugPrint('Value added :: ${value.id}'))
        .catchError((error) => debugPrint('Value added :: $error'));
  }

  void selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: transactiondate,
      currentDate: transactiondate,
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
            data: ThemeData(
              primarySwatch: AppColor.textColorDark.toMaterialColor(),
            ),
            child: child!);
      },
    );
    if (selected != null && selected != transactiondate) {
      transactiondate = selected;
      var transactionDate;
      debugPrint(
          ''' Date :: ${transactionDate.day} / ${transactionDate.month} / ${transactionDate.year}''');
    }
    update();
  }

  Stream<QuerySnapshot> fetchloan() {
    var data = FirebaseFirestore.instance
        .collection('users/${currentUser!.uid}/loan')
        .snapshots();
    return data;
  }
}
