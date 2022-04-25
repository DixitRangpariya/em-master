import 'package:expanse_manage/res/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../common_widget/common_appbar.dart';
import '../common_widget/common_text.dart';

class Loandetails extends StatefulWidget {
  const Loandetails({Key? key}) : super(key: key);

  @override
  State<Loandetails> createState() => _LoandetailsState();
}

class _LoandetailsState extends State<Loandetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
          title: 'Loan Detail', hasBackIcon: true, actionIcon: Icon(Icons.add)),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Stack(children: [
          // IconButton(onPressed: () {}, icon: Icon(Icons.close)),
          Card(
            // color: Color.fromARGB(255, 50, 67, 114),
            margin: const EdgeInsets.all(20),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            // child: Padding(
            // padding: EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    stops: [
                      0.13,
                      0.90,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color.fromARGB(255, 50, 67, 114),
                      Color.fromARGB(255, 80, 114, 172),
                    ],
                  )),
              // height: 180,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CustomText(
                      'Loan Name :',
                      size: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      'Loan Amount :',
                      size: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      'Installment :',
                      size: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      'Loan Percentage :',
                      size: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      'Installment Date :',
                      size: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
        // )
      ]),
    );
  }
}
