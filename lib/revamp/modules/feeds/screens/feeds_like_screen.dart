import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/feeds/bloc/feed_bloc.dart';
import 'package:soedja_freelance/revamp/modules/feeds/bloc/feed_state.dart';
import 'package:soedja_freelance/revamp/modules/feeds/components/feeds_component.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/like_models.dart';
import 'package:soedja_freelance/revamp/modules/profile/bloc/profile_bloc.dart';
import 'package:soedja_freelance/revamp/modules/profile/components/profile_components.dart';
import 'package:soedja_freelance/revamp/modules/profile/models/profile_models.dart';
import 'package:soedja_freelance/revamp/modules/profile/screens/profile_detail_screen.dart';

class FeedLikeScreen extends StatefulWidget {
  final Feed feed;
  final ProfileDetail authUser;

  const FeedLikeScreen({Key key, this.feed, @required this.authUser})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FeedLikeScreen();
  }
}

class _FeedLikeScreen extends State<FeedLikeScreen> {
  FeedBloc feedBloc = new FeedBloc();
  ScrollController listController = new ScrollController();
  int limit = 20;
  int page = 1;
  String title = "";
  List<LikeDetail> likeList = new List<LikeDetail>();
  bool isLoadMore = false;
  bool isEmpty = false;
  AuthBloc authBloc = new AuthBloc();
  ProfileDetail profileAuth = new ProfileDetail();
  ProfileBloc profileBloc = new ProfileBloc();

  @override
  void initState() {
    listController.addListener(scrollListener);
    getList();
    super.initState();
  }

  void getList() {
    feedBloc.requestGetLikes(context, widget.feed.portfolioId, limit, page);
  }

  void scrollListener() {
    if (listController.position.pixels >
        listController.position.maxScrollExtent -
            MediaQuery.of(context).size.width) {
      if (isLoadMore) {
        page++;
        likeList.add(LikeDetail());
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
        title: Text(
          "Likes",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtil().setSp(15)),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigation().navigateBack(context)),
        actions: <Widget>[],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          page = 1;
          getList();
          return;
        },
        child: StreamBuilder<LikeListState>(
            stream: feedBloc.getLikes,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.isLoading) {
                  if (page == 1) {
                    return ListView.separated(
                        padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                        itemBuilder: (context, index) {
                          return CardSearchProfileLoader(
                            context: context,
                            size: size,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(height: ScreenUtil().setHeight(40));
                        },
                        itemCount: 20);
                  }
                } else if (snapshot.data.hasError) {
                  onWidgetDidBuild(() {
                    if (snapshot.data.standby) {
                      showDialogMessage(context, snapshot.data.message,
                          "Terjadi Kesalahan, silahkan coba lagi");
                      feedBloc.unStandBy();
                    }
                  });
                  return Center(
                    child: Text(
                      snapshot.data.message,
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                } else if (snapshot.data.isSuccess) {
                  if (snapshot.data.standby) {
                    if (page < snapshot.data.data.payload.totalPage) {
                      isLoadMore = true;
                    } else {
                      isLoadMore = false;
                    }
                    if (page == 1) {
                      likeList = snapshot.data.data.payload.rows;
//
                      if (snapshot.data.data.payload.rows.length == 0) {
                        isEmpty = true;
                      } else {
                        isEmpty = false;
                      }
                    } else {
                      likeList.removeLast();
                      likeList.addAll(snapshot.data.data.payload.rows);
                    }
                  }
                  feedBloc.unStandBy();
                }
              }
              if (!isEmpty) {
                return ListView.separated(
                    padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                    controller: listController,
                    itemBuilder: (context, index) {
                      if (likeList[index].userId != null) {
                        return CardSearchProfileItem(
                          context: context,
                          size: size,
                          hasFollow: likeList[index].userData.hasFollow,
                          profile: likeList[index].userData,
                          authUser: widget.authUser,
                          onPressed: () => Navigation().navigateScreen(
                              context,
                              ProfileDetailScreen(
                                  before: 'like',
                                  profileDetail: likeList[index].userData,
                                  authUser: widget.authUser)),
                          onFollow: () async {
                            if (likeList[index].userData.hasFollow == 0) {
                              await profileBloc
                                  .createFollow(context,
                                  likeList[index].userData.userId)
                                  .then((response) {
                                if (response.code == "success") {
                                  setState(() {
                                    likeList[index].userData.hasFollow = 1;
                                  });
                                } else {
                                  showDialogMessage(context, response.message,
                                      "Terjadi kesalahan, silahkan coba lagi.");
                                }
                              });
                            } else {
                              await profileBloc
                                  .deleteFollow(context,
                                  likeList[index].userData.userId)
                                  .then((response) {
                                if (response.code == "success") {
                                  setState(() {
                                    likeList[index].userData.hasFollow = 0;
                                  });
                                } else {
                                  showDialogMessage(context, response.message,
                                      "Terjadi kesalahan, silahkan coba lagi.");
                                }
                              });
                            }
                          },
                        );
                      } else {
                        return CardSearchProfileLoader(
                          context: context,
                          size: size,
                        );
                      }
                    },
                    separatorBuilder: (context, index) {
                      return Divider(height: ScreenUtil().setHeight(40));
                    },
                    itemCount: likeList.length);
              } else {
                return EmptyFeeds();
              }
            }),
      ),
    );
  }
}
