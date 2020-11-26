import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/auth/services/auth_service.dart';
import 'package:soedja_freelance/revamp/modules/category/bloc/category_bloc.dart';
import 'package:soedja_freelance/revamp/modules/feeds/bloc/feed_bloc.dart';
import 'package:soedja_freelance/revamp/modules/feeds/bloc/feed_state.dart';
import 'package:soedja_freelance/revamp/modules/feeds/components/feeds_component.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';
import 'package:soedja_freelance/revamp/modules/home/components/appbar_component.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/screens/detail_portfolio_screen.dart';
import 'package:soedja_freelance/revamp/modules/profile/bloc/profile_bloc.dart';
import 'package:soedja_freelance/revamp/modules/profile/bloc/profile_state.dart';
import 'package:soedja_freelance/revamp/modules/profile/components/profile_components.dart';
import 'package:soedja_freelance/revamp/modules/profile/models/profile_models.dart';
import 'package:soedja_freelance/revamp/modules/profile/screens/profile_detail_screen.dart';

class SearchProfileScreen extends StatefulWidget {
  final AuthBloc authBloc;
  final ProfileDetail profileAuth;
  final ProfileBloc profileBloc;
  final String title;

  SearchProfileScreen({
    Key key,
    this.authBloc,
    this.profileBloc,
    this.title,
    this.profileAuth,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchProfileScreen();
  }
}

class _SearchProfileScreen extends State<SearchProfileScreen> {
  ScrollController listController = new ScrollController();
  int limit = 20;
  int page = 1;
  String title = "";
  List<ProfileDetail> profileList = new List<ProfileDetail>();
  bool isLoadMore = false;
  bool isEmpty = false;

//  ProfileDetail profileAuth = new ProfileDetail();

  @override
  void initState() {
    title = widget.title;
    getList();
//    getAuth();
    listController.addListener(scrollListener);
    super.initState();
  }

  void getList() {
    if (widget.title.length > 0) {
      isEmpty = false;
      widget.profileBloc
          .requestSearchProfile(context, limit, page, widget.title);
    } else {
      isEmpty = true;
    }
  }

//  getAuth() {
//    AuthServices().getProfile(context).then((response) {
//      if (response.code == "success") {
//        setState(() {
//          profileAuth = response.payload;
//        });
//      } else {
//        showDialogMessage(
//            context, response.message, "Terjadi kesalahan, silahkan coba lagi");
//      }
//    });
//  }

  void scrollListener() {
    if (listController.position.pixels >
        listController.position.maxScrollExtent -
            MediaQuery.of(context).size.width) {
      if (isLoadMore) {
        page++;
        profileList.add(ProfileDetail());
        getList();
        isLoadMore = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;

    return RefreshIndicator(
      onRefresh: () async {
        page = 1;
        getList();
        return;
      },
      child: StreamBuilder<SearchProfileListState>(
          stream: widget.profileBloc.getSearchProfile,
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
                    widget.profileBloc.unStandBy();
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
                    profileList = snapshot.data.data.payload.rows;
//
                    if (snapshot.data.data.payload.rows.length == 0) {
                      isEmpty = true;
                    } else {
                      isEmpty = false;
                    }
                  } else {
                    profileList.removeLast();
                    profileList.addAll(snapshot.data.data.payload.rows);
                  }
                }
                widget.profileBloc.unStandBy();
              }
            }
            if (!isEmpty) {
              return ListView.separated(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                  controller: listController,
                  itemBuilder: (context, index) {
                    if (profileList[index].userId != null) {
                      return CardSearchProfileItem(
                        context: context,
                        size: size,
                        profile: profileList[index],
                        authUser: widget.profileAuth,
                        onPressed: () => Navigation().navigateScreen(
                            context,
                            ProfileDetailScreen(
                              before: 'search',
//                              profile: profileList[index],
//                              profileAuth: widget.profileAuth,
                            )),
                        onFollow: () async {
                          if (profileList[index].hasFollow == 0) {
                            await widget.profileBloc
                                .createFollow(
                                    context, profileList[index].userId)
                                .then((response) {
                              if (response.code == "success") {
                                setState(() {
                                  profileList[index].hasFollow = 1;
                                });
                              } else {
                                showDialogMessage(context, response.message,
                                    "Terjadi kesalahan, silahkan coba lagi.");
                              }
                            });
                          } else {
                            await widget.profileBloc
                                .deleteFollow(
                                    context, profileList[index].userId)
                                .then((response) {
                              if (response.code == "success") {
                                setState(() {
                                  profileList[index].hasFollow = 0;
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
                  itemCount: profileList.length);
            } else {
              return EmptyFeeds();
            }
          }),
    );
  }
}
