import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expanse_manage/common_widget/transaction_tile.dart';
import 'package:expanse_manage/home_page/filter_bottom_sheet.dart';
import 'package:expanse_manage/home_page/show_description.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common_widget/common_text.dart';
import '../common_widget/common_textbutton.dart';
import '../common_widget/widget.dart';
import '../controller/dashbord_controller.dart';
import '../controller/transacition_controller.dart';
import '../res/app_color.dart';
import '../res/app_image.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(DashBoardController());
  final tranController = Get.put(TransactionController());

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(
        init: controller,
        builder: (controller) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                elevation: 2,
                backgroundColor: AppColor.white,
                shadowColor: AppColor.shadowColor,
                leading: Padding(
                  padding: const EdgeInsets.all(3),
                  child: CircleAvatar(
                    backgroundColor: AppColor.textColorDark,
                    child: CustomText(
                      controller.username[0],
                      color: AppColor.white,
                      size: 18,
                    ),
                  ),
                ),

                title: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      'Welcome!',
                      color: AppColor.textColorDark,
                      fontWeight: FontWeight.w300,
                      size: 20,
                    ),
                    const SizeBoxH(5),
                    CustomText(
                      controller.username,
                      size: 20,
                      color: AppColor.textColorDark,
                      fontWeight: FontWeight.w600,
                    )
                  ],
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_active,
                      color: AppColor.textColorDark,
                    ),
                  ),
                ],
                //expandedHeight: 100,
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: controller.search,
                            decoration: const InputDecoration(
                                hintText: 'Search By Category',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  width: 2,
                                  color: AppColor.textColorDark,
                                )),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10)),
                          ),
                          const SizeBoxH(15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildFilterButton(
                                title: 'All Time                       ',
                                icon: Icons.calendar_month,
                                onPressed: () {
                                  buildCalenderSheet(context);
                                },
                              ),
                              buildFilterButton(
                                  title: 'Search',
                                  icon: Icons.search,
                                  onPressed: () {
                                    controller.serchMethode();
                                  }),
                            ],
                          ),
                          const SizeBoxH(15),
                          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                            stream: controller.getTotal(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {}
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {}
                              if (snapshot.data?.data() == null) {
                                return Text('Loading');
                              }
                              return Card(
                                margin: EdgeInsets.zero,
                                elevation: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(children: [
                                    SizeBoxH(Get.height * 0.001),
                                    buildCustomRow(
                                      title: 'Net Balance',
                                      actionTitle:
                                          '${snapshot.data!.data()!['net_balance']}',
                                      fontWeight: FontWeight.w600,
                                    ),
                                    SizeBoxH(Get.height * 0.01),
                                    Divider(
                                      color: AppColor.textColorLight,
                                      thickness: Get.height * 0.002,
                                      endIndent: 0,
                                      indent: 0,
                                    ),
                                    SizeBoxH(Get.height * 0.02),
                                    buildCustomRow(
                                        title: 'Total In (+)',
                                        actionTitle: snapshot.data!
                                            .data()!['totalIncome']
                                            .toStringAsFixed(2),
                                        color: AppColor.green),
                                    SizeBoxH(Get.height * 0.02),
                                    buildCustomRow(
                                        title: 'Total Out (-)',
                                        actionTitle: snapshot.data!
                                            .data()!['totalExpanse']
                                            .toStringAsFixed(2),
                                        color: AppColor.red),
                                  ]),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    controller.search.text.trim().isNotEmpty
                        ? StreamBuilder<QuerySnapshot>(
                            stream: controller.serchMethode(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (snapshot.data!.docs.length.isEqual(0)) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const SizeBoxH(10),
                                      Image.asset(AppImage.noData2,
                                          height: Get.height / 4.5,
                                          width: Get.width / 2.5,
                                          fit: BoxFit.contain),
                                      const CustomText(
                                        '\nNo data found',
                                        size: 20,
                                        color: AppColor.textColorDark,
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizeBoxH(150)
                                    ],
                                  ),
                                );
                              }

                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  var data = snapshot.data!.docs[index];
                                  return TransactionTile(
                                    isExpanse: data['isExpanse'],
                                    color: AppColor.shadowColor,
                                    transactionData: data,
                                  );
                                },
                              );
                            })
                        : StreamBuilder<QuerySnapshot>(
                            stream: controller.fetchTransaction(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (snapshot.data!.docs.length == 0) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const SizeBoxH(10),
                                      Image.asset(AppImage.noData2,
                                          height: Get.height / 4.5,
                                          width: Get.width / 2.5,
                                          fit: BoxFit.fill),
                                      const CustomText(
                                        '\nLooks like we haven\'t even started yet',
                                        size: 20,
                                        color: AppColor.textColorDark,
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizeBoxH(150)
                                    ],
                                  ),
                                );
                              }

                              return Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      var transactionData =
                                          snapshot.data!.docs[index];
                                      bool isExpanse =
                                          transactionData['isExpanse'];
                                      Color color = isExpanse
                                          ? AppColor.red
                                          : AppColor.green;
                                      final data = snapshot.data!.docs;

                                      final currentIndexDate =
                                          data[index]['sortingDate'];
                                      final DateTime date = DateTime.parse(
                                          (data[index]['transactionDate']));
                                      //final lastIndexDate =
                                      //    data[index - 1]['sortingDate'];
                                      return Column(
                                        children: [
                                          index == 0
                                              ? Container(
                                                  height: Get.height / 18,
                                                  width: Get.width,
                                                  color: AppColor.shadowColor,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    '${date.day} - ${controller.months[date.month - 1]} - ${date.year}',
                                                  ),
                                                )
                                              : date.day !=
                                                      DateTime.parse(data[
                                                                  index - 1][
                                                              "transactionDate"])
                                                          .day
                                                  ? Container(
                                                      height: Get.height / 18,
                                                      width: Get.width,
                                                      color:
                                                          AppColor.shadowColor,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        '${date.day} - ${controller.months[date.month - 1]} - ${date.year}',
                                                      ),
                                                    )
                                                  : const SizedBox.shrink(),
                                          TransactionTile(
                                            transactionData: transactionData,
                                            isExpanse: isExpanse,
                                            color: color,
                                            documentId:
                                                transactionData.reference.id,
                                            onLongPress: () {
                                              buildDetailSheet(
                                                  context: context,
                                                  categoryName: transactionData[
                                                      'categoryName'],
                                                  amount:
                                                      transactionData['amount'],
                                                  url: transactionData[
                                                      'attachmentUrl'],
                                                  date: DateTime.parse(
                                                      transactionData[
                                                          'transactionDate']),
                                                  isExpanse: transactionData[
                                                      'isExpanse'],
                                                  description: transactionData[
                                                      'description']);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                ],
                              );
                            },
                          )
                  ],
                ),
              ),
            ],
          );
        });
  }

  Widget buildFilterButton({
    required String title,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 40,
      child: Card(
        elevation: 3,
        margin: EdgeInsets.zero,
        shadowColor: AppColor.shadowColor,
        child: TextButton.icon(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 22,
            color: AppColor.textColorDark,
          ),
          label: CustomText(
            title,
            size: 14,
            color: AppColor.textColorDark,
          ),
        ),
      ),
    );
  }

  Widget buildCustomRow({
    required String title,
    required String actionTitle,
    Color? color,
    Color? actionColor,
    FontWeight? fontWeight,
  }) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      CustomText(
        title,
        fontWeight: fontWeight ?? FontWeight.w500,
        color: AppColor.black,
      ),
      CustomText(
        actionTitle,
        color: color ?? AppColor.black,
        fontWeight: fontWeight ?? FontWeight.w500,
      ),
    ]);
  }

  Widget buildCustomIconButton(IconData icon, String title, double width) {
    return CommonTextButton(
      onPressed: () {},
      child: Row(children: [
        Icon(
          icon,
          color: AppColor.textColorDark,
        ),
        CustomText('   $title')
      ]),
      buttonColor: AppColor.white,
      elevation: 3,
      horizontal: 0,
      buttonHeight: Get.height * 0.05,
      buttonWidth: width,
      radius: 0,
    );
  }

  PreferredSizeWidget buildContainer() {
    return AppBar(
      flexibleSpace: Container(height: 50, color: Colors.red),
    );
  }
}
/* SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ListTile(
                leading: Card(
                  child: const Icon(
                    Icons.title,
                    color: Colors.red,
                    size: 35,
                  ),
                  color: Colors.red.shade100,
                ),
                title: const CustomText(
                  'Cate Name ',
                  size: 15,
                  color: AppColor.textColorDark,
                  fontWeight: FontWeight.w500,
                ),
                subtitle: const CustomText(
                  'description',
                  overflow: TextOverflow.ellipsis,
                  color: AppColor.textGrey,
                  size: 12,
                ),
                trailing: const CustomText(
                  'amount',
                  overflow: TextOverflow.ellipsis,
                  size: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
                onTap: () {},
              );
            },
            childCount: 10,
          ),
        ),*/
