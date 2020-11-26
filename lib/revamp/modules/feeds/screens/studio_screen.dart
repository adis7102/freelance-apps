import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/assets/urls.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/feeds/bloc/feed_bloc.dart';
import 'package:soedja_freelance/revamp/modules/feeds/bloc/feed_state.dart';
import 'package:soedja_freelance/revamp/modules/feeds/components/feeds_component.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/screens/detail_portfolio_screen.dart';
import 'package:soedja_freelance/revamp/modules/profile/models/profile_models.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

class StudioScreen extends StatefulWidget {
  final AuthBloc authBloc;
  final FeedBloc feedBloc;
  final ProfileDetail authUser;

  const StudioScreen(
      {Key key, this.authBloc, @required this.authUser, this.feedBloc})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StudioScreen();
  }
}

class _StudioScreen extends State<StudioScreen> {
  ScrollController listController = new ScrollController();

  int limit = 10;
  int page = 1;
  String title = "";
  List<Feed> feedList = new List<Feed>();
  bool isLoadMore = true;
  bool isEmpty = false;

  FeedBloc feedBloc = new FeedBloc();

  @override
  void initState() {
    getList();
    feedBloc.requestStudioBanner(context);
    listController.addListener(scrollListener);
    super.initState();
  }

  void getList() {
    widget.feedBloc.requestGetVideoList(context, limit, page);
  }

