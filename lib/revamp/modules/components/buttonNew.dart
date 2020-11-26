import 'package:flutter/material.dart';

Widget TextFlatButton({
  @required BuildContext context,
  bool isExpanded = false,
  double height,
  EdgeInsets padding,
  EdgeInsets margin,
  BorderSide border,
  BorderRadius borderRadius,
  Function onTap,
  Color color,
  Color disabledColor,
  String text = "Button Text",
  TextStyle textStyle,
}) {
  Size size = MediaQuery.of(context).size;
  return Container(
    height: height,
    width: isExpanded ? size.width : null,
    margin: margin ?? EdgeInsets.zero,
    child: FlatButton(
      onPressed: onTap,
      padding: padding,
      disabledColor: disabledColor ?? Color(0xFF979797),
      color: color ?? Color(0xFF393AF5),
      shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(5),
          side: border ?? BorderSide.none),
      child: Text(
        text,
        style: textStyle ??
            TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
      ),
    ),
  );
}


Widget WidgetFlatButton({
  @required BuildContext context,
  bool isExpanded = false,
  double height,
  EdgeInsets padding,
  EdgeInsets margin,
  BorderSide border,
  BorderRadius borderRadius,
  Function onTap,
  Color color,
  Color disabledColor,
  Widget child,
  TextStyle textStyle,
}) {
  Size size = MediaQuery.of(context).size;
  return Container(
    height: height,
    width: isExpanded ? size.width : null,
    margin: margin ?? EdgeInsets.zero,
    child: FlatButton(
      onPressed: onTap,
      padding: padding,
      disabledColor: disabledColor ?? Color(0xFF979797),
      color: color ?? Color(0xFF393AF5),
      shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(5),
          side: border ?? BorderSide.none),
      child: child ?? Container(),
    ),
  );
}
