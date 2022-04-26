import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expanse_manage/common_widget/common_appbar.dart';
import 'package:expanse_manage/common_widget/common_textbutton.dart';
import 'package:expanse_manage/my_profile/change_password.dart';
import 'package:expanse_manage/my_profile/mobail.dart';
import 'package:expanse_manage/my_profile/my_profile_controller.dart';
import 'package:expanse_manage/signup_screen/signup_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../common_widget/common_text.dart';
import '../common_widget/widget.dart';
import '../res/app_color.dart';
import '../res/app_image.dart';
import '../screens/about.dart';

class Profile extends StatelessWidget {
  final myProfileController = Get.put(MyProfileController());

  Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
          hasBackIcon: false,
          actionIcon:
              IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
          titleWidget: const CustomText('Profile',
              size: 20,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w600)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  CircleImageFromAsset(
                    AppImage.logoM,
                    size: Get.height / 8,
                  ),
                  CustomText(
                    '\n${myProfileController.username}\n',
                    size: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomText(
                    myProfileController.email,
                    color: AppColor.textGrey,
                    size: 14,
                  ),
                ],
              )),
          const SizeBoxH(10),
          buildButton(text: 'Setting', onPressed: () {}),
          buildButton(
              text: 'Archive',
              onPressed: () {
                generatePDF();
              }),
          buildButton(text: 'Invite Friend', onPressed: () {}),
          buildButton(
            text: 'About us',
            onPressed: () => Get.to(
              const AboutUs(),
            ),
          ),
          buildButton(text: 'Help Center', onPressed: () {}),
          buildButton(text: 'Logout', onPressed: () {}),
        ],
      ),
    );
  }

  Widget buildButton({required String text, required VoidCallback onPressed}) {
    return CommonTextButton(
      onPressed: onPressed,
      onlyText: true,
      text: text,
      color: AppColor.black,
      fontWeight: FontWeight.w500,
      textSize: 15,
      textAlign: TextAlign.start,
      vertical: 0,
      horizontal: 30,
    );
  }
}

List list = [];

Future<void> generatePDF() async {
  final PdfDocument document = PdfDocument();
  var user = FirebaseAuth.instance.currentUser;
  final page = document.pages.add();
  final PdfGrid grid = PdfGrid();

  final pfdGent = await FirebaseFirestore.instance
      .collection('users/${user!.uid}/transaction')
      .get();
  for (var value in pfdGent.docs) {
    print(value.data());
    print('DAta');
    return list.add(value);
  }
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
    row.cells[0].value = list[i]['isExpanse'];
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
/*class Profile extends StatelessWidget {
  final myProfileController = Get.put(MyProfileController());
  final signUpController = Get.put(Signupcontroller());

  Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Profile', hasBackIcon: false),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText("Username",
                      fontWeight: FontWeight.w500,
                      size: 20,
                      color: Colors.black.withOpacity(0.4)),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    myProfileController.username,
                    fontWeight: FontWeight.bold,
                    size: 18,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              const CustomText(
                "Email",
                fontWeight: FontWeight.w600,
                size: 12,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomText(
                myProfileController.email,
                fontWeight: FontWeight.bold,
                size: 18,
              ),
              const SizedBox(
                height: 25,
              ),
            ],
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
                    // Get.to(ChangePassword());
                  },
                  text: 'About Us'),
              buildTextButton(
                  onPressed: () {
                    Get.to(generatepdf());
                  },
                  text: 'Export Data'),
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
}*/
