import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info/package_info.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/sharedpref_keys.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/helpers/sharedpref_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_state.dart';
import 'package:soedja_freelance/revamp/modules/auth/screens/auth_screen.dart';
import 'package:soedja_freelance/revamp/modules/auth/screens/input_pin_screen.dart';
import 'package:soedja_freelance/revamp/modules/dashboard/screens/dashboard_screen.dart';
import 'package:soedja_freelance/revamp/modules/onboard/screens/onboard_screen.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> {
  AuthBloc authBloc = new AuthBloc();
  PackageInfo packageInfo = new PackageInfo();

  @override
  void initState() {
    getVersionCode();
    super.initState();
  }

  void getVersionCode() async {
    packageInfo = await PackageInfo.fromPlatform();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;

    authBloc.requestGetProfile(context);

    return Scaffold(
      body: StreamBuilder<GetProfileState>(
          stream: authBloc.getProfile,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isLoading) {
                return splashScreen(context, size);
              } else if (snapshot.data.hasError) {
                onWidgetDidBuild(() {
                  SharedPreference.get(SharedPrefKey.FirstTime).then((value) {
                    if (value == null) {
                      Navigation()
                          .navigateReplacement(context, OnBoardScreen());
                      authBloc.unStandBy();
                    } else {
                      if (snapshot.data.standby) {
                        SharedPreference.set(SharedPrefKey.AuthToken, null);
                        Navigation().navigateReplacement(context, AuthScreen());
                        authBloc.unStandBy();
                      }
                    }
                  });
                });
              } else if (snapshot.data.isSuccess) {
                onWidgetDidBuild(() {
                  if (snapshot.data.standby) {
                    Navigation().navigateReplacement(
                        context,
                        InputPinScreen(
                          version: packageInfo.version,
                          email: snapshot.data.data.payload.email,
                        ));
                  }
                });
              }
            }
            return splashScreen(context, size);
          }),
    );
  }

  Widget splashScreen(BuildContext context, Size size) {
    return Container(
      color: ColorApps.dark,
      alignment: Alignment.center,
      child: Image.asset(
        Images.imgLogoOnly,
        height: ScreenUtil().setHeight(100.0),
        width: ScreenUtil().setWidth(100.0),
      ),
    );
  }
}
