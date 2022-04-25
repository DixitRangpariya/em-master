import 'package:expanse_manage/common_widget/common_text.dart';
import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(children: [
        IconButton(onPressed: () {}, icon: Icon(Icons.radio_button_off)),
        CustomText('No Category')
      ]),
    );
  }
}

enum CategoryOption { none, selected }
