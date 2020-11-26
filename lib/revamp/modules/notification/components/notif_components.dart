import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/urls.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/modules/notification/models/notification_models.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

Widget CardNotifItem({
  BuildContext context,
  MessageData messageData,
  Function onRead,
}) {
  Size size = MediaQuery.of(context).size;
  return GestureDetector(
    onTap: onRead,
    child: Container(
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(32),
            decoration: BoxDecoration(
              color: ColorApps.light,
              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(16)),
            ),
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: messageData.type == "comment"
                  ? SvgPicture.asset(
                      Images.iconCommentCountSvg,
                      width: ScreenUtil().setWidth(30),
                      semanticsLabel: "icon_comment_count",
                    )
                  : SvgPicture.asset(
                      Images.iconLikeCountSvg,
                      width: ScreenUtil().setWidth(30),
                      semanticsLabel: "icon_like_count",
                    ),
            ),
          ),
          SizedBox(width: ScreenUtil().setWidth(10)),
          Container(
            width: ScreenUtil().setWidth(32),
            decoration: BoxDecoration(
              color: ColorApps.light,
              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(16)),
            ),
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(16)),
                child: FadeInImage.assetNetwork(
                    placeholder: avatar(messageData.detail.name),
                    width: size.width,
                    fit: BoxFit.cover,
                    image: messageData.detail.picture.length > 0
                        ? BaseUrl.SoedjaAPI + "/" + messageData.detail.picture
                        : ""),
              ),
            ),
          ),
          SizedBox(width: ScreenUtil().setWidth(10)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  messageData.detail.message.message,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: ScreenUtil().setSp(12),
                    height: 1.5,
                  ),
                ),
                SizedBox(height: ScreenUtil().setWidth(5)),
                Text(
                  dateFormat(date: messageData.createdAt),
                  style: TextStyle(
                    color: Colors.black.withOpacity(.5),
                    fontWeight: FontWeight.w300,
                    fontSize: ScreenUtil().setSp(10),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget CardNotifLoader(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Container(
    color: Colors.white,
    child: Row(
      children: <Widget>[
        Container(
          width: ScreenUtil().setWidth(32),
          decoration: BoxDecoration(
            color: ColorApps.light,
            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(16)),
          ),
          child: AspectRatio(
            aspectRatio: 1 / 1,
          ),
        ),
        SizedBox(width: ScreenUtil().setWidth(10)),
        Container(
          width: ScreenUtil().setWidth(32),
          decoration: BoxDecoration(
            color: ColorApps.light,
            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(16)),
          ),
          child: AspectRatio(
            aspectRatio: 1 / 1,
          ),
        ),
        SizedBox(width: ScreenUtil().setWidth(10)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: ScreenUtil().setWidth(12),
                width: size.width,
                decoration: BoxDecoration(
                  color: ColorApps.light,
                  borderRadius: BorderRadius.circular(ScreenUtil().setWidth(5)),
                ),
              ),
              SizedBox(height: ScreenUtil().setWidth(5)),
              Container(
                height: ScreenUtil().setWidth(12),
                width: size.width / 2,
                decoration: BoxDecoration(
                  color: ColorApps.light,
                  borderRadius: BorderRadius.circular(ScreenUtil().setWidth(5)),
                ),
              ),
              SizedBox(height: ScreenUtil().setWidth(10)),
              Container(
                height: ScreenUtil().setWidth(12),
                width: size.width / 3,
                decoration: BoxDecoration(
                  color: ColorApps.light,
                  borderRadius: BorderRadius.circular(ScreenUtil().setWidth(5)),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
