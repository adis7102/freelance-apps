import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
import 'package:soedja_freelance/old_ver/models/category.dart';
import 'package:soedja_freelance/old_ver/models/feeds.dart';
import 'package:soedja_freelance/old_ver/models/notification.dart';
import 'package:soedja_freelance/old_ver/models/subcategory.dart';
import 'package:soedja_freelance/old_ver/models/typecategory.dart';
import 'package:soedja_freelance/old_ver/models/user.dart';
import 'package:soedja_freelance/push_notification.dart';
import 'package:soedja_freelance/old_ver/screens/account/account_screen.dart';
import 'package:soedja_freelance/old_ver/screens/bookmark/bookmark_screen.dart';
import 'package:soedja_freelance/old_ver/screens/events/events_screen.dart';
import 'package:soedja_freelance/old_ver/screens/explore/explore_screen.dart';
import 'package:soedja_freelance/old_ver/screens/feeds/feeds_screen.dart';
import 'package:soedja_freelance/old_ver/screens/interest/interest_screen.dart';
import 'package:soedja_freelance/old_ver/screens/news/news_screen.dart';
import 'package:soedja_freelance/old_ver/screens/notification/notification_screen.dart';
import 'package:soedja_freelance/old_ver/screens/podcast/podcast_screen.dart';
import 'package:soedja_freelance/old_ver/screens/portfolio/create_screen.dart';
import 'package:soedja_freelance/old_ver/screens/portfolio/portfolio_screen.dart';
import 'package:soedja_freelance/old_ver/screens/profile/profile_screen.dart';
import 'package:soedja_freelance/old_ver/screens/search/search_home_screen.dart';
import 'package:soedja_freelance/old_ver/screens/videos/videos_screen.dart';
import 'package:soedja_freelance/old_ver/screens/webview/webview_screen.dart';
import 'package:soedja_freelance/old_ver/screens/works/works_screen.dart';
import 'package:soedja_freelance/old_ver/services/category.dart';
import 'package:soedja_freelance/old_ver/services/feeds.dart';
import 'package:soedja_freelance/old_ver/services/notification.dart';
import 'package:soedja_freelance/old_ver/services/push_notification.dart';
import 'package:soedja_freelance/old_ver/services/user.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';
import 'package:soedja_freelance/old_ver/utils/helpers.dart';
import 'package:soedja_freelance/old_ver/utils/local_storage.dart';
import 'package:soedja_freelance/old_ver/utils/navigation.dart';

class DashboardScreen extends StatefulWidget {
  final int index;

  DashboardScreen({
    this.index = 0,
  });

  @override
  State<StatefulWidget> createState() {
    return _DashboardScreen();
  }
}

class _DashboardScreen extends State<DashboardScreen> {
  int index = 0;
  int indexCategory;

  bool isRefresh = false;
  ScrollController controller = new ScrollController();

  Profile profile = new Profile();

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  String tokenFCM = '';

  JwtData jwtData = new JwtData();

  void fetchProfile() {
    UserService().getProfile(context).then((value) async {
      setState(() {
        profile = value;
      });
    });
  }

  void initDevice() async {
    await initPlatformState(deviceInfoPlugin).then((value) async {
      if (value != null) {
        _deviceData = value;
        print('Device data $_deviceData');
      }
    });
  }

  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  bool showDialog = false;

  void dismissDialogNotif() {
    if (showDialog) {
      showDialog = false;
    }
  }

  Future initFCM() async {
    if (Platform.isIOS) {
      _firebaseMessaging
          .requestNotificationPermissions(IosNotificationSettings());
    }

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage $message");
        if (showDialog) {
          Navigation().navigateBack(context);
          dismissDialogNotif();
        }

        showDialog = true;
        showNotifications(
            context: context,
            title: message['data']['message'],
            description: 'Klik disini untuk melihat notifikasi.',
            onClose: dismissDialogNotif);

        Future.delayed(Duration(seconds: 3), () {
          if (showDialog) {
            Navigation().navigateBack(context);
          }
          dismissDialogNotif();
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume $message");
      },
    );

    _firebaseMessaging.getToken().then((String token) async {
      if (token != null) {
        tokenFCM = token;
      }
      updateTokenFCM();
    });
  }

