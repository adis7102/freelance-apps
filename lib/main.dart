import 'package:flutter/material.dart';
import 'package:soedja_freelance/revamp/assets/fonts.dart';
import 'package:soedja_freelance/revamp/modules/onboard/screens/splash_screen.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

//import 'old_ver.screens/splash/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SOEDJA Freelance',
      home: SplashScreen(),
      theme: ThemeData(
        canvasColor: ColorApps.white,
        fontFamily: Fonts.ubuntu,
      ),
    );
  }
}
