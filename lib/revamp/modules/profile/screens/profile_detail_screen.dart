import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/account/components/share_components.dart';
import 'package:soedja_freelance/revamp/modules/account/screens/account_screen.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/auth/models/auth_models.dart';
import 'package:soedja_freelance/revamp/modules/auth/services/auth_service.dart';
import 'package:soedja_freelance/revamp/modules/feeds/bloc/feed_bloc.dart';
import 'package:soedja_freelance/revamp/modules/feeds/bloc/feed_state.dart';
import 'package:soedja_freelance/revamp/modules/feeds/components/feeds_component.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/models/portfolio_models.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/screens/detail_portfolio_screen.dart';
import 'package:soedja_freelance/revamp/modules/profile/bloc/profile_bloc.dart';
import 'package:soedja_freelance/revamp/modules/profile/bloc/profile_state.dart';
import 'package:soedja_freelance/revamp/modules/profile/components/profile_components.dart';
import 'package:soedja_freelance/revamp/modules/profile/models/profile_models.dart';
import 'package:soedja_freelance/revamp/modules/qrcode/components/qrcode_components.dart';

class ProfileDetailScreen extends StatefulWidget {
  final ProfileDetail profileDetail;
  final ProfileDetail authUser;
  final AuthBloc authBloc;
  final String before;
  final Function(ProfileDetail) onEdit;

  ProfileDetailScreen({
    Key key,
    @required this.authUser,
    this.before,
    this.profileDetail,
    this.onEdit,
    this.authBloc,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProfileDetailScreen();
  }
}

class _ProfileDetailScreen extends State<ProfileDetailScreen> {
  ProfileBloc profileBloc = new ProfileBloc();
  FeedBloc feedBloc = new FeedBloc();

  ProfileDetail profileDetail = new ProfileDetail();

  bool showAll = false;

  ProfileFollow profileFollow = new ProfileFollow(following: 0, follower: 0);
  ScrollController listController = new ScrollController();
  int limit = 4;
  int page = 1;
  String title = "";
  List<Feed> feedList = new List<Feed>();
  bool isLoadMore = false;
  bool isEmpty = false;

  @override
  void initState() {
    setProfile();
    getProfileFollow();
    getPortfolioProfile();
    listController.addListener(scrollListener);
    super.initState();
  }

  void scrollListener() {
    if (listController.position.pixels >
        listController.position.maxScrollExtent -
            MediaQuery.of(context).size.width) {
      if (isLoadMore) {
        page++;
        feedList.add(Feed());
        feedList.add(Feed());
        getPortfolioProfile();
        isLoadMore = false;
      }
    }
  }

  setProfile() {
    profileBloc.requestProfileDetail(context, widget.profileDetail.userId);
  }

  getProfileFollow() {
    profileBloc.profileService
        .getProfileFollow(context, widget.profileDetail.userId)
        .then((response) {
      if (response.code == "success") {
        setState(() {
          profileFollow = response.payload;
        });
      } else {
        showDialogMessage(context, response.message,
            "Terjadi kesalahan, silahkan coba lagi.");
      }
    });
  }

