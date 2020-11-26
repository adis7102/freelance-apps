import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/lists.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/account/components/interest_select_screen.dart';
import 'package:soedja_freelance/revamp/modules/account/screens/account_screen.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/auth/screens/select_interest_screen.dart';
import 'package:soedja_freelance/revamp/modules/category/bloc/category_bloc.dart';
import 'package:soedja_freelance/revamp/modules/dashboard/components/dashboard_components.dart';
import 'package:soedja_freelance/revamp/modules/feeds/bloc/feed_bloc.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';
import 'package:soedja_freelance/revamp/modules/feeds/screens/bookmark_screen.dart';
import 'package:soedja_freelance/revamp/modules/profile/models/profile_models.dart';
import 'package:soedja_freelance/revamp/modules/webview/screens/webview_screen.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';
import 'package:url_launcher/url_launcher.dart';

Widget LeadingDrawer(BuildContext context, _scaffoldKey) {
  return PreferredSize(
    preferredSize: AppBar().preferredSize,
    child: Container(
      height: AppBar().preferredSize.height,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom:
                  BorderSide(color: Colors.black.withOpacity(.5), width: .2))),
      child: IconButton(
        icon: Icon(
          Icons.menu,
          color: Colors.black,
        ),
        onPressed: () => _scaffoldKey.currentState.openDrawer(),
      ),
    ),
  );
}

