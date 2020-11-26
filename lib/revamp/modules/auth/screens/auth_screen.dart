import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info/package_info.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/auth/screens/login_screen.dart';
import 'package:soedja_freelance/revamp/modules/auth/screens/register_screen.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';
import 'package:soedja_freelance/old_ver/utils/navigation.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthScreen();
  }
}

class _AuthScreen extends State<AuthScreen> {
  PackageInfo packageInfo = new PackageInfo();

  @override
  void initState() {
    getVersionCode();
    super.initState();
  }

  void getVersionCode() async {
    packageInfo = await PackageInfo.fromPlatform();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorApps.dark,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              Images.illustrationAuthScreen,
              width: size.width,
              height: size.height * .7,
              fit: BoxFit.fitHeight,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: bottomNavigation(context, size),
          ),
        ],
      ),
    );
  }

  Widget bottomNavigation(BuildContext context, Size size) {
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(ScreenUtil().setHeight(20)))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Image.asset(
            Images.imgLogoOnly,
            width: ScreenUtil().setSp(24),
            height: ScreenUtil().setSp(24),
          ),
          SizedBox(height: ScreenUtil().setHeight(24)),
          Text(
            Texts.authTitle,
            style: TextStyle(
              color: ColorApps.black,
              fontSize: ScreenUtil().setSp(25),
              fontWeight: FontWeight.bold,
              height: 1.5,
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(24)),
          Text(
            Texts.authSubtitle,
            style: TextStyle(
              color: ColorApps.black.withOpacity(.5),
              fontSize: ScreenUtil().setSp(12),
              height: 1.5,
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(24)),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: ScreenUtil().setHeight(60),
                  child: FlatButtonText(
                    onPressed: () => Navigation().navigateScreen(
                        context,
                        LoginScreen(
                          version: packageInfo.version,
                        )),
                    color: Colors.white,
                    side: BorderSide(
                        color: Colors.black.withOpacity(.2), width: 1),
                    text: Texts.login.toUpperCase(),
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(15),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: ScreenUtil().setWidth(16)),
              Expanded(
                child: Container(
                  height: ScreenUtil().setHeight(60),
                  child: FlatButtonWidget(
                    onPressed: () => Navigation().navigateScreen(
                        context,
                        RegisterScreen(
                          version: packageInfo.version,
                        )),
                    color: ColorApps.black,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            Texts.register.toUpperCase(),
                            style: TextStyle(
                                color: ColorApps.white,
                                fontSize: ScreenUtil().setSp(15),
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: ColorApps.white,
                          size: ScreenUtil().setSp(20),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: ScreenUtil().setHeight(24)),
          Text(
            Texts.appsSoedjaVer +
                (packageInfo.version != null ? packageInfo.version : "1.0.1"),
            style: TextStyle(
                color: Colors.black, fontSize: ScreenUtil().setSp(10)),
          )
        ],
      ),
    );
  }
}