  getPortfolioProfile() {
    feedBloc.requestPortfolioUser(
        context, limit, page, widget.profileDetail.userId);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        automaticallyImplyLeading: false,
        title: widget.before == "dashboard"
            ? Text(
                Texts.myProfile,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(15),
                  fontWeight: FontWeight.bold,
                ),
              )
            : Text(
                "",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(15),
                  fontWeight: FontWeight.bold,
                ),
              ),
        leading: widget.before != "dashboard"
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: () => Navigation().navigateBack(context))
            : null,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.black,
            ),
            onPressed: () => shareApp(context),
          ),
          IconButton(
            icon: Image.asset(
              Images.iconQrBlack,
              width: ScreenUtil().setWidth(20),
            ),
            onPressed: () => DialogQRUser(context, widget.profileDetail.userId),
          ),
          Visibility(
            visible: widget.before == "dashboard",
            child: IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onPressed: () => Navigation().navigateScreen(
                  context,
                  AccountScreen(
                    authBloc: widget.authBloc,
//                    profileAuth: widget.profileAuth,
                      )),
            ),
          ),
          SizedBox(width: ScreenUtil().setWidth(10)),
        ],
      ),
      body: StreamBuilder<ProfileDetailState>(
          stream: profileBloc.getDetail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isLoading) {
                return ProfileDetailLoader(context);
              } else if (snapshot.data.hasError) {
                return ProfileDetailLoader(context);
              } else if (snapshot.data.isSuccess) {
                profileDetail = snapshot.data.data.payload;
                return ListView(
                  controller: listController,
                  children: <Widget>[
                    ProfileDetailContent(
                      context: context,
                      authBloc: widget.authBloc,
                      size: size,
                      profileDetail: profileDetail,
                      authUser: widget.authUser,
                      showAll: showAll,
                      isShow: (val) {
                        setState(() {
                          showAll = val;
                        });
                      },
                      profileFollow: profileFollow,
                      onFollow: () async {
                        if (profileDetail.hasFollow == 0) {
                          await profileBloc
                              .createFollow(
                                  context, profileDetail.userId)
                              .then((response) {
                            if (response.code == "success") {
                              setState(() {
                                profileDetail.hasFollow = 1;
                                widget.profileDetail.hasFollow = 1;
                              });
                              getProfileFollow();
                            } else {
                              showDialogMessage(context, response.message,
                                  "Terjadi kesalahan, silahkan coba lagi.");
                            }
                          });
                        } else {
                          await profileBloc
                              .deleteFollow(
                                  context, profileDetail.userId)
                              .then((response) {
                            if (response.code == "success") {
                              setState(() {
                                profileDetail.hasFollow = 0;
                                widget.profileDetail.hasFollow = 0;
                              });
                              getProfileFollow();
                            } else {
                              showDialogMessage(context, response.message,
                                  "Terjadi kesalahan, silahkan coba lagi.");
                            }
                          });
                        }
                      },
                    ),
                    StreamBuilder<PortfolioListState>(
                        stream: feedBloc.getPortfolioUser,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.isLoading) {
                              if (page == 1) {
                                return SingleChildScrollView(
                                  padding:
                                      EdgeInsets.all(ScreenUtil().setWidth(10)),
                                  child: Wrap(
                                    spacing: ScreenUtil().setWidth(10),
                                    runSpacing: ScreenUtil().setHeight(10),
                                    children: List.generate(4, (index) {
                                      return CardSearchFeedsLoader(
                                        context: context,
                                        size: size,
                                      );
                                    }),
                                  ),
                                );
                              }
                            } else if (snapshot.data.hasError) {
                              onWidgetDidBuild(() {
                                if (snapshot.data.standby) {
                                  showDialogMessage(
                                      context,
                                      snapshot.data.message,
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
                                if (page <
                                    snapshot.data.data.payload.totalPage) {
                                  isLoadMore = true;
                                } else {
                                  isLoadMore = false;
                                }
                                if (page == 1) {
                                  feedList = snapshot.data.data.payload.rows;
                                  feedBloc.unStandBy();

                                  if (feedList.length == 0) {
                                    isEmpty = true;
                                  } else {
                                    isEmpty = false;
                                  }
                                } else {
                                  feedList.removeLast();
                                  feedList.removeLast();
                                  feedList
                                      .addAll(snapshot.data.data.payload.rows);
                                  feedBloc.unStandBy();
                                }
                              }
                            }
                          }
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(10)),
                            child: Wrap(
                              spacing: ScreenUtil().setWidth(10),
                              runSpacing: ScreenUtil().setHeight(10),
                              children: List.generate(feedList.length, (index) {
                                if (feedList[index].portfolioId != null) {
                                  return CardProfilePortfolioItem(
                                    context: context,
                                    index: index,
                                    size: size,
                                    feed: feedList[index],
                                    onPressed: () =>
                                        Navigation().navigateScreen(
                                            context,
                                            DetailPortfolioScreen(
                                              before: "profile",
                                              portfolioId: feedList[index].portfolioId,
                                              profileDetail: profileDetail,
                                              authUser: widget.authUser,
//                                              feedBloc: feedBloc,
                                            )),
                                  );
                                } else {
                                  return CardSearchFeedsLoader(
                                    context: context,
                                    size: size,
                                  );
                                }
                              }),
                            ),
                          );
                        }),
                    SizedBox(height: ScreenUtil().setHeight(20)),
                  ],
                );
              }
            }
            return ProfileDetailLoader(context);
          }),
    );
  }
}
