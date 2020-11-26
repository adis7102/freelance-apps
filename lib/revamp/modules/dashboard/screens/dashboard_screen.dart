import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info/package_info.dart';
import 'package:share/share.dart';
import 'package:showcaseview/showcase.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/lists.dart';
import 'package:soedja_freelance/revamp/assets/sharedpref_keys.dart';
import 'package:soedja_freelance/revamp/assets/urls.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/helpers/sharedpref_helper.dart';
import 'package:soedja_freelance/revamp/modules/account/components/interest_select_screen.dart';
import 'package:soedja_freelance/revamp/modules/account/screens/account_screen.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_state.dart';
import 'package:soedja_freelance/revamp/modules/auth/models/auth_models.dart';
import 'package:soedja_freelance/revamp/modules/auth/screens/select_interest_screen.dart';
import 'package:soedja_freelance/revamp/modules/auth/services/auth_service.dart';
import 'package:soedja_freelance/revamp/modules/category/bloc/category_bloc.dart';
import 'package:soedja_freelance/revamp/modules/dashboard/components/dashboard_components.dart';
import 'package:soedja_freelance/revamp/modules/feeds/bloc/feed_bloc.dart';
import 'package:soedja_freelance/revamp/modules/feeds/screens/explore_screen.dart';
import 'package:soedja_freelance/revamp/modules/home/components/appbar_component.dart';
import 'package:soedja_freelance/revamp/modules/home/screens/home_screen.dart';
import 'package:soedja_freelance/revamp/modules/notification/screens/notification_screen.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/screens/create_portfolio_screen.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/screens/detail_portfolio_screen.dart';
import 'package:soedja_freelance/revamp/modules/profile/models/profile_models.dart';
import 'package:soedja_freelance/revamp/modules/profile/screens/profile_detail_screen.dart';
import 'package:soedja_freelance/revamp/modules/profile/services/profile_services.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

class DashboardScreen extends StatefulWidget {
  final String before;

  const DashboardScreen({
    Key key,
    this.before,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DashboardScreen();
  }
}

class _DashboardScreen extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
//  BuildContext _context;

  int indexTab = 0;
  int homeIndex = 0;
  TabController dashboardController;
  PackageInfo packageInfo = new PackageInfo();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AuthBloc authBloc = new AuthBloc();
  FeedBloc feedBloc = new FeedBloc();
  ProfileDetail authUser = new ProfileDetail();
  bool showInterest = true;

  GlobalKey feedKey = GlobalKey();
  GlobalKey workKey = GlobalKey();
  GlobalKey studioKey = GlobalKey();
  GlobalKey qrcodeKey = GlobalKey();
  GlobalKey bookmarkKey = GlobalKey();
  GlobalKey searchKey = GlobalKey();
  GlobalKey exploreKey = GlobalKey();
  GlobalKey portfolioKey = GlobalKey();
  GlobalKey notificationKey = GlobalKey();
  GlobalKey accountKey = GlobalKey();

  BuildContext _context;

  @override
  void initState() {
    dashboardController =
        new TabController(vsync: this, length: 5, initialIndex: indexTab);
//    homeController =
//        new TabController(vsync: this, length: 4, initialIndex: homeIndex);
    initShowCase();
    getVersionCode();
    showInterestFeed();
    showMessage();
    getAuth();
    super.initState();
  }

  void initShowCase() {
    Future.delayed(Duration(milliseconds: 100), () {
      SharedPreference.get(SharedPrefKey.DashboardOnboard).then((value) async {
        if (value == null || value == "false") {
          WidgetsBinding.instance.addPostFrameCallback(
              (_) async => ShowCaseWidget.of(_context).startShowCase([
                    feedKey,
                    workKey,
                    studioKey,
                    qrcodeKey,
                    bookmarkKey,
                    searchKey,
                    exploreKey,
                    portfolioKey,
                    notificationKey,
                    accountKey,
                  ]));
        }
      });
    });
  }

  void getVersionCode() async {
    packageInfo = await PackageInfo.fromPlatform();
    setState(() {});
  }

  getAuth() {
    authBloc.requestGetProfile(context);
    authBloc.getProfileAuth(context).then((response) {
      if (response.code == "success") {
        initFireBase(context, response.payload.userId, packageInfo);
      }
    });
  }

  void showInterestFeed() {
    if (widget.before == "create_pin") {
      InterestSelectScreen(context: context, authBloc: authBloc);
    }
  }

  void showMessage() {
    if (widget.before == "create_pin") {
      Future.delayed(
          Duration(milliseconds: 250),
          () => showDialogMessage(context, "Hore! Selamat Datang di SOEDJA!",
              "Pendaftaran Kamu Berhasil dilakukan."));
    }
  }

