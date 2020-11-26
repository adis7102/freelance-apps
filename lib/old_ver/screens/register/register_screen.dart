import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soedja_freelance/old_ver/components/button.dart';
import 'package:soedja_freelance/old_ver/components/dialog.dart';
import 'package:soedja_freelance/old_ver/components/text_input.dart';
import 'package:soedja_freelance/old_ver/constants/assets.dart';
import 'package:soedja_freelance/old_ver/constants/local_storage.dart';
import 'package:soedja_freelance/old_ver/constants/strings.dart';
import 'package:soedja_freelance/old_ver/models/register.dart';
import 'package:soedja_freelance/old_ver/screens/login/login_screen.dart';
import 'package:soedja_freelance/old_ver/screens/otp/confirm_screen.dart';
import 'package:soedja_freelance/old_ver/services/user.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';
import 'package:soedja_freelance/old_ver/utils/helpers.dart';
import 'package:soedja_freelance/old_ver/utils/keyboard.dart';
import 'package:soedja_freelance/old_ver/components/text_input.dart' as EditText;
import 'package:soedja_freelance/old_ver/components/text_input.dart';
import 'package:soedja_freelance/old_ver/utils/local_storage.dart';
import 'package:soedja_freelance/old_ver/utils/navigation.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterScreen();
  }
}

class _RegisterScreen extends State<RegisterScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String name = '';
  String phone = '';
  String email = '';

  bool isLoading = false;
  bool isEmailRegistered = false;

  // bool isPhoneRegistered = false;

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();

  final FocusNode nameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();

  final formKey = GlobalKey<FormState>();
  bool validateError = false;

  void onFieldSubmitted(
    BuildContext context,
    FocusNode currentFocus,
    FocusNode nextFocus,
  ) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: GestureDetector(
        onTap: () => Keyboard().closeKeyboard(context),
        child: Form(
          key: formKey,
          autovalidate: validateError,
          child: Stack(
            children: <Widget>[
              ListView(
                padding: EdgeInsets.all(24.0),
                physics: ClampingScrollPhysics(),
                children: <Widget>[
                  SizedBox(height: 24.0),
                  Row(
                    children: <Widget>[
                      appBarSection(context),
                    ],
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    Strings.labelFullName.toUpperCase(),
                    style: TextStyle(
                        fontSize: 10.0,
                        height: 1.0),
                  ),
                  SizedBox(height: 12.0),
                  EditText.TextInput(
                    props: new TextInputProps(
                      hintText: Strings.hintFullName,
                      keyboardType: TextInputType.text,
                      validator: validateName,
                      focusNode: nameFocus,
                      controller: nameController,
                      onFieldSubmitted: (val) =>
                          onFieldSubmitted(context, nameFocus, phoneFocus),
                    ),
                  ),

                  // Phone Number
                  SizedBox(height: 24.0),
                  Text(
                    Strings.labelPhone.toUpperCase(),
                    style: TextStyle(
                        fontSize: 10.0,
                        height: 1.0),
                  ),
                  SizedBox(height: 12.0),
                  Row(
                    children: <Widget>[
                      Container(
                        height: 48.0,
                        width: 110.0,
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            bottomLeft: Radius.circular(4.0),
                          ),
                          color: AppColors.black,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Image.asset(
                              Assets.imgFlagIdn,
                              width: 18.0,
                              fit: BoxFit.fitWidth,
                            ),
                            Text(
                              '+62',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: EditText.TextInput(
                          padding: EdgeInsets.all(16.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(5.0))),
                          props: new TextInputProps(
                            hintText: Strings.hintPhone,
                            keyboardType: TextInputType.number,
                            validator: validatePhone,
                            focusNode: phoneFocus,
                            controller: phoneController,
                            onFieldSubmitted: (val) => onFieldSubmitted(
                                context, phoneFocus, emailFocus),
                          ),
                          onChanged: (val) {
                            onChangePhone(val);
                          },
                        ),
                      ),
                    ],
                  ),

                  //Email Address
                  SizedBox(height: 24.0),
                  Text(
                    Strings.labelEmail.toUpperCase(),
                    style: TextStyle(
                        fontSize: 10.0,
                        height: 1.0),
                  ),
                  SizedBox(height: 12.0),
                  EditText.TextInput(
                    props: new TextInputProps(
                      hintText: Strings.hintEmail,
                      keyboardType: TextInputType.emailAddress,
                      validator: isEmailRegistered
                          ? validateEmailRegister
                          : validateEmail,
                      focusNode: emailFocus,
                      controller: emailController,
                      onFieldSubmitted: (val) => onHandleRegister(context),
                    ),
                    onChanged: (val) => onChangeEmail(),
                  ),
                ],
              ),
              Visibility(
                visible: !Keyboard().isKeyboardOpen(context),
                child: Positioned(
                  bottom: 24.0,
                  left: 24.0,
                  right: 24.0,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            text: Strings.registerTerm1 + " ",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 12.0,
                                fontFamily: Fonts.ubuntu),
                            children: <TextSpan>[
                              TextSpan(
                                text: Strings.registerTerm2 + " ",
                                style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 12.0,
                                    fontFamily: Fonts.ubuntu),
                              ),
                              TextSpan(
                                text: Strings.registerTerm3 + " ",
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 12.0,
                                    fontFamily: Fonts.ubuntu),
                              ),
                              TextSpan(
                                text: Strings.registerTerm4,
                                style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 12.0,
                                    fontFamily: Fonts.ubuntu),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8.0),
                        ButtonPrimary(
                          buttonColor: AppColors.black,
                          height: 56.0,
                          child: Text(
                            Strings.createAccount.toUpperCase(),
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white),
                          ),
                          onTap: () => onHandleRegister(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onChangePhone(String value) {
    String val = '';
    if (value.contains('+62')) {
      val = value.substring(3, value.length);
    } else if (value[0] == '0') {
      val = value.substring(1, value.length);
    } else {
      val = value;
    }

    setState(() {
      phone = val;
    });
  }

  void onChangeEmail() {
    if (isEmailRegistered) {
      setState(() {
        isEmailRegistered = false;
      });
      formKey.currentState.validate();
    }
  }

  void onHandleRegister(BuildContext context) {
    Keyboard().checkKeyboard(context);

    if (formKey.currentState.validate()) {
      onHandleRequest(context);
    } else {
      setState(() {
        validateError = true;
      });
    }
  }

  onHandleRequest(BuildContext context) async {
    showLoading(context);

    RegisterPayload payload = new RegisterPayload(
      name: nameController.text,
      phone: '+62$phone',
      email: emailController.text,
      type: 'freelance',
    );

    UserService().register(payload).then((response) async {
      dismissDialog(context);
      if (response == 'success') {
        await LocalStorage.set(LocalStorageKey.Email, payload.email).then((value) {
          Navigation().navigateScreen(
              context,
              ConfirmOtpScreen(
                before: Strings.registerKey,
                email: payload.email,
              ));
        });
      } else if (response == 'registered') {
        setState(() {
          isEmailRegistered = true;
        });
      }
    });
  }
}

Widget appBarSection(BuildContext context) {
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
      onTap: () => Navigation().navigateBack(context),
      child: Icon(
        Icons.chevron_left,
        color: AppColors.black,
        size: 30.0,
      ));
}
