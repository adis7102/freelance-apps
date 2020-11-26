import 'package:flutter/material.dart';

class Keyboard {
  void closeKeyboard(BuildContext context){
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  void checkKeyboard(BuildContext context){
    if(MediaQuery.of(context).viewInsets.bottom != 0)
      return closeKeyboard(context);
    return ;
  }

  bool isKeyboardOpen(BuildContext context){
    if(MediaQuery.of(context).viewInsets.bottom != 0)
      return true;
    return false;
  }
}