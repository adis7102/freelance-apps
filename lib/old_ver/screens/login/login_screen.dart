import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soedja_freelance/old_ver/components/button.dart';
import 'package:soedja_freelance/old_ver/components/text_input.dart' as EditText;
import 'package:soedja_freelance/old_ver/components/text_input.dart';
import 'package:soedja_freelance/old_ver/constants/local_storage.dart';
import 'package:soedja_freelance/old_ver/constants/strings.dart';
import 'package:soedja_freelance/old_ver/screens/pin/input_pin_screen.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';
import 'package:soedja_freelance/old_ver/utils/helpers.dart';
import 'package:soedja_freelance/old_ver/utils/keyboard.dart';
import 'package:soedja_freelance/old_ver/utils/local_storage.dart';
import 'package:soedja_freelance/old_ver/utils/navigation.dart';

class LoginScreen extends StatefulWidget {
  final String before;

  LoginScreen({
    this.before,
  });

  @override
  State<StatefulWidget> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  TextEditingController emailController = new TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validateError = false;

  void onChangeValue() {
    formKey.currentState.validate();
  }

  void onHandleLogin() async {
    if (formKey.currentState.validate()) {
      await LocalStorage.set(LocalStorageKey.Email, emailController.text).then((value){
        Navigation()
            .navigateScreen(context, InputPinScreen());
      });

    } else {
      setState(() {
        validateError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Keyboard().closeKeyboard(context),
        child: Container(
          color: AppColors.white,
          padding: !Keyboard().isKeyboardOpen(context) ? EdgeInsets.all(24.0) : EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              appBarSection(context),
              contentSection(
                context: context,
                formKey: formKey,
                focusNode: emailFocus,
                onFieldSubmitted: onHandleLogin,
                onHandleLogin: onHandleLogin,
                onChanged: ()=> onChangeValue(),
                controller: emailController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget appBarSection(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(top: 24.0),
    child: ButtonPrimary(
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
        onTap: ()=> Navigation().navigateBack(context),
        child: Icon(
          Icons.chevron_left,
          color: AppColors.black,
          size: 30.0,
        )),
  );
}

Widget contentSection({
  BuildContext context,
  GlobalKey<FormState> formKey,
  FocusNode focusNode,
  Function onFieldSubmitted,
  Function onChanged,
  Function onHandleLogin,
  TextEditingController controller,
}) {
  return Form(
    key: formKey,
    child: Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 24.0),
          Text(
            Strings.loginTitle,
            style: TextStyle(
                fontSize: 25.0, fontWeight: FontWeight.bold, height: 1.5),
          ),
          SizedBox(height: 24.0),
          Text(
            Strings.labelInputEmail.toUpperCase(),
            style: TextStyle(
                fontSize: 10.0, height: 1.0),
          ),
          SizedBox(height: 12.0),
          EditText.TextInput(
            props: new TextInputProps(
              hintText: Strings.hintEmail,
              keyboardType: TextInputType.text,
              validator: validateLogin,
              focusNode: focusNode,
              controller: controller,
              onFieldSubmitted: (val) {
                onFieldSubmitted();
              },
            ),
            onChanged:(val) {
              onChanged();
            },
          ),
          Expanded(
            child: SizedBox(
              height: 24.0,
            ),
          ),
          Visibility(
            visible: !Keyboard().isKeyboardOpen(context),
            child: ButtonPrimary(
              height: 56.0,
              child: Text(
                Strings.login.toUpperCase(),
                style: TextStyle(
                    color: AppColors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () => onHandleLogin(),
            ),
          ),
        ],
      ),
    ),
  );
}
