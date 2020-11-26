import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/assets/urls.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/keyboard_helper.dart';
import 'package:soedja_freelance/revamp/helpers/masked_text.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_state.dart';
import 'package:soedja_freelance/revamp/modules/auth/models/auth_models.dart';
import 'package:soedja_freelance/revamp/modules/feeds/bloc/feed_bloc.dart';
import 'package:soedja_freelance/revamp/modules/feeds/bloc/feed_state.dart';
import 'package:soedja_freelance/revamp/modules/feeds/components/feeds_component.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';
import 'package:soedja_freelance/revamp/modules/feeds/screens/feeds_like_screen.dart';
import 'package:soedja_freelance/revamp/modules/payment/bloc/payment_bloc.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/bloc/portfolio_bloc.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/bloc/portfolio_state.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/components/detail_components.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/components/portfolio_components.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/components/support_author_component.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/models/comment_model.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/screens/comment_sawer_screen.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/screens/edit_portfolio_screen.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/screens/gallery_screen.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/screens/video_portfolio_screen.dart';
import 'package:soedja_freelance/revamp/modules/profile/models/profile_models.dart';
import 'package:soedja_freelance/revamp/modules/profile/screens/profile_detail_screen.dart';
import 'package:soedja_freelance/revamp/modules/wallet/bloc/wallet_bloc.dart';
import 'package:soedja_freelance/revamp/modules/wallet/components/withdraw_components.dart';
import 'package:soedja_freelance/revamp/modules/wallet/screens/withdraw_screen.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailPortfolioScreen extends StatefulWidget {
  final String before;
  final String portfolioId;
  final ProfileDetail profileDetail;
  final ProfileDetail authUser;

//  final FeedBloc feedBloc;

  const DetailPortfolioScreen({
    Key key,
    this.before,
    this.portfolioId,
    this.authUser,
//    this.feedBloc,
    this.profileDetail,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DetailPortfolioScreen();
  }
}

class _DetailPortfolioScreen extends State<DetailPortfolioScreen> {
  CarouselController galleryController = new CarouselController();
  ScrollController controller = new ScrollController();
  TextEditingController textController = new TextEditingController();
  MoneyMaskedTextController amountController = new MoneyMaskedTextController(
    thousandSeparator: '.',
    decimalSeparator: '',
    precision: 0,
  );
  TextEditingController commentController = new TextEditingController();

  int indexGallery = 0;

  YoutubePlayerController _controller;
  TextEditingController _seekToController;

  bool _muted = false;
  bool _isPlayerReady = false;
  String videoId = "";

  bool isVideo = false;

  PaymentBloc paymentBloc = new PaymentBloc();
  PortfolioBloc portfolioBloc = new PortfolioBloc();

  ScrollController listController = new ScrollController();

  int limit = 20;
  int page = 1;
  String title = "";
  List<Comment> commentList = new List<Comment>();
  bool isLoadMore = false;

  AuthBloc authBloc = new AuthBloc();
  WalletBloc walletBloc = new WalletBloc();
  Feed feed = new Feed();

  bool isAutoBid = false;
  bool isLoaded = false;
  FeedBloc feedBloc = new FeedBloc();

  bool show = false;

