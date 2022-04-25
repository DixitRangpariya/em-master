import 'package:expanse_manage/screens/api/tipmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Tips extends GetxController {
  Future<List<FinancialTip>?> fetchFineTip() async {
    var client = http.Client();
    var url = Uri.parse('https://nikunjdudhat.com/api/financetips.php');
    var response = await client.get(url);
    debugPrint('Status Code ::: ${response.statusCode}');
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var financialList =
          List.from(json).map((e) => FinancialTip.fromJson(e)).toList();
      debugPrint('Response Type ::: ${financialList.runtimeType}');
      debugPrint('Response ::: $financialList');
      return financialList;
    } else {
      debugPrint('Status Code ::: ${response.statusCode}');
    }
    return null;
  }
}
