import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:soedja_freelance/revamp/assets/fonts.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/keyboard_helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_state.dart';
import 'package:soedja_freelance/revamp/modules/auth/screens/create_pin_screen.dart';
import 'package:soedja_freelance/revamp/modules/auth/screens/input_pin_screen.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

class ConfirmOTPScreen extends StatefulWidget {
  final String email;
  final String version;
  final bool showMessage;

  const ConfirmOTPScreen({Key key, this.version, this.email, this.showMessage})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ConfirmOTPScreen();
  }
}

class _ConfirmOTPScreen extends State<ConfirmOTPScreen> {
  TextEditingController otpController = new TextEditingController();
  AuthBloc authBloc = new AuthBloc();
  bool hasError = false;

  Timer _timer;
  static int countdown = 0;
  var time;

  bool isLoading = false;

  @override
  void initState() {
    startTimer();
    showSuccessRegister();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void showSuccessRegister() {
    if (widget.showMessage != null) {
      Future.delayed(
          Duration(milliseconds: 500),
          () => showDialogMessage(context, "Registrasi Akun Sukses!",
              "Pendaftaran Kamu Berhasil dilakukan."));
    }
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

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;

    double sizeWithoutAppbar =
        size.height - (MediaQuery.of(context).padding.top + kToolbarHeight);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: Container(
              margin: EdgeInsets.all(ScreenUtil().setSp(8)),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.5),
                    blurRadius: 3,
                  )
                ],
                borderRadius:
                    BorderRadius.circular(AppBar().preferredSize.height / 2),
              ),
              alignment: Alignment.center,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: ScreenUtil().setSp(24),
                ),
                onPressed: () => Navigation().navigateBack(context),
              )),
        ),
      ),
      body: GestureDetector(
        onTap: () => Keyboard().closeKeyboard(context),
        child: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            Container(
              height: sizeWithoutAppbar * 2 / 3,
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: ScreenUtil().setSp(20)),
                  Text(
                    Texts.confirmOtpTitle,
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(25),
                        fontWeight: FontWeight.bold,
                        height: 1.5),
                  ),
                  SizedBox(height: ScreenUtil().setSp(24)),
                  RichText(
                    text: TextSpan(
                      text: Texts.confirmOtpDescription + " ",
                      style: TextStyle(
                        color: ColorApps.black,
                        fontSize: ScreenUtil().setSp(15),
                        fontWeight: FontWeight.normal,
                        height: 1.5,
                        fontFamily: Fonts.ubuntu,
                      ),
                      children: [
                        TextSpan(
                          text: widget.email,
                          style: TextStyle(
                            color: ColorApps.primary,
                            fontSize: ScreenUtil().setSp(15),
                            fontWeight: FontWeight.normal,
                            fontFamily: Fonts.ubuntu,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setSp(24)),
                  StreamBuilder<ValidateOtpState>(
                      stream: authBloc.getValidateStatus,
                      builder: (context, snapshot) {
                        return PinCodeTextField(
                          controller: otpController,
                          hideCharacter: false,
                          highlight: true,
                          pinBoxBorderWidth: .5,
                          pinBoxWidth:
                              size.width / 6 - ScreenUtil().setWidth(20),
                          pinBoxHeight:
                              size.width / 6 - ScreenUtil().setWidth(20),
                          pinBoxOuterPadding: EdgeInsets.all(4.0),
                          highlightColor: ColorApps.black,
                          defaultBorderColor: Colors.black.withOpacity(.5),
                          hasTextBorderColor: Colors.black.withOpacity(.1),
                          maxLength: 6,
                          hasError: false,
                          maskCharacter: "●",
                          onTextChanged: (text) {
                            if (text.length < 6) {
                              hasError = false;
                            }
                          },
                          onDone: (text) => authBloc.requestValidate(
                              context, otpController.text, widget.email),
                          pinTextStyle: hasError
                              ? TextStyle(
                                  color: ColorApps.primary,
                                  fontSize: ScreenUtil().setSp(20),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Fonts.ubuntu,
                                )
                              : TextStyle(
                                  color: Colors.black,
                                  fontSize: ScreenUtil().setSp(20),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Fonts.ubuntu,
                                ),
                          pinTextAnimatedSwitcherTransition:
                              ProvidedPinBoxTextAnimation.scalingTransition,
                          pinBoxRadius: 10.0,
                          pinTextAnimatedSwitcherDuration:
                              Duration(milliseconds: 100),
                          highlightAnimationBeginColor: ColorApps.black,
                          highlightAnimationEndColor:
                              ColorApps.white.withOpacity(.12),
                          keyboardType: TextInputType.number,
                        );
                      }),
                  SizedBox(height: ScreenUtil().setSp(24)),
                  StreamBuilder<ResendOtpState>(
                      stream: authBloc.getResendOtpStatus,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.isLoading) {
                            return Row(
                              children: <Widget>[
                                Text(
                                  Texts.resendOtp,
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(15),
                                    fontWeight: FontWeight.normal,
                                    fontFamily: Fonts.ubuntu,
                                  ),
                                ),
                                SizedBox(width: 12.0),
                                Container(
                                  height: ScreenUtil().setHeight(20),
                                  width: ScreenUtil().setWidth(100),
                                  child: LoadingIndicator(
                                    indicatorType: Indicator.ballPulse,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            );
                          } else if (snapshot.data.hasError) {
                            onWidgetDidBuild(() {
                              if (snapshot.data.standby) {
                                showDialogMessage(
                                    context,
                                    "Gagal Mengirim Ulang Kode OTP",
                                    "Silahkan coba beberapa saat lagi");
                                authBloc.unStandBy();
                              }
                            });
                          } else if (snapshot.data.isSuccess) {
                            onWidgetDidBuild(() {
                              if (snapshot.data.standby) {
                                showDialogMessage(
                                    context,
                                    "Berhasil Mengirim Ulang Kode OTP",
                                    "Kode OTP berhasil dikirim ulang ke akun email ${widget.email}");
                                countdown = 300;
                                startTimer();
                                authBloc.unStandBy();
                              }
                            });
                          }
                        }
                        return Row(
                          children: <Widget>[
                            Text(
                              Texts.resendOtp,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(15),
                                fontWeight: FontWeight.normal,
                                fontFamily: Fonts.ubuntu,
                              ),
                            ),
                            SizedBox(width: 12.0),
                            countdown == 0
                                ? GestureDetector(
                                    onTap: () => authBloc.requestResend(
                                        context, widget.email,'activate'),
                                    child: Text(
                                      Texts.resendOtpNow,
                                      style: TextStyle(
                                        fontSize: ScreenUtil().setSp(15),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: Fonts.ubuntu,
                                      ),
                                    ),
                                  )
                                : Text(
                                    time.toString().substring(14, 19),
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(15),
                                      fontWeight: FontWeight.normal,
                                      fontFamily: Fonts.ubuntu,
                                    ),
                                  ),
                          ],
                        );
                      }),
                ],
              ),
            ),
            Container(
              height: sizeWithoutAppbar * 1 / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  StreamBuilder<ValidateOtpState>(
                      stream: authBloc.getValidateStatus,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.isLoading) {
                            return RaisedButtonLoading(
                                context, size, Colors.black, Colors.white);
                          } else if (snapshot.data.hasError) {
                            onWidgetDidBuild(() {
                              if (snapshot.data.standby) {
                                showDialogMessage(
                                    context,
                                    snapshot.data.message,
                                    "Verifikasi akun gagal, silahkan coba lagi.");
                                authBloc.unStandBy();
                              }
                            });
                          } else if (snapshot.data.isSuccess) {
                            onWidgetDidBuild(() {
                              if (snapshot.data.standby) {
                                Navigation().navigateScreen(
                                    context,
                                    CreatePinScreen(
                                      email: widget.email,
                                      token: snapshot.data.data.payload.jwt,
                                      version: widget.version,
                                      showMessage: true,
                                    ));
                                authBloc.unStandBy();
                              }
                            });
                          }
                        }
                        return Container(
                          width: size.width,
                          height: ScreenUtil().setHeight(56),
                          margin: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(20)),
                          child: RaisedButtonText(
                            text: Texts.verificationSelf.toUpperCase(),
                            color: Colors.black,
                            padding: EdgeInsets.all(1),
                            textStyle: TextStyle(
                                color: ColorApps.white,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(14)),
                            onPressed: () {
                              validateField(context);
                              if (otpController.text.length == 6) {
                                Keyboard().closeKeyboard(context);
                                authBloc.requestValidate(
                                    context, otpController.text, widget.email);
                              }
                            },
                          ),
                        );
                      }),
                  SizedBox(height: ScreenUtil().setSp(24)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void validateField(BuildContext context) {
    if (otpController.text.length < 6) {
      showDialogMessage(context, "Format OTP Belum Benar",
          "Kolom OTP harus diisi minimal 6 angka");
    }
  }
}
