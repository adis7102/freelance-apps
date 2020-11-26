import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/category/bloc/category_bloc.dart';
import 'package:soedja_freelance/revamp/modules/feeds/bloc/feed_bloc.dart';
import 'package:soedja_freelance/revamp/modules/feeds/bloc/feed_state.dart';
import 'package:soedja_freelance/revamp/modules/feeds/components/feeds_component.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';
import 'package:soedja_freelance/revamp/modules/home/components/appbar_component.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/screens/detail_portfolio_screen.dart';
import 'package:soedja_freelance/revamp/modules/profile/models/profile_models.dart';

class SearchFeedsScreen extends StatefulWidget {
  final AuthBloc authBloc;
  final FeedBloc feedBloc;
  final ProfileDetail authUser;
  final ScrollController scrollController;
  final String title;
  final int page;

  SearchFeedsScreen({
    Key key,
    this.authBloc,
    this.feedBloc,
    this.scrollController,
    this.title,
    this.page,
    this.authUser,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchFeedsScreen();
  }
}

class _SearchFeedsScreen extends State<SearchFeedsScreen> {
  ScrollController listController = new ScrollController();
  int limit = 20;
  int page = 1;
  String title = "";
  List<Feed> feedList = new List<Feed>();
  bool isLoadMore = false;
  bool isEmpty = false;

  @override
  void initState() {
    title = widget.title;
    getList();
    listController.addListener(scrollListener);
    super.initState();
  }

  void getList() {
    if (widget.title.length > 0) {
      isEmpty = false;
      widget.feedBloc.requestSearchList(context, limit, page, widget.title);
    } else {
      isEmpty = true;
    }
  }

  void scrollListener() {
    if (listController.position.pixels >
        listController.position.maxScrollExtent -
            MediaQuery.of(context).size.width) {
      if (isLoadMore) {
        page++;
        feedList.add(Feed());
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

    return RefreshIndicator(
      onRefresh: () async {
        page = 1;
        getList();
        return;
      },
      child: StreamBuilder<SearchListState>(
          stream: widget.feedBloc.getSearchList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isLoading) {
                if (page == 1) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
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
//
                    if (snapshot.data.data.payload.rows.length == 0) {
                      isEmpty = true;
                    } else {
                      isEmpty = false;
                    }
                  } else {
                    feedList.removeLast();
                    feedList.removeLast();
                    feedList.addAll(snapshot.data.data.payload.rows);
                  }
                }
                widget.feedBloc.unStandBy();
              }
            }
            if (!isEmpty) {
              return SingleChildScrollView(
                controller: listController,
                padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                child: Wrap(
                  spacing: ScreenUtil().setWidth(10),
                  runSpacing: ScreenUtil().setHeight(10),
                  children: List.generate(feedList.length, (index) {
                    if (feedList[index].portfolioId != null) {
                      return CardSearchFeedsItem(
                        context: context,
                        isBookmark: false,
                        authBloc: widget.authBloc,
                        index: index,
                        size: size,
                        feed: feedList[index],
                        authUser: widget.authUser,
                        onPressed: () => Navigation().navigateScreen(
                            context,
                            DetailPortfolioScreen(
                              before: "search",
                              portfolioId: feedList[index].portfolioId,
                              profileDetail: feedList[index].userData,
                              authUser: widget.authUser,
//                              feedBloc: widget.feedBloc,
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
                          }
                        },
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
            } else {
              return EmptyFeeds();
            }
          }),
    );
  }
}
