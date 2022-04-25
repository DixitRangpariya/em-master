import 'package:expanse_manage/common_widget/common_appbar.dart';
import 'package:expanse_manage/common_widget/common_text.dart';
import 'package:expanse_manage/res/app_image.dart';
import 'package:flutter/material.dart';

class Aboutus extends StatefulWidget {
  const Aboutus({Key? key}) : super(key: key);

  @override
  State<Aboutus> createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: "Aboutus",
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Image.asset(AppImage.logoS, height: 100),
            SizedBox(
              height: 20,
            ),
            CustomText(
              'Expence Manager is a Professional App Platform. Here we will provide you only interesting content, which you will like very much. We are dedicated to providing you the best of WebsiteType, with a focus on dependability and WebsiteSpeciality. Wea re working to turn our passion for WebsiteType into a booming online website. We hope you enjoy our WebsiteType as much as we enjoy offering them to you.\n\n      Have a nice day !',
              size: 15,
              height: 1.5,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
