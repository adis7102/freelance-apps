import 'package:flutter/material.dart';
import 'package:soedja_freelance/old_ver/constants/assets.dart';
import 'package:soedja_freelance/old_ver/constants/strings.dart';
import 'package:soedja_freelance/old_ver/screens/account/account_screen.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';
import 'package:soedja_freelance/old_ver/utils/navigation.dart';

import 'expandable_screen.dart';

class AboutSoedjaScreen extends StatefulWidget {
  final String title;

  AboutSoedjaScreen({
    this.title,
  });

  @override
  State<StatefulWidget> createState() {
    return _AboutSoedjaScreen();
  }
}

class _AboutSoedjaScreen extends State<AboutSoedjaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSection(),
      body: ExpandableListScreen(list: aboutList,),
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
            fontSize: 15.0,
            fontWeight: FontWeight.bold),
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
    );
  }
}