Widget TitleAppBar({BuildContext context, Function onSearch, GlobalKey key}) {
  return PreferredSize(
    preferredSize: AppBar().preferredSize,
    child: Container(
      height: AppBar().preferredSize.height,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom:
                  BorderSide(color: Colors.black.withOpacity(.5), width: .2))),
      child: Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: onSearch,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.black.withOpacity(.5), width: .2),
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setSp(25))),
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(15),
                    vertical: ScreenUtil().setHeight(10)),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      color: Colors.black,
                      size: ScreenUtil().setSp(24),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    Text(
                      Texts.searchInspiration,
                      style: TextStyle(
                          color: Colors.black.withOpacity(.5),
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(10)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget MessageAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize: AppBar().preferredSize,
    child: Container(
      height: AppBar().preferredSize.height,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom:
                  BorderSide(color: Colors.black.withOpacity(.5), width: .2))),
      child: IconButton(
        icon: Stack(
          children: <Widget>[
            Icon(
              Icons.chat,
              color: Colors.black,
            ),
            Positioned(
              right: 0,
              child: new Container(
                padding: EdgeInsets.all(1),
                decoration: new BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: BoxConstraints(
                  minWidth: 12,
                  minHeight: 12,
                ),
                child: new Text(
                  '10',
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget BookmarkAppBar(
    BuildContext context, ProfileDetail authUser, AuthBloc authBloc) {
  return PreferredSize(
    preferredSize: AppBar().preferredSize,
    child: Container(
      width: AppBar().preferredSize.height,
      decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: Colors.black.withOpacity(.5), width: .2))),
      child: IconButton(
        icon: Container(
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(.05),
              borderRadius: BorderRadius.circular(ScreenUtil().setSp(25))),
          height: ScreenUtil().setHeight(40),
          width: ScreenUtil().setWidth(40),
          child: Icon(
            Icons.star_border,
            color: Colors.black,
          ),
        ),
        onPressed: () => Navigation().navigateScreen(
            context,
            BookmarkScreen(
              authUser: authUser,
              authBloc: authBloc,
            )),
      ),
    ),
  );
}

Widget DrawerHome(
  BuildContext context,
  AuthBloc authBloc,
  FeedBloc feedBloc,
  String version,
) {
  return Drawer(
    child: Column(
      children: <Widget>[
        SizedBox(height: ScreenUtil().setHeight(100)),
        Column(
          children: List.generate(drawerMenu.length, (index) {
            return ListTile(
              onTap: () {
                switch (index) {
                  case 0:
                    Navigation().navigateBack(context);
                    DialogSupportCenterWhatsapp(
                      context,
                      () async {
                        var whatsappUrl =
                            "whatsapp://send?phone=+6281278281501&text=Halo min, saya butuh bantuan nih mengenai aplikasi SOEDJA. Bisa dibantu?";
                        await canLaunch(whatsappUrl)
                            ? launch(whatsappUrl)
                            : showDialogMessage(context, "Gagal Buka Whatsapp",
                                "Terjadi kesalahan, silahkan coba lagi.");
                      },
                    );
                    break;
                  case 1:
                    Navigation().navigateBack(context);
                    Navigation().navigateScreen(
                        context,
                        WebViewScreen(
                          index: index,
                          title: drawerMenu[index]['title'],
                          url: "https://www.soedja.com/panduan",
                        ));
                    break;
                  case 2:
                    Navigation().navigateBack(context);
                    Navigation().navigateScreen(
                        context,
                        SelectInterestScreen(
                          authBloc: authBloc,
                          feedBloc: feedBloc,
                          before: "new_user",
                        ));
//                    InterestSelectScreen(
//                      context: context,
//                      authBloc: authBloc,
//                    );
                    break;
                  case 3:
                    Navigation().navigateBack(context);
                    Navigation().navigateScreen(
                        context,
                        AccountScreen(
                          authBloc: authBloc,
                        ));
                    break;
                  default:
                    Navigation().navigateBack(context);
                    print("Click");
                    break;
                }
              },
              contentPadding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              leading: drawerMenu[index]['icon'],
              title: Text(
                drawerMenu[index]['title'],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(15),
                  fontWeight: FontWeight.w300,
                ),
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: Colors.black.withOpacity(.5),
              ),
            );
          }),
        ),
        Expanded(child: Container()),
        Row(
          children: <Widget>[
            SizedBox(width: ScreenUtil().setWidth(30)),
            Image.asset(Images.imgLogo, width: ScreenUtil().setWidth(70)),
            Expanded(child: SizedBox(width: ScreenUtil().setWidth(30))),
            Text(
              Texts.freelanceAppVersion + version,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: ScreenUtil().setSp(10)),
            ),
            SizedBox(width: ScreenUtil().setWidth(30)),
          ],
        ),
        SizedBox(height: ScreenUtil().setHeight(30)),
      ],
    ),
  );
}

Widget TabHomeMenu(
  BuildContext context,
  int tabIndex,
  int index,
  List<GlobalKey> keyList,
  GlobalKey lastKey,
    Function onClose,
) {
  return Tab(
    icon: Container(
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(5),
      ),
      decoration: BoxDecoration(
          color: tabIndex == index ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(ScreenUtil().setSp(20)),
          border: Border.all(color: Colors.black.withOpacity(.5), width: .2)),
      padding: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(10),
          ScreenUtil().setHeight(5),
          ScreenUtil().setWidth(20),
          ScreenUtil().setWidth(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Showcase.withWidget(
            disableAnimation: true,
            key: keyList[index],
            container: contentTips(
                context: context,
                index: index,
                onNext: () => ShowCaseWidget.of(context).startShowCase(
                    index == 0
                        ? [keyList[1], keyList[2], keyList[3], lastKey]
                        : index == 1
                            ? [keyList[2], keyList[3], lastKey]
                            : index == 2 ? [keyList[3], lastKey] : [lastKey]),
                onClose: onClose),
            shapeBorder: CircleBorder(),
            width: 300,
            height: 120,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: tabIndex == index ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(20)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(ScreenUtil().setSp(20)),
                child: Image.asset(
                  listHomeMenu[index]['icon'],
                  height: ScreenUtil().setHeight(26),
                  width: ScreenUtil().setWidth(26),
                ),
              ),
            ),
          ),
          SizedBox(width: ScreenUtil().setWidth(10)),
          Text(
            listHomeMenu[index]['title'],
            style: TextStyle(
              color: tabIndex == index ? Colors.white : Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: ScreenUtil().setSp(12),
            ),
          ),
        ],
      ),
    ),
  );
}
