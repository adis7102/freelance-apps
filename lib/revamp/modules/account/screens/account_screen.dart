import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/assets/file.dart';
import 'package:soedja_freelance/revamp/assets/lists.dart';
import 'package:soedja_freelance/revamp/assets/sharedpref_keys.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/helpers/sharedpref_helper.dart';
import 'package:soedja_freelance/revamp/modules/account/components/interest_select_screen.dart';
import 'package:soedja_freelance/revamp/modules/account/screens/about_screen.dart';
import 'package:soedja_freelance/revamp/modules/account/screens/invite_screen.dart';
import 'package:soedja_freelance/revamp/modules/account/screens/privacy_policy_screen.dart';
import 'package:soedja_freelance/revamp/modules/account/screens/rate_screen.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_state.dart';
import 'package:soedja_freelance/revamp/modules/auth/screens/auth_screen.dart';
import 'package:soedja_freelance/revamp/modules/profile/models/profile_models.dart';
import 'package:soedja_freelance/revamp/modules/profile/screens/profile_edit_screen.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

class AccountScreen extends StatefulWidget {
  final AuthBloc authBloc;

  const AccountScreen({Key key, this.authBloc}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AccountScreen();
  }
}

class _AccountScreen extends State<AccountScreen> {
  List<dynamic> directoryList = [];
  List<dynamic> policyList = [];
  List<dynamic> privacyList = [];
  List<dynamic> aboutList = [];

  void fetchDirectories() {
    rootBundle
        .loadString(JsonFile.tnc)
        .then((String value) => json.decode(value) as List)
        .then((List value) {
      value.forEach((index) {
        if (index['kategori_tnc'] == 'DIREKTORI') {
          directoryList = [];
          index['value'].forEach((data) {
            directoryList.add(data);
          });

          directoryList.toList().forEach((element) {
            print('Element $element');
          });
        } else if (index['kategori_tnc'] == 'KEBIJAKAN') {
          policyList = [];

          index['value'].forEach((data) {
            policyList.add(data);
          });
        } else if (index['kategori_tnc'] == 'PRIVASI') {
          privacyList = [];

          index['value'].forEach((data) {
            privacyList.add(data);
          });
        } else if (index['kategori_tnc'] == 'TENTANG') {
          aboutList = [];

          index['value'].forEach((data) {
            aboutList.add(data);
          });
        }
      });
//      directoryList.forEach((element) {
//        print('Directory $element');
//      });
    });
  }

