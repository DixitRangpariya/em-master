import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expanse_manage/res/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class DashBoardController extends GetxController {
  TextEditingController serch = TextEditingController();
  List userData = [];
  List getIncome = [];
  final currentUser = FirebaseAuth.instance.currentUser;
  double total = 0;
  double netBalance = 0.0;
  double totalIncome = 0.0;
  double totalExpanse = 0.0;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'April',
    'May',
    'June',
    'July',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  final int month = DateTime.now().month;

  Stream<QuerySnapshot<Object?>> fetchTransaction() {
    var data = FirebaseFirestore.instance
        .collection('users/${currentUser!.uid}/transaction')
        .orderBy('sortingDate', descending: true)
        .snapshots();
    // transaction.forEach((element) {
    //   final info;
    //   info = element.data;
    //   List<Model> model = info;
    // });
    return data;
  }

  Future<void> deleteTransaction(String docID, bool isExpanse) async {
    await FirebaseFirestore.instance
        .collection('users/${currentUser!.uid}/transaction')
        .doc(docID)
        .delete()
        .then(
      (_) {
        isExpanse
            ? {
                totalExpanse = 0,
                getTotalExpanse(),
              }
            : {
                totalIncome = 0,
                getTotalIncome(),
              };
        Get.snackbar(
          'Deleted',
          'Transaction Deleted Successfully',
          icon: const Icon(
            Icons.check_circle_outlined,
            color: AppColor.green,
          ),
        );
      },
    );
  }

  Future<void> getTotalIncome() async {
    final transaction = await FirebaseFirestore.instance
        .collection('users/${currentUser!.uid}/transaction')
        .where('isExpanse', isEqualTo: false)
        .get();
    totalIncome = 0;
    transaction.docs.forEach((element) {
      var val = element.data()['amount'];
      totalIncome += double.parse(val);
      debugPrint('TOTAL :::: $totalIncome');
    });
    netBalance = totalIncome - totalExpanse;
    await fireStore
        .doc('users/${currentUser!.uid}/total/TXNxFrce29mr5nwQm2KX')
        .update(
      {
        'totalIncome': totalIncome,
        'net_balance': netBalance,
      },
    );
    update();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getTotal() {
    return fireStore
        .doc('users/${currentUser!.uid}/total/TXNxFrce29mr5nwQm2KX')
        .get()
        .asStream();
  }

  Future<void> getTotalExpanse() async {
    final transaction = await FirebaseFirestore.instance
        .collection('users/${currentUser!.uid}/transaction')
        .where('isExpanse', isEqualTo: true)
        .get();
    totalExpanse = 0;
    transaction.docs.forEach((element) {
      var val = element.data()['amount'];
      totalExpanse += double.parse(val);
      debugPrint('TOTAL :::: $totalExpanse');
    });
    netBalance = totalIncome - totalExpanse;
    await fireStore
        .doc('users/${currentUser!.uid}/total/TXNxFrce29mr5nwQm2KX')
        .update(
      {
        'totalExpanse': totalExpanse,
        'net_balance': netBalance,
      },
    );
    debugPrint('Net Balance :::: $netBalance');
    update();
  }

  late Map<String, dynamic> category;
  Stream<QuerySnapshot> serchMethode() {
    final transaction = FirebaseFirestore.instance
        .collection('users/${currentUser!.uid}/transaction')
        .where('categoryName', isEqualTo: serch.text)
        .snapshots();
    update();
    return transaction;
    //     .get()
    //     .then((value) {
    //   category = value.docs[0].data();
    //   update();
    //   print(category);
    // });
  }
}