  void showGuide(ProfileDetail authUser) {
    SharedPreference.set(SharedPrefKey.DashboardOnboard, "true");
    showFirstTipsDialog(
      context: context,
      authUser: authUser,
      onTap: (val) {
        Navigation().navigateBack(context);
        if (val == "portfolio") {
          Navigation().navigateScreen(
              context,
              CreatePortfolioScreen(
                authBloc: authBloc,
              ));
        } else if (val == "explore") {
          setState(() {
            indexTab = 1;
            dashboardController.animateTo(indexTab);
          });
        } else {
          setState(() {
            homeIndex = 2;
            changeIndex(homeIndex);
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;
    return ShowCaseWidget(
      onFinish: () {
        print("Finished");
        showGuide(authUser);
      },
      builder: Builder(
        builder: (context) {
          _context = context;
          return Scaffold(
            key: _scaffoldKey,
            drawer:
                DrawerHome(context, authBloc, feedBloc, packageInfo.version),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: dashboardController,
              children: [
                HomeScreen(
                  homeIndex: homeIndex,
                  onChangeIndex: (val) {
                    setState(() {
                      homeIndex = val;
                    });
                  },
                  authBloc: authBloc,
                  feedBloc: feedBloc,
                  authUser: authUser,
                  scaffoldKey: _scaffoldKey,
                  keyList: [
                    feedKey,
                    workKey,
                    studioKey,
                    qrcodeKey,
                    bookmarkKey,
                    searchKey,
                    exploreKey,
                  ],
                  onClose: () {
                    showGuide(authUser);
                  },
                ),
                ExploreScreen(
                  authBloc: authBloc,
                  authUser: authUser,
                ),
                Container(
                  color: Colors.white,
                ),
                NotificationScreen(
                  authBloc: authBloc,
                  authUser: authUser,
                  feedBloc: feedBloc,
                ),
                ProfileDetailScreen(
                  authUser: authUser,
                  authBloc: authBloc,
                  profileDetail: authUser,
                  before: "dashboard",
                ),
              ],
            ),
            backgroundColor: Colors.white,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: fabPortfolio(context),
            bottomNavigationBar: bottomNavigation(context),
          );
        },
      ),
    );
  }

  Widget fabPortfolio(BuildContext context) {
    return Showcase.withWidget(
      disableAnimation: true,
      key: portfolioKey,
      container: contentTips(
          context: context,
          index: 7,
          onNext: () {
            ShowCaseWidget.of(context)
                .startShowCase([notificationKey, accountKey]);
          },
        onClose: () {
          showGuide(authUser);
        },),
      shapeBorder: CircleBorder(),
      width: 300,
      height: 120,
      child: Container(
        width: 60.0,
        height: 60.0,
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35.0),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
                .3,
                .7,
                1.0
              ],
              colors: <Color>[
                ColorApps.dark,
                ColorApps.primaryDark,
                ColorApps.primary.withOpacity(.7),
              ]),
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 3.0),
            borderRadius: BorderRadius.circular(35.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.2),
                  blurRadius: 5,
                  offset: Offset(0.0, 4.0))
            ],
          ),
          child: IconButton(
              onPressed: () {
//                Navigation().navigateScreen(
//                    context,
//                    CreatePortfolioScreen(
//                      authBloc: authBloc,
//                    ));
                showGuide(authUser);
              },
              icon: Image.asset(
                Images.imgLogoOnlyWhite,
                height: 40.0,
                width: 40.0,
              )),
        ),
      ),
    );
  }

  Widget bottomNavigation(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(0, 2))
      ]),
      child: TabBar(
        controller: dashboardController,
        labelColor: ColorApps.primary,
        unselectedLabelColor: Colors.black.withOpacity(.5),
        indicatorSize: TabBarIndicatorSize.label,
        indicator: BoxDecoration(
          border: Border(
            top: BorderSide(color: ColorApps.primary, width: 3.0),
          ),
        ),
        onTap: (val) {
          print("$val");
//          setState(() {});
        },
        tabs: [
          Tab(icon: Icon(Icons.home)),
          Tab(
            icon: Showcase.withWidget(
              disableAnimation: true,
              key: exploreKey,
              container: contentTips(
                context: context,
                index: 6,
                onNext: () {
                  ShowCaseWidget.of(context).startShowCase(
                      [portfolioKey, notificationKey, accountKey]);
                },
                onClose: () {
                  showGuide(authUser);
                },
              ),
              shapeBorder: CircleBorder(),
              width: 300,
              height: 120,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.all(4),
                child: Icon(Icons.explore),
              ),
            ),
          ),
          Container(
            height: 1,
            width: 1,
          ),
          Tab(
            icon: Showcase.withWidget(
              disableAnimation: true,
              key: notificationKey,
              container: contentTips(
                  context: context,
                  index: 8,
                  onNext: () {
                    ShowCaseWidget.of(context).startShowCase([accountKey]);
                  },
                onClose: () {
                  showGuide(authUser);
                },),
              shapeBorder: CircleBorder(),
              width: 300,
              height: 120,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.all(4),
                child: Icon(Icons.notifications),
              ),
            ),
          ),
          Tab(
            icon: Showcase.withWidget(
              disableAnimation: true,
              key: accountKey,
              container: contentTips(
                  context: context,
                  index: 9,
                  onNext: () {
                    ShowCaseWidget.of(context).dismiss();
                    showGuide(authUser);
                  },
                onClose: () {
                  showGuide(authUser);
                },),
              shapeBorder: CircleBorder(),
              width: 300,
              height: 120,
              child: StreamBuilder<GetProfileState>(
                stream: authBloc.getProfile,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.isLoading) {
                    } else if (snapshot.data.hasError) {
                      if (snapshot.data.standby) {
                        onWidgetDidBuild(() {
                          showDialogMessage(context, snapshot.data.message,
                              "Terjadi kesalahan, silahkan coba lagi.");
                        });
                        authBloc.unStandBy();
                      }
                    } else if (snapshot.data.isSuccess) {
                      authUser = snapshot.data.data.payload;
                      onWidgetDidBuild(() {
                        setState(() {});
                        if (authUser.interests.length == 0 && showInterest) {
                          Navigation().navigateScreen(
                              context,
                              SelectInterestScreen(
                                authBloc: authBloc,
                                feedBloc: feedBloc,
                                before: "new_user",
                              ));
                          showInterest = false;
                        }
                      });
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        padding: EdgeInsets.all(4),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().setSp(18)),
                          child: Container(
                            width: 24,
                            color: Colors.black.withOpacity(.05),
                            child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child: FadeInImage.assetNetwork(
                                  placeholder: avatar(authUser.name ?? "A"),
                                  fit: BoxFit.cover,
                                  image: authUser.picture.length > 0
                                      ? BaseUrl.SoedjaAPI +
                                          "/" +
                                          authUser.picture
                                      : ""),
                            ),
                          ),
                        ),
                      );
                    }
                  }
                  return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.all(4),
                      child: Icon(Icons.account_circle));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<dynamic> notificationBackground(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
//    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
//    final dynamic notification = message['notification'];
  }

  print(message);
  await Notifikasi().showNotification(message['data']['title'],
      "Seseorang telah merespon portfolio kamu. Cek Sekarang");
}

