import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soedja_freelance/old_ver/components/button.dart';
import 'package:soedja_freelance/old_ver/components/dialog.dart';
import 'package:soedja_freelance/old_ver/constants/assets.dart';
import 'package:soedja_freelance/old_ver/constants/lists.dart';
import 'package:soedja_freelance/old_ver/constants/local_storage.dart';
import 'package:soedja_freelance/old_ver/constants/strings.dart';
import 'package:soedja_freelance/old_ver/constants/urls.dart';
import 'package:soedja_freelance/old_ver/models/feeds.dart';
import 'package:soedja_freelance/old_ver/models/tnc.dart';
import 'package:soedja_freelance/old_ver/models/user.dart';
import 'package:soedja_freelance/old_ver/screens/auth/auth_screen.dart';
import 'package:soedja_freelance/old_ver/screens/feeds/detail_screen.dart';
import 'package:soedja_freelance/old_ver/screens/profile/info_screen.dart';
import 'package:soedja_freelance/old_ver/services/user.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';
import 'package:soedja_freelance/old_ver/utils/helpers.dart';
import 'package:soedja_freelance/old_ver/utils/local_storage.dart';
import 'package:soedja_freelance/old_ver/utils/navigation.dart';

class AccountScreen extends StatefulWidget {
  final Profile profile;

  AccountScreen({
    this.profile,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AccountScreen();
  }
}

List<dynamic> directoryList = [];
List<dynamic> policyList = [];
List<dynamic> privacyList = [];
List<dynamic> aboutList = [];

class _AccountScreen extends State<AccountScreen> {
  Profile profile = new Profile();

  double progress = 0.0;

  void fetchProfile() {
    setState(() {
      if (profile.village.length > 0) {
        progress = 1.0;
      } else {
        progress = 0.5;
      }
    });

    UserService().getProfile(context).then((value) async {
      setState(() {
        profile = value;
      });
    });
  }

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
    profile = widget.profile;
    fetchProfile();
    fetchDirectories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: AppColors.light,
      appBar: appBarSection(context: context, profile: profile),
      body: ListView(
        children: <Widget>[
          accountInfoSection(),
          dividerText(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Text(
              Strings.other,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          listMenu(),
          dividerText(
            height: 72.0,
            child: ButtonPrimary(
                buttonColor: AppColors.light,
                onTap: () => showLogout(
                    context: context,
                    onGhost: () => logout(context),
                    onPrimary: () => dismissDialog(context)),
                child: Text(
                  Strings.menuLogout,
                  style: TextStyle(color: AppColors.black, fontSize: 15.0),
                )),
          ),
        ],
      ),
    );
  }

  Widget accountInfoSection() {
    return ButtonPrimary(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      buttonColor: AppColors.white,
      onTap: () => Navigation().navigateScreen(
          context,
          ProfileInfoScreen(
            profile: profile,
          )),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Container(
                  color: AppColors.light,
                  child: FadeInImage.assetNetwork(
                    placeholder: avatar(profile.name),
                    image: profile.picture != null
                        ? BaseUrl.SoedjaAPI + '/${profile.picture}'
                        : '',
                    width: 40.0,
                    height: 40.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      Strings.editInfo,
                      style: TextStyle(
                        color: AppColors.dark.withOpacity(.5),
                        fontSize: 10.0,
                      ),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      profile.name,
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.grey707070,
                size: 16.0,
              ),
            ],
          ),
          Visibility(
            visible: progress < 1.0,
            child: dividerLine(height: 32.0),
          ),
          Visibility(
            visible: progress < 1.0,
            child: percentageBar(),
          ),
        ],
      ),
    );
  }

  Widget percentageBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          Strings.fillInfoDesc,
          style: TextStyle(
            color: AppColors.dark.withOpacity(.5),
            fontSize: 10.0,
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
                        color: AppColors.light,
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        flex: ((progress * 10).toInt()),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: SizedBox(
                            height: 8.0,
                            child: Container(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 10 - ((progress * 10).toInt()),
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
                '${(progress * 100).toInt()}%',
                style: TextStyle(color: AppColors.dark, fontSize: 12.0),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget listMenu() {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () => Navigation()
              .navigateScreen(context, otherMenuList[index]['menuScreen']),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                otherMenuList[index]['menuIcon'],
                SizedBox(width: 16.0),
                Expanded(
                  child: Text(
                    otherMenuList[index]['menuTitle'],
                    style: TextStyle(color: AppColors.black, fontSize: 15.0),
                  ),
                ),
                SizedBox(width: 16.0),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12.0,
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => Container(
          color: AppColors.white,
          child: dividerLine(indent: 16.0, endIndent: 16.0, height: 8.0)),
      itemCount: otherMenuList.length,
    );
  }
}

Widget appBarSection({BuildContext context, Profile profile}) {
  return AppBar(
    backgroundColor: AppColors.white,
    elevation: 1.0,
    textTheme: TextTheme(),
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: AppColors.black,
      ),
      onPressed: () => Navigation().navigateBack(context),
    ),
    title: Text(
      Strings.myAccount,
      style: TextStyle(
        color: AppColors.black,
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

void logout(BuildContext context) async {
  await LocalStorage.remove(LocalStorageKey.AuthToken);
  await LocalStorage.remove(LocalStorageKey.ShowInterest).then((value) {
    return Navigation().navigateReplacement(context, AuthScreen());
  });
}
