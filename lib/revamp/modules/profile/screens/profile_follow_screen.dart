import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/feeds/bloc/feed_bloc.dart';
import 'package:soedja_freelance/revamp/modules/feeds/bloc/feed_state.dart';
import 'package:soedja_freelance/revamp/modules/feeds/components/feeds_component.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/like_models.dart';
import 'package:soedja_freelance/revamp/modules/profile/bloc/profile_bloc.dart';
import 'package:soedja_freelance/revamp/modules/profile/bloc/profile_state.dart';
import 'package:soedja_freelance/revamp/modules/profile/components/profile_components.dart';
import 'package:soedja_freelance/revamp/modules/profile/models/profile_models.dart';
import 'package:soedja_freelance/revamp/modules/profile/screens/profile_detail_screen.dart';

class ProfileFollowScreen extends StatefulWidget {
  final String before;
  final ProfileDetail profileDetail;
  final ProfileDetail authUser;

  const ProfileFollowScreen(
      {Key key, this.before, this.profileDetail, this.authUser})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProfileFollowScreen();
  }
}

class _ProfileFollowScreen extends State<ProfileFollowScreen> {
  ProfileBloc profileBloc = new ProfileBloc();
  ScrollController listController = new ScrollController();
  int limit = 20;
  int page = 1;
  String title = "";
  List<FollowingDetail> followingList = new List<FollowingDetail>();
  List<FollowerDetail> followerList = new List<FollowerDetail>();
  bool isLoadMore = false;
  bool isEmpty = false;

  @override
  void initState() {
    listController.addListener(scrollListener);
    getList();
    super.initState();
  }

  void getList() {
    if (widget.before == "follower") {
      profileBloc.requestProfileFollower(
          context, widget.profileDetail.userId, limit, page);
    } else {
      profileBloc.requestProfileFollowing(
          context, widget.profileDetail.userId, limit, page);
    }
  }

  void scrollListener() {
    if (listController.position.pixels >
        listController.position.maxScrollExtent -
            MediaQuery.of(context).size.width) {
      if (isLoadMore) {
        page++;
        if (widget.before == "follower") {
          followerList.add(FollowerDetail());
        } else {
          followingList.add(FollowingDetail());
        }
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
          widget.before == "follower" ? "Follower" : "Following",
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
        child: widget.before == "follower"
            ? ListFollower(context, size)
            : ListFollowing(context, size),
      ),
    );
  }

  Widget ListFollower(BuildContext context, Size size) {
    return StreamBuilder<GetFollowerState>(
        stream: profileBloc.getProfileFollower,
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
                  profileBloc.unStandBy();
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
                  followerList = snapshot.data.data.payload.rows;
//
                  if (snapshot.data.data.payload.rows.length == 0) {
                    isEmpty = true;
                  } else {
                    isEmpty = false;
                  }
                } else {
                  followerList.removeLast();
                  followerList.addAll(snapshot.data.data.payload.rows);
                }
              }
              profileBloc.unStandBy();
            }
          }
          if (!isEmpty) {
            return ListView.separated(
                padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                controller: listController,
                itemBuilder: (context, index) {
                  if (followerList[index].followerDetail.userId != null) {
                    return CardSearchProfileItem(
                      context: context,
                      size: size,
                      hasFollow: followerList[index].hasFollow,
                      profile: followerList[index].followerDetail,
                      authUser: widget.authUser,
                      onPressed: () => Navigation().navigateScreen(
                          context,
                          ProfileDetailScreen(
                            before: 'search',
//                            profile: followerList[index].followerDetail,
                            authUser: widget.authUser,
                            profileDetail: followerList[index].followerDetail,
                          )),
                      onFollow: () async {
                        if (followerList[index].hasFollow == 0) {
                          await profileBloc
                              .createFollow(context,
                                  followerList[index].followerDetail.userId)
                              .then((response) {
                            if (response.code == "success") {
                              setState(() {
                                followerList[index].hasFollow = 1;
                              });
                            } else {
                              showDialogMessage(context, response.message,
                                  "Terjadi kesalahan, silahkan coba lagi.");
                            }
                          });
                        } else {
                          await profileBloc
                              .deleteFollow(context,
                                  followerList[index].followerDetail.userId)
                              .then((response) {
                            if (response.code == "success") {
                              setState(() {
                                followerList[index].hasFollow = 0;
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
                itemCount: followerList.length);
          } else {
            return EmptyFeeds();
          }
        });
  }

  Widget ListFollowing(BuildContext context, Size size) {
    return StreamBuilder<GetFollowingState>(
        stream: profileBloc.getProfileFollowing,
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
                  profileBloc.unStandBy();
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
                  followingList = snapshot.data.data.payload.rows;
//
                  if (snapshot.data.data.payload.rows.length == 0) {
                    isEmpty = true;
                  } else {
                    isEmpty = false;
                  }
                } else {
                  followingList.removeLast();
                  followingList.addAll(snapshot.data.data.payload.rows);
                }
              }
              profileBloc.unStandBy();
            }
          }
          if (!isEmpty) {
            return ListView.separated(
                padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                controller: listController,
                itemBuilder: (context, index) {
                  if (followingList[index].followingDetail.userId != null) {
                    return CardSearchProfileItem(
                      context: context,
                      size: size,
                      hasFollow: followingList[index].hasFollow,
                      profile: followingList[index].followingDetail,
                      authUser: widget.authUser,
                      onPressed: () => Navigation().navigateScreen(
                          context,
                          ProfileDetailScreen(
                            before: 'search',

                            authUser: widget.authUser,
                            profileDetail: followerList[index].followerDetail,
//                            profile: followingList[index].followingDetail,
                          )),
                      onFollow: () async {
                        if (followingList[index].hasFollow == 0) {
                          await profileBloc
                              .createFollow(context,
                                  followingList[index].followingDetail.userId)
                              .then((response) {
                            if (response.code == "success") {
                              setState(() {
                                followingList[index].hasFollow = 1;
                              });
                            } else {
                              showDialogMessage(context, response.message,
                                  "Terjadi kesalahan, silahkan coba lagi.");
                            }
                          });
                        } else {
                          await profileBloc
                              .deleteFollow(context,
                                  followingList[index].followingDetail.userId)
                              .then((response) {
                            if (response.code == "success") {
                              setState(() {
                                followingList[index].hasFollow = 0;
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
                itemCount: followingList.length);
          } else {
            return EmptyFeeds();
          }
        });
  }
}
