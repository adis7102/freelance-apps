import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';

class KeyPadPIN extends StatelessWidget {
  final String pinController;
  final double width;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final EdgeInsets padding;
  final EdgeInsets paddingKey;
  final int crossAxisCount;
  final int totalKey;
  final Function(int) onKeyPressed;
  final Function onRemove;
  final Function(String) onDelete;
  final bool isDisabled;
  final bool keyDelete;
  final bool keyRemove;
  final bool isBorder;
  final Color color;
  final Color colorKey;
  final Color borderColor;
  final double borderWidth;
  final TextStyle textStyle;

  KeyPadPIN({
    Key key,
    @required this.pinController,
    @required this.width,
    this.padding,
    this.paddingKey = const EdgeInsets.all(0.0),
    this.crossAxisCount = 3,
    this.totalKey = 12,
    this.onKeyPressed,
    this.onRemove,
    this.onDelete,
    this.isDisabled,
    this.keyDelete,
    this.crossAxisSpacing = 16.0,
    this.mainAxisSpacing = 16.0,
    this.keyRemove = false,
    this.isBorder = false,
    this.color = Colors.white,
    this.borderColor = Colors.black,
    this.borderWidth = 2.0,
    this.colorKey = Colors.white,
    this.textStyle = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var heightKey = size.height;
    var widthKey = size.width;
    return Container(
      width: width,
      color: color,
      padding: padding,
      alignment: Alignment.topCenter,
      child: GridView.count(
        primary: false,
        shrinkWrap: true,
        padding: paddingKey,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisCount: crossAxisCount,
        children: List.generate(totalKey, (data) {
          return FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                widthKey / crossAxisCount / 2,
              ),
              side: isBorder
                  ? BorderSide(
                color: borderColor,
                width: borderWidth,
                style: BorderStyle.solid,
              )
                  : BorderSide.none,
            ),
            color: colorKey,
            child: Container(
              alignment: Alignment.center,
              child: keyPad(context, data),
            ),
            onPressed: data == 9
                ? keyRemove ? () => onRemove : null
                : data == 11
                ? pinController.length > 0
                ? () => onDelete(
              pinController.substring(
                  0, pinController.length - 1),
            )
                : null
                : pinController.length < 6
                ? data == 10
                ? () => onKeyPressed(0)
                : () => onKeyPressed(data + 1)
                : null,
          );
        }),
      ),
    );
  }

  Widget keyPad(BuildContext context, data) {
    if (data == 9)
      return Visibility(
        visible: keyRemove,
        child: Icon(
          Icons.delete,
        ),
      );
    else if (data == 11)
      return Icon(
        Icons.backspace,
        color: AppColors.white,
      );
    else
      return Text(
        (data == 10 ? 0 : data + 1).toString(),
        style: textStyle,
      );
  }
}

//class InputPinField extends StatelessWidget {
//
//  @override
//  Widget build(BuildContext context) {
//
//    return Row(
//      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//      children: <Widget>[
//        Container(
//          height: 50.0,
//          width: 50.0,
//          child: InputTextField(
//            textInputType: TextInputType.number,
//            textInputAction: TextInputAction.done,
//            validator: null,
//          ),
//        ),
//        Container(
//          height: size50,
//          width: size50,
//          child: InputTextField(
//            textInputType: TextInputType.number,
//            textInputAction: TextInputAction.done,
//            validator: null,
//          ),
//        ),
//        Container(
//          height: size50,
//          width: size50,
//          child: InputTextField(
//            textInputType: TextInputType.number,
//            textInputAction: TextInputAction.done,
//            validator: null,
//          ),
//        ),
//        Container(
//          height: size50,
//          width: size50,
//          child: InputTextField(
//            textInputType: TextInputType.number,
//            textInputAction: TextInputAction.done,
//            validator: null,
//          ),
//        ),
//        Container(
//          height: size50,
//          width: size50,
//          child: InputTextField(
//            textInputType: TextInputType.number,
//            textInputAction: TextInputAction.done,
//            validator: null,
//          ),
//        ),
//        Container(
//          height: size50,
//          width: size50,
//          child: InputTextField(
//            textInputType: TextInputType.number,
//            textInputAction: TextInputAction.done,
//            validator: null,
//          ),
//        ),
//      ],
//    );
//  }
//
//}