  void updateTokenFCM() {
    UpdateTokenPayload payload = new UpdateTokenPayload(
        userId: jwtData.userId,
        device: Platform.isIOS ? 'ios' : 'android',
        os: _deviceData['version.baseOS'] != null
            ? _deviceData['version.baseOS']
            : 'lolipop',
        osVersion: _deviceData['version.release'],
        appVersion: '1.0.0',
        brand: _deviceData['brand'] ?? 'samsung',
        brandType: _deviceData['device'] ?? 'samsung A10',
        token: tokenFCM ?? '');

    NotificationService().updateToken(context, payload).then((response) {
      if (response) {
        print(response);
      }
    });
  }

  @override
  void initState() {
    index = widget.index;
    indexCategory = 0;
    fetchProfile();
    initDevice();
//    initJwt();
    initFCM();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBarSection(
        context: context,
        index: index,
        indexCategory: indexCategory,
        size: size,
        controller: controller,
        onChanged: (val) {
          if (indexCategory != val) {
            if (val == 0 || val == 1) {
              setState(() {
                indexCategory = val;
              });
            } else {
              Navigation().navigateScreen(
                  context,
                  WebViewScreen(
                    index: val,
                    title: listCategoryHome[val]['title'],
                  ));
            }
          }
        },
      ),
      drawer: drawerSection(
          context: context,
          index: indexCategory,
          onChanged: (val) {
            if (indexCategory != val) {
              setState(() {
                indexCategory = val;
              });
              controller.animateTo((70.0 * indexCategory),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut);
            }
          }),
      body: bodySection(
        context: context,
        index: index,
        indexCategory: indexCategory,
        isRefresh: isRefresh,
        profile: profile,
      ),
      floatingActionButton: fabSection(
          context: context,
          index: index,
          onTap: () {
//            if (index != listDashboardMenu[2]['index']) {
//              setState(() {
//                index = listDashboardMenu[2]['index'];
//              });
//            }
            Navigation().navigateScreen(context, PortfolioCreateScreen());
//            showNotifications(
//                context: context,
//                title:
//                    'Firmansyah memberikan Firmansyah memberikan komentar di portofolio kamu',
//                description: 'Klik disini untuk melihat notifikasi.',
//                onClose: dismissDialogNotif);
          }),
      bottomNavigationBar: bottomNavBarSection(
        context: context,
        index: index,
        onTap: (data) {
          if (index != listDashboardMenu[data]['index']) {
            setState(() {
              index = listDashboardMenu[data]['index'];
            });
          }
        },
        profile: profile,
        size: size,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

Widget appBarSection({
  BuildContext context,
  int index,
  int indexCategory,
  Category category,
  SubCategory subCategory,
  TypeCategory typeCategory,
  Size size,
  Function(int) onChanged,
  Function(Category) onChangedCategory,
  Function(SubCategory) onChangedSubCategory,
  Function(TypeCategory) onChangedTypeCategory,
  ScrollController controller,
  List<Category> categoryList,
  List<SubCategory> subCategoryList,
  List<TypeCategory> typeCategoryList,
}) {
  if (index == 0) {
    return AppBar(
      backgroundColor: AppColors.white,
      iconTheme: IconThemeData(),
      elevation: 1.0,
      title: Container(
        height: 50.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.center,
        child: ButtonPrimary(
            context: context,
            onTap: () => Navigation().navigateScreen(
                context,
                SearchHomeScreen(
                  onUpdate: () => Navigation().navigateBack(context),
                )),
            height: 40.0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Icon(
                  Icons.search,
                  color: AppColors.black,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Text(
                    Strings.searchInspiration,
                    maxLines: 1,
                    style: TextStyle(
                      color: AppColors.dark.withOpacity(.6),
                      fontSize: 10.0,
                    ),
                  ),
                )
              ],
            ),
            buttonColor: AppColors.white,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: AppColors.grey707070, width: .2),
            padding: EdgeInsets.symmetric(horizontal: 16.0)),
      ),
      actions: <Widget>[
        Row(
          children: <Widget>[
            ButtonPrimary(
                context: context,
                onTap: () => Navigation().navigateScreen(
                    context,
                    BookmarkScreen(
                      onUpdate: () => Navigation().navigateBack(context),
                    )),
                height: 40.0,
                width: 40.0,
                child: Icon(
                  Icons.bookmark_border,
                  color: AppColors.black,
                ),
                buttonColor: AppColors.light,
                borderRadius: BorderRadius.circular(20.0),
                splashColor: AppColors.green,
                padding: EdgeInsets.all(0.0)),
            SizedBox(width: 16.0),
          ],
        )
      ],
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: categorySection(
              context: context,
              indexCategory: indexCategory,
              size: size,
              onChanged: (val) => onChanged(val),
              controller: controller)),
    );
  }
  return null;
}

