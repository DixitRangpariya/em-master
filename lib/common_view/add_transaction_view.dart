import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:expanse_manage/chose_category/chose_category.dart';
import 'package:expanse_manage/common_widget/common_appbar.dart';
import 'package:expanse_manage/common_widget/common_text.dart';
import 'package:expanse_manage/common_widget/common_text_form_field.dart';
import 'package:expanse_manage/common_widget/common_textbutton.dart';
import 'package:expanse_manage/common_widget/widget.dart';
import 'package:expanse_manage/controller/dashbord_controller.dart';
import 'package:expanse_manage/res/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/transacition_controller.dart';

class AddTransaction extends StatelessWidget {
  final bool isExpanse;
  final tranController = Get.put(TransactionController());
  final dashController = Get.put(DashBoardController());

  AddTransaction({
    Key? key,
    this.isExpanse = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: isExpanse ? 'Expense' : 'Income',
        onBackTap: tranController.onBackTap,
      ),
      body: GetBuilder<TransactionController>(
        init: tranController,
        builder: (trController) {
          tranController.isExpanse = isExpanse;
          DateTime selectedDate = tranController.transactionDate;
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width / 15, vertical: Get.height / 30),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        isExpanse ? Icons.logout : Icons.login,
                        color: AppColor.textColorDark,
                        size: 45,
                      ),
                      SizeBoxV(Get.width / 25),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const CustomText(
                            'Transaction Type',
                            size: 12,
                            color: AppColor.textColor,
                          ),
                          CustomText(
                            isExpanse ? 'Expense' : 'Income',
                            size: 25,
                            fontWeight: FontWeight.bold,
                            color: AppColor.textColorDark,
                          )
                        ],
                      ),
                    ],
                  ),
                  SizeBoxH(Get.height / 50),
                  CommonTextButton(
                    onPressed: () {
                      Get.to(ChoseCategory());
                    },
                    radius: 8,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                              tranController.choseCategory == null
                                  ? 'Chose Category'
                                  : tranController.choseCategory!,
                              color: AppColor.textColorDark,
                              size: 15,
                              fontWeight: FontWeight.w500),
                          const Icon(
                            Icons.arrow_drop_down_sharp,
                            color: AppColor.textColorDark,
                          )
                        ]),
                    vertical: 0,
                    horizontal: 0,
                    color: Colors.indigo,
                    buttonColor: AppColor.blueShade50,
                    elevation: 3,
                  ),
                  SizeBoxH(Get.height * 0.04),
                  CommonTextFormField(
                    hintText: 'Enter Amount',
                    keyboardType: TextInputType.number,
                    controller: tranController.amountController,
                    underLineBorder: false,
                  ),
                  CommonTextButton(
                      radius: 8,
                      onPressed: () => tranController.selectDate(context),
                      buttonColor: AppColor.blueShade50,
                      elevation: 3,
                      vertical: Get.height / 20,
                      horizontal: Get.width * 0.001,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            '''${selectedDate.day} / ${selectedDate.month} / ${selectedDate.year}''',
                            color: AppColor.textColorDark,
                            size: 18,
                          ),
                          const Icon(
                            Icons.calendar_today_outlined,
                            color: AppColor.textColorDark,
                          )
                        ],
                      ),
                      buttonWidth: Get.width,
                      buttonHeight: Get.height / 14),
                  CommonTextFormField(
                    hintText: 'Add Description....',
                    controller: tranController.descriptionController,
                    keyboardType: TextInputType.multiline,
                    underLineBorder: false,
                    padding: EdgeInsets.zero,
                    maxLines: 8,
                  ),
                  SizeBoxH(Get.height / 20),
                  InkWell(
                    onTap: () {
                      buildBottomSheet(context);
                    },
                    child: _imageFile(tranController.attachment ?? ''),
                  ),
                  trController.isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        )
                      : CommonTextButton(
                          onPressed: () async {
                            log('total', error: tranController.isSelected);
                            log('total',
                                error: tranController.amountController.text
                                    .trim()
                                    .isEmpty);
                            if (tranController.choseCategory == null ||
                                tranController.amountController.text
                                    .trim()
                                    .isEmpty) {
                              Get.snackbar(
                                  'Error', 'Category and Amount Required',
                                  colorText: AppColor.white,
                                  icon: const Icon(
                                    Icons.error,
                                    color: AppColor.white,
                                    size: 20,
                                  ),
                                  backgroundColor: AppColor.red);
                            }
                            if (tranController.choseCategory != null &&
                                tranController.amountController.text
                                    .trim()
                                    .isNotEmpty) {
                              await tranController.addTransaction(context);
                              isExpanse
                                  ? await dashController.getTotalExpanse()
                                  : await dashController.getTotalIncome();
                            }
                          },
                          text: 'Add Transaction',
                          radius: 8,
                          vertical: Get.height * 0.05,
                          horizontal: 0,
                        )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _imageFile(String image) {
    return image.isNotEmpty
        ? Align(
            alignment: Alignment.centerLeft,
            child: Image.file(
              File(image),
              width: Get.width / 2.5,
              height: Get.height / 6,
              fit: BoxFit.cover,
            ),
          )
        : DottedBorder(
            child: Row(
              children: const [
                Icon(
                  Icons.attach_file_sharp,
                  color: AppColor.textGrey,
                ),
                CustomText(
                  'Add Attachment',
                  color: AppColor.textGrey,
                ),
              ],
            ),
            color: AppColor.textGrey,
            padding: EdgeInsets.symmetric(
                horizontal: Get.width / 4, vertical: Get.height / 50),
            dashPattern: const [6, 6],
            borderType: BorderType.RRect,
            radius: const Radius.circular(8),
          );
  }

  Future buildBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
            child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const CustomText('Gallery'),
              onTap: () async {
                await tranController.imageFromGallery().then((_) async {
                  tranController.saveAttachment();
                });
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const CustomText('Camera'),
              onTap: () async {
                await tranController.imageFromCamera().then((_) async {
                  tranController.saveAttachment();
                });
                Get.back();
              },
            )
          ],
        ));
      },
    );
  }
}