  @override
  void initState() {
    getCommentList();
    listController.addListener(scrollListener);
    authBloc.requestGetProfile(context);
    walletBloc.requestGetWallet(context);
    updateViewer();
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getPortfolioDetail() {
    feedBloc.requestGetDetail(context, widget.portfolioId);
  }

  updateViewer() {
    feedBloc.updateViewer(context, widget.portfolioId).then((response) {
      if (response.code == "success") {
        getPortfolioDetail();
      } else {
        showDialogMessage(context, response.message,
            "Terjadi kesalahan, silahkan coba lagi.");
      }
    });
  }

  void scrollListener() {
    if (listController.position.pixels >
        listController.position.maxScrollExtent -
            MediaQuery.of(context).size.width) {
      if (isLoadMore) {
        page++;
        commentList.add(Comment());
        getCommentList();
        isLoadMore = false;
      }
    }
  }

  getCommentList() {
    portfolioBloc.requestGetComment(
        context: context,
        id: widget.portfolioId,
        limit: limit,
        page: page,
        isSawer: "");
  }

  void onBookmark(Feed feed) async {
    if (feed.hasBookmark == 0) {
      await feedBloc.feedServices
          .createBookmark(context, feed.portfolioId)
          .then((response) {
        if (response.code == "success") {
          setState(() {
            feed.hasBookmark = 1;
          });
        }
      });
    } else {
      await feedBloc.feedServices
          .deleteBookmark(context, feed.portfolioId)
          .then((response) {
        if (response.code == "success") {
          setState(() {
            feed.hasBookmark = 0;
          });
        }
      });
    }
  }

  void onEdit(Feed feed) {
    Navigation().navigateScreen(
        context,
        EditPortfolioScreen(
          authBloc: authBloc,
          feed: feed,
          feedBloc: feedBloc,
          onRefresh: () => getPortfolioDetail(),
        ));
  }

  void onScan(String portfolioId) {}

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: StreamBuilder<PortfolioDetailState>(
            stream: feedBloc.getDetail,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.hasError) {
                  if (snapshot.data.standby) {
                    onWidgetDidBuild(() {
                      showDialogMessage(context, snapshot.data.message,
                          "Terjadi kesalahan silahkan coba lagi.");
                    });
                    feedBloc.unStandBy();
                  }
                } else if (snapshot.data.isSuccess) {
                  return AppBarDetailPortfolio(
                    context: context,
                    feed: snapshot.data.data.payload,
                    authUser: widget.authUser,
                    onBookmark: () => onBookmark(snapshot.data.data.payload),
                    onEdit: () => onEdit(snapshot.data.data.payload),
                    onScan: () =>
                        onScan(snapshot.data.data.payload.portfolioId),
                  );
                }
              }
              return AppBarDetailPortfolioLoader(context);
            }),
      ),
      body: LiquidPullToRefresh(
        height: ScreenUtil().setHeight(90),
        color: Color(0xFFBC2445) /* Color(0xFFF0F0F0) */,
        backgroundColor: Color(0xFFFFC936) /* Colors.white */,
        showChildOpacityTransition: false,
        onRefresh: () async {
          try {
            getCommentList();
            listController.addListener(scrollListener);
            authBloc.requestGetProfile(context);
            walletBloc.requestGetWallet(context);
            updateViewer();
          } catch (e) {
            print('[LOG ERROR DETAIL PORTFOLIO] $e');
          }
        },
        child: StreamBuilder<PortfolioDetailState>(
            stream: feedBloc.getDetail,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.hasError) {
                  if (snapshot.data.standby) {
                    onWidgetDidBuild(() {
                      showDialogMessage(context, snapshot.data.message,
                          "Terjadi kesalahan silahkan coba lagi.");
                    });
                    feedBloc.unStandBy();
                  }
//                  return AppBarDetailPortfolioLoader(context);
                } else if (snapshot.data.isSuccess) {
                  feed = snapshot.data.data.payload;
                  return Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: ListView(
                          controller: listController,
                          children: <Widget>[
                            BodyDetailPortfolio(
                              context: context,
                              feed: snapshot.data.data.payload,
                              authUser: widget.authUser,
                              show: show,
                              isShow: (val) {
                                setState(() {
                                  show = val;
                                });
                              },
                              profileDetail: widget.profileDetail,
                              onVideoScreen: () => Navigation().navigateScreen(
                                context,
                                VideoPortfolioScreen(
                                  feed: snapshot.data.data.payload,
                                  authUser: widget.authUser,
                                  profileDetail: widget.profileDetail,
                                  feedBloc: feedBloc,
                                ),
                              ),
                              onUserDetail: () => Navigation().navigateScreen(
                                  context,
                                  ProfileDetailScreen(
                                    authUser: widget.authUser,
                                    authBloc: authBloc,
                                    profileDetail: widget.profileDetail,
                                    before: "detail",
                                  )),
                            ),
                            StreamBuilder<CommentListState>(
                                stream: portfolioBloc.getComment,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data.hasError) {
                                      onWidgetDidBuild(() {
                                        if (snapshot.data.standby) {
                                          showDialogMessage(
                                              context,
                                              snapshot.data.message,
                                              "Terjadi Kesalahan, silahkan coba lagi");
                                          portfolioBloc.unStandBy();
                                        }
                                      });
                                    } else if (snapshot.data.isSuccess) {
                                      if (snapshot.data.standby) {
                                        if (page <
                                            snapshot
                                                .data.data.payload.totalPage) {
                                          isLoadMore = true;
                                        } else {
                                          isLoadMore = false;
                                        }
                                        if (page == 1) {
                                          commentList =
                                              snapshot.data.data.payload.rows;
                                          portfolioBloc.unStandBy();
                                        } else {
                                          commentList.removeLast();
                                          commentList.addAll(
                                              snapshot.data.data.payload.rows);
                                          portfolioBloc.unStandBy();
                                        }
                                      }
                                    }
                                  }
                                  return PortfolioComment(
                                    context: context,
                                    commentList: commentList,
                                    feed: feed,
                                    onLike: () async {
                                      if (feed.hasLike == 0) {
                                        await feedBloc.feedServices
                                            .createLike(
                                                context, feed.portfolioId)
                                            .then((response) {
                                          if (response.code == "success") {
                                            setState(() {
                                              feed.hasLike = 1;
                                              feed.likeCount++;
                                            });
                                          } else {
                                            showDialogMessage(
                                                context,
                                                response.message,
                                                "Terjadi kesalahan, silahkan coba lagi.");
                                          }
                                        });
                                      } else {
                                        await feedBloc.feedServices
                                            .deleteLike(
                                                context, feed.portfolioId)
                                            .then((response) {
                                          if (response.code == "success") {
                                            setState(() {
                                              feed.hasLike = 0;
                                              feed.likeCount--;
                                            });
                                          } else {
                                            showDialogMessage(
                                                context,
                                                response.message,
                                                "Terjadi kesalahan, silahkan coba lagi.");
                                          }
                                        });
                                      }
                                    },
                                    onLikeList: () =>
                                        Navigation().navigateScreen(
                                            context,
                                            FeedLikeScreen(
                                              feed: feed,
                                              authUser: widget.authUser,
                                            )),
                                  );
                                }),
                            SizedBox(height: ScreenUtil().setHeight(100)),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: ScreenUtil().setHeight(15),
                              bottom: ScreenUtil().setHeight(15),
                              right: ScreenUtil().setWidth(5)),
                          decoration:
                              BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                              blurRadius: 3,
                              color: Colors.black26,
                            )
                          ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Visibility(
                                visible: !Keyboard().isKeyboardOpen(context) &&
                                    textController.text.isEmpty,
                                child: Container(
                                    height: ScreenUtil().setHeight(55),
                                    child: widget.authUser.userId == feed.userId
                                        ? FlatButtonCircleWidget(
                                            context: context,
                                            color: Colors.black,
                                            onPressed: () =>
                                                DialogWithdrawMethod(
                                                    context: context,
                                                    onChooseMethod: (type) {
                                                      Navigation().navigateBack(
                                                          context);
                                                      Navigation()
                                                          .navigateScreen(
                                                              context,
                                                              WithdrawScreen(
                                                                type: type,
                                                                walletBloc:
                                                                    walletBloc,
                                                              ));
                                                    }),
                                            child: SvgPicture.asset(
                                              Images.iconGiveSupport,
                                              height:
                                                  ScreenUtil().setHeight(21),
                                              width: ScreenUtil().setWidth(21),
                                              semanticsLabel: "icon_support",
                                            ))
                                        : FlatButtonCircleWidget(
                                            context: context,
                                            color: Colors.black,
                                            onPressed: () async {
                                              print('[LOG DETAIL PROFILE] ${widget.profileDetail.toJson().toString()}');
                                              String _paymentStatus =
                                                  await DialogSupportAuthor(
                                                      context: context,
                                                      profile: widget.authUser,
                                                      profileDetail:
                                                          widget.profileDetail,
                                                      portfolioId:
                                                          widget.portfolioId,
                                                      authUser: widget.authUser,
                                                      paymentBloc: paymentBloc,
                                                      amountController:
                                                          amountController,
                                                      commentController:
                                                          commentController,
                                                      onGiveSupport:
                                                          (amount, comment) {});
                                              if (_paymentStatus ==
                                                  'successpayment') {
                                                print(
                                                    '[LOG PAYMENT SUCCESS] $_paymentStatus');
                                                getCommentList();
                                                listController.addListener(
                                                    scrollListener);
                                                authBloc
                                                    .requestGetProfile(context);
                                                walletBloc
                                                    .requestGetWallet(context);
                                                updateViewer();
                                              }
                                            },
                                            child: SvgPicture.asset(
                                              Images.iconGiveSupport,
                                              height:
                                                  ScreenUtil().setHeight(21),
                                              width: ScreenUtil().setWidth(21),
                                              semanticsLabel: "icon_support",
                                            ))),
                              ),
                              Visibility(
                                visible: !Keyboard().isKeyboardOpen(context) &&
                                    textController.text.isEmpty,
                                child: GestureDetector(
                                  onTap: () => Navigation().navigateScreen(
                                      context,
                                      CommentSawerScreen(
                                        feed: feed,
                                      )),
                                  child: Container(
                                    width: ScreenUtil().setWidth(45),
                                    height: ScreenUtil().setWidth(45),
                                    color: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: ScreenUtil().setWidth(5)),
                                    child: SvgPicture.asset(
                                      Images.iconHowtoRegSvg,
                                      semanticsLabel: "icon_verified",
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(10),
                              ),
                              Expanded(
                                child: Container(
                                  height: ScreenUtil().setHeight(45),
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 250),
                                    child: StreamBuilder<GiveCommentState>(
                                        stream: portfolioBloc.getGiveComment,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            if (snapshot.data.isLoading) {
                                              return SmallLayoutLoading(
                                                  context, Colors.black);
                                            } else if (snapshot.data.hasError) {
                                              onWidgetDidBuild(() {
                                                if (snapshot.data.standby) {
                                                  showDialogMessage(
                                                      context,
                                                      snapshot.data.message,
                                                      "Terjadi kesalahan, silahkan coba lagi.");
                                                  portfolioBloc.unStandBy();
                                                }
                                              });
                                            } else if (snapshot
                                                .data.isSuccess) {
                                              onWidgetDidBuild(() {
                                                if (snapshot.data.standby) {
                                                  textController.clear();
                                                  showDialogMessage(
                                                      context,
                                                      "Berhasil Berikan Komentar",
                                                      "Kamu telah memberikan komentar ke portfolio ini.");
                                                  Comment comment = snapshot
                                                      .data.data.payload;
                                                  comment.userData =
                                                      widget.authUser;
                                                  print(comment.toJson());

                                                  commentList.insert(
                                                      0, comment);
                                                  feed.commentCount++;
                                                  setState(() {});
                                                  portfolioBloc.unStandBy();
                                                }
                                              });
                                            }
                                          }
                                          return TextFormFieldAreaFilled(
                                            hint: 'Katakan Sesuatu ...',
                                            controller: textController,
                                            minLines: 1,
                                            maxLines: 5,
                                            onChanged: (val) {
                                              setState(() {});
                                            },
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize:
                                                    ScreenUtil().setSp(12),
                                                height: 1.5,
                                                fontWeight: FontWeight.normal),
                                            contentPadding: EdgeInsets.all(
                                                ScreenUtil().setHeight(10)),
                                            suffixIcon: Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: ScreenUtil()
                                                      .setHeight(5)),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle),
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: ScreenUtil()
                                                        .setHeight(10)),
                                                child: SvgPicture.asset(
                                                  Images.iconCommentSvg,
                                                  height: ScreenUtil()
                                                      .setHeight(17),
                                                  width:
                                                      ScreenUtil().setWidth(20),
                                                  semanticsLabel:
                                                      "icon_comment",
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: !Keyboard().isKeyboardOpen(context) &&
                                    textController.text.isEmpty,
                                child: SizedBox(
                                  width: ScreenUtil().setWidth(20),
                                ),
                              ),
                              Visibility(
                                visible: !Keyboard().isKeyboardOpen(context) &&
                                    textController.text.isEmpty,
                                child: GestureDetector(
                                  onTap: () async {
                                    if (feed.hasLike == 0) {
                                      await feedBloc.feedServices
                                          .createLike(context, feed.portfolioId)
                                          .then((response) {
                                        if (response.code == "success") {
                                          setState(() {
                                            feed.hasLike = 1;
                                            feed.likeCount++;
                                          });
                                        } else {
                                          showDialogMessage(
                                              context,
                                              response.message,
                                              "Terjadi kesalahan, silahkan coba lagi.");
                                        }
                                      });
                                    } else {
                                      await feedBloc.feedServices
                                          .deleteLike(context, feed.portfolioId)
                                          .then((response) {
                                        if (response.code == "success") {
                                          setState(() {
                                            feed.hasLike = 0;
                                            feed.likeCount--;
                                          });
                                        } else {
                                          showDialogMessage(
                                              context,
                                              response.message,
                                              "Terjadi kesalahan, silahkan coba lagi.");
                                        }
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: ScreenUtil().setWidth(22),
                                    child: AspectRatio(
                                      aspectRatio: 1 / 1,
                                      child: SvgPicture.asset(
                                        feed.hasLike == 0
                                            ? Images.iconHeart
                                            : Images.iconLiked,
                                        width: ScreenUtil().setWidth(22),
                                        semanticsLabel: "icon_heart",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: !Keyboard().isKeyboardOpen(context) &&
                                    textController.text.isEmpty,
                                child: SizedBox(
                                  width: ScreenUtil().setWidth(20),
                                ),
                              ),
                              Visibility(
                                visible: Keyboard().isKeyboardOpen(context) ||
                                    textController.text.isNotEmpty,
                                child: GestureDetector(
                                  onTap: () {
                                    Keyboard().closeKeyboard(context);
                                    portfolioBloc.requestGiveComment(context,
                                        feed.portfolioId, textController.text);
                                  },
                                  child: Container(
                                    height: ScreenUtil().setHeight(60),
                                    color: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: ScreenUtil().setWidth(10)),
                                    child: Icon(Icons.send),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }
              return BodyDetailPortfolioLoader(context);
//          return Stack(
//            children: <Widget>[
//          Positioned.fill(
//            child: GestureDetector(
//              onTap: () => Keyboard().closeKeyboard(context),
//              child: ListView(
//                controller: listController,
//                children: <Widget>[
////                  widget.portfolio.youtubeUrl.contains("youtube.com")
////                      ? YoutubePlayer(
////                          controller: _controller,
////                          showVideoProgressIndicator: true,
////                          progressIndicatorColor: ColorApps.primary,
////                          progressColors: ProgressBarColors(
////                              playedColor: ColorApps.primary,
////                              handleColor: Colors.white.withOpacity(.5),
////                              backgroundColor: Colors.white.withOpacity(.2),
////                              bufferedColor: Colors.white.withOpacity(.8)),
////                          onReady: () {
////                            _isPlayerReady = true;
////                          },
////                          topActions: <Widget>[
////                            SizedBox(width: ScreenUtil().setWidth(10)),
////                            Expanded(
////                              child: Text(
////                                _controller.metadata.title,
////                                style: const TextStyle(
////                                  color: Colors.white,
////                                  fontSize: 18.0,
////                                ),
////                                overflow: TextOverflow.ellipsis,
////                                maxLines: 1,
////                              ),
////                            ),
////                            IconButton(
////                              icon: Icon(
////                                _muted ? Icons.volume_off : Icons.volume_up,
////                                color: Colors.white,
////                              ),
////                              onPressed: _isPlayerReady
////                                  ? () {
////                                      _muted
////                                          ? _controller.unMute()
////                                          : _controller.mute();
////                                      setState(() {
////                                        _muted = !_muted;
////                                      });
////                                    }
////                                  : null,
////                            ),
////                          ],
////                        )
////                      : Container(),
            }),
      ),
    );
  }
}
