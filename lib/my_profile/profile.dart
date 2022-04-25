import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expanse_manage/common_widget/common_appbar.dart';
import 'package:expanse_manage/common_widget/common_textbutton.dart';
import 'package:expanse_manage/my_profile/change_password.dart';
import 'package:expanse_manage/my_profile/mobail.dart';
import 'package:expanse_manage/my_profile/my_profile_controller.dart';
import 'package:expanse_manage/screens/about.dart';
import 'package:expanse_manage/screens/creditcard/addcard.dart';
import 'package:expanse_manage/screens/creditcard/card.dart';
import 'package:expanse_manage/signup_screen/signup_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../common_widget/common_text.dart';
import '../res/app_color.dart';

class Profile extends StatelessWidget {
  final myProfileController = Get.put(MyProfileController());
  final signUpController = Get.put(Signupcontroller());

  Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Profile', hasBackIcon: false),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                border: Border.all(
                  width: 4,
                  color: AppColor.darkBlue,
                  style: BorderStyle.solid,
                )),
            child: const CircleAvatar(
              radius: 50.0,
              // backgroundImage: AssetImage(AppImage.profile),
              backgroundColor: AppColor.darkBlue,
              // child: ClipRRect(
              //   child: Image.asset(AppImage.profile),
              //   borderRadius: BorderRadius.circular(100.0),
              // ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText("Username",
                  fontWeight: FontWeight.w500,
                  size: 15,
                  color: Colors.black.withOpacity(0.4)),
              const SizedBox(
                height: 10,
              ),
              const CustomText(
                "Dixit Rangpariya",
                fontWeight: FontWeight.bold,
                size: 20,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 150),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              buildTextButton(
                  onPressed: () {
                    Get.to(ChangePassword());
                  },
                  text: 'Change Password'),
              buildTextButton(
                  onPressed: () {
                    myProfileController.logOut();
                  },
                  text: 'Logout'),
              buildTextButton(
                  onPressed: () {
                    Get.to(Aboutus());
                  },
                  text: 'About Us'),
              buildTextButton(
                  onPressed: () {
                    Get.to(generatepdf());
                  },
                  text: 'Export Data'),
              buildTextButton(
                  onPressed: () {
                    Get.to(Cardadd());
                  },
                  text: 'card Data'),
            ]),
          ),
        ],
      ),
    );
  }

  buildTextButton({
    required VoidCallback onPressed,
    required String text,
  }) {
    return CommonTextButton(
      onPressed: onPressed,
      text: text,
      textSize: 15,
      color: AppColor.textColorDark,
      onlyText: true,
      horizontal: Get.width * 0.02,
      vertical: Get.height * 0.0001,
    );
  }
}

List list = [];

Future<void> generatepdf() async {
  final PdfDocument document = PdfDocument();
  var user = FirebaseAuth.instance.currentUser;
  final page = document.pages.add();
  final PdfGrid grid = PdfGrid();

  final pfdgent = await FirebaseFirestore.instance
      .collection('users/${user!.uid}/transaction')
      .get();
  pfdgent.docs.forEach(
    (value) {
      print(value.data());
      print('DAta');
      return list.add(value);
    },
  );
  print('Data::::::::::::::::::::::::::::');
  print(list.length);
  final PdfPageTemplateElement headerTemplate =
      PdfPageTemplateElement(const Rect.fromLTWH(0, 0, 515, 50));
  headerTemplate.graphics.drawString(
      'Power By Expense Manager', PdfStandardFont(PdfFontFamily.helvetica, 12),
      bounds: const Rect.fromLTWH(0, 15, 200, 20));
  document.template.top = headerTemplate;
  grid.columns.add(count: 5);
  final PdfGridRow headerRow = grid.headers.add(1)[0];
  headerRow.cells[0].value = 'Inc/Exp Name';
  headerRow.cells[1].value = 'Type';
  headerRow.cells[2].value = 'Date';
  headerRow.cells[3].value = 'Amount';
  headerRow.cells[4].value = 'Description';
  headerRow.style.font =
      PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.bold);
  PdfGridRow row = grid.rows.add();

  for (var i = 0; i < list.length; i++) {
    row = grid.rows.add();
    if (list[i]['isExpanse'] == true) {
      // row.cells[0].value = list[i]['isExpanse'];
      row.cells[0].value = 'Expanse';
    } else {
      row.cells[0].value = 'Income';
    }
    row.cells[1].value = list[i]['categoryName'];
    row.cells[2].value = list[i]['transactionDate'];
    row.cells[3].value = list[i]['amount'];
    row.cells[4].value = list[i]['description'];
  }

  grid.style.cellPadding = PdfPaddings(left: 5, top: 5);

  grid.draw(
      page: page,
      bounds: Rect.fromLTWH(
          0, 0, page.getClientSize().width, page.getClientSize().height));

  // page.graphics.drawString(
  //     'Hello World!', PdfStandardFont(PdfFontFamily.helvetica, 12),
  //     brush: PdfSolidBrush(PdfColor(0, 0, 0)),
  //     bounds: const Rect.fromLTWH(0, 0, 150, 20));
// Save the document.

  List<int> bytes = document.save();
// Dispose the document.
  document.dispose();
  saveAndLaunchFile(bytes, 'e.pdf');
}
