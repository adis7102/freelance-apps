import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/lists.dart';
import 'package:soedja_freelance/revamp/assets/sharedpref_keys.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/assets/urls.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/helpers/sharedpref_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/models/auth_models.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/screens/detail_portfolio_screen.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

final formatCurrency =
    NumberFormat.currency(locale: "id_ID", symbol: "", decimalDigits: 0);

void onWidgetDidBuild(Function callback) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    callback();
  });
}

Widget FlatButtonText({
  BuildContext context,
  String text,
  TextStyle textStyle,
  Color color,
  Color disabledColor,
  Color splashColor,
  Color hoverColor,
  Color highlightColor,
  Color focusColor,
  Function onPressed,
  BorderRadius borderRadius,
  EdgeInsets padding,
  BorderSide side,
}) {
  return FlatButton(
    shape: RoundedRectangleBorder(
        side: side ?? BorderSide.none,
        borderRadius:
            borderRadius ?? BorderRadius.circular(ScreenUtil().setSp(5))),
    color: color ?? Colors.black,
    disabledColor: disabledColor ?? ColorApps.grey9F9F9F,
    splashColor: splashColor ?? Colors.black26,
    focusColor: focusColor ?? Colors.black26,
    hoverColor: hoverColor ?? Colors.black26,
    highlightColor: highlightColor ?? Colors.black26,
    onPressed: onPressed ?? null,
    child: Text(
      text ?? "Button Text",
      style: textStyle ??
          TextStyle(
            fontSize: ScreenUtil().setSp(15),
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
    ),
  );
}

Widget FlatButtonCircleWidget({
  BuildContext context,
  Widget child,
  TextStyle textStyle,
  Color color,
  Color disabledColor,
  Color splashColor,
  Color hoverColor,
  Color highlightColor,
  Color focusColor,
  Function onPressed,
  BorderRadius borderRadius,
  EdgeInsets padding,
  BorderSide side,
}) {
  return FlatButton(
    shape: CircleBorder(),
    color: color ?? ColorApps.primary,
    padding: padding ?? null,
    disabledColor: disabledColor ?? ColorApps.grey9F9F9F,
    splashColor: splashColor ?? Colors.black26,
    focusColor: focusColor ?? Colors.black26,
    hoverColor: hoverColor ?? Colors.black26,
    highlightColor: highlightColor ?? Colors.black26,
    onPressed: onPressed ?? null,
    child: child ??
        Text(
          "Button Text",
          style: TextStyle(
            fontSize: ScreenUtil().setSp(15),
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
  );
}

Widget FlatButtonWidget({
  BuildContext context,
  Widget child,
  TextStyle textStyle,
  Color color,
  Color disabledColor,
  Color splashColor,
  Color hoverColor,
  Color highlightColor,
  Color focusColor,
  Function onPressed,
  BorderRadius borderRadius,
  EdgeInsets padding,
  BorderSide side,
}) {
  return FlatButton(
    shape: RoundedRectangleBorder(
        side: side ?? BorderSide.none,
        borderRadius:
            borderRadius ?? BorderRadius.circular(ScreenUtil().setSp(5))),
    color: color ?? ColorApps.primary,
    padding: padding ?? null,
    disabledColor: disabledColor ?? ColorApps.grey9F9F9F,
    splashColor: splashColor ?? Colors.black26,
    focusColor: focusColor ?? Colors.black26,
    hoverColor: hoverColor ?? Colors.black26,
    highlightColor: highlightColor ?? Colors.black26,
    onPressed: onPressed ?? null,
    child: child ??
        Text(
          "Button Text",
          style: TextStyle(
            fontSize: ScreenUtil().setSp(15),
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
  );
}

Widget FlatButtonLoading({
  BuildContext context,
  Size size,
  Color color,
  Color indicatorColor,
  EdgeInsets margin,
  BorderSide side,
}) {
  return Container(
    width: size.width,
    height: ScreenUtil().setHeight(56),
    margin:
        margin ?? EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
    child: FlatButtonWidget(
      side: side ?? BorderSide.none,
      child: LoadingIndicator(
        indicatorType: Indicator.ballPulse,
        color: indicatorColor ?? Colors.white,
      ),
      color: color ?? Colors.black,
      padding: EdgeInsets.all(1),
      onPressed: () {},
    ),
  );
}


Widget RaisedButtonText({
  BuildContext context,
  String text,
  TextStyle textStyle,
  Color color,
  Color disabledColor,
  Color splashColor,
  Color hoverColor,
  Color highlightColor,
  Color focusColor,
  Function onPressed,
  BorderRadius borderRadius,
  EdgeInsets padding,
  BorderSide side,
}) {
  return RaisedButton(
    shape: RoundedRectangleBorder(
        side: side ?? BorderSide.none,
        borderRadius:
            borderRadius ?? BorderRadius.circular(ScreenUtil().setSp(5))),
    color: color ?? ColorApps.primary,
    disabledColor: disabledColor ?? ColorApps.grey9F9F9F,
    splashColor: splashColor ?? Colors.black26,
    focusColor: focusColor ?? Colors.black26,
    hoverColor: hoverColor ?? Colors.black26,
    highlightColor: highlightColor ?? Colors.black26,
    onPressed: onPressed ?? null,
    child: Text(
      text ?? "Button Text",
      style: textStyle ??
          TextStyle(
            fontSize: ScreenUtil().setSp(15),
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
    ),
  );
}

Widget RaisedButtonWidget({
  BuildContext context,
  Widget child,
  TextStyle textStyle,
  Color color,
  Color disabledColor,
  Color splashColor,
  Color hoverColor,
  Color highlightColor,
  Color focusColor,
  Function onPressed,
  BorderRadius borderRadius,
  EdgeInsets padding,
  BorderSide side,
}) {
  return RaisedButton(
    shape: RoundedRectangleBorder(
        side: side ?? BorderSide.none,
        borderRadius:
            borderRadius ?? BorderRadius.circular(ScreenUtil().setSp(5))),
    color: color ?? ColorApps.primary,
    disabledColor: disabledColor ?? ColorApps.grey9F9F9F,
    splashColor: splashColor ?? Colors.black26,
    focusColor: focusColor ?? Colors.black26,
    hoverColor: hoverColor ?? Colors.black26,
    highlightColor: highlightColor ?? Colors.black26,
    onPressed: onPressed ?? null,
    child: child ??
        Text(
          "Button Text",
          style: textStyle ??
              TextStyle(
                fontSize: ScreenUtil().setSp(15),
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
  );
}

Widget RaisedButtonLoading(
    BuildContext context, Size size, Color color, Color textColor) {
  return Container(
    width: size.width,
    height: ScreenUtil().setHeight(56),
    margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
    child: RaisedButtonWidget(
      child: LoadingIndicator(
        indicatorType: Indicator.ballPulse,
        color: Colors.white,
      ),
      color: color ?? Colors.black,
      padding: EdgeInsets.all(1),
      textStyle: TextStyle(
          color: textColor ?? ColorApps.white,
          fontWeight: FontWeight.bold,
          fontSize: ScreenUtil().setSp(14)),
      onPressed: () {},
    ),
  );
}

Widget SmallLayoutLoading(BuildContext context, Color color) {
  return Container(
    height: 14.0,
    width: 100,
    child: LoadingIndicator(
      indicatorType: Indicator.ballPulse,
      color: color ?? Colors.white,
    ),
  );
}

Widget CircleLayoutLoading(
  BuildContext context,
  Color color,
  double width,
) {
  return Container(
    height: width * .5 ?? ScreenUtil().setWidth(40),
    width: width ?? ScreenUtil().setWidth(80),
    child: LoadingIndicator(
      indicatorType: Indicator.ballPulse,
      color: color ?? Colors.white,
    ),
  );
}

Widget ShowErrorState() {
  return Text(
    "Terjadi Kesalahan."
    "\nSilahkan coba lagi.",
    style: TextStyle(
        color: Colors.black.withOpacity(.5),
        fontWeight: FontWeight.normal,
        fontSize: ScreenUtil().setSp(15)),
  );
}

TextFormField TextFormFieldOutline(
    {TextEditingController controller,
    bool enabled,
    String hint,
    FocusNode focusNode,
    TextInputType keyboardType,
    TextStyle style,
    Function(String) validator,
    InputDecoration decoration,
    Function(String) onChanged,
    Function(String) onFieldSubmitted,
    Function() onPressedSuffix,
    Widget suffixIcon,
    Widget prefixIcon,
    int maxLength,
    int maxLines,
    int minLines,
    EdgeInsets contentPadding,
    BorderRadius borderRadius,
    TextInputAction textInputAction}) {
  return TextFormField(
    enabled: enabled ?? true,
    controller: controller,
    focusNode: focusNode,
    maxLines: maxLines ?? 1,
    minLines: minLines ?? 1,
    textInputAction: textInputAction ?? TextInputAction.done,
    keyboardType: keyboardType ?? TextInputType.text,
    style: style ??
        TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(15)),
    validator: validator,
    maxLength: maxLength ?? null,
    decoration: decoration ??
        InputDecoration(
            contentPadding: contentPadding ??
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            hintText: hint ?? "Field Hint",
            counterText: '',
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorApps.black, width: .5),
              borderRadius:
                  borderRadius ?? BorderRadius.circular(ScreenUtil().setSp(5)),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorApps.red, width: .5),
              borderRadius:
                  borderRadius ?? BorderRadius.circular(ScreenUtil().setSp(5)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorApps.red, width: .5),
              borderRadius:
                  borderRadius ?? BorderRadius.circular(ScreenUtil().setSp(5)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorApps.black.withOpacity(.5), width: .2),
              borderRadius:
                  borderRadius ?? BorderRadius.circular(ScreenUtil().setSp(5)),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorApps.black.withOpacity(.5), width: .2),
              borderRadius:
                  borderRadius ?? BorderRadius.circular(ScreenUtil().setSp(5)),
            ),
            suffixIcon: suffixIcon ??
                Visibility(
                  visible: controller.text.isNotEmpty,
                  child: GestureDetector(
                    onTap: () => onPressedSuffix(),
                    child: Icon(
                      Icons.close,
                      size: ScreenUtil().setSp(20),
                      color: Colors.black.withOpacity(.5),
                    ),
                  ),
                ),
            prefixIcon: prefixIcon ?? null),
    onChanged: (val) => onChanged(val),
    onFieldSubmitted: (val) {
      onFieldSubmitted(val);
    },
  );
}

TextFormField TextFormFieldAreaOutline(
    {TextEditingController controller,
    bool enabled,
    String hint,
    FocusNode focusNode,
    TextInputType keyboardType,
    TextStyle style,
    TextStyle hintStyle,
    Function(String) validator,
    InputDecoration decoration,
    Function(String) onChanged,
    Function(String) onFieldSubmitted,
    Function() onPressedSuffix,
    Widget suffixIcon,
    Widget prefixIcon,
    int maxLength,
    int maxLines,
    int minLines,
    EdgeInsets contentPadding,
    BorderRadius borderRadius,
    TextInputAction textInputAction}) {
  return TextFormField(
    enabled: enabled ?? true,
    controller: controller,
    focusNode: focusNode,
    maxLines: maxLines ?? 1,
    minLines: minLines ?? 1,
    textInputAction: textInputAction ?? TextInputAction.done,
    keyboardType: keyboardType ?? TextInputType.text,
    style: style ??
        TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(15)),
    validator: validator,
    maxLength: maxLength ?? null,
    decoration: decoration ??
        InputDecoration(
            contentPadding: contentPadding ??
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            hintText: hint ?? "Field Hint",
            counterText: '',
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorApps.black, width: .5),
              borderRadius:
                  borderRadius ?? BorderRadius.circular(ScreenUtil().setSp(5)),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorApps.red, width: .5),
              borderRadius:
                  borderRadius ?? BorderRadius.circular(ScreenUtil().setSp(5)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorApps.red, width: .5),
              borderRadius:
                  borderRadius ?? BorderRadius.circular(ScreenUtil().setSp(5)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorApps.black.withOpacity(.5), width: .2),
              borderRadius:
                  borderRadius ?? BorderRadius.circular(ScreenUtil().setSp(5)),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorApps.black.withOpacity(.5), width: .2),
              borderRadius:
                  borderRadius ?? BorderRadius.circular(ScreenUtil().setSp(5)),
            ),
            hintStyle: hintStyle ?? null,
            suffixIcon: suffixIcon ?? null,
            prefixIcon: prefixIcon ?? null),
    onChanged: (val) => onChanged(val),
    onFieldSubmitted: (val) {
      onFieldSubmitted(val);
    },
  );
}