  @override
  void initState() {
    fetchDirectories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorApps.light,
      appBar: AppBar(
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
          Texts.myAccount,
          style: TextStyle(
            color: Colors.black,
            fontSize: ScreenUtil().setSp(15),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          StreamBuilder<GetProfileState>(
              stream: widget.authBloc.getProfile,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.isLoading) {
                  } else if (snapshot.data.hasError) {
                    if (snapshot.data.standby) {
                      onWidgetDidBuild(() {
                        showDialogMessage(context, snapshot.data.message,
                            "Terjadi Kesalahan, silahkan coba lagi");
                      });
                    }
                  } else if (snapshot.data.isSuccess) {
                    return GestureDetector(
                      onTap: () => Navigation().navigateScreen(
                          context,
                          ProfileEditScreen(
                            authBloc: widget.authBloc,
                            profileDetail: snapshot.data.data.payload,
                          )),
                      child: Container(
                        padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  AvatarProfile(
                                      profile: snapshot.data.data.payload,
                                      size: ScreenUtil().setWidth(40)),
                                  SizedBox(width: ScreenUtil().setWidth(10)),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Edit Informasi",
                                          style: TextStyle(
                                            color: Colors.black.withOpacity(.5),
                                            fontWeight: FontWeight.w300,
                                            fontSize: ScreenUtil().setSp(10),
                                            height: 1.5,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data.data.payload.name,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: ScreenUtil().setSp(15),
                                            height: 1.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(Icons.chevron_right,
                                      color: Colors.black.withOpacity(.5)),
                                ],
                              ),
                            ),
                            Visibility(
                                visible: snapshot
                                        .data.data.payload.province.length ==
                                    0,
                                child: Divider(
                                    height: ScreenUtil().setHeight(40))),
                            Visibility(
                                visible: snapshot
                                        .data.data.payload.province.length ==
                                    0,
                                child:
                                    percentageBar(snapshot.data.data.payload)),
                          ],
                        ),
                      ),
                    );
                  }
                }
                return Container(
                  padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            SizedBox(width: ScreenUtil().setWidth(10)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Edit Informasi",
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
                            Icon(Icons.chevron_right,
                                color: Colors.black.withOpacity(.5)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
          DividerWidget(
            child: Text(
              Texts.other,
              style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(15),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding:
                  EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    switch (index) {
                      case 0:
                        Navigation().navigateScreen(
                          context,
                          RateScreen(
                            title: otherMenuList[index]['menuTitle'],
                          ),
                        );
                        break;
                      case 1:
                        Navigation().navigateScreen(
                          context,
                          PrivacyPolicyScreen(
                            title: otherMenuList[index]['menuTitle'],
                            directoryList: directoryList,
                            policyList: policyList,
                            privacyList: privacyList,
                          ),
                        );
                        break;
                      case 2:
                        Navigation().navigateScreen(
                          context,
                          AboutSoedjaScreen(
                            title: otherMenuList[index]['menuTitle'],
                            aboutList: aboutList,
                          ),
                        );
                        break;
                      case 3:
                        Navigation().navigateScreen(
                          context,
                          InviteFriendScreen(
                            title: otherMenuList[index]['menuTitle'],
                          ),
                        );
                        break;
                      default:
                        print("");
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(15),
                        horizontal: ScreenUtil().setWidth(20)),
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        otherMenuList[index]['menuIcon'],
                        SizedBox(width: ScreenUtil().setWidth(20)),
                        Expanded(
                          child: Text(
                            otherMenuList[index]['menuTitle'],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenUtil().setSp(15)),
                          ),
                        ),
                        SizedBox(width: ScreenUtil().setWidth(20)),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: ScreenUtil().setWidth(15),
                          color: Colors.black.withOpacity(.5),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => Container(
                  color: Colors.white,
                  child: Divider(
                      indent: ScreenUtil().setWidth(30),
                      endIndent: 16.0,
                      height: 8.0)),
              itemCount: otherMenuList.length,
            ),
          ),
          DividerWidget(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(20),
                vertical: ScreenUtil().setHeight(50)),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  DialogLogoutAccount(
                      context: context,
                      onLogout: () {
                        SharedPreference.remove(SharedPrefKey.AuthToken)
                            .then((response) {
                          Navigation()
                              .navigateReplacement(context, AuthScreen());
                        });
                      });
                },
                child: Container(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                  color: ColorApps.light,
                  child: Text(
                    Texts.menuLogout,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(15),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget percentageBar(ProfileDetail profileDetail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          Texts.fillInfoDesc,
          style: TextStyle(
            color: Colors.black.withOpacity(.5),
            fontSize: ScreenUtil().setSp(10),
            fontWeight: FontWeight.w300,
          ),
        ),
        SizedBox(height: 8.0),
        Row(
          children: <Widget>[
            Flexible(
              flex: 9,
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: SizedBox(
                      height: 8.0,
                      child: Container(
                        color: ColorApps.light,
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        flex:
                            (((profileDetail.province.length > 0 ? 1 : .5) * 10)
                                .toInt()),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: SizedBox(
                            height: 8.0,
                            child: Container(
                              color: ColorApps.primary,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 10 -
                            (((profileDetail.province.length > 0 ? 1 : .5) * 10)
                                .toInt()),
                        child: Container(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.0),
            Flexible(
              flex: 1,
              child: Text(
                '${((profileDetail.province.length > 0 ? 1 : .5) * 100).toInt()}%',
                style: TextStyle(color: Colors.black, fontSize: 12.0),
              ),
            ),
          ],
        ),
      ],
    );
  }

  DialogLogoutAccount({BuildContext context, Function onLogout}) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(ScreenUtil().setSp(10))),
            ),
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(20),
                vertical: ScreenUtil().setHeight(30)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: ScreenUtil().setHeight(20)),
                Text(
                  Texts.logoutTitle,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(20),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(40)),
                  child: Text(
                    Texts.logoutSubtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black.withOpacity(.5),
                      fontWeight: FontWeight.normal,
                      height: 1.5,
                      fontSize: ScreenUtil().setSp(12),
                    ),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(50)),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: ScreenUtil().setHeight(56),
                        child: FlatButtonText(
                            context: context,
                            borderRadius: BorderRadius.zero,
                            color: Colors.white,
                            side: BorderSide(color: Colors.black, width: .5),
                            text: Texts.leave.toUpperCase(),
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(15)),
                            onPressed: onLogout),
                      ),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: ScreenUtil().setHeight(56),
                        child: FlatButtonText(
                            context: context,
                            borderRadius: BorderRadius.zero,
                            color: Colors.black,
                            text: Texts.ehCancel.toUpperCase(),
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(15)),
                            onPressed: () {
                              Navigation().navigateBack(context);
                            }),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
