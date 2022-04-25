import 'package:expanse_manage/common_view/add_transaction_view.dart';
import 'package:flutter/material.dart';

class Income extends StatelessWidget {
  const Income({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AddTransaction(
      isExpanse: false,
    );
  }
}
