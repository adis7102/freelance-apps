import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';
import 'package:soedja_freelance/old_ver/utils/helpers.dart';

Widget ButtonPrimary({
  BuildContext context,
  Widget child,
  Function onTap,
  EdgeInsets padding,
  double height,
  double width,
  BorderRadius borderRadius,
  Color buttonColor,
  bool allowed = true,
  Color splashColor,
  List<BoxShadow> boxShadow,
  LinearGradient linearGradient,
  Border border,
}) {
  return Container(
    decoration: BoxDecoration(
      color: allowed ? buttonColor : AppColors.grey9F9F9F ?? AppColors.dark,
      gradient: linearGradient,
      borderRadius: borderRadius ?? BorderRadius.circular(4.0),
      boxShadow: boxShadow,
      border: border,
    ),
    child: ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(4.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: splashColor ?? AppColors.light,
          onTap: onTap,
          child: Container(
              height: height,
              width: width,
              padding: padding ??
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              alignment: Alignment.center,
              child: child),
        ),
      ),
    ),
  );
}