TextFormField TextFormFieldAreaFilled(
    {TextEditingController controller,
    bool enabled,
    String hint,
    FocusNode focusNode,
    TextInputType keyboardType,
    TextStyle style,
    TextStyle hintStyle,
    Function(String) validator,
    InputDecoration decoration,
    Function(String) onChanged,
    Function(String) onFieldSubmitted,
    Function() onPressedSuffix,
    Widget suffixIcon,
    Widget prefixIcon,
    int maxLength,
    int maxLines,
    int minLines,
    EdgeInsets contentPadding,
    BorderRadius borderRadius,
    TextInputAction textInputAction}) {
  return TextFormField(
    enabled: enabled ?? true,
    controller: controller,
    focusNode: focusNode,
    maxLines: maxLines ?? 1,
    minLines: minLines ?? 1,
    textInputAction: textInputAction ?? TextInputAction.done,
    keyboardType: keyboardType ?? TextInputType.text,
    style: style ??
        TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(15)),
    validator: validator,
    maxLength: maxLength ?? null,
    decoration: decoration ??
        InputDecoration(
            filled: true,
            fillColor: Color(0xFFF0F0F0),
            contentPadding: contentPadding ??
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            hintText: hint ?? "Field Hint",
            counterText: '',
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorApps.black, width: .5),
              borderRadius:
                  borderRadius ?? BorderRadius.circular(ScreenUtil().setSp(25)),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorApps.red, width: .5),
              borderRadius:
                  borderRadius ?? BorderRadius.circular(ScreenUtil().setSp(25)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorApps.red, width: .5),
              borderRadius:
                  borderRadius ?? BorderRadius.circular(ScreenUtil().setSp(25)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorApps.black.withOpacity(.5), width: .2),
              borderRadius:
                  borderRadius ?? BorderRadius.circular(ScreenUtil().setSp(25)),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorApps.black.withOpacity(.5), width: .2),
              borderRadius:
                  borderRadius ?? BorderRadius.circular(ScreenUtil().setSp(25)),
            ),
            hintStyle: hintStyle ?? null,
            suffixIcon: suffixIcon ?? null,
            prefixIcon: prefixIcon ?? null),
    onChanged: (val) => onChanged(val),
    onFieldSubmitted: (val) {
      onFieldSubmitted(val);
    },
  );
}

