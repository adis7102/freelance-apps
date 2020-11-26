import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:soedja_freelance/old_ver/components/button.dart';
import 'package:soedja_freelance/old_ver/components/dialog.dart';
import 'package:soedja_freelance/old_ver/constants/strings.dart';
import 'package:soedja_freelance/old_ver/models/pin.dart';
import 'package:soedja_freelance/old_ver/services/user.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';
import 'package:soedja_freelance/old_ver/utils/keyboard.dart';
import 'package:soedja_freelance/old_ver/utils/navigation.dart';

import 'input_pin_screen.dart';

class GeneratePinScreen extends StatefulWidget {
  final String before;
  final String email;
  final String pinToken;

  GeneratePinScreen({
    @required this.before,
    this.email,
    this.pinToken,
  });

  @override
  State<StatefulWidget> createState() {
    return _GeneratePinScreen();
  }
}

class _GeneratePinScreen extends State<GeneratePinScreen> {
  TextEditingController controller = TextEditingController();
  TextEditingController controllerRetype = TextEditingController();
  bool hasError = false;

  bool isLoading = false;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;

    // TODO: implement build
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
          onTap: () => Keyboard().checkKeyboard(context),
          child: Form(
            key: formKey,
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
                    SizedBox(height: 24.0),
                    Text(
                      widget.before == Strings.inputKey
                          ? Strings.resetPINHeading
                          : Strings.generatePINHeading,
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 24.0),
                    Text(
                      Strings.generatePINDesc,
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 15.0,
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
                      maskCharacter: "●",
                      onDone: (text) {
                        onHandleCheck();
                      },
                      pinTextStyle: TextStyle(
                          color: AppColors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                      pinTextAnimatedSwitcherTransition:
                          ProvidedPinBoxTextAnimation.scalingTransition,
                      pinBoxRadius: 10.0,
                      pinTextAnimatedSwitcherDuration:
                          Duration(milliseconds: 100),
                      highlightAnimationBeginColor: Colors.black,
                      highlightAnimationEndColor: Colors.white12,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 32.0),
                    Row(
                      children: <Widget>[
                        Text(
                          Strings.generateConfirm,
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          Strings.generateConfirm,
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32.0),
                    PinCodeTextField(
                      controller: controllerRetype,
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
                      onDone: (text) {
                        onHandleConfirm(context);
                      },
                      pinTextStyle: hasError
                          ? TextStyle(
                              color: AppColors.primary,
                              fontSize: 15.0,)
                          : TextStyle(
                              color: AppColors.black,
                              fontSize: 15.0,),
                      pinTextAnimatedSwitcherTransition:
                          ProvidedPinBoxTextAnimation.scalingTransition,
                      pinBoxRadius: 10.0,
                      pinTextAnimatedSwitcherDuration:
                          Duration(milliseconds: 100),
                      highlightAnimationBeginColor: Colors.black,
                      highlightAnimationEndColor: Colors.white12,
                      keyboardType: TextInputType.number,
                    ),
                    hasError
                        ? Text(
                            Strings.wrongCreatePIN,
                            style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 15.0,),
                          )
                        : Container(),
                    SizedBox(height: 16.0),
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
                        widget.before == Strings.registerKey ? Strings.createPin.toUpperCase() : Strings.resetPin.toUpperCase(),
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                      onTap: controller.text.length != 6 ||
                              controllerRetype.text.length != 6
                          ? () => onHandleConfirm
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onHandleCheck() {
    if (controller.text.length == 6 && controllerRetype.text.length == 6) {
      if (controller.text == controllerRetype.text) {
        setState(() {
          hasError = false;
        });
      } else {
        setState(() {
          hasError = true;
        });
      }
    }
  }

  void onHandleConfirm(BuildContext context) {
    onHandleCheck();

    if (!hasError) {
      Keyboard().checkKeyboard(context);
      onHandleCreateRequest(context);
    }
  }

  void onHandleCreateRequest(BuildContext context) async {
    showLoading(context);

    PinCreatePayload payload = new PinCreatePayload(
      email: widget.email,
      pin: controllerRetype.text,
    );
    UserService().postResetPin(payload).then((response) {
      dismissDialog(context);
      if (response) {
        Navigation().navigateReplacement(context, InputPinScreen());
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
