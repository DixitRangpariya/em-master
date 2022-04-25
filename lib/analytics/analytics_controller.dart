import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expanse_manage/modal/chart_data.dart';
import 'package:expanse_manage/modal/monthely_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AnalyticsController extends GetxController {
  final currentUser = FirebaseAuth.instance.currentUser;

  final List<ChartData> chartData = [
    ChartData(2010, 35),
    ChartData(2011, 28),
    ChartData(2012, 34),
    ChartData(2013, 32),
    ChartData(2014, 40)
  ];
  final List<ChartData> incomeData = [
    ChartData(2010, 3),
    ChartData(2011, 58),
    ChartData(2012, 74),
    ChartData(2013, 22),
    ChartData(2014, 70)
  ];

  final List<MonthlyData> monthIncome = [
    MonthlyData('Jan', '2000'),
    MonthlyData('Feb', '2450'),
    MonthlyData('Mar', '2350'),
    MonthlyData('April', '2231'),
    MonthlyData('May', '3443'),
    MonthlyData('Jun', '4354'),
    MonthlyData('July', '1256'),
    MonthlyData('August', '7645'),
    MonthlyData('September', '5673'),
    MonthlyData('October', '5687'),
    MonthlyData('November', '1265'),
    MonthlyData('December', '3653'),
  ];

  Stream<QuerySnapshot> fetchData(bool isExpanse) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    return firestore
        .collection('users/${currentUser!.uid}/transaction')
        .where(
          'isExpanse',
          isEqualTo: isExpanse,
        )
        .snapshots();
  }
}
