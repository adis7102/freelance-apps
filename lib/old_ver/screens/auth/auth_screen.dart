import 'package:flutter/material.dart';
import 'package:soedja_freelance/old_ver/components/button.dart';
import 'package:soedja_freelance/old_ver/components/dialog.dart';
import 'package:soedja_freelance/old_ver/constants/assets.dart';
import 'package:soedja_freelance/old_ver/constants/strings.dart';
import 'package:soedja_freelance/old_ver/screens/login/login_screen.dart';
import 'package:soedja_freelance/old_ver/screens/register/register_screen.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';
import 'package:soedja_freelance/old_ver/utils/navigation.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AuthScreen();
  }
}

class _AuthScreen extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: <Color>[AppColors.pink, AppColors.peach],
                begin: Alignment.topCenter,
                stops: [.5, 1.0],
                end: Alignment.bottomCenter)),
        child: Column(
          children: <Widget>[
            contentSection(context: context, size: size),
            buttonSection(context),
          ],
        ),
      ),
    );
  }
}

Widget contentSection({BuildContext context, Size size}) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.only(left: 24.0, top: 32.0, bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(bottom: 8.0),
                child: Image.asset(
                  Assets.imgAuthFlag,
                  width: size.width / 1.5,
                  alignment: Alignment.centerRight,
                  fit: BoxFit.fitHeight,
                )),
          ),
          Row(
            children: <Widget>[
              Image.asset(
                Assets.imgLogoOnly,
                width: 22.0,
                height: 22.0,
              ),
              SizedBox(width: 8.0),
              Text(
                Strings.forFreelancer,
                style: TextStyle(
                    color: AppColors.white,
                    fontSize: 12.0),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: 24.0, top: 16.0),
            child: Text(
              Strings.authTitle,
              style: TextStyle(
                  color: AppColors.white,
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                  height: 1.3),
            ),
          ),
          SizedBox(height: 24.0),
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Text(
              Strings.authSubtitle,
              style: TextStyle(
                  color: AppColors.white,
                  fontSize: 15.0,
                  height: 1.5),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buttonSection(BuildContext context) {
  return Container(
    margin: EdgeInsets.all(24.0),
    child: Row(
      children: <Widget>[
        Expanded(
          child: ButtonPrimary(
              context: context,
              buttonColor: AppColors.white,
              height: 60.0,
              child: Text(
                Strings.login.toUpperCase(),
                style: TextStyle(
                    color: AppColors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () => Navigation().navigateScreen(context, LoginScreen())),
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: ButtonPrimary(
              context: context,
              onTap: () =>
                  Navigation().navigateScreen(context, RegisterScreen()),
              buttonColor: AppColors.dark,
              height: 60.0,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      Strings.register.toUpperCase(),
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: AppColors.white,
                    size: 20.0,
                  )
                ],
              )),
        ),
      ],
    ),
  );
}
