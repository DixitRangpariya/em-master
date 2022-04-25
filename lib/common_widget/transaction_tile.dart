import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/dashbord_controller.dart';
import '../res/app_color.dart';
import 'common_text.dart';

class TransactionTile extends StatelessWidget {
  final dashController = Get.find<DashBoardController>();
  final GestureLongPressCallback? onLongPress;
  final dynamic transactionData;
  final String? documentId;
  final bool isExpanse;
  final Color color;

  TransactionTile({
    Key? key,
    this.transactionData,
    required this.isExpanse,
    required this.color,
    this.documentId,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(transactionData['id']),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are You Sure !'),
            content: Text(
                'Do You Really Want To Remove ${transactionData['categoryName']}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    false,
                  );
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    true,
                  );
                },
                child: const Text('Yes'),
              )
            ],
          ),
        );
      },
      background: Container(
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          size: 25,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
      ),
      onDismissed: (direction) {
        dashController.deleteTransaction(documentId!, isExpanse);
      },
      child: ListTile(
        onLongPress: onLongPress,
        leading: Card(
          child: Icon(
            isExpanse ? Icons.trending_down : Icons.trending_up,
            color: color,
            size: 35,
          ),
          color: isExpanse ? Colors.red.shade100 : Colors.green.shade100,
        ),
        title: CustomText(
          transactionData['categoryName'],
          size: 15,
          color: AppColor.textColorDark,
          fontWeight: FontWeight.w500,
        ),
        subtitle: CustomText(
          transactionData['description'],
          overflow: TextOverflow.ellipsis,
          color: AppColor.textGrey,
          size: 12,
        ),
        trailing: CustomText(
          isExpanse
              ? '-' + transactionData['amount']
              : '+' + transactionData['amount'],
          overflow: TextOverflow.ellipsis,
          size: 18,
          color: color,
          fontWeight: FontWeight.w700,
        ),
        onTap: () {},
      ),
    );
  }
}
