import 'package:expanse_manage/common_widget/common_textbutton.dart';
import 'package:flutter/material.dart';

import '../common_widget/common_appbar.dart';
import '../common_widget/common_text_form_field.dart';

class addbudget extends StatefulWidget {
  const addbudget({Key? key}) : super(key: key);

  @override
  State<addbudget> createState() => _addbudgetState();
}

class _addbudgetState extends State<addbudget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Add Budget',
        hasBackIcon: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CommonTextFormField(hintText: 'Amount'),
            CommonTextFormField(hintText: 'Category'),
            CommonTextButton(onPressed: () {}, text: 'Add Budget')
          ],
        ),
      ),
    );
  }
}