void initFireBase(
    BuildContext context, String userId, PackageInfo packageInfo) async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationAppLaunchDetails notificationAppLaunchDetails;

  notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  // Note: permissions aren't requested here just to demonstrate that can be done later using the `requestPermissions()` method
  // of the `IOSFlutterLocalNotificationsPlugin` class
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {});
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    //selectNotificationSubject.add(payload);
  });

  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  _firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      notificationBackground(message);
      return null;
    },
    onResume: (Map<String, dynamic> message) async {
      notificationBackground(message);
      return null;
    },
    onBackgroundMessage: Platform.isIOS ? null : notificationBackground,
    onLaunch: (Map<String, dynamic> message) async {
      notificationBackground(message);
      return null;
    },
  );

  _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true));

  try {
    _firebaseMessaging.getToken().then(
      (token) async {
        AuthBloc()
            .requestUpdateTokenFCM(context, token, userId, packageInfo.version);
      },
    );
  } catch (e) {}
}

//notificationHandler(String type, Map<String, dynamic> message) {
//  print("$type $message");
////    showDialogMessage(context, message['data']['message'],
////        "Seseorang telah merespon portfolio kamu. Cek Sekarang");
//  showNotif(context, message, () {
//    ProfileService()
//        .getProfileDetail(context, message['data']['given_by_id'])
//        .then((response) {
//      if (response.code == "success") {
//        Navigation().navigateScreen(
//            context,
//            DetailPortfolioScreen(
//              before: "notif",
//              portfolioId: message['data']['parent_id'],
//              authUser: authUser,
//              profileDetail: response.payload,
//            ));
//      } else {
//        showDialogMessage(context, response.message,
//            "Terjadi Kesalahan, silahkan coba lagi");
//      }
//    });
//  });
//
////    authBloc.requestGetProfile(context);
//}
