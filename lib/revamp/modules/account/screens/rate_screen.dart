import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info/package_info.dart';
import 'package:soedja_freelance/revamp/assets/fonts.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/lists.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

class RateScreen extends StatefulWidget {
  final String title;

  RateScreen({
    this.title,
  });

  @override
  StateRateScreen createState() => StateRateScreen();
}

class StateRateScreen extends State<RateScreen> {

  PackageInfo packageInfo = new PackageInfo();


  @override
  void initState() {
    getVersionCode();
    super.initState();
  }

  void getVersionCode() async {
    packageInfo = await PackageInfo.fromPlatform();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBarSection(),
      backgroundColor: ColorApps.light,
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: ScreenUtil().setHeight(100),
                      width: ScreenUtil().setWidth(160),
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      ColorApps.dark,
                                      ColorApps.primaryDark
                                    ]),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenUtil().setWidth(50)),
                                ),
                              ),
                              width: ScreenUtil().setHeight(100),
                              padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                              child: AspectRatio(
                                aspectRatio: 1/1,
                                child: Image.asset(
                                  Images.imgLogoOnly,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: ScreenUtil().setWidth(16),
                            top: ScreenUtil().setHeight(5),
                            child: Container(
                              width: ScreenUtil().setWidth(40),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenUtil().setWidth(20)),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorApps.black.withOpacity(.2),
                                    blurRadius: 2.0,
                                    // has the effect of softening the shadow
                                    spreadRadius: 1.0,
                                    // has the effect of extending the shadow
                                    offset: Offset(
                                      1.0, // horizontal, move right 10
                                      1.0, // vertical, move down 10
                                    ),
                                  ),
                                ],
                              ),
                              child: AspectRatio(
                                aspectRatio: 1/1,
                                child: Image.asset(
                                  Images.logoPlayStore,
                                  height: ScreenUtil().setHeight(20),
                                  width: ScreenUtil().setWidth(20),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(10)),
                    RichText(
                      text: TextSpan(
                        text: Texts.soedja+" ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: Fonts.ubuntu,
                            fontSize: ScreenUtil().setSp(15)),
                        children: <TextSpan>[
                          TextSpan(
                            text: Texts.appFreelancer,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: ScreenUtil().setSp(15),
                              fontFamily: Fonts.ubuntu,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: ScreenUtil().setHeight(40),),
                    Text(
                      Texts.soedjaAppFreelancerDesc,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: ScreenUtil().setSp(12),
                        fontFamily: Fonts.ubuntu,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              DividerWidget(
                child: Text(
                  Texts.infoApp,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(15),),
                ),
              ),
              Container(
                color: Colors.white,
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          infoAppList[index]['label'],
                          style: TextStyle(
                              color: Colors.black.withOpacity(.5),
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenUtil().setSp(12)),
                        ),
                        Text(
                          index == 3 ? "Version ${packageInfo.version}" :
                          infoAppList[index]['value'],
                          style:
                              TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(12)),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(height: ScreenUtil().setHeight(40),),
                  itemCount: infoAppList.length,
                ),
              ),
              DividerWidget(height: ScreenUtil().setHeight(100)),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    width: .5,
                    color: Colors.black.withOpacity(.2),
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(20),
                vertical: ScreenUtil().setHeight(15),
              ),
              child: Container(
                height: ScreenUtil().setHeight(56),
                child: FlatButtonText(
                  color: Colors.white,
                  side: BorderSide(color: Colors.black.withOpacity(.2), width: .5),
                  text: Texts.writeReview.toUpperCase(),
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(15),),
                  onPressed: (){},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget appBarSection() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1.0,
      textTheme: TextTheme(),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () => Navigation().navigateBack(context),
      ),
      title: Text(
        widget.title,
        style: TextStyle(
          color: Colors.black,
          fontSize: ScreenUtil().setSp(15),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
