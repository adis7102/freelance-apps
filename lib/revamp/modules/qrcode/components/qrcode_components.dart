import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

DialogQRUser(BuildContext context, String userId) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
          Size size = MediaQuery.of(context).size;

          return Container(
            padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(ScreenUtil().setSp(10))),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: ScreenUtil().setHeight(200),
                  child: QrImage(
                    data: "profile.$userId}",
                    version: QrVersions.auto,
                    size: ScreenUtil().setHeight(200),
                  ),
                ),
              ],
            ),
          );
        });
      });
}
