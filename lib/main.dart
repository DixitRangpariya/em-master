import 'package:expanse_manage/res/app_color.dart';
import 'package:expanse_manage/utils/color_ext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common_bottom_bar/common_bottom_bar.dart';
import '../controller_binding.dart';
import '../login_screen/login_screen.dart';
import '../splash_screen/splash_screen.dart';
import 'signup_screen/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ExpanseManager());
}

class ExpanseManager extends StatelessWidget {
  const ExpanseManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // routes: {
      //   LoginScreen.routeName: (ctx) => LoginScreen(),
      //   SignUpScreen.routeName: (ctx) => SignUpScreen(),
      //   CommonBottomBar.routeName: (ctx) => CommonBottomBar(),
      //   SplashScreen.routeName: (ctx) => SplashScreen(),
      // },
      theme: ThemeData(primarySwatch: AppColor.textColorDark.toMaterialColor()),
      getPages: [
        GetPage(
          name: CommonBottomBar.routeName,
          page: () => CommonBottomBar(),
          binding: BottomBarBinding(),
        ),
        GetPage(
          name: SplashScreen.routeName,
          page: () => SplashScreen(),
          binding: OnBoardBinding(),
        ),
        GetPage(
          name: SignUpScreen.routeName,
          page: () => SignUpScreen(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: LoginScreen.routeName,
          page: () => LoginScreen(),
          binding: AuthBinding(),
        )
      ],
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            debugPrint('Status ::::: ${snapshot.hasData}');
            if (snapshot.hasData) {
              return CommonBottomBar();
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Something Went Wrong\n Please try again later'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SplashScreen();
          }),
    );
  }
}
/* return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          debugPrint('Something went wrong :: ${snapshot.hasError}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

      },
    );*/