class Dots extends StatelessWidget {
  final int total;
  final int index;
  final double size;
  final Color activeColor;
  final Color defaultColor;

  Dots({
    this.total = 3,
    this.index = 0,
    this.size = 10.0,
    this.activeColor,
    this.defaultColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(total, (data) {
          return Container(
            height: size,
            width: size,
            margin: EdgeInsets.only(right: data != total - 1 ? 4.0 : 0.0),
            decoration: BoxDecoration(
              color: index == data
                  ? activeColor ?? ColorApps.black
                  : defaultColor ?? ColorApps.white,
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(size / 2)),
            ),
          );
        }),
      ),
    );
  }
}

class SliderDots extends StatelessWidget {
  final int total;
  final int index;
  final double size;

  SliderDots({
    this.total = 3,
    this.index = 0,
    this.size = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(total, (data) {
          return Container(
            height: size,
            margin: EdgeInsets.only(right: 4.0),
            decoration: BoxDecoration(
              color: index != data ? Colors.white : ColorApps.primary,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(
                  color: ColorApps.black, width: .8, style: BorderStyle.solid),
            ),
            child: AspectRatio(
              aspectRatio: 1 / 1,
            ),
          );
        }),
      ),
    );
  }
}

class SliderImageGalleries extends StatelessWidget {
  final int index;
  final List<Picture> img;
  final Function(int) onCLick;

