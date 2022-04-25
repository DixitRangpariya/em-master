import 'package:expanse_manage/common_bottom_bar/bottom_bar_controller.dart';
import 'package:expanse_manage/common_view/add_transaction_view.dart';
import 'package:expanse_manage/common_widget/common_text.dart';
import 'package:expanse_manage/common_widget/widget.dart';
import 'package:expanse_manage/res/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

class CommonBottomBar extends StatelessWidget {
  final BottomBarController bottomBarController =
      Get.put(BottomBarController());
  static const routeName = '/commonBottomBar';

  //final ExpanseController expanseController = Get.put(ExpanseController());

  CommonBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomBarController>(
      init: bottomBarController,
      builder: (controller) {
        return Scaffold(
          extendBody: true,
          floatingActionButton: SpeedDial(
            icon: Icons.add,
            activeIcon: Icons.close,
            backgroundColor: AppColor.textColorDark,
            overlayColor: AppColor.textColorDark,
            shape: const CircleBorder(),
            overlayOpacity: 0.3,
            children: [
              SpeedDialChild(
                shape: const CircleBorder(),
                label: 'Expense',
                backgroundColor: AppColor.red,
                foregroundColor: AppColor.white,
                child: const Icon(Icons.logout),
                onTap: () {
                  Get.to(
                    AddTransaction(
                      isExpanse: true,
                    ),
                  );
                },
              ),
              SpeedDialChild(
                shape: const CircleBorder(),
                label: 'Income',
                backgroundColor: AppColor.green,
                foregroundColor: AppColor.white,
                child: const Icon(Icons.login),
                onTap: () {
                  Get.to(
                    AddTransaction(
                      isExpanse: false,
                    ),
                  );
                },
              )
            ],
          ),
          resizeToAvoidBottomInset: false,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: PageView(
            controller: bottomBarController.pageController,
            children: bottomBarController.pageView,
            physics: const NeverScrollableScrollPhysics(),
            allowImplicitScrolling: true,
          ),
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 10,
            clipBehavior: Clip.antiAlias,
            color: Colors.blue.shade50,
            //AppColor.textColorDark,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                commonIconButton(icon: Icons.home, index: 0, label: 'Home'),
                commonIconButton(
                    icon: Icons.insert_chart, index: 1, label: 'Analytics'),
                SizeBoxV(Get.width / 8),
                commonIconButton(
                    icon: Icons.account_balance_wallet_rounded,
                    index: 2,
                    label: 'Wallet'),
                commonIconButton(
                    icon: Icons.account_box, index: 3, label: 'My Profile'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget commonIconButton(
      {required IconData icon, required int index, String? label}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: Get.height / 70, horizontal: Get.width / 50),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              bottomBarController.bottomTaped(index);
            },
            icon: Icon(
              icon,
              color: bottomBarController.currentIndex == index
                  ? AppColor.textColorDark
                  : AppColor.textColor,
              size: 25,
            ),
            splashColor: Colors.transparent,
            splashRadius: 1,
          ),
          CustomText(
            label!,
            size: 12,
            color: bottomBarController.currentIndex == index
                ? AppColor.textColorDark
                : AppColor.textColor,
          )
        ],
      ),
    );
  }

/*  Widget buildFloatingButton() {
    var icons = bottomBarController.icons;
    var _controller = bottomBarController.animationController;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(bottomBarController.icons.length, (int index) {
        Widget child = Container(
          height: 70.0,
          width: 56.0,
          alignment: FractionalOffset.topCenter,
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: bottomBarController.animationController,
              curve: Interval(0.0, 1.0 - index / icons.length / 2.0,
                  curve: Curves.easeOut),
            ),
            child: FloatingActionButton(
              heroTag: null,
              backgroundColor: AppColor.textColor,
              mini: true,
              child: Icon(icons[index], color: AppColor.blueShade50),
              onPressed: () {
                if (_controller.isDismissed) {
                  _controller.forward();
                } else {
                  _controller.reverse();
                }
              },
            ),
          ),
        );
        return child;
      }).toList()
        ..add(
          FloatingActionButton(
            heroTag: null,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget? child) {
                return Transform(
                  transform:
                      Matrix4.rotationZ(_controller.value * 0.5 * math.pi),
                  alignment: FractionalOffset.center,
                  child:
                      Icon(_controller.isDismissed ? Icons.add : Icons.close),
                );
              },
            ),
            onPressed: () {
              if (_controller.isDismissed) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            },
          ),
        ),
      */ /*.toList()..add(
         FloatingActionButton(
          heroTag: null,
          child:  AnimatedBuilder(
            animation: bottomBarController.animationController,
            builder: (BuildContext context, Widget child) {
              return  Transform(
                transform:  Matrix4.rotationZ(_controller.value * 0.5 * math.pi),
                alignment: FractionalOffset.center,
                child:  Icon(_controller.isDismissed ? Icons.share : Icons.close),
              );
            },
          ),*/ /*
    );

    */ /*Transform.rotate(
      angle: 90 *math.pi /180,
      child: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: AppColor.black,
        ),
      ),
    );*/ /*
  }*/
}
