import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

Widget TextFormFieldPhone({TextEditingController controller,
  String hint,
  FocusNode focusNode,
  TextInputType keyboardType,
  TextStyle style,
  Function(String) validator,
  InputDecoration decoration,
  Function(String) onChanged,
  Function(String) onFieldSubmitted,
  Function() onPressedSuffix,
  Icon suffixIcon,
  int maxLength,
  Function() onEditingComplete}){
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(10),
            vertical: ScreenUtil().setHeight(20)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(ScreenUtil().setSp(5)),
            bottomLeft:
            Radius.circular(ScreenUtil().setSp(5)),
          ),
          border: Border.all(color: Colors.black.withOpacity(.5), width: .5),
          color: ColorApps.black,
        ),
        child: Row(
          children: <Widget>[
            Image.asset(
              Images.imgFlagIdn,
              width: 18.0,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(width: ScreenUtil().setWidth(5)),
            Text(
              '+62',
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(15),
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
      Expanded(
        child: TextFormFieldOutline(
          controller: controller,
          focusNode: focusNode,
          validator: (value) => validatePhone(value),
          keyboardType: TextInputType.phone,
          onChanged: (val) => onChanged(val),
          textInputAction: TextInputAction.next,
          maxLength: 12,
          onFieldSubmitted: (val) => onFieldSubmitted(val),
          decoration: InputDecoration(
            hintText: Texts.hintPhone,
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: ColorApps.black.withOpacity(.2),
                    width: 1),
                borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(
                        ScreenUtil().setSp(5)))),
            contentPadding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(20)),
            counterText: '',
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorApps.black,
                  width: 1),
              borderRadius: BorderRadius.horizontal(
                  right:
                  Radius.circular(ScreenUtil().setSp(5))),
            ),
            errorBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: ColorApps.red, width: 1),
              borderRadius: BorderRadius.horizontal(
                  right:
                  Radius.circular(ScreenUtil().setSp(5))),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: ColorApps.red, width: 1),
              borderRadius: BorderRadius.horizontal(
                  right:
                  Radius.circular(ScreenUtil().setSp(5))),
            ),
            suffixIcon: Visibility(
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
          ),
        ),
      ),
    ],
  );
}