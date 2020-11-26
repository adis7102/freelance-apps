import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soedja_freelance/old_ver/components/button.dart';
import 'package:soedja_freelance/old_ver/constants/assets.dart';
import 'package:soedja_freelance/old_ver/constants/lists.dart';
import 'package:soedja_freelance/old_ver/constants/strings.dart';
import 'package:soedja_freelance/old_ver/screens/feeds/detail_screen.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';
import 'package:soedja_freelance/old_ver/utils/navigation.dart';

class RateScreen extends StatefulWidget {
  final String title;

  RateScreen({
    this.title,
  });

  @override
  StateRateScreen createState() => StateRateScreen();
}

class StateRateScreen extends State<RateScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBarSection(),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 100.0,
                      width: 160.0,
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      AppColors.dark,
                                      AppColors.primaryDark
                                    ]),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50.0),
                                ),
                              ),
                              height: 100.0,
                              width: 100.0,
                              padding: EdgeInsets.all(20.0),
                              child: Image.asset(
                                Assets.imgLogoOnly,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 16.0,
                            top: 4.0,
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(24.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.black.withOpacity(.2),
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
                              child: Image.asset(
                                Assets.logoPlayStore,
                                height: 20.0,
                                width: 20.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          Strings.soedja,
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 4.0),
                        Text(
                          Strings.appFreelancer,
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                    dividerLine(height: 32.0),
                    Text(
                      Strings.soedjaAppFreelancerDesc,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 12.0,
                        height: 1.3
                      ),
                    ),
                  ],
                ),
              ),
              dividerText(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Text(
                  Strings.infoApp,
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          infoAppList[index]['label'],
                          style: TextStyle(
                              color: AppColors.dark.withOpacity(.5),
                              fontSize: 12.0),
                        ),
                        Text(
                          infoAppList[index]['value'],
                          style:
                              TextStyle(color: AppColors.black, fontSize: 12.0),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    dividerLine(indent: 16.0, endIndent: 16.0, height: 8.0),
                itemCount: infoAppList.length,
              ),
              dividerColor(height: 100),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 72.0,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    width: .5,
                    color: AppColors.dark.withOpacity(.3),
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 12.0,
              ),
              child: ButtonPrimary(
                buttonColor: AppColors.white,
                border: Border.all(color: AppColors.black, width: 1.0),
                child: Text(
                  Strings.writeReview.toUpperCase(),
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () => {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget appBarSection() {
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
        widget.title,
        style: TextStyle(
          color: AppColors.black,
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