Widget categorySection({
  BuildContext context,
  int indexCategory,
  Size size,
  Function(int) onChanged,
  ScrollController controller,
}) {
  return Container(
    height: 50.0,
    width: size.width,
    decoration: BoxDecoration(
        color: AppColors.white,
        border:
            Border(top: BorderSide(color: AppColors.grey707070, width: .2))),
    child: ListView.separated(
      controller: controller,
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      separatorBuilder: (BuildContext context, int index) => SizedBox(
        width: 8.0,
      ),
      itemCount: listCategoryHome.length,
      itemBuilder: (BuildContext context, int index) {
        return ButtonPrimary(
          onTap: () => onChanged(index),
          buttonColor:
              indexCategory == index ? AppColors.black : AppColors.white,
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(
              color: AppColors.grey707070,
              width: indexCategory == index ? 0 : .2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                listCategoryHome[index]['icon'],
                height: 26.0,
                width: 26.0,
              ),
              SizedBox(width: 8.0),
              Text(
                listCategoryHome[index]['title'],
                style: TextStyle(
                    color: indexCategory == index
                        ? AppColors.white
                        : AppColors.black,
                    fontSize: 10.0),
              ),
              Visibility(
                visible: index == 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10.0)),
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                  margin: EdgeInsets.only(left: 4.0),
                  child: Text(
                    'Soon'.toUpperCase(),
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 6.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

Widget drawerSection(
    {BuildContext context, int index, Function(int) onChanged}) {
  return Drawer(
    child: ListView(
      shrinkWrap: true,
      padding: EdgeInsets.fromLTRB(24.0, 52.0, 24.0, 24.0),
      children: <Widget>[
        Text(
          Strings.comingSoon,
          style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 12.0),
        ),
        SizedBox(
          height: 16.0,
        ),
        ButtonPrimary(
            context: context,
            buttonColor: AppColors.white,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: AppColors.grey707070, width: .2),
            onTap: () {
              onChanged(1);
              Navigation().navigateBack(context);
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  listCategoryHome[1]['icon'],
                  height: 26.0,
                  width: 26.0,
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 4.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Cari ' + listCategoryHome[1]['title'],
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: AppColors.black,
                            size: 20.0,
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        listCategoryHome[1]['subtitle'],
                        style: TextStyle(
                          color: AppColors.black.withOpacity(.6),
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
        SizedBox(
          height: 16.0,
        ),
        Text(
          Strings.explore,
          style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 12.0),
        ),
        ListView.separated(
            padding: EdgeInsets.all(0),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              if (index != 0 && index != 1) {
                return ButtonPrimary(
                    context: context,
                    buttonColor: AppColors.white,
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: AppColors.grey707070, width: .2),
                    onTap: () {
                      onChanged(index);
                      Navigation().navigateBack(context);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          listCategoryHome[index]['icon'],
                          height: 26.0,
                          width: 26.0,
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 4.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    listCategoryHome[index]['title'],
                                    style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: AppColors.black,
                                    size: 20.0,
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                listCategoryHome[index]['subtitle'],
                                style: TextStyle(
                                  color: AppColors.black.withOpacity(.6),
                                  fontSize: 10.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ));
              }
              return Container();
            },
            separatorBuilder: (BuildContext context, int index) => SizedBox(
                  height: 8.0,
                ),
            itemCount: listCategoryHome.length),
        SizedBox(height: 32.0),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset(
              Assets.imgLogo,
              height: 20.0,
              fit: BoxFit.fitHeight,
            ),
            Text(
              Strings.appVersion,
              style: TextStyle(
                  color: AppColors.black.withOpacity(.6), fontSize: 8.0),
            )
          ],
        ),
      ],
    ),
  );
}

Widget fabSection({BuildContext context, int index, Function onTap}) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.white, width: 3.0),
      borderRadius: BorderRadius.circular(35.0),
      boxShadow: [
        BoxShadow(
            color: AppColors.black.withOpacity(.2),
            blurRadius: 5,
            offset: Offset(0.0, 4.0))
      ],
    ),
    child: ButtonPrimary(
        context: context,
        onTap: onTap,
        width: 60.0,
        height: 60.0,
        borderRadius: BorderRadius.circular(35.0),
        linearGradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [
              .3,
              .7,
              1.0
            ],
            colors: <Color>[
              AppColors.dark,
              AppColors.primaryDark,
              AppColors.primary.withOpacity(.7),
            ]),
        child: Image.asset(
          index == listDashboardMenu[2]['index']
              ? Assets.imgLogoOnly
              : Assets.imgLogoOnlyWhite,
          height: 40.0,
          width: 40.0,
        )),
  );
}