  SliderImageGalleries({
    this.index = 0,
    this.img,
    this.onCLick,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(img.length, (data) {
        return Stack(
          children: <Widget>[
            Container(
              height: ScreenUtil().setHeight(64),
              decoration: BoxDecoration(
                border: Border.all(
                    color: index != data ? Colors.white : ColorApps.primary,
                    width: 3,
                    style: BorderStyle.solid),
              ),
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: img[data].path.length > 0
                    ? FadeInImage.assetNetwork(
                        placeholder: Images.imgPlaceholder,
                        image: img.length > 0
                            ? BaseUrl.SoedjaAPI + '/' + img[data].path
                            : '')
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(Images.iconVideoSvg),
                      ),
              ),
            ),
            GestureDetector(
              onTap: () {
                onCLick(data);
              },
              child: Container(
                color: index != data
                    ? Colors.white.withOpacity(.5)
                    : Colors.transparent,
                height: ScreenUtil().setHeight(64),
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class DotsPin extends StatelessWidget {
  final int total;
  final int index;
  final double size;
  final Color color;

  DotsPin({
    this.total = 3,
    this.index = 0,
    this.size = 10.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(total, (data) {
          return Container(
            height: size,
            width: size,
            margin: EdgeInsets.only(
                right: data != total - 1 ? ScreenUtil().setWidth(20) : 0.0),
            decoration: BoxDecoration(
              color: index > data
                  ? color ?? ColorApps.white
                  : ColorApps.white.withOpacity(.3),
              borderRadius: BorderRadius.all(Radius.circular(size / 2)),
            ),
          );
        }),
      ),
    );
  }
}

String validateEmpty(String value) {
  if (value.isEmpty) return Texts.formEmpty;
}

String validateEmail(String value) {
  if (value.isEmpty) return Texts.emailEmpty;

  final RegExp nameExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!nameExp.hasMatch(value)) return Texts.emailNotValid;
  return null;
}

String validateEmailRegister(String value) {
  return Texts.emailIsRegister;
}

String validatePhoneRegister(String value) {
  return Texts.phoneIsRegister;
}

String validateLogin(String value) {
  if (value.isEmpty) return Texts.emailEmpty;

  final RegExp nameExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!nameExp.hasMatch(value)) return Texts.emailNotValid;
  return null;
}

String validateEmailNotRegister(String value) {
  return Texts.emailNotRegister;
}

String validateName(String value) {
  if (value.isEmpty) return Texts.nameEmpty;
  if (value.length < 3) return Texts.nameNotValid;
  return null;
}

String validatePhone(String value) {
  if (value.isEmpty) return Texts.phoneEmpty;
  if (value.length < 8) return Texts.phoneNotValid;
  return null;
}

showNotif(BuildContext context, Map<String, dynamic> message, Function onTap) {
  Flushbar(
    messageText: GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Image.asset(
                  Images.imgLogoOnly,
                  width: ScreenUtil().setSp(14),
                  height: ScreenUtil().setSp(14),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    Texts.soedjaNotification,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black.withOpacity(.5),
                      fontSize: ScreenUtil().setSp(10),
                    ),
                  ),
                ),
                Text(
                  "Sekarang",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w300,
                    fontSize: ScreenUtil().setSp(10),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              message['data']['title'],
              style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(15),
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "Seseorang telah merespon portfolio kamu. Cek Sekarang",
              style: TextStyle(
                color: Colors.black.withOpacity(.5),
                fontSize: ScreenUtil().setSp(12),
              ),
            ),
          ],
        ),
      ),
    ),
    duration: Duration(seconds: 3),
    shouldIconPulse: false,
    backgroundColor: Colors.white,
    borderRadius: ScreenUtil().setSp(5),
    animationDuration: Duration(milliseconds: 250),
    leftBarIndicatorColor: Colors.transparent,
    flushbarPosition: FlushbarPosition.TOP,
    margin: EdgeInsets.all(ScreenUtil().setSp(10)),
    boxShadows: [
      BoxShadow(offset: Offset(0, 5), blurRadius: 5, color: Colors.black26)
    ],
