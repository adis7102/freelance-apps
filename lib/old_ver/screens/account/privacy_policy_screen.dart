import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soedja_freelance/old_ver/constants/assets.dart';
import 'package:soedja_freelance/old_ver/constants/strings.dart';
import 'package:soedja_freelance/old_ver/screens/account/account_screen.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';
import 'package:soedja_freelance/old_ver/utils/navigation.dart';

import 'expandable_screen.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  final String title;

  PrivacyPolicyScreen({
    this.title,
  });

  @override
  StatePrivacyPolicyScreen createState() => StatePrivacyPolicyScreen();
}

class StatePrivacyPolicyScreen extends State<PrivacyPolicyScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: appBarSection(),
        body: TabBarView(
          children: [
            ExpandableListScreen(
              list: directoryList,
            ),
            ExpandableListScreen(
              list: policyList,
            ),
            ExpandableListScreen(
              list: privacyList,
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
          color: AppColors.black,
        ),
        onPressed: () => Navigation().navigateBack(context),
      ),
      backgroundColor: AppColors.white,
      title: Text(
        widget.title,
        style: TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.bold,
          fontSize: 15.0,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.cloud_download,
            color: AppColors.black,
          ),
          onPressed: () => {},
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: .5,
                color: AppColors.black.withOpacity(.6),
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: TabBar(
            labelPadding: EdgeInsets.all(0),
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.black,
            labelStyle: TextStyle(
              fontSize: 12.0,
              fontFamily: Fonts.ubuntu,
            ),
            tabs: [
              Tab(text: Strings.directoryTitle.toUpperCase()),
              Tab(text: Strings.policyTitle.toUpperCase()),
              Tab(text: Strings.privacyTitle.toUpperCase()),
            ],
          ),
        ),
      ),
    );
  }
}
