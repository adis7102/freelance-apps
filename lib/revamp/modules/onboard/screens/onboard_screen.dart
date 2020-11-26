import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/lists.dart';
import 'package:soedja_freelance/revamp/assets/sharedpref_keys.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/helpers/sharedpref_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/screens/auth_screen.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

class OnBoardScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _OnBoardScreen();
  }
}

class _OnBoardScreen extends State<OnBoardScreen> {
  int index = 0;
  PageController bgController = PageController();
  PageController textController = PageController();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF212121),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: imageBackground(context, size),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: bottomNavOnBoard(context, size),
          ),
        ],
      ),
    );
  }

  Widget imageBackground(BuildContext context, Size size) {
    return Container(
      height: size.height / 1.8,
      child: PageView(
          controller: bgController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (int page) => setState(() {
                index = page;
//                textController.animateToPage(
//                  index,
//                  duration: Duration(milliseconds: 500),
//                  curve: Curves.ease,
//                );
              }),
          children: List.generate(listOnBoard.length, (index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
//                Text(
//                  listOnBoard[index]['title'],
//                  textAlign: TextAlign.center,
//                  style: TextStyle(
//                      color: Colors.white,fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(25)),
//                ),
//                Text(
//                  listOnBoard[index]['subtitle'],
//                  textAlign: TextAlign.center,
//                  style: TextStyle(
//                      color: Colors.white.withOpacity(.5),
//                      height: 1.5,
//                      fontSize: ScreenUtil().setSp(12)),
//                ),
                Image.asset(
                  listOnBoard[index]['image'],
                  width: size.width,
                  height: size.height / 1.8,
                  fit: BoxFit.fitWidth,
                ),
              ],
            );
          })),
    );
  }

  Widget bottomNavOnBoard(BuildContext context, Size size) {
    return Container(
      height: size.height / 2,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(ScreenUtil().setHeight(20)))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(height: (ScreenUtil().setHeight(32))),
          Dots(
            index: index,
            total: 4,
          ),
          SizedBox(height: (ScreenUtil().setHeight(32))),
          Expanded(
            child: PageView(
                controller: textController,
                physics: ClampingScrollPhysics(),
                onPageChanged: (int page) => setState(() {
                      index = page;
//                  bgController.animateToPage(
//                    index,
//                    duration: Duration(milliseconds: 500),
//                    curve: Curves.ease,
//                  );
                      bgController.jumpToPage(index);
                    }),
                children: List.generate(listOnBoard.length, (index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        listOnBoard[index]['title'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(25)),
                      ),
                      SizedBox(height: (ScreenUtil().setHeight(10))),
                      Text(
                        listOnBoard[index]['subtitle'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black.withOpacity(.5),
                            height: 1.5,
                            fontSize: ScreenUtil().setSp(12)),
                      ),
                    ],
                  );
                })),
          ),
          SizedBox(height: (ScreenUtil().setHeight(24))),
          Container(
            height: ScreenUtil().setHeight(45),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(width: (ScreenUtil().setWidth(20))),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setSp(5)),
                        border: Border.all(color: Colors.black, width: .2)),
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(10),
                        vertical: ScreenUtil().setHeight(10)),
                    child: Row(
                      children: <Widget>[
                        VerticalDivider(
                          width: ScreenUtil().setWidth(20),
                          color: Colors.red,
                          thickness: 1.0,
                        ),
                        Expanded(
                          child: Text(
                            smallBanner(index, 0),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: ScreenUtil().setSp(12),
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: (ScreenUtil().setWidth(20))),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setSp(5)),
                        border: Border.all(color: Colors.black, width: .2)),
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(10),
                        vertical: ScreenUtil().setHeight(10)),
                    child: Row(
                      children: <Widget>[
                        VerticalDivider(
                          width: ScreenUtil().setWidth(20),
                          color: Colors.red,
                          thickness: 1.0,
                        ),
                        Expanded(
                          child: Text(
                            smallBanner(index, 1),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: ScreenUtil().setSp(12),
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: (ScreenUtil().setWidth(20))),
              ],
            ),
          ),
          SizedBox(height: (ScreenUtil().setHeight(10))),
          Divider(
            height: (ScreenUtil().setHeight(20)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButtonText(
                text: Texts.skip.toUpperCase(),
                color: Colors.white,
                padding: EdgeInsets.all(1),
                textStyle: TextStyle(
                    color: ColorApps.dark,
                    fontWeight: FontWeight.w400,
                    fontSize: ScreenUtil().setSp(14)),
                splashColor: Colors.white,
                focusColor: Colors.white,
                highlightColor: Colors.white,
                onPressed: () {
                  SharedPreference.set(SharedPrefKey.FirstTime, "false");
                  Navigation().navigateReplacement(context, AuthScreen());
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: ScreenUtil().setSp(21),
                  ),
                  onPressed: () {
                    if (index != 3) {
                      setState(() {
                        index++;
//                        bgController.animateToPage(
//                          index,
//                          duration: Duration(milliseconds: 500),
//                          curve: Curves.ease,
//                        );
                        bgController.jumpToPage(index);
                        textController.animateToPage(
                          index,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      });
                    } else {
                      SharedPreference.set(SharedPrefKey.FirstTime, "false");
                      Navigation().navigateReplacement(context, AuthScreen());
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: (ScreenUtil().setHeight(10)))
        ],
      ),
    );
  }

  String smallBanner(int index, int position) {
    if (position == 0) {
      switch (index) {
        case 0:
          return "Commission Project";
          break;
        case 1:
          return "Auto-bid Features";
          break;
        case 2:
          return "SOEDJA Bills";
          break;
        case 3:
          return "E-Wallet Payment";
          break;
        default:
          return "Task";
      }
    } else if (position == 1) {
      switch (index) {
        case 0:
          return "Crowdfunding";
          break;
        case 1:
          return "QR Direct Match";
          break;
        case 2:
          return "Project Management";
          break;
        case 3:
          return "Withdraw System";
          break;
        default:
          return "Task";
      }
    }
  }
}