//    padding: EdgeInsets.zero,
  )..show(context);
}

showDialogMessage(BuildContext context, String title, String subtitle) {
  Flushbar(
    messageText: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Image.asset(
              Images.imgLogoOnly,
              width: ScreenUtil().setSp(14),
              height: ScreenUtil().setSp(14),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                Texts.soedjaNotification,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black.withOpacity(.5),
                  fontSize: ScreenUtil().setSp(10),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: ScreenUtil().setSp(15),
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.black.withOpacity(.5),
            fontSize: ScreenUtil().setSp(12),
          ),
        ),
      ],
    ),
    duration: Duration(seconds: 3),
    shouldIconPulse: false,
    backgroundColor: Colors.white,
    borderRadius: ScreenUtil().setSp(5),
    animationDuration: Duration(milliseconds: 250),
    leftBarIndicatorColor: Colors.transparent,
    flushbarPosition: FlushbarPosition.TOP,
    margin: EdgeInsets.all(ScreenUtil().setSp(10)),
    boxShadows: [
      BoxShadow(offset: Offset(0, 5), blurRadius: 5, color: Colors.black26)
    ],
//    padding: EdgeInsets.zero,
  )..show(context);
}

showSnackProgressBar({
  BuildContext context,
  String message,
}) {
  Flushbar(
    messageText: Text(
      message,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
    icon: Container(
      height: 28,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: LoadingIndicator(
          indicatorType: Indicator.ballPulse,
          color: Colors.black.withOpacity(.8),
        ),
      ),
    ),
    duration: Duration(seconds: 9999),
    backgroundColor: Colors.white,
    borderRadius: ScreenUtil().setSp(10),
    animationDuration: Duration(milliseconds: 250),
    leftBarIndicatorColor: Colors.transparent,
    flushbarPosition: FlushbarPosition.BOTTOM,
    margin: EdgeInsets.all(ScreenUtil().setSp(20)),
//    padding: EdgeInsets.zero,
  )..show(context);
}

