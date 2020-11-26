import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/feeds/bloc/feed_bloc.dart';
import 'package:soedja_freelance/revamp/modules/feeds/bloc/feed_state.dart';
import 'package:soedja_freelance/revamp/modules/feeds/components/feeds_component.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/bookmark_models.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/screens/detail_portfolio_screen.dart';
import 'package:soedja_freelance/revamp/modules/profile/models/profile_models.dart';

class BookmarkScreen extends StatefulWidget {
  final ProfileDetail authUser;
  final AuthBloc authBloc;

  const BookmarkScreen({Key key, @required this.authUser, this.authBloc}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BookmarkScreen();
  }
}

class _BookmarkScreen extends State<BookmarkScreen> {
  ScrollController listController = new ScrollController();
  int limit = 20;
  int page = 1;
  String title = "";
  List<Bookmark> bookmarkList = new List<Bookmark>();
  bool isLoadMore = false;
  bool isEmpty = false;

  FeedBloc feedBloc = new FeedBloc();

  @override
  void initState() {
    getList();
    listController.addListener(scrollListener);
    super.initState();
  }

  void getList() {
    feedBloc.requestGetBookmark(context, limit, page);
  }

  void scrollListener() {
    if (listController.position.pixels >
        listController.position.maxScrollExtent -
            MediaQuery.of(context).size.width) {
      if (isLoadMore) {
        page++;
        bookmarkList.add(Bookmark());
        bookmarkList.add(Bookmark());
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
          "Daftar Simpan",
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
        child: StreamBuilder<BookmarkListState>(
            stream: feedBloc.getBookmarks,
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
                      bookmarkList = snapshot.data.data.payload.rows;
//
                      if (snapshot.data.data.payload.rows.length == 0) {
                        isEmpty = true;
                      } else {
                        isEmpty = false;
                      }
                    } else {
                      bookmarkList.removeLast();
                      bookmarkList.removeLast();
                      bookmarkList.addAll(snapshot.data.data.payload.rows);
                    }
                    print(bookmarkList.length);
                  }
                  feedBloc.unStandBy();
                  print(bookmarkList.length);
                }
              }
              if (!isEmpty) {
                return SingleChildScrollView(
                  controller: listController,
                  padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                  child: Wrap(
                    spacing: ScreenUtil().setWidth(10),
                    runSpacing: ScreenUtil().setHeight(10),
                    children: List.generate(bookmarkList.length, (index) {
                      if (bookmarkList[index].portfolioId != null) {
                        return CardSearchFeedsItem(
                          isBookmark: true,
                          authBloc: widget.authBloc,
                          context: context,
                          index: index,
                          size: size,
                          feed: bookmarkList[index].portfolioDetail,
                          profileDetail: bookmarkList[index].userDetail,
                          onPressed: () => Navigation().navigateScreen(
                              context,
                              DetailPortfolioScreen(
                                before: "bookmark",
                                portfolioId: bookmarkList[index].portfolioId,
                                profileDetail: bookmarkList[index].userDetail,
                                authUser: widget.authUser,
//                                feedBloc: feedBloc,
                              )),
                          onBookmark: () async {
                            if (bookmarkList[index].portfolioDetail.hasBookmark == 0) {
                              await feedBloc.feedServices
                                  .createBookmark(
                                  context, bookmarkList[index].portfolioDetail.portfolioId)
                                  .then((response) {
                                if (response.code == "success") {
                                  setState(() {
                                    bookmarkList[index].portfolioDetail.hasBookmark = 1;
                                  });
                                }
                              });
                            }
                            else {
                              await feedBloc.feedServices
                                  .deleteBookmark(
                                  context, bookmarkList[index].portfolioDetail.portfolioId)
                                  .then((response) {
                                if (response.code == "success") {
                                  setState(() {
                                    bookmarkList[index].portfolioDetail.hasBookmark = 0;
                                    bookmarkList.removeAt(index);
                                  });
                                }
                              });
                            }
                          },
                          authUser: widget.authUser,
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
      ),
    );
  }
}
