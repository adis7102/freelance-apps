import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:soedja_freelance/revamp/assets/fonts.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/lists.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_state.dart';
import 'package:soedja_freelance/revamp/modules/auth/screens/confirm_otp_screen.dart';
import 'package:soedja_freelance/revamp/modules/auth/screens/create_pin_screen.dart';
import 'package:soedja_freelance/revamp/modules/dashboard/screens/dashboard_screen.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

class InputPinScreen extends StatefulWidget {
  final String email;
  final String version;

  const InputPinScreen({Key key, this.email, this.version}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _InputPinScreen();
  }
}

class _InputPinScreen extends State<InputPinScreen> {
  String pin = '';

  AuthBloc authBloc = new AuthBloc();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorApps.dark,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(Images.imgLogoOnly,
                height: ScreenUtil().setHeight(51), fit: BoxFit.fitHeight),
            SizedBox(height: ScreenUtil().setHeight(36)),
            StreamBuilder<GetProfileState>(
                stream: authBloc.getProfile,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.isLoading) {
                      return SmallLayoutLoading(context, Colors.white);
                    } else if (snapshot.data.hasError) {
                      if (snapshot.data.message
                          .contains('silahkan melakukan aktifasi account')) {
                        if (snapshot.data.standby) {
                          authBloc.requestResend(
                              context, widget.email, 'activate');
                          authBloc.unStandBy();
                        }
                      } else if (snapshot.data.message ==
                          'PIN anda belum diaktifkan') {
                        if (snapshot.data.standby) {
                          authBloc.requestResend(
                              context, widget.email, 'reset');
                          authBloc.unStandBy();
                        }
                      } else if (snapshot.data.message.contains("Email")) {
                        if (snapshot.data.standby) {
                          onWidgetDidBuild(() {
                            showDialogMessage(
                                context,
                                "Email / PIN Yang Kamu Masukan Salah!",
                                "Coba lagi untuk masukan kode PIN rahasia yang benar.");
                            authBloc.unStandBy();
                          });
                        }
                      } else {
                        if (snapshot.data.standby) {
                          onWidgetDidBuild(() {
                            showDialogMessage(
                                context,
                                "Terjadi Kesalahan Saat Login",
                                "Silahkan coba beberapa saat lagi.");
                            authBloc.unStandBy();
                          });
                        }

                      }
                    } else if (snapshot.data.isSuccess) {
                      onWidgetDidBuild(() {
                        if (snapshot.data.standby) {
                          Navigation().navigateReplacement(
                              context,
                              DashboardScreen(
                                before: "input_pin",
                              ));
                        }
                      });
                    }
                  }
                  return Column(
                    children: <Widget>[
                      DotsPin(
                        total: 6,
                        index: pin.length,
                        size: 14.0,
                        color: ColorApps.white,
                      ),
                    ],
                  );
                }),
            SizedBox(height: ScreenUtil().setHeight(52)),
            StreamBuilder<ResendOtpState>(
                stream: authBloc.getResendOtpStatus,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.isLoading) {
                      return SmallLayoutLoading(context, Colors.white);
                    } else if (snapshot.data.hasError) {
                      onWidgetDidBuild(() {
                        if (snapshot.data.standby) {
                          showDialogMessage(context, snapshot.data.message,
                              "Terjadi Kesalahan, silahkan coba lagi");
                          authBloc.unStandBy();
                        }
                      });
                    } else if (snapshot.data.isSuccess) {
                      onWidgetDidBuild(() {
                        if (snapshot.data.standby) {
                          Navigation().navigateScreen(
                              context,
                              ConfirmOTPScreen(
                                email: widget.email,
                                version: widget.version,
                              ));
                          authBloc.unStandBy();
                        }
                      });
                    }
                  }
                  return GestureDetector(
                    onTap: () =>
                        authBloc.requestResend(context, widget.email, 'forget'),
                    child: RichText(
                      text: TextSpan(
                        text: Texts.forgotPin.toUpperCase() + "  ",
                        style: TextStyle(
                          fontSize: 10.0,
                          color: ColorApps.white,
                          fontFamily: Fonts.ubuntu,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: Texts.reset.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10.5,
                              color: ColorApps.red,
                              fontFamily: Fonts.ubuntu,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
            SizedBox(height: ScreenUtil().setHeight(40)),
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(70)),
              child: Wrap(
                spacing: ScreenUtil().setSp(40),
                runSpacing: ScreenUtil().setSp(20),
                children: List.generate(listPhonebutton.length, (index) {
                  if (index != 11) {
                    return ClipRRect(
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setSp(72)),
                      child: Material(
                        color: index != 9 && pin.length != 6
                            ? Colors.black
                            : Colors.transparent,
                        child: Container(
                          width:
                              (size.width - ScreenUtil().setWidth(220)) * 1 / 3,
                          child: AspectRatio(
                            aspectRatio: 1 / 1,
                            child: InkWell(
                              onTap: index == 9 || pin.length == 6
                                  ? null
                                  : () {
                                      if (pin.length != 6) {
                                        setState(() {
                                          pin = pin +
                                              listPhonebutton[index]['value'];
                                        });
                                        print(pin);
                                        if (pin.length == 6) {
                                          authBloc.requestLogin(
                                              context, widget.email, pin);
                                        }
                                      }
                                    },
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  listPhonebutton[index]['text'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenUtil().setSp(34)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (index == 11) {
                    return ClipRRect(
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setSp(72)),
                      child: Material(
                        color: index != 9 && pin.length != 6
                            ? Colors.black
                            : Colors.transparent,
                        child: Container(
                          width:
                              (size.width - ScreenUtil().setWidth(220)) * 1 / 3,
                          child: AspectRatio(
                            aspectRatio: 1 / 1,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  if (pin.length > 0) {
                                    pin = pin.substring(0, pin.length - 1);
                                  }
                                });
                              },
                              child: Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(ScreenUtil().setSp(72)),
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        height: ScreenUtil().setHeight(72),
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(55)),
            Text(
              Texts.freelanceAppVersion + (widget.version ?? "1.0.1"),
              style: TextStyle(
                color: ColorApps.white.withOpacity(.6),
                fontSize: ScreenUtil().setSp(10),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
