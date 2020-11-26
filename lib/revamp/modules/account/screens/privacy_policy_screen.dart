import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/assets/fonts.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

import 'expandable_screen.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  final String title;
  final List<dynamic> directoryList;
  final List<dynamic> policyList;
  final List<dynamic> privacyList;

  PrivacyPolicyScreen({
    this.title, this.directoryList, this.policyList, this.privacyList,
  });

  @override
  StatePrivacyPolicyScreen createState() => StatePrivacyPolicyScreen();
}

class StatePrivacyPolicyScreen extends State<PrivacyPolicyScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: appBarSection(),
        body: TabBarView(
          children: [
            ExpandableListScreen(
              list: widget.directoryList,
            ),
            ExpandableListScreen(
              list: widget.policyList,
            ),
            ExpandableListScreen(
              list: widget.privacyList,
            ),
          ],
        ),
      ),
    );
  }

  Widget appBarSection() {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () => Navigation().navigateBack(context),
      ),
      backgroundColor: Colors.white,
      title: Text(
        widget.title,
        style: TextStyle(
          color: Colors.black,
          fontSize: ScreenUtil().setSp(15),
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.cloud_download,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ],
      bottom: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: .5,
                color: Colors.black.withOpacity(.5),
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
          child: TabBar(
            labelPadding: EdgeInsets.all(0),
            indicatorColor: ColorApps.primary,
            labelColor: ColorApps.primary,
            unselectedLabelColor: Colors.black,
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil().setSp(12),
              fontWeight: FontWeight.bold,
              fontFamily: Fonts.ubuntu,
            ),
            tabs: [
              Tab(text: Texts.directoryTitle.toUpperCase()),
              Tab(text: Texts.policyTitle.toUpperCase()),
              Tab(text: Texts.privacyTitle.toUpperCase()),
            ],
          ),
        ),
      ),
    );
  }
}
