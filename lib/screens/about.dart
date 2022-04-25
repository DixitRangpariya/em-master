import 'package:expanse_manage/common_widget/common_appbar.dart';
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
    );
  }
}
