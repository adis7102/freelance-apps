import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget BlueCircle({BuildContext buildContext, size, bool isIcon, icon, String content, fontSize}){
  return Container(
    height: size,
    width: size,
    decoration: BoxDecoration(
      color: Color(0xFF2D5ADF),
      shape: BoxShape.circle,
    ),
    child: 
      isIcon ? Center(
        child: Icon(
          icon,
          color: Colors.white,
          size: ScreenUtil().setHeight(15),
        ),
      ) : Center(
        child: Text(
          content,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(fontSize),
            fontWeight: FontWeight.w800,
            color: Colors.white
          ),
        ),
      ),
  );
}