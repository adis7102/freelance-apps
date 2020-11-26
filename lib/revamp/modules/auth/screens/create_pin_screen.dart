import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:soedja_freelance/revamp/assets/fonts.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/keyboard_helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_state.dart';
import 'package:soedja_freelance/revamp/modules/dashboard/screens/dashboard_screen.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

class CreatePinScreen extends StatefulWidget {
  final String email;
  final String token;
  final String version;
  final bool showMessage;

  const CreatePinScreen({Key key, this.email, this.version, this.showMessage, this.token})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CreatePinScreen();
  }
}

class _CreatePinScreen extends State<CreatePinScreen> {
  TextEditingController pinController = new TextEditingController();
  TextEditingController retypePinController = new TextEditingController();

  FocusNode pinFocus = new FocusNode();
  FocusNode retypePinFocus = new FocusNode();

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
          () => showDialogMessage(context, "Verifikasi Kode OTP Benar!",
              "Akun kamu berhasil terverifikasi."));
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
                    Texts.generatePINTitle,
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(25),
                        fontWeight: FontWeight.bold,
                        height: 1.5),
                  ),
                  SizedBox(height: ScreenUtil().setSp(24)),
                  Text(
                    Texts.generatePINDesc,
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(15),
                        fontWeight: FontWeight.normal,
                        height: 1.5),
                  ),
                  SizedBox(height: ScreenUtil().setSp(24)),
                  PinCodeTextField(
                    controller: pinController,
                    focusNode: pinFocus,
                    hideCharacter: true,
                    highlight: true,
                    pinBoxBorderWidth: .5,
                    pinBoxWidth: size.width / 6 - ScreenUtil().setWidth(20),
                    pinBoxHeight: size.width / 6 - ScreenUtil().setWidth(20),
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
                    onDone: (text) =>
                        onFieldSubmitted(context, pinFocus, retypePinFocus),
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
                  ),
                  SizedBox(height: ScreenUtil().setSp(24)),
                  Row(
                    children: <Widget>[
                      Text(
                        Texts.generateConfirm,
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(15),
                            fontWeight: FontWeight.bold,
                            height: 1.5),
                      ),
                      SizedBox(width: ScreenUtil().setWidth(10)),
                      Text(
                        Texts.retype,
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(12),
                            fontWeight: FontWeight.normal,
                            height: 1.5),
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenUtil().setSp(24)),
                  PinCodeTextField(
                    controller: retypePinController,
                    focusNode: retypePinFocus,
                    hideCharacter: true,
                    highlight: true,
                    pinBoxBorderWidth: .5,
                    pinBoxWidth: size.width / 6 - ScreenUtil().setWidth(20),
                    pinBoxHeight: size.width / 6 - ScreenUtil().setWidth(20),
                    pinBoxOuterPadding: EdgeInsets.all(4.0),
                    highlightColor: ColorApps.black,
                    defaultBorderColor: Colors.black.withOpacity(.5),
                    hasTextBorderColor: Colors.black.withOpacity(.1),
                    maxLength: 6,
                    hasError: false,
                    maskCharacter: "●",
                    onTextChanged: (text) {
                      setState(() {
                        if (text.length < 6) {
                          hasError = false;
                        }
                      });
                    },
//                    onDone: (text) => authBloc.requestValidate(
//                        context, otpController.text, widget.email),
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
                  ),
                  SizedBox(height: ScreenUtil().setSp(10)),
                  Visibility(
                    visible: hasError,
                    child: Text(
                      Texts.wrongCreatePIN,
                      style: TextStyle(
                          color: ColorApps.primary,
                          fontSize: ScreenUtil().setSp(12),
                          fontWeight: FontWeight.bold,
                          fontFamily: Fonts.ubuntu,
                    )
                  ),),
                ],
              ),
            ),
            Container(
              height: sizeWithoutAppbar * 1 / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  StreamBuilder<ResetPinState>(
                      stream: authBloc.getResetPinStatus,
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
                                    "Buat PIN keamanan gagal, silahkan coba lagi.");
                                authBloc.unStandBy();
                              }
                            });
                          } else if (snapshot.data.isSuccess) {
                            if (snapshot.data.standby) {
                              authBloc.requestLogin(context, widget.email, retypePinController.text);
                              authBloc.unStandBy();
                            }
                            return RaisedButtonLoading(
                                context, size, Colors.black, Colors.white);
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
                              if (pinController.text == retypePinController.text) {
                                Keyboard().closeKeyboard(context);
                                authBloc.requestResetPin(
                                    context, widget.email, retypePinController.text, widget.token);
                              }
                            },
                          ),
                        );
                      }),
                  StreamBuilder<GetProfileState>(
                    stream: authBloc.getProfile,
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        if(snapshot.data.isSuccess){
                          onWidgetDidBuild((){
                            if(snapshot.data.standby){
                              Navigation().navigateReplacement(
                                  context,
                                  DashboardScreen(
                                    before: "create_pin",
                                  ));
                              authBloc.unStandBy();
                            }
                          });
                      }
                      }
                      return SizedBox(height: ScreenUtil().setSp(24));
                    }
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
//
  void validateField(BuildContext context) {
    if (pinController.text.length < 6) {
      showDialogMessage(context, "Format PIN Belum Benar",
          "Kolom PIN harus diisi minimal 6 angka");
      return null;
    }
    if (retypePinController.text.length < 6) {
      showDialogMessage(context, "Format Konfirmasi PIN Belum Benar",
          "Kolom Konfirmasi PIN harus diisi minimal 6 angka");
      return null;
    }

    if(pinController.text != retypePinController.text){
      showDialogMessage(context, "Konfirmasi PIN tidak sama dengan isian PIN",
          "Silahkan cek kembali, PIN dan Konfirmasi PIN harus sama");
      return null;

    }
  }
}
