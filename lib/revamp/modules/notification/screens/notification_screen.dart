import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/feeds/bloc/feed_bloc.dart';
import 'package:soedja_freelance/revamp/modules/feeds/bloc/feed_state.dart';
import 'package:soedja_freelance/revamp/modules/feeds/components/feeds_component.dart';
import 'package:soedja_freelance/revamp/modules/notification/bloc/notification_bloc.dart';
import 'package:soedja_freelance/revamp/modules/notification/bloc/notification_state.dart';
import 'package:soedja_freelance/revamp/modules/notification/components/notif_components.dart';
import 'package:soedja_freelance/revamp/modules/notification/models/notification_models.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/screens/detail_portfolio_screen.dart';
import 'package:soedja_freelance/revamp/modules/profile/bloc/profile_bloc.dart';
import 'package:soedja_freelance/revamp/modules/profile/models/profile_models.dart';

class NotificationScreen extends StatefulWidget {
  final AuthBloc authBloc;
  final ProfileDetail authUser;
  final FeedBloc feedBloc;

  const NotificationScreen(
      {Key key, this.authBloc, this.authUser, this.feedBloc})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NotificationScreen();
  }
}

class _NotificationScreen extends State<NotificationScreen> {
  ScrollController listController = new ScrollController();

  int limit = 10;
  int page = 1;
  String title = "";
  List<MessageData> notificationList = new List<MessageData>();
  bool isLoadMore = true;
  bool isEmpty = false;

  NotificationBloc notificationBloc = new NotificationBloc();
  ProfileBloc profileBloc = new ProfileBloc();

  @override
  void initState() {
    getList();
    listController.addListener(scrollListener);
    super.initState();
  }

  void getList() {
    notificationBloc.requestNotifList(context, limit, page);
  }

  void scrollListener() {
    if (listController.position.pixels >
        listController.position.maxScrollExtent -
            MediaQuery.of(context).size.width) {
      if (isLoadMore) {
        page++;
        notificationList.add(MessageData());
        getList();
        isLoadMore = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        textTheme: TextTheme(),
        automaticallyImplyLeading: false,
        title: Text(
          Texts.notification,
          style: TextStyle(
            color: Colors.black,
            fontSize: ScreenUtil().setSp(15),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<GetNotifState>(
          stream: notificationBloc.getNotif,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isLoading) {
                if (page == 1) {
                  return ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
                      itemBuilder: (BuildContext context, int index) {
                        return CardNotifLoader(context);
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                            height: ScreenUtil().setHeight(40),
                          ),
                      itemCount: 5);
                }
              } else if (snapshot.data.hasError) {
                onWidgetDidBuild(() {
                  if (snapshot.data.standby) {
                    showDialogMessage(context, snapshot.data.message,
                        "Terjadi Kesalahan, silahkan coba lagi");
                    notificationBloc.unStandBy();
                  }
                });
                return ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
                    itemBuilder: (BuildContext context, int index) {
                      return CardNotifLoader(context);
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                          height: ScreenUtil().setHeight(40),
                        ),
                    itemCount: 5);
              } else if (snapshot.data.isSuccess) {
                if (snapshot.data.standby) {
                  if (page < snapshot.data.data.payload.totalPage) {
                    isLoadMore = true;
                  } else {
                    isLoadMore = false;
                  }
                  if (page == 1) {
                    notificationList = snapshot.data.data.payload.rows;
                    notificationBloc.unStandBy();

                    if (notificationList.length == 0) {
                      isEmpty = true;
                    } else {
                      isEmpty = false;
                    }
                  } else {
                    notificationList.removeLast();
                    notificationList.addAll(snapshot.data.data.payload.rows);
                    notificationBloc.unStandBy();
                  }
                }
              }
            }
            if (!isEmpty) {
              return ListView.separated(
                  padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
                  shrinkWrap: true,
                  controller: listController,
                  itemBuilder: (BuildContext context, int index) {
                    if (notificationList[index].messageId != null) {
                      return CardNotifItem(
                          context: context,
                          messageData: notificationList[index],
                          onRead: () {
                            notificationBloc
                                .setRead(
                                    context, notificationList[index].messageId)
                                .then((response) {
                              if (response.code == "success") {
                                if (notificationList[index].type == "comment" ||
                                    notificationList[index].type == "like") {
                                  Navigation().navigateScreen(
                                      context,
                                      DetailPortfolioScreen(
                                        before: "profile",
                                        portfolioId: notificationList[index]
                                            .detail
                                            .message
                                            .contentId,
                                        profileDetail: widget.authUser,
                                        authUser: widget.authUser,
//                                      feedBloc: widget.feedBloc,
                                      ));
                                }
                              } else {
                                showDialogMessage(context, response.message,
                                    "Terjadi kesalahan, silahkan coba lagi");
                              }
                            });
                          });
                    } else {
                      return CardNotifLoader(context);
                    }
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                        height: ScreenUtil().setHeight(40),
                      ),
                  itemCount: notificationList.length);
            } else {
              return EmptyFeeds();
            }
          }),
    );
  }
}