Widget bottomNavBarSection({
  BuildContext context,
  int index,
  Size size,
  Function(int) onTap,
  Profile profile,
}) {
  return BottomAppBar(
    clipBehavior: Clip.antiAlias,
    child: Container(
      height: 50.0,
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(listDashboardMenu.length, (data) {
          if (data != 2 && data != 4) {
            return Container(
              height: 50.0,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: index == listDashboardMenu[data]['index']
                              ? AppColors.primary
                              : AppColors.white,
                          width: 5.0))),
              child: ButtonPrimary(
                  context: context,
                  width: size.width / 5 - 20,
                  buttonColor: AppColors.white,
                  child: Icon(
                    listDashboardMenu[data]['icon'],
                    color: index == listDashboardMenu[data]['index']
                        ? AppColors.primary
                        : AppColors.black,
                  ),
                  onTap: () => onTap(data)),
            );
          } else if (data == 4) {
            return Container(
              height: 50.0,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: index == listDashboardMenu[data]['index']
                              ? AppColors.primary
                              : AppColors.white,
                          width: 5.0))),
              child: ButtonPrimary(
                  padding: EdgeInsets.symmetric(horizontal: 0.0),
                  context: context,
                  width: size.width / 5 - 20,
                  buttonColor: AppColors.white,
                  child: profile.picture != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: FadeInImage.assetNetwork(
                            placeholder: avatar(profile.name),
                            image: BaseUrl.SoedjaAPI +
                                '/' +
                                (profile.picture ?? ''),
                            height: 24.0,
                            width: 24.0,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Icon(
                          listDashboardMenu[data]['icon'],
                          color: index == listDashboardMenu[data]['index']
                              ? AppColors.primary
                              : AppColors.black,
                        ),
                  onTap: () => onTap(data)),
            );
          } else {
            return Container(
              width: size.width / 5 - 10,
            );
          }
        }),
      ),
    ),
  );
}

Widget bodySection({
  BuildContext context,
  int index,
  int indexCategory,
  Category category,
  SubCategory subCategory,
  TypeCategory typeCategory,
  bool isRefresh,
  Profile profile,
}) {
  switch (index) {
    case 0:
      switch (indexCategory) {
        case 0:
          return FeedsScreen(
            profile: profile,
          );
          break;
        case 1:
          return WorksScreen();
          break;
        case 2:
          return PodCastScreen();
          break;
        case 3:
          return NewsScreen();
          break;
        case 4:
          return VideosScreen();
          break;
        case 5:
          return EventsScreen();
          break;
        default:
          return FeedsScreen(
            profile: profile,
          );
      }
      break;
    case 1:
      return ExploreScreen(
        category: category,
        subCategory: subCategory,
        typeCategory: typeCategory,
      );
      break;
    case 2:
      return PortfolioScreen();
      break;
    case 3:
      return NotificationScreen();
      break;
    case 4:
      return ProfileScreen(
        profile: profile,
        feeds: Feeds(),
      );
      break;
    default:
      return ExploreScreen(
        category: category,
        subCategory: subCategory,
        typeCategory: typeCategory,
      );
      break;
  }
}
