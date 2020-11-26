import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';

import 'expandable_screen.dart';

class AboutSoedjaScreen extends StatefulWidget {
  final String title;
  final List<dynamic> aboutList;

  AboutSoedjaScreen({
    this.title, this.aboutList,
  });

  @override
  State<StatefulWidget> createState() {
    return _AboutSoedjaScreen();
  }
}

class _AboutSoedjaScreen extends State<AboutSoedjaScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBarSection(),
      body: ExpandableListScreen(list: widget.aboutList,),
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
          fontWeight: FontWeight.bold,),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.cloud_download,
            color: Colors.black,
          ),
          onPressed: (){},
        ),
      ],
    );
  }
}
