import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/account/components/share_components.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

class InviteFriendScreen extends StatefulWidget {
  final String title;

  InviteFriendScreen({
    this.title,
  });

  @override
  StateInviteFriendScreen createState() => StateInviteFriendScreen();
}

class StateInviteFriendScreen extends State<InviteFriendScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        automaticallyImplyLeading: false,
        title: Text(
          Texts.inviteScreenTitle,
          style: TextStyle(
            color: Colors.black,
            fontSize: ScreenUtil().setSp(15),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigation().navigateBack(context)),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: ColorApps.light,
              child: Image.asset(
                Images.illustrationAuthScreen,
                fit: BoxFit.cover,
                width: size.width,
              ),
            ),
          ),
          Container(
            width: size.width,
            color: Colors.white,
            padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Share Link Download",
                  style: TextStyle(
                    color: ColorApps.primary,
                    fontSize: ScreenUtil().setSp(12),
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                Text(
                  "Undang Teman &"
                  "\nKerabat Kamu Gunakan"
                  "\nAplikasi SOEDJA.",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(25),
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(30)),
                Container(
                  height: ScreenUtil().setHeight(56),
                  child: FlatButtonText(
                      color: Colors.black,
                      text: "SHARE",
                      onPressed: () => shareApp(context)),
                ),
                SizedBox(height: ScreenUtil().setHeight(30)),
                Text(
                  "Share karya kamu, dan wujudkan kolaborasi"
                  "\nbersama bisnis.",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(15),
                    fontWeight: FontWeight.w300,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