void onFieldSubmitted(
  BuildContext context,
  FocusNode currentFocus,
  FocusNode nextFocus,
) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

String avatar(String name) {
  if (name != null) {
    for (int i = 0; i < avatarList.length; i++) {
      if (name[0].toUpperCase() == avatarList[i]['name']) {
        return avatarList[i]['value'];
      }
    }
  }
  return avatarList[0]['value'];
}

String dateFormat({int date, DateTime dateTime, String formatDate}) {
  var format = DateFormat(formatDate ?? 'dd/MM/yyyy HH:mm a');
  if (dateTime != null) {
    return format.format(dateTime);
  } else {
    var dates = DateTime.fromMillisecondsSinceEpoch(date * 1000);
    return format.format(dates);
  }
}

String countDown({int date, DateTime dateTime, String formatDate}) {
  var format = DateFormat(formatDate ?? 'dd/MM/yyyy HH:mm a');
  if (dateTime != null) {
    return format.format(dateTime);
  } else {
    var dates = DateTime.fromMillisecondsSinceEpoch(date * 1000);
    return format.format(dates);
  }
}

String typeProject({String type}) {
  if (type == 'creative') {
    return 'Project Kreatif';
  } else {
    return 'Bayar Perjam';
  }
}

String strDateOnly(String date) {
  var dates;
  if (date.contains('-')) {
    dates = date.split('-');
  } else {
    dates = date.split('/');
  }
  return '${dates[2]} ${monthId(dates[1])} ${dates[0]}';
}

String strDateTime(String date) {
  var dates;
  if (date.contains('-')) {
    dates = date.split('-');
  } else {
    dates = date.split('/');
  }
  return '${dates[2]} ${monthId(dates[1])} ${dates[0]}';
}

String monthId(String month) {
  if (month == '01') {
    return 'Januari';
  } else if (month == '02') {
    return 'Februari';
  } else if (month == '03') {
    return 'Maret';
  } else if (month == '04') {
    return 'April';
  } else if (month == '05') {
    return 'Mei';
  } else if (month == '06') {
    return 'Juni';
  } else if (month == '07') {
    return 'Juli';
  } else if (month == '08') {
    return 'Agustus';
  } else if (month == '09') {
    return 'September';
  } else if (month == '10') {
    return 'Oktober';
  } else if (month == '11') {
    return 'November';
  } else {
    return 'Desember';
  }
}

Widget DividerWidget({
  double height,
  double width,
  Color color,
  Widget child,
  EdgeInsets padding,
  EdgeInsets margin,
}) {
  return Container(
    color: color ?? ColorApps.light,
    child: child,
    padding: padding ?? EdgeInsets.all(ScreenUtil().setHeight(20)),
    margin: margin ?? EdgeInsets.zero,
    height: height,
    width: width ?? double.infinity,
  );
}

bool isOdd(int val) {
  return (val & 0x01) != 0;
}

Future<dynamic> decodeToken() async {
  var data;

  await SharedPreference.get(SharedPrefKey.AuthToken).then((value) async {
    data = parseJwt(value);
  });

  return data;
}

Map<String, dynamic> parseJwt(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('invalid token');
  }

  final payload = _decodeBase64(parts[1]);
  final payloadMap = json.decode(payload);
  if (payloadMap is! Map<String, dynamic>) {
    throw Exception('invalid payload');
  }

  return payloadMap;
}

String _decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

  return utf8.decode(base64Url.decode(output));
}

Widget guidanceTips(
    {BuildContext context,
    int index,
    String title,
    String desc,
    Function onSkip,
    Function onNext}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.max,
    children: <Widget>[
      Text(
        '${index + 1}. $title',
      ),
      Text(
        '$desc',
      ),
    ],
  );
}
