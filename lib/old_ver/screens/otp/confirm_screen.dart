import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:soedja_freelance/old_ver/components/button.dart';
import 'package:soedja_freelance/old_ver/components/dialog.dart';
import 'package:soedja_freelance/old_ver/constants/assets.dart';
import 'package:soedja_freelance/old_ver/constants/local_storage.dart';
import 'package:soedja_freelance/old_ver/constants/strings.dart';
import 'package:soedja_freelance/old_ver/models/otp.dart';
import 'package:soedja_freelance/old_ver/screens/pin/generate_screen.dart';
import 'package:soedja_freelance/old_ver/services/user.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';
import 'package:soedja_freelance/old_ver/utils/keyboard.dart';
import 'package:soedja_freelance/old_ver/utils/local_storage.dart';
import 'package:soedja_freelance/old_ver/utils/navigation.dart';

class ConfirmOtpScreen extends StatefulWidget {
  final String before;
  final String email;

  ConfirmOtpScreen({
    @required this.before,
    this.email,
  });

  @override
  State<StatefulWidget> createState() {
    return _ConfirmOtpScreen();
  }
}

class _ConfirmOtpScreen extends State<ConfirmOtpScreen> {
  String email = '';

  TextEditingController controller = TextEditingController();
  bool hasError = false;

  Timer _timer;
  static int countdown = 0;
  var time;

  bool isLoading = false;

  @override
  void initState() {
    startTimer();
    checkEmail();
    Future.delayed(Duration(seconds: 0), () {
      showSuccessSendOtp(
        context: context,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    countdown = 300;
    const oneSec = const Duration(seconds: 1);
    time = new DateTime.fromMillisecondsSinceEpoch(countdown * 1000);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (countdown < 1) {
            timer.cancel();
          } else {
            countdown = countdown - 1;
          }
          time = new DateTime.fromMillisecondsSinceEpoch(countdown * 1000);
        },
      ),
    );
  }

  void checkEmail() async {
    if (widget.email != null) {
      email = widget.email;
    } else {
      email = await LocalStorage.get(LocalStorageKey.Email);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    return WillPopScope(
      onWillPop: () {
        return showLeave(
          context: context,
          onGhost: () {
            Navigation().navigateBack(context);
            Navigation().navigateBack(context);
          },
          onPrimary: () {
            Navigation().navigateBack(context);
          },
        );
      },
      child: Scaffold(
        body: GestureDetector(
          onTap: () => Keyboard().closeKeyboard(context),
          child: Stack(
            children: <Widget>[
              ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  SizedBox(height: 24.0),
                  Row(
                    children: <Widget>[
                      appBarSection(
                        context: context,
                        onTap: () => showLeave(
                          context: context,
                          onGhost: () {
                            Navigation().navigateBack(context);
                            Navigation().navigateBack(context);
                          },
                          onPrimary: () {
                            Navigation().navigateBack(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.0),
                  Text(
                    Strings.confirmOtpTitle,
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 24.0),
                  RichText(
                    text: TextSpan(
                      text: Strings.confirmOtpDescription + " ",
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 15.0,
                        fontFamily: Fonts.ubuntu,
                      ),
                      children: [
                        TextSpan(
                          text: widget.email,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 15.0,
                            fontFamily: Fonts.ubuntu,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // OTP Field
                  SizedBox(height: 32.0),
                  PinCodeTextField(
                    controller: controller,
                    hideCharacter: true,
                    highlight: true,
                    pinBoxWidth: width / 6 - 12.0,
                    pinBoxHeight: width / 6 - 12.0,
                    pinBoxOuterPadding: EdgeInsets.all(4.0),
                    highlightColor: AppColors.black,
                    defaultBorderColor: AppColors.grey707070,
                    hasTextBorderColor: AppColors.black,
                    maxLength: 6,
                    hasError: hasError,
                    maskCharacter: "●",
                    onTextChanged: (text) {
                      if (text.length < 6) {
                        setState(() {
                          hasError = false;
                        });
                      }
                    },
                    onDone: (text) => onHandleValidate(context),
                    pinTextStyle: hasError
                        ? TextStyle(
                            color: AppColors.primary,
                            fontSize: 15.0,
                          )
                        : TextStyle(
                            color: AppColors.black,
                            fontSize: 15.0,
                          ),
                    pinTextAnimatedSwitcherTransition:
                        ProvidedPinBoxTextAnimation.scalingTransition,
                    pinBoxRadius: 10.0,
                    pinTextAnimatedSwitcherDuration:
                        Duration(milliseconds: 100),
                    highlightAnimationBeginColor: AppColors.black,
                    highlightAnimationEndColor:
                        AppColors.white.withOpacity(.12),
                    keyboardType: TextInputType.number,
                  ),
                  hasError
                      ? Text(
                          Strings.wrongOTP,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 15.0,
                          ),
                        )
                      : Container(),
                  SizedBox(height: 16.0),
                  Row(
                    children: <Widget>[
                      Text(
                        Strings.resendOtp + time.toString().substring(14, 19),
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 15.0,
                        ),
                      ),
                      SizedBox(width: 12.0),
                      countdown == 0
                          ? GestureDetector(
                              onTap: onHandleResend,
                              child: Text(
                                Strings.resendOtpNow,
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 15.0,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ],
              ),
              Visibility(
                visible: !Keyboard().isKeyboardOpen(context),
                child: Positioned(
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                  child: ButtonPrimary(
                    height: 56.0,
                    buttonColor: AppColors.black,
                    child: Text(
                      Strings.verificationSelf.toUpperCase(),
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                    onTap: controller.text.length == 6
                        ? () => onHandleValidate(context)
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onHandleResend() {
    Keyboard().checkKeyboard(context);
    onHandleResendRequest(context);
  }

  onHandleResendRequest(BuildContext context) async {
    showLoading(context);

    OtpPayload payload = new OtpPayload(
      email: email,
    );

    UserService().postOtp(payload, widget.before).then((response) {
      dismissDialog(context);
      if (response) {
        setState(() {
          controller.clear();
        });
        startTimer();
        showSuccessResendOtp(context: context);
      }
    });
  }

  void onHandleValidate(BuildContext context) {
    Keyboard().checkKeyboard(context);
    onHandleValidateRequest(context);
  }

  void onHandleValidateRequest(BuildContext context) {
    showLoading(context);
    OtpValidatePayload payload = new OtpValidatePayload(
      email: email,
      otp: controller.text,
    );

    UserService().postValidateOtp(payload).then((response) async {
      dismissDialog(context);
      if (response.jwt != null) {
        await LocalStorage.set(LocalStorageKey.PinToken, response.jwt)
            .then((value) {
          Navigation().navigateScreen(
              context,
              GeneratePinScreen(
                before: widget.before,
                email: email,
                pinToken: response.jwt,
              ));
        });
      } else {
        setState(() {
          hasError = true;
        });
      }
    });
  }
}

Widget appBarSection({BuildContext context, Function onTap}) {
  return ButtonPrimary(
      context: context,
      buttonColor: AppColors.white,
      height: 50.0,
      width: 50.0,
      borderRadius: BorderRadius.circular(25.0),
      padding: EdgeInsets.all(0.0),
      boxShadow: [
        BoxShadow(
            color: AppColors.black.withOpacity(.2),
            blurRadius: 5,
            offset: Offset(0.0, 2.0))
      ],
      onTap: onTap,
      child: Icon(
        Icons.chevron_left,
        color: AppColors.black,
        size: 30.0,
      ));
}
