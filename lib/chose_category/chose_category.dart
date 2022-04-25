import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expanse_manage/common_widget/common_chip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common_widget/common_appbar.dart';
import '../common_widget/common_text.dart';
import '../common_widget/common_text_form_field.dart';
import '../common_widget/common_textbutton.dart';
import '../common_widget/widget.dart';
import '../controller/transacition_controller.dart';
import '../res/app_color.dart';

class ChoseCategory extends StatelessWidget {
  final tranController = Get.find<TransactionController>();

  ChoseCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar(title: 'Chose Category'),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.05, vertical: Get.height * 0.02),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  ' Category in this book\n',
                  color: AppColor.textColorDark,
                ),
                Wrap(
                  spacing: 6.0,
                  runSpacing: 6.0,
                  children: <Widget>[chipList()],
                ),
                const SizeBoxH(10),
                StreamBuilder<QuerySnapshot>(
                  stream: tranController.fetchNewCategory(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    var newCategory = snapshot.data?.docs;
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text('\nYou can add your own category\n'),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText('\nUsers Categories\n'),
                        Wrap(
                          spacing: 6.0,
                          runSpacing: 6.0,
                          children: <Widget>[
                            for (int index = 0;
                                index < newCategory!.length;
                                index++)
                              InkWell(
                                onTap: () {
                                  tranController.onChoseCategory(
                                      newCategory[index]['categoryName']);
                                },
                                child: BuildChip(
                                  label:
                                      newCategory[index]['categoryName'] ?? '',
                                  color: Colors.indigo.shade600,
                                  hasActionIcon: true,
                                  onDelete: () {
                                    tranController.deleteCategory(snapshot
                                        .data!.docs[index].reference.id);
                                  },
                                ),
                              )
                          ],
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
        floatingActionButton: CommonTextButton(
          onPressed: () {
            buildBottomSheet(context);
          },
          buttonWidth: Get.width / 3,
          buttonHeight: Get.height * 0.07,
          radius: 40,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(Icons.add),
                CustomText(
                  'Add New',
                  size: 15,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w600,
                  color: AppColor.white,
                )
              ]),
        ));
  }

  Future buildBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        isDismissible: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        isScrollControlled: true,
        barrierColor: Colors.indigo.shade900.withOpacity(0.2),
        context: context,
        builder: (context) {
          debugPrint('Is Expanse  :: ${tranController.isExpanse}');

          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Get.height * 0.02, horizontal: Get.width * 0.05),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.clear_outlined,
                            color: AppColor.black,
                          )),
                      const CustomText(
                        'Add New Category',
                        size: 17,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w600,
                      )
                    ],
                  ),
                  SizeBoxH(Get.height / 20),
                  CommonTextFormField(
                    hintText: 'Category Name',
                    autofocus: true,
                    controller: tranController.newCategory,
                    underLineBorder: false,
                  ),
                  SizeBoxH(Get.height * 0.05),
                  CommonTextButton(
                    onPressed: () {
                      tranController.addNewCategory(
                        context: context,
                        isExpanse: tranController.isExpanse,
                      );
                    },
                    text: 'Save',
                    vertical: 0,
                    horizontal: 0,
                    radius: 8,
                    buttonWidth: Get.width,
                    buttonHeight: Get.height * 0.06,
                  ),
                ],
              ),
            ),
          );
        });
  }

  chipList() {
    return Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      children: <Widget>[
        buildChip('Food', const Color(0xFFff6666)),
        buildChip('Entertainment', const Color(0xFF007f5c)),
        buildChip('Traveling', const Color(0xFF60230b)),
        buildChip('Entertainment', const Color(0xFF007f5c)),
        buildChip('Traveling', const Color(0xFF60230b)),
        buildChip('Rent', const Color(0xFF5f65d3)),
        buildChip('Maintenance', const Color(0xFF19ca21)),
        buildChip('Traveling', const Color(0xFF60230b)),
        buildChip('Rent', const Color(0xFF5f65d3)),
        buildChip('Traveling', const Color(0xFF60230b)),
        buildChip('Rent', const Color(0xFF5f65d3)),
        buildChip('Entertainment', const Color(0xFF007f5c)),
        buildChip('Fees', const Color(0xFF60230b)),
      ],
    );
  }

  Widget buildChip(String label, Color color) {
    return Chip(
      labelPadding: const EdgeInsets.all(2.0),
      label: CustomText(
        label,
        color: Colors.white,
      ),
      deleteIconColor: Colors.white,
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: const EdgeInsets.all(8.0),
    );
  }
}