  void scrollListener() {
    if (listController.position.pixels >
        listController.position.maxScrollExtent -
            MediaQuery.of(context).size.width) {
      if (isLoadMore) {
        page++;
        feedList.add(Feed());
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
      body: RefreshIndicator(
        onRefresh: () async {
          page = 1;
          getList();
          return;
        },
        child: ListView(
          controller: listController,
          children: <Widget>[
            StreamBuilder<BannerStudioState>(
                stream: feedBloc.getBannerStudio,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.isSuccess) {
                      if (snapshot.data.data.payload.rows.length > 0) {
                        return Container(
                          height: ScreenUtil().setHeight(170),
                          width: size.width,
                          color: ColorApps.light,
                          child: CarouselSlider.builder(
                            options: CarouselOptions(
                              height: ScreenUtil().setHeight(150),
                              autoPlay: true,
                              viewportFraction: 0.9,
                            ),
                            itemCount: snapshot.data.data.payload.rows.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(5)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      ScreenUtil().setWidth(10)),
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned.fill(
                                        child: Container(
                                          color: Colors.white,
                                          child: FadeInImage.assetNetwork(
                                            placeholder: Images.imgPlaceholder,
                                            image: snapshot.data.data.payload
                                                        .rows.length ==
                                                    0
                                                ? ""
                                                : snapshot
                                                            .data
                                                            .data
                                                            .payload
                                                            .rows[index]
                                                            .picture
                                                            .length >
                                                        0
                                                    ? (BaseUrl.SoedjaAPI +
                                                        "/" +
                                                        snapshot
                                                            .data
                                                            .data
                                                            .payload
                                                            .rows[index]
                                                            .picture)
                                                    : "",
                                            width: size.width -
                                                ScreenUtil().setWidth(40),
                                            height: ScreenUtil().setHeight(150),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned.fill(
                                        child: Container(
                                          color: Colors.white,
                                          child: FadeInImage.assetNetwork(
                                            placeholder: Images.imgPlaceholder,
                                            image: snapshot.data.data.payload
                                                        .rows.length ==
                                                    0
                                                ? ""
                                                : snapshot
                                                            .data
                                                            .data
                                                            .payload
                                                            .rows[index]
                                                            .picture
                                                            .length >
                                                        0
                                                    ? (BaseUrl.SoedjaAPI +
                                                        "/" +
                                                        snapshot
                                                            .data
                                                            .data
                                                            .payload
                                                            .rows[index]
                                                            .picture)
                                                    : "",
                                            width: size.width -
                                                ScreenUtil().setWidth(40),
                                            height: ScreenUtil().setHeight(150),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned.fill(
                                          child: Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                              Colors.transparent,
                                              Colors.black38
                                            ])),
                                      )),
                                      Positioned(
                                        bottom: ScreenUtil().setHeight(15),
                                        left: ScreenUtil().setHeight(20),
                                        right: ScreenUtil().setHeight(20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              snapshot.data.data.payload
                                                      .rows[index].title ??
                                                  "",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    ScreenUtil().setSp(15),
                                                height: 1.5,
                                              ),
                                            ),
                                            Text(
                                              snapshot
                                                      .data
                                                      .data
                                                      .payload
                                                      .rows[index]
                                                      .description ??
                                                  "",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                                fontSize:
                                                    ScreenUtil().setSp(12),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return Container(
                          height: ScreenUtil().setHeight(170),
                          width: size.width,
                          color: ColorApps.light,
                        );
                      }
                    }
                  }
                  return Container(
                    height: ScreenUtil().setHeight(170),
                    width: size.width,
                    color: ColorApps.light,
                  );
                }),
            Container(
              width: size.width,
              padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(
                          color: Colors.black.withOpacity(.5), width: .2))),
              child: Text(
                "Semua Video",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(12)),
              ),
            ),
            StreamBuilder<VideoListState>(
                stream: widget.feedBloc.getVideoList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.isLoading) {
                      if (page == 1) {
                        return ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
                            itemBuilder: (BuildContext context, int index) {
                              return CardVideoLoader(
                                context: context,
                                size: size,
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) => Divider(
                                      height: ScreenUtil().setHeight(40),
                                    ),
                            itemCount: 5);
                      }
                    } else if (snapshot.data.hasError) {
                      onWidgetDidBuild(() {
                        if (snapshot.data.standby) {
                          showDialogMessage(context, snapshot.data.message,
                              "Terjadi Kesalahan, silahkan coba lagi");
                          widget.feedBloc.unStandBy();
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
                          feedList = snapshot.data.data.payload.rows;
                          widget.feedBloc.unStandBy();

                          if (feedList.length == 0) {
                            isEmpty = true;
                          } else {
                            isEmpty = false;
                          }
                        } else {
                          feedList.removeLast();
                          feedList.addAll(snapshot.data.data.payload.rows);
                          widget.feedBloc.unStandBy();
                        }
                      }
                    }
                  }
                  if (!isEmpty) {
                    return ListView.separated(
                        padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          if (feedList[index].portfolioId != null) {
                            return CardVideoItem(
                              context: context,
                              index: index,
                              authBloc: widget.authBloc,
                              size: size,
                              feed: feedList[index],
                              authUser: widget.authUser,
                              onDetail: () => Navigation().navigateScreen(
                                  context,
                                  DetailPortfolioScreen(
                                    before: "studio",
                                    portfolioId: feedList[index].portfolioId,
                                    profileDetail: feedList[index].userData,
                                    authUser: widget.authUser,
//                                  feedBloc: feedBloc,
                                  )),
                              onBookmark: () async {
                                if (feedList[index].hasBookmark == 0) {
                                  await widget.feedBloc.feedServices
                                      .createBookmark(
                                          context, feedList[index].portfolioId)
                                      .then((response) {
                                    if (response.code == "success") {
                                      setState(() {
                                        feedList[index].hasBookmark = 1;
                                      });
                                    }
                                  });
                                } else {
                                  await widget.feedBloc.feedServices
                                      .deleteBookmark(
                                          context, feedList[index].portfolioId)
                                      .then((response) {
                                    if (response.code == "success") {
                                      setState(() {
                                        feedList[index].hasBookmark = 0;
                                      });
                                    }
                                  });
                                }
                              },
                            );
                          } else {
                            return CardVideoLoader(
                              context: context,
                              size: size,
                            );
                          }
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                              height: ScreenUtil().setHeight(40),
                            ),
                        itemCount: feedList.length);
                  } else {
                    return Container(height: size.width, child: EmptyFeeds());
                  }
                }),
          ],
        ),
      ),
    );
  }
}
