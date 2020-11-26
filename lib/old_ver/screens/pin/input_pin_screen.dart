import 'dart:io';
import 'dart:math';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soedja_freelance/old_ver/components/dialog.dart';
import 'package:soedja_freelance/old_ver/components/dots.dart';
import 'package:soedja_freelance/old_ver/components/pin.dart';
import 'package:soedja_freelance/old_ver/constants/assets.dart';
import 'package:soedja_freelance/old_ver/constants/local_storage.dart';
import 'package:soedja_freelance/old_ver/constants/strings.dart';
import 'package:soedja_freelance/old_ver/models/login.dart';
import 'package:soedja_freelance/old_ver/models/otp.dart';
import 'package:soedja_freelance/old_ver/screens/dashboard/dashboard.dart';
import 'package:soedja_freelance/old_ver/screens/otp/confirm_screen.dart';
import 'package:soedja_freelance/old_ver/services/user.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';
import 'package:soedja_freelance/old_ver/utils/local_storage.dart';
import 'package:soedja_freelance/old_ver/utils/navigation.dart';

class InputPinScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _InputPinScreen();
  }
}

class _InputPinScreen extends State<InputPinScreen> {
  String pin = '';
  String email;

  int keyPad = 12;

  bool isLoading = false;
  bool isWrongPIN = false;


  void fetchEmail() async {
    await LocalStorage.get(LocalStorageKey.Email).then((value) {
      setState(() {
        email = value;
      });
    });
  }

  void onChangePIN(int key) {
    setState(() {
      pin = pin + key.toString();
    });

    if (pin.length == 6) onCheckPIN();
  }

  void onDeletePIN(String val) {
    setState(() {
      pin = val;
      isWrongPIN = false;
    });
  }

  void onCheckPIN() {
    LoginPayload login = new LoginPayload();
    setState(() {
      isLoading = true;
      login = new LoginPayload(email: email, pin: pin);
    });

    onLoginRequest(context: context, payload: login);
  }

  void onLoginRequest({BuildContext context, LoginPayload payload}) {
    showLoading(context);

    UserService().login(payload).then((response) async {
      dismissDialog(context);
      if (response.message == 'success' && response.jwt != null) {
        await LocalStorage.set(LocalStorageKey.AuthToken, response.jwt)
            .then((value) {
          Navigation().navigateReplacement(context, DashboardScreen());
        });
      } else if (response.message == 'wrong_pin') {
        setState(() {
          isWrongPIN = true;
        });
      } else if (response.message == 'deactive_pin') {
        Navigation().navigateReplacement(
            context,
            ConfirmOtpScreen(
              before: 'input',
              email: email,
            ));
      } else if (response.message == 'deactive_account') {
        Navigation().navigateReplacement(
            context,
            ConfirmOtpScreen(
              before: 'register',
              email: email,
            ));
      }
    });
  }

  void onHandleReset(BuildContext context) {
    showLoading(context);
    resetValue();

    OtpPayload payload = new OtpPayload(
      email: email,
    );

    UserService().postOtp(payload, 'reset').then((response) {
      dismissDialog(context);
      if (response) {
        Navigation().navigateScreen(
            context,
            ConfirmOtpScreen(
              before: Strings.inputKey,
              email: email,
            ));
      }
    });
  }

  void resetValue() {
    setState(() {
      pin = '';
      isLoading = false;
      isWrongPIN = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchEmail();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.dark,
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 56.0),
            Image.asset(Assets.imgLogoOnly,
                width: 53.0, height: 51.0, fit: BoxFit.fitWidth),
            SizedBox(height: 24.0),
            DotsPin(
              total: 6,
              index: pin.length,
              size: 14.0,
              color: isWrongPIN ? AppColors.primary : null,
            ),
            SizedBox(height: 12.0),
            Text(
              isWrongPIN ? Strings.wrongPIN : '',
              style: TextStyle(color: AppColors.white, fontSize: 12.0),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () => onHandleReset(context),
              child: RichText(
                text: TextSpan(
                  text: Strings.forgotPin.toUpperCase() + "  ",
                  style: TextStyle(
                    fontSize: 10.0,
                    color: AppColors.white,
                    fontFamily: Fonts.ubuntu,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: Strings.reset.toUpperCase(),
                      style: TextStyle(
                        fontSize: 11.0,
                        color: AppColors.red,
                        fontFamily: Fonts.ubuntu,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.0),
            Center(
              child: KeyPadPIN(
                pinController: pin,
                width: size.width / 1.5,
                color: Colors.transparent,
                colorKey: AppColors.black,
                crossAxisSpacing: 32.0,
                mainAxisSpacing: 16.0,
                onKeyPressed: (int key) {
                  onChangePIN(key);
                },
                onDelete: (String pin) {
                  onDeletePIN(pin);
                },
                textStyle: TextStyle(
                    color: AppColors.white,
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 24.0),
            Text(
              Strings.appVersion,
              style: TextStyle(
                  color: AppColors.white.withOpacity(.6),
                  fontSize: 10.0,),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }
}
