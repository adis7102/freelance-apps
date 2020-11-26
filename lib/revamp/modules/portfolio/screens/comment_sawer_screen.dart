import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/feeds/components/feeds_component.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/bloc/portfolio_bloc.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/bloc/portfolio_state.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/models/comment_model.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/services/portfolio_service.dart';
import 'package:soedja_freelance/revamp/modules/wallet/components/withdraw_components.dart';

class CommentSawerScreen extends StatefulWidget {
  final Feed feed;

  const CommentSawerScreen({Key key, this.feed}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CommentSawerScreen();
  }
}

class _CommentSawerScreen extends State<CommentSawerScreen> {
  ScrollController listController = new ScrollController();
  int limit = 20;
  int page = 1;
  String title = "";
  List<Comment> commentList = new List<Comment>();
  bool isLoadMore = false;
  bool isEmpty = false;
  int total = 0;

  PortfolioBloc portfolioBloc = new PortfolioBloc();

  @override
  void initState() {
    listController.addListener(scrollListener);
    getList();
    getTotal();
    super.initState();
  }

  void getTotal() {
    PortfolioService()
        .getTotalSawer(context, widget.feed.portfolioId)
        .then((response) {
      if (response.code == "success") {
        setState(() {
          total = response.payload.total;
        });
      }
    });
  }

  void getList() {
    portfolioBloc.requestGetComment(
        context: context,
        id: widget.feed.portfolioId,
        limit: limit,
        page: page,
        isSawer: "1");
  }

  void scrollListener() {
    if (listController.position.pixels >
        listController.position.maxScrollExtent -
            MediaQuery.of(context).size.width) {
      if (isLoadMore) {
        page++;
        commentList.add(Comment());
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
          "Komentar",
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
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          page = 1;
          getList();
          return;
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(20)),
              margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.black54, width: .2))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Total Dukungan Terkumpul"),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black54, width: .2)),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.card_giftcard,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Rp ${formatCurrency.format(total)}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<CommentListState>(
                  stream: portfolioBloc.getComment,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.isLoading) {
                        if (page == 1) {
                          return ListView.separated(
                              padding:
                                  EdgeInsets.all(ScreenUtil().setWidth(20)),
                              itemBuilder: (context, index) {
                                return CardWithdrawHistoryLoader(context);
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                    height: ScreenUtil().setHeight(20));
                              },
                              itemCount: 10);
                        }
                      } else if (snapshot.data.hasError) {
                        onWidgetDidBuild(() {
                          if (snapshot.data.standby) {
                            showDialogMessage(context, snapshot.data.message,
                                "Terjadi Kesalahan, silahkan coba lagi");
                            portfolioBloc.unStandBy();
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
                            commentList = snapshot.data.data.payload.rows;
//
                            if (snapshot.data.data.payload.rows.length == 0) {
                              isEmpty = true;
                            } else {
                              isEmpty = false;
                            }
                          } else {
                            commentList.removeLast();
                            commentList.addAll(snapshot.data.data.payload.rows);
                          }
                        }
                        portfolioBloc.unStandBy();
                      }
                    }
                    if (!isEmpty) {
                      return ListView.separated(
                          padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                          controller: listController,
                          itemBuilder: (context, index) {
                            if (commentList[index].userId != null) {
                              return Container(
                                padding:
                                    EdgeInsets.all(ScreenUtil().setWidth(20)),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.black.withOpacity(.5),
                                        width: .2),
                                    borderRadius: BorderRadius.circular(
                                        ScreenUtil().setWidth(5))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                commentList[index]
                                                        .userData
                                                        .name ??
                                                    "",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize:
                                                      ScreenUtil().setSp(15),
                                                ),
                                              ),
                                              SizedBox(
                                                  height:
                                                      ScreenUtil().setWidth(5)),
                                              Text(
                                                dateFormat(
                                                    date: commentList[index]
                                                        .createdAt),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w300,
                                                  fontSize:
                                                      ScreenUtil().setSp(12),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          "Rp ${formatCurrency.format(commentList[index].amount)}",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: ScreenUtil().setSp(20),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: ScreenUtil().setWidth(20)),
                                    Text(
                                      commentList[index].comment,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                        fontSize: ScreenUtil().setSp(12),
                                        height: 1.5,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            } else {
                              return CardWithdrawHistoryLoader(context);
                            }
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: ScreenUtil().setHeight(20));
                          },
                          itemCount: commentList.length);
                    } else {
                      return EmptyFeeds();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
