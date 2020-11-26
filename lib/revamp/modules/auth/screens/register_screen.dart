import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:soedja_freelance/revamp/assets/fonts.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/keyboard_helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_state.dart';
import 'package:soedja_freelance/revamp/modules/auth/components/register_components.dart';
import 'package:soedja_freelance/revamp/modules/auth/screens/input_pin_screen.dart';
import 'package:soedja_freelance/revamp/modules/auth/screens/confirm_otp_screen.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

class RegisterScreen extends StatefulWidget {
  final String version;

  const RegisterScreen({Key key, this.version}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RegisterScreen();
  }
}

class _RegisterScreen extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  final FocusNode nameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();

  AuthBloc authBloc = new AuthBloc();

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
        child: Form(
          key: formKey,
          child: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              Container(
                height: sizeWithoutAppbar * 2.2 / 3,
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: ScreenUtil().setSp(20)),
                    Text(
                      Texts.labelFullName.toUpperCase(),
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(10), height: 1.0),
                    ),
                    SizedBox(height: ScreenUtil().setSp(10)),
                    TextFormFieldOutline(
                      controller: nameController,
                      focusNode: nameFocus,
                      validator: (value) => validateName(value),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      hint: Texts.hintFullName,
                      onPressedSuffix: () {
                        setState(() {
                          nameController.clear();
                        });
                      },
                      onChanged: (val) => setState(() {}),
                      onFieldSubmitted: (val) {
                        onFieldSubmitted(context, nameFocus, phoneFocus);
                      },
                    ),
                    SizedBox(height: ScreenUtil().setSp(35)),
                    Text(
                      Texts.labelPhone.toUpperCase(),
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(10), height: 1.0),
                    ),
                    SizedBox(height: ScreenUtil().setSp(10)),
                    TextFormFieldPhone(
                        controller: phoneController,
                        focusNode: phoneFocus,
                        onFieldSubmitted: (val) =>
                            onFieldSubmitted(context, phoneFocus, emailFocus),
                        onChanged: (val) => setState(() {}),
                        onPressedSuffix: () => setState(() {
                              phoneController.clear();
                            })),
                    SizedBox(height: ScreenUtil().setSp(35)),
                    Text(
                      Texts.labelInputEmail.toUpperCase(),
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(10), height: 1.0),
                    ),
                    SizedBox(height: ScreenUtil().setSp(10)),
                    TextFormFieldOutline(
                      controller: emailController,
                      focusNode: emailFocus,
                      validator: (value) => validateEmail(value),
                      keyboardType: TextInputType.emailAddress,
                      hint: Texts.hintEmail,
                      onPressedSuffix: () {
                        setState(() {
                          emailController.clear();
                        });
                      },
                      onChanged: (val) => setState(() {}),
                      onFieldSubmitted: (val) {
                        validateField(context);
                        if (formKey.currentState.validate()) {
                          Keyboard().closeKeyboard(context);
                          authBloc.requestRegister(context, nameController.text,
                              phoneController.text, emailController.text);
                        }
                      },
                    ),
                  ],
                ),
              ),
              Container(
                height: sizeWithoutAppbar * 0.8 / 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20)),
                      child: RichText(
                        text: TextSpan(
                          text: Texts.registerTerm1 + " ",
                          style: TextStyle(
                              color: ColorApps.black,
                              fontSize: ScreenUtil().setSp(12.0),
                              fontWeight: FontWeight.normal,
                              height: 1.5,
                              fontFamily: Fonts.ubuntu),
                          children: <TextSpan>[
                            TextSpan(
                              text: Texts.registerTerm2 + " ",
                              style: TextStyle(
                                  color: ColorApps.primary,
                                  fontSize: ScreenUtil().setSp(12.0),
                                  fontWeight: FontWeight.normal,
                                  fontFamily: Fonts.ubuntu),
                            ),
                            TextSpan(
                              text: Texts.registerTerm3 + " ",
                              style: TextStyle(
                                  color: ColorApps.black,
                                  fontSize: ScreenUtil().setSp(12.0),
                                  fontWeight: FontWeight.normal,
                                  fontFamily: Fonts.ubuntu),
                            ),
                            TextSpan(
                              text: Texts.registerTerm4,
                              style: TextStyle(
                                  color: ColorApps.primary,
                                  fontSize: ScreenUtil().setSp(12.0),
                                  fontWeight: FontWeight.normal,
                                  fontFamily: Fonts.ubuntu),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setSp(35)),
                    StreamBuilder<RegisterStatusState>(
                        stream: authBloc.getRegisterStatus,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.isLoading) {
                              return RaisedButtonLoading(context, size, Colors.black, Colors.white);
                            } else if (snapshot.data.hasError) {
                              onWidgetDidBuild(() {
                                if (snapshot.data.standby) {
                                  showDialogMessage(
                                      context,
                                      snapshot.data.message,
                                      "Registrasi gagal, silahkan coba lagi.");
                                  authBloc.unStandBy();
                                }
                              });
                            } else if (snapshot.data.isSuccess) {
                              onWidgetDidBuild(() {
                                if (snapshot.data.standby) {
                                  Navigation().navigateScreen(
                                      context,
                                      ConfirmOTPScreen(
                                          showMessage: true,
                                          email: emailController.text,
                                          version: widget.version));
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
                              text: Texts.createAccount.toUpperCase(),
                              color: Colors.black,
                              padding: EdgeInsets.all(1),
                              textStyle: TextStyle(
                                  color: ColorApps.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: ScreenUtil().setSp(14)),
                              onPressed: () {
                                validateField(context);
                                if (formKey.currentState.validate()) {
                                  Keyboard().closeKeyboard(context);
                                  authBloc.requestRegister(
                                      context,
                                      nameController.text,
                                      phoneController.text,
                                      emailController.text);
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
      ),
    );
  }

  void validateField(BuildContext context) {
    if (validateName(nameController.text) != null) {
      showDialogMessage(context, "Format Nama Belum Benar",
          "Masukan minimum 3 nama yang valid");
      return null;
    }
    if (validatePhone(phoneController.text) != null) {
      showDialogMessage(context, "Format Nomor Handphone Belum Benar",
          "Masukan minimum 8 Nomor Handphone Kamu yang Valid.");
      return null;
    }
    if (validateEmail(emailController.text) != null) {
      showDialogMessage(context, "Format Email Belum Benar",
          "Pastikan Email kamu benar untuk verifikasi diri.");
      return null;
    }
  }
}
