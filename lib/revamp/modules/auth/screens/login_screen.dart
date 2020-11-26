import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/keyboard_helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_state.dart';
import 'package:soedja_freelance/revamp/modules/auth/screens/input_pin_screen.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

class LoginScreen extends StatefulWidget {
  final String version;

  const LoginScreen({Key key, this.version}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  TextEditingController emailController = new TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                height: sizeWithoutAppbar * 2 / 3,
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: ScreenUtil().setSp(20)),
                    Text(
                      Texts.loginTitle,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(25),
                          fontWeight: FontWeight.bold,
                          height: 1.5),
                    ),
                    SizedBox(height: ScreenUtil().setSp(24)),
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
                          Navigation().navigateScreen(
                              context,
                              InputPinScreen(
                                email: emailController.text,
                                version: widget.version,
                              ));
                        }
                      },
//                      onEditingComplete: () {
//
//                      },
                    ),
                  ],
                ),
              ),
              Container(
                height: sizeWithoutAppbar * 1 / 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: size.width,
                      height: ScreenUtil().setHeight(56),
                      margin: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20)),
                      child: RaisedButtonText(
                        text: Texts.login.toUpperCase(),
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
                            Navigation().navigateScreen(
                                context,
                                InputPinScreen(
                                  email: emailController.text,
                                  version: widget.version,
                                ));
                          }
                        },
                      ),
                    ),
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
    if (validateEmail(emailController.text) != null) {
      showDialogMessage(context, "Format Email Belum Benar",
          "Pastikan Email kamu benar untuk verifikasi diri.");
    }
  }
}
