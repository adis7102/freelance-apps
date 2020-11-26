import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
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

class FeedsScreen extends StatefulWidget {
  final AuthBloc authBloc;
  final ProfileDetail authUser;

  const FeedsScreen({Key key, this.authBloc, @required this.authUser})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FeedsScreen();
  }
}

class _FeedsScreen extends State<FeedsScreen> {
  FeedBloc feedBloc = new FeedBloc();

  ScrollController listController = new ScrollController();

  int limit = 10;
  int page = 1;
  String title = "";
  List<Feed> feedList = new List<Feed>();
  bool isLoadMore = true;
  bool isEmpty = false;

  @override
  void initState() {
    getList();
    listController.addListener(scrollListener);
    super.initState();
  }

  void getList() {
    Future.delayed(Duration(microseconds: 250),
        () => feedBloc.requestGetList(context, limit, page, title));
  }

  void scrollListener() {
    if (listController.position.pixels >
        listController.position.maxScrollExtent -
            MediaQuery.of(context).size.width) {
      if (isLoadMore) {
        page++;
        feedList.add(Feed());
        feedBloc.requestGetList(context, limit, page, title);
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
          feedBloc.requestGetList(context, limit, page, title);
          return;
        },
        child: StreamBuilder<GetListFeedState>(
            stream: feedBloc.getList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.isLoading) {
                  if (page == 1) {
                    return ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return CardFeedsLoader(
                            context: context,
                            size: size,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(
                              height: ScreenUtil().setHeight(0),
                            ),
                        itemCount: 2);
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
                      feedList = snapshot.data.data.payload.rows;
                      feedBloc.unStandBy();

                      if (feedList.length == 0) {
                        isEmpty = true;
                      } else {
                        isEmpty = false;
                      }
                    } else {
                      feedList.removeLast();
                      feedList.addAll(snapshot.data.data.payload.rows);
                      feedBloc.unStandBy();
                    }
                  }
                }
              }
              if (!isEmpty) {
                return ListView.separated(
                    controller: listController,
                    itemBuilder: (BuildContext context, int index) {
                      if (feedList[index].portfolioId != null) {
                        return CardFeedsItem(
                          context: context,authBloc: widget.authBloc,
                          index: index,
                          size: size,
                          feed: feedList[index],
                          authUser: widget.authUser,
                          onPressed: () => Navigation().navigateScreen(
                              context,
                              DetailPortfolioScreen(
                                before: "feeds",
                                portfolioId: feedList[index].portfolioId,
                                authUser: widget.authUser,
                                profileDetail: feedList[index].userData,
//                                feedBloc: feedBloc,
                              )),
                          onLike: () async {
                            if (feedList[index].hasLike == 0) {
                              await feedBloc.feedServices
                                  .createLike(
                                      context, feedList[index].portfolioId)
                                  .then((response) {
                                if (response.code == "success") {
                                  setState(() {
                                    feedList[index].hasLike = 1;
                                    feedList[index].likeCount++;
                                  });
                                } else {
                                  showDialogMessage(context, response.message,
                                      "Terjadi kesalahan, silahkan coba lagi.");
                                }
                              });
                            } else {
                              await feedBloc.feedServices
                                  .deleteLike(
                                      context, feedList[index].portfolioId)
                                  .then((response) {
                                if (response.code == "success") {
                                  setState(() {
                                    feedList[index].hasLike = 0;
                                    feedList[index].likeCount--;
                                  });
                                } else {
                                  showDialogMessage(context, response.message,
                                      "Terjadi kesalahan, silahkan coba lagi.");
                                }
                              });
                            }
                          },
                          onBookmark: () async {
                            if (feedList[index].hasBookmark == 0) {
                              await feedBloc.feedServices
                                  .createBookmark(
                                      context, feedList[index].portfolioId)
                                  .then((response) {
                                if (response.code == "success") {
                                  setState(() {
                                    feedList[index].hasBookmark = 1;
                                  });
                                }
                              });
                            }
                            else {
                              await feedBloc.feedServices
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
                        return CardFeedsLoader(
                          context: context,
                          size: size,
                        );
                      }
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(
                          height: ScreenUtil().setHeight(0),
                        ),
                    itemCount: feedList.length);
              } else {
                return EmptyFeeds();
              }
            }),
      ),
    );
  }
}
