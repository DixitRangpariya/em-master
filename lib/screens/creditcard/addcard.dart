import 'package:expanse_manage/common_widget/common_appbar.dart';
import 'package:expanse_manage/res/app_color.dart';
import 'package:expanse_manage/screens/creditcard/card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_widget/common_text.dart';
import '../../common_widget/common_textbutton.dart';

class Cardadd extends StatefulWidget {
  const Cardadd({Key? key}) : super(key: key);

  @override
  State<Cardadd> createState() => _CardaddState();
}

class _CardaddState extends State<Cardadd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar(
          title: 'Add Loan',
          hasBackIcon: true,
        ),
        body: Column(children: [
          Card(
            color: Color.fromARGB(245, 235, 242, 252),
            margin: const EdgeInsets.all(20),
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                // height: 100,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      'Make a Card',
                      size: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      'Creat Your Card Recods just a second.',
                      size: 15,
                      // fontWeight: FontWeight.normal,
                      color: Colors.black.withOpacity(0.4),
                    ),
                    CommonTextButton(
                      onPressed: () {
                        Get.to(Creditcard());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.add_box_rounded,
                              size: 25, color: AppColor.white),
                          Text(
                            'Add Card',
                            style:
                                TextStyle(fontSize: 22, color: AppColor.white),
                          )
                          // CustomText('Create Loan',
                          //     size: 20, color: AppColor.white)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]));
  }
}
