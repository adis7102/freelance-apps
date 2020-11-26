import 'package:flutter/material.dart';
import 'package:soedja_freelance/old_ver/components/button.dart';
import 'package:soedja_freelance/old_ver/constants/assets.dart';
import 'package:soedja_freelance/old_ver/constants/lists.dart';
import 'package:soedja_freelance/old_ver/constants/strings.dart';
import 'package:soedja_freelance/old_ver/screens/feeds/detail_screen.dart';
import 'package:soedja_freelance/old_ver/screens/portfolio/create_screen.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';

class WorksScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WorksScreen();
  }
}

class _WorksScreen extends State<WorksScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: bodySection(context: context, size: size),
    );
  }
}

Widget bodySection({BuildContext context, Size size}) {
  return Stack(
    children: <Widget>[
      ListView(
        padding: EdgeInsets.only(bottom: 40.0),
        children: <Widget>[
          SizedBox(height: 32.0),
          headerWorksSection(size: size),
          dividerColor(),
          comingSoonSection(context: context, size: size),
          dividerColor(),
          tipsSection(context: context, size: size),
        ],
      ),
      Container(
          margin: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0), color: AppColors.white),
          child: yellowBanner(
              title: Strings.worksTitleBanner, margin: EdgeInsets.all(0))),
    ],
  );
}

Widget headerWorksSection({Size size}) {
  return Container(
    width: size.width,
    height: size.width,
    alignment: Alignment.center,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            Strings.worksHeaderTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.black,
                height: 1.5,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Text(
            Strings.worksHeaderSubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.grey707070,
                height: 1.5,
                fontSize: 12.0),
          ),
        ),
        Image.asset(
          Assets.illustrationTwoHand,
          width: size.width,
          fit: BoxFit.fitWidth,
        ),
      ],
    ),
  );
}

Widget comingSoonSection({
  BuildContext context,
  Size size,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          Strings.comingSoonWorks,
          style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 12.0),
        ),
        SizedBox(height: 16.0),
        ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return ButtonPrimary(
                  buttonColor: AppColors.white,
                  border: Border.all(color: AppColors.grey707070, width: .2),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        listWorksComingSoon[index]['icon'],
                        width: 26.0,
                        height: 26.0,
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Text(
                          listWorksComingSoon[index]['title'],
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: 12.0),
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.black,
                      ),
                    ],
                  ));
            },
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(height: 8.0),
            itemCount: listWorksComingSoon.length)
      ],
    ),
  );
}

Widget tipsSection({BuildContext context, Size size}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          Strings.tipsForYou,
          style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 12.0),
        ),
        SizedBox(height: 16.0),
        Row(
          children: <Widget>[
            Expanded(
              child: ButtonPrimary(
                  padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
                  border: Border.all(color: AppColors.grey707070, width: .2),
                  buttonColor: AppColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.asset(Assets.iconNews, width: 26.0, height: 26.0),
                      SizedBox(height: 8.0),
                      Text(
                        Strings.tipsPortfolioTitle,
                        style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 10.0),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        Strings.tipsPortfolioSubtitle,
                        style: TextStyle(
                            color: AppColors.dark.withOpacity(.6),
                            height: 1.5,
                            fontSize: 10.0),
                      ),
                    ],
                  )),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: ButtonPrimary(
                padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
                  border: Border.all(color: AppColors.grey707070, width: .2),
                  buttonColor: AppColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.asset(Assets.iconNews, width: 26.0, height: 26.0),
                      SizedBox(height: 8.0),
                      Text(
                        Strings.tipsContentTitle,
                        style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 10.0),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        Strings.tipsContentSubtitle,
                        style: TextStyle(
                            color: AppColors.dark.withOpacity(.6),
                            height: 1.5,
                            fontSize: 10.0),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ],
    ),
  );
}
