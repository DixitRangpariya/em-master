import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expanse_manage/res/app_color.dart';
import 'package:expanse_manage/utils/color_ext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TransactionController extends GetxController {
  var currentUser = FirebaseAuth.instance.currentUser;
  final newCategory = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  String? attachment;
  DateTime transactionDate = DateTime.now();
  String? choseCategory;
  bool isExpanse = false;
  bool isLoading = false;
  bool isSelected = false;
  String attachmentUrl = '';

  Future<void> addTransaction(BuildContext context) async {
    FocusScope.of(context).unfocus();
    isLoading = true;

    if (choseCategory != null && amountController.text.trim().isNotEmpty) {
      FirebaseFirestore.instance
          .collection('users/${currentUser!.uid}/transaction')
          .add({
        'id': FieldValue.serverTimestamp(),
        'isExpanse': isExpanse,
        'categoryName': choseCategory,
        'amount': amountController.text.trim(),
        'transactionDate': transactionDate.toIso8601String(),
        'sortingDate': transactionDate,
        'description': descriptionController.text.trim(),
        'attachmentUrl': attachmentUrl,
        'currentMonth': transactionDate.month
      }).then((_) async {
        onBackTap();
        Get.snackbar('Transaction', 'Transaction Added Successfully');
        isLoading = false;
      }).catchError((onError) {
        isLoading = false;
        log('Error::', error: onError);
      });
    }
  }

  void onBackTap() {
    choseCategory = null;
    amountController.clear();
    transactionDate = DateTime.now();
    descriptionController.clear();
    attachment = '';
    Get.back();
  }

  void selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: transactionDate,
      currentDate: transactionDate,
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
    if (selected != null && selected != transactionDate) {
      transactionDate = selected;
      debugPrint(
          ''' Date :: ${transactionDate.day} / ${transactionDate.month} / ${transactionDate.year}''');
    }
    update();
  }

  Future<void> addNewCategory({
    required BuildContext context,
    required bool isExpanse,
  }) async {
    FocusScope.of(context).unfocus();
    if (!isSelected) {
    await FirebaseFirestore.instance
            .collection('users/${currentUser!.uid}/newCategory')
            .add(
          {
            'id': FieldValue.serverTimestamp(),
            'categoryName': newCategory.text,
            'isExpanse': isExpanse,
          },
        ).then((value) {
          Get.back();
          isSelected = false;
          Get.snackbar(
              'New Category', '${newCategory.text}  Added Successfully',
              icon: const Icon(
                Icons.check_circle_outlined,
                color: AppColor.green,
                size: 25,
              ));
          newCategory.clear();
        }).catchError(
          (onError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$onError'),
                backgroundColor: AppColor.red,
              ),
            );
          },
        );

    }
    update();
  }

  Stream<QuerySnapshot> fetchNewCategory() {
    return FirebaseFirestore.instance
        .collection('users/${currentUser!.uid}/newCategory')
        .snapshots();
  }

  Future<void> deleteCategory(String path) async {
    //log('Doc Id', error: '${path}');
    await FirebaseFirestore.instance
        .collection('users/${currentUser!.uid}/newCategory')
        .doc(path)
        .delete()
        .then(
      (_) {
        Get.snackbar('Removed', 'Item Deleted Successfully!');
      },
    );
  }

  void onChoseCategory(String category) {
    choseCategory = category;
    Get.back();
    update();
  }

  Future<void> imageFromGallery() async {
    PickedFile? _image = await (ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 50));
    attachment = _image!.path;
    debugPrint('Expanse :: $attachment  \n Income ::$attachment');
    update();
  }

  Future<void> imageFromCamera() async {
    PickedFile? _image = await (ImagePicker.platform
        .pickImage(source: ImageSource.camera, imageQuality: 50));
    attachment = _image!.path;
    debugPrint('Expanse :: $attachmentUrl  \n Income ::$attachmentUrl');
    update();
  }

  Future<void> saveAttachment() async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('profilePic')
        .child(DateTime.now().toIso8601String() + '.jpg');
    await ref.putFile(File(attachment!)).whenComplete(
          () async => attachmentUrl = await ref.getDownloadURL(),
        );
debugPrint('$attachmentUrl');
    update();
  }
}
