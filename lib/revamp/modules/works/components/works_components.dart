import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soedja_freelance/old_ver/constants/urls.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/components/portfolio_components.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

import '../../auth/bloc/auth_state.dart';
import '../../auth/models/auth_models.dart';
import '../../auth/models/auth_models.dart';

DialogOnBoardWorks(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(ScreenUtil().setSp(20))),
          ),
          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              YellowBanner(
                message:
                    "Mulailah upload portfolio sebanyak mungkin untuk nikmati fitur ini.",
              ),
              SizedBox(height: ScreenUtil().setHeight(10)),
              Text(
                "Segera Datang Nih!".toUpperCase(),
                style: TextStyle(
                  color: ColorApps.primary,
                  fontSize: ScreenUtil().setSp(10),
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(20)),
              Text(
                "Ucapkan selamat tinggal, dari cara"
                "\nmanual dapat pekerjaan.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorApps.black,
                  fontSize: ScreenUtil().setSp(20),
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(20)),
              Text(
                "Tidak lagi ketinggalan kesempatan mendaftar"
                "\ndi proyek dengan Auto-Bid.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorApps.black.withOpacity(.5),
                  fontSize: ScreenUtil().setSp(12),
                  fontWeight: FontWeight.normal,
                  height: 1.5,
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(20)),
              Image.asset(
                Images.illustrationTwoHand,
                fit: BoxFit.fitWidth,
                width: size.width,
              ),
              DividerWidget(
                  height: ScreenUtil().setHeight(24),
                  margin: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(10))),
              Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Sementara Fitur Akan Datang, Kamu bisa : ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenUtil().setSp(12),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      Container(
                        width: size.width,
                        height: ScreenUtil().setHeight(110),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                    ScreenUtil().setWidth(5),
                                  ),
                                  border: Border.all(
                                      color: Colors.black.withOpacity(.5),
                                      width: .2),
                                ),
                                padding:
                                    EdgeInsets.all(ScreenUtil().setWidth(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Posting Banyak Portfolio",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: ScreenUtil().setSp(10),
                                        fontWeight: FontWeight.bold,
                                        height: 1.5,
                                      ),
                                    ),
                                    Expanded(
                                        child: SizedBox(
                                            height:
                                                ScreenUtil().setHeight(10))),
                                    Text(
                                      "Sistem kami akan melakukan "
                                      "rekomendasi pekerjaan kepada"
                                      "akun freelancer yang aktif.",
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(.5),
                                        fontSize: ScreenUtil().setSp(10),
                                        fontWeight: FontWeight.normal,
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: ScreenUtil().setWidth(10)),
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                    ScreenUtil().setWidth(5),
                                  ),
                                  border: Border.all(
                                      color: Colors.black.withOpacity(.5),
                                      width: .2),
                                ),
                                padding:
                                    EdgeInsets.all(ScreenUtil().setWidth(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Bangun interaktif konten & Dapat Uang.",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: ScreenUtil().setSp(10),
                                        fontWeight: FontWeight.bold,
                                        height: 1.5,
                                      ),
                                    ),
                                    Expanded(
                                        child: SizedBox(
                                            height:
                                                ScreenUtil().setHeight(10))),
                                    Text(
                                      "Interaksi konten yang banyak "
                                      "membuat sistem kami mereko-"
                                      "mendasikan kamu kepada klien.",
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(.5),
                                        fontSize: ScreenUtil().setSp(10),
                                        fontWeight: FontWeight.normal,
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        );
      });
}

Widget WorksProfile({BuildContext context, GetProfileResponse profile}) {
  String url = BaseUrl.SoedjaAPI;
  return Container(
    margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(20)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
              borderRadius: BorderRadius.circular(ScreenUtil().setSp(50)),
              child: Container(
                width: ScreenUtil().setWidth(48),
                color: Colors.black.withOpacity(.05),
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: FadeInImage.assetNetwork(
                      placeholder: avatar(profile.payload.name),
                      fit: BoxFit.cover,
                      image:  profile.payload.picture != '' ? '$url/${profile.payload.picture}' : AssetImage('assets/avatar/avatar_A.png')),
                ),
              ),
            ),
        Container(
          margin: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(5)),
                child: Text(
                  profile.payload.name,
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(13),
                      fontWeight: FontWeight.w800),
                ),
              ),
              Text(
                profile.payload.profession,
                style: TextStyle(
                    color: Color(0xFF707070),
                    fontSize: ScreenUtil().setSp(12),
                    fontWeight: FontWeight.w800),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget WorksProfileLoading({BuildContext context}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(20)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Color(0xFFF4F4F4),
          radius: ScreenUtil().setHeight(23),
        ),
        Container(
          margin: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(5)),
                height: ScreenUtil().setHeight(10),
                width: ScreenUtil().setWidth(75),
                decoration: BoxDecoration(
                  color: Color(0xFFF4F4F4),
                  borderRadius: BorderRadius.circular(ScreenUtil().setHeight(5))
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(5)),
                height: ScreenUtil().setHeight(10),
                width: ScreenUtil().setWidth(75),
                decoration: BoxDecoration(
                  color: Color(0xFFF4F4F4),
                  borderRadius: BorderRadius.circular(ScreenUtil().setHeight(5))
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
