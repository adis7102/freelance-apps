import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:soedja_freelance/revamp/assets/lotties.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/dashboard/screens/dashboard_screen.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/models/portfolio_models.dart';

Future<dynamic> SuccessScreenPortfolio(
  BuildContext context,
  AuthBloc authBloc,
  Portfolio item,
  String type,
  Function() onCreateAgain,
) {
  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.black,
    context: context,
    enableDrag: false,
    builder: (BuildContext context) {
      Size size = MediaQuery.of(context).size;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: ScreenUtil().setHeight(20)),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(
                Icons.cancel,
                color: Colors.white,
              ),
              onPressed: () => Navigation().navigateReplacement(
                  context,
                  DashboardScreen(
//                    authBloc: authBloc,
//                    version: version,
                  )),
            ),
          ),
          Expanded(
            child: Container(),
          ),
          LottieBuilder.asset(
            Lotties.successIcon,
            height: ScreenUtil().setHeight(200),
            repeat: false,
          ),
          Text(
            Texts.portfolio.toUpperCase(),
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtil().setSp(24)),
          ),
          SizedBox(height: ScreenUtil().setHeight(10)),
          Text(
            type == 'create'
                ? Texts.successCreateSubtitle : type == 'update' ?
                 Texts.successUpdateSubtitle : "Berhasil Dihapus",
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
            child: Column(
              children: <Widget>[
                Divider(
                  height: ScreenUtil().setHeight(60),
                  color: Colors.white,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        Texts.portfolioTitle + ' :',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: ScreenUtil().setSp(12)),
                      ),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    Expanded(
                      child: Text(
                        "${item.title}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(12),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        Texts.portfolioType + ' :',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: ScreenUtil().setSp(12)),
                      ),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    Expanded(
                      child: Text(
                        "${item.category} - ${item.typeCategory}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(12),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: ScreenUtil().setHeight(60),
                  color: Colors.white,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        Texts.timeCreate + ' :',
                        style: TextStyle(
                            color: Colors.white.withOpacity(.5),
                            fontWeight: FontWeight.normal,
                            fontSize: ScreenUtil().setSp(10)),
                      ),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    Expanded(
                      child: Text(
                          dateFormat(date: item.createdAt),
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Colors.white.withOpacity(.5),
                            fontSize: ScreenUtil().setSp(10),
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                Visibility(
                  visible: type != "delete",
                  child: Container(
                    height: ScreenUtil().setHeight(56),
                    width: size.width,
                    child: FlatButtonText(
                      context: context,
                      color: Colors.black,
                      side: BorderSide(color: Colors.white, width: .5),
                      text: Texts.createAgain.toUpperCase(),
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(15)),
                      onPressed: onCreateAgain,
                    ),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(10)),
                Container(
                  height: ScreenUtil().setHeight(56),
                  width: size.width,
                  child: FlatButtonText(
                    context: context,
                    color: Colors.black,
                    text: Texts.backHome.toUpperCase(),
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(15)),
                    onPressed: () => Navigation().navigateReplacement(
                        context,
                        DashboardScreen(
//                          authBloc: authBloc,
//                          version: version,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
