import 'dart:async';

import 'package:flutter/material.dart';
import 'package:soedja_freelance/old_ver/constants/assets.dart';
import 'package:soedja_freelance/old_ver/screens/auth/auth_screen.dart';
import 'package:soedja_freelance/old_ver/screens/login/login_screen.dart';
import 'package:soedja_freelance/old_ver/screens/onBoard/on_board_screen.dart';
import 'package:soedja_freelance/old_ver/screens/pin/input_pin_screen.dart';
import 'package:soedja_freelance/old_ver/services/push_notification.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';
import 'package:soedja_freelance/old_ver/utils/helpers.dart';
import 'package:soedja_freelance/old_ver/utils/navigation.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> {
  startTimer() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    isLogin().then((value) {
      if (value) {
        Navigation().navigateReplacement(context, InputPinScreen());
      } else {
        isFirstTime().then((value) {
          if (value) {
            Navigation().navigateReplacement(context, OnBoardScreen());
          } else {
            Navigation().navigateReplacement(context, AuthScreen());
          }
        });
      }
    });
  }

  @override
  void initState() {

    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        color: AppColors.dark,
        alignment: Alignment.center,
        child: Image.asset(
          Assets.imgLogoOnly,
          height: 100.0,
          width: 100.0,
        ),
      ),
    );
  }
}
