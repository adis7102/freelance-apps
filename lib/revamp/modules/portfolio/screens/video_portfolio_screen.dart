import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import 'package:soedja_freelance/revamp/modules/portfolio/screens/video_full_screen.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/screens/video_portfolio_screen.dart';
import 'package:soedja_freelance/revamp/modules/profile/models/profile_models.dart';
import 'package:soedja_freelance/revamp/modules/wallet/bloc/wallet_bloc.dart';
import 'package:soedja_freelance/revamp/modules/wallet/components/withdraw_components.dart';
import 'package:soedja_freelance/revamp/modules/wallet/screens/withdraw_screen.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPortfolioScreen extends StatefulWidget {
  final String before;
  final Feed feed;
  final ProfileDetail profileDetail;
  final ProfileDetail authUser;
  final FeedBloc feedBloc;

  const VideoPortfolioScreen({
    Key key,
    this.before,
    this.feed,
    this.authUser,
    this.feedBloc,
    this.profileDetail,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VideoPortfolioScreen();
  }
}

class _VideoPortfolioScreen extends State<VideoPortfolioScreen> {
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

  @override
  void initState() {
//    getPortfolioDetail();
//    if (widget.portfolio.youtubeUrl.contains("youtube.com")) {
//      initYoutube(
    initYoutube();
    getCommentList();
    listController.addListener(scrollListener);
    authBloc.requestGetProfile(context);
    walletBloc.requestGetWallet(context);
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

  initYoutube() {
    if (widget.feed.youtubeUrl.contains("youtube") || widget.feed.youtubeUrl.contains("youtu"))  {
      videoId = YoutubePlayer.convertUrlToId(widget.feed.youtubeUrl);
    } else {
      showDialogMessage(context, "Url Youtube Tidak Ditemukan",
          "Silahkan coba dengan portfolio lainnya.");
    }
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
        id: widget.feed.portfolioId,
        limit: limit,
        page: page,
        isSawer: "");
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Navigation().navigateBack(context),
          icon: Container(
            width: ScreenUtil().setWidth(40),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(.1),
                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(20))),
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
        titleSpacing: 1.0,
        title: Container(
          width: ScreenUtil().setWidth(90),
          margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(15)),
          child: Image.asset(Images.imgLogoWhite),
        ),
        actions: <Widget>[
          PreferredSize(
            preferredSize: AppBar().preferredSize,
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFF1d1d1d),
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().setHeight(50))),
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
              margin:
                  EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.remove_red_eye,
                    color: ColorApps.primary,
                    size: 20,
                  ),
                  SizedBox(width: ScreenUtil().setWidth(10)),
                  Text(
                    formatCurrency.format(feed.viewer ?? 0),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(12)),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.fullscreen),
            onPressed: () => Navigation().navigateScreen(
                context, VideoFullScreen(url: widget.feed.youtubeUrl)),
          ),
          SizedBox(width: ScreenUtil().setWidth(20)),
        ],
      ),
      body: StreamBuilder<PortfolioDetailState>(
        stream: widget.feedBloc.getDetail,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.hasError) {
              if (snapshot.data.standby) {
                onWidgetDidBuild(() {
                  showDialogMessage(context, snapshot.data.message,
                      "Terjadi kesalahan silahkan coba lagi.");
                });
                widget.feedBloc.unStandBy();
              }
//                  return AppBarDetailPortfolioLoader(context);
            } else if (snapshot.data.isSuccess) {
              feed = snapshot.data.data.payload;
              return Stack(
                children: <Widget>[
                  Positioned(
                    top: size.width * 9 / 16,
                    left: 0,
                    right: 0,
                    bottom: ScreenUtil().setHeight(60),
                    child: ListView(
                      controller: listController,
                      reverse: true,
                      children: <Widget>[
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
                                        snapshot.data.data.payload.totalPage) {
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
                              return VideoComment(
                                context: context,
                                commentList: commentList,
                                feed: feed,
                                onLike: () async {
                                  if (feed.hasLike == 0) {
                                    await widget.feedBloc.feedServices
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
                                    await widget.feedBloc.feedServices
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
                                onLikeList: () => Navigation().navigateScreen(
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
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Color(0xFF1d1d1d),
                      width: size.width,
                      height: size.width * 9 / 16,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: WebView(
                              initialUrl: "https://www.youtube.com/embed/$videoId",
                              javascriptMode: JavascriptMode.unrestricted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20),
                          vertical: ScreenUtil().setHeight(10)),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 250),
                              child: StreamBuilder<GiveCommentState>(
                                  stream: portfolioBloc.getGiveComment,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data.isLoading) {
                                        return SmallLayoutLoading(
                                            context, Colors.white);
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
                                      } else if (snapshot.data.isSuccess) {
                                        onWidgetDidBuild(() {
                                          if (snapshot.data.standby) {
                                            textController.clear();
                                            showDialogMessage(
                                                context,
                                                "Berhasil Berikan Komentar",
                                                "Kamu telah memberikan komentar ke portfolio ini.");
                                            Comment comment =
                                                snapshot.data.data.payload;
                                            comment.userData = widget.authUser;
                                            print(comment.toJson());

                                            commentList.insert(0, comment);
                                            feed.commentCount++;
                                            setState(() {});
                                            portfolioBloc.unStandBy();
                                          }
                                        });
                                      }
                                    }
                                    return Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xFF1D1D1D),
                                          borderRadius: BorderRadius.circular(
                                              ScreenUtil().setHeight(30))),
                                      child: TextFormFieldAreaOutline(
                                        controller: textController,
                                        keyboardType: TextInputType.multiline,
                                        textInputAction:
                                            TextInputAction.newline,
                                        minLines: 1,
                                        maxLines: 8,
                                        onChanged: (val) {
                                          setState(() {});
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: Texts.comment + " ...",
                                          hintStyle: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(.5),
                                              fontSize: ScreenUtil().setSp(12),
                                              height: 1.5,
                                              fontWeight: FontWeight.normal),
                                          prefixIcon: Icon(
                                            Icons.chat,
                                            color: Colors.white,
                                          ),
                                          suffixIcon: GestureDetector(
                                            onTap: textController.text.isEmpty
                                                ? null
                                                : () {
                                                    Keyboard()
                                                        .closeKeyboard(context);
                                                    portfolioBloc
                                                        .requestGiveComment(
                                                            context,
                                                            feed.portfolioId,
                                                            textController
                                                                .text);
                                                  },
                                            child: Icon(
                                              Icons.send,
                                              color: Colors.white,
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.all(
                                              ScreenUtil().setHeight(20)),
                                        ),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: ScreenUtil().setSp(12),
                                            height: 1.5,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(10),
                          ),
                          Visibility(
                            visible: !Keyboard().isKeyboardOpen(context) &&
                                textController.text.isEmpty,
                            child: Container(
                                height: ScreenUtil().setHeight(60),
                                child: widget.authUser.userId == feed.userId
                                    ? IconButton(
                                        onPressed: () => DialogWithdrawMethod(
                                            context: context,
                                            onChooseMethod: (type) {
                                              Navigation()
                                                  .navigateBack(context);
                                              Navigation().navigateScreen(
                                                  context,
                                                  WithdrawScreen(
                                                    type: type,
                                                    walletBloc: walletBloc,
                                                  ));
                                            }),
                                        icon: Container(
                                          width: ScreenUtil().setWidth(40),
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      ScreenUtil()
                                                          .setWidth(20))),
                                          child: AspectRatio(
                                            aspectRatio: 1 / 1,
                                            child: Icon(
                                              Icons.card_giftcard,
                                              color: Colors.black,
                                              size: 20,
                                            ),
                                          ),
                                        ))
                                    : IconButton(
                                        onPressed: () async {
                                          String _paymentStatus =
                                                  await DialogSupportAuthor(
                                                      context: context,
                                                      profile: widget.authUser,
                                                      profileDetail:
                                                          widget.profileDetail,
                                                      portfolioId:
                                                        widget.feed.portfolioId,
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
                                                listController.addListener(scrollListener);
                                                authBloc.requestGetProfile(context);
                                                walletBloc.requestGetWallet(context);
                                              }
                                        },
                                        icon: Container(
                                          width: ScreenUtil().setWidth(40),
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      ScreenUtil()
                                                          .setWidth(20))),
                                          child: AspectRatio(
                                            aspectRatio: 1 / 1,
                                            child: Icon(
                                              Icons.card_giftcard,
                                              color: Colors.black,
                                              size: 20,
                                            ),
                                          ),
                                        ))),
                          ),
                          IconButton(
                              onPressed: () async {
                                if (feed.hasLike == 0) {
                                  await widget.feedBloc.feedServices
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
                                  await widget.feedBloc.feedServices
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
                              icon: Container(
                                width: ScreenUtil().setWidth(40),
                                decoration: BoxDecoration(
                                    color: Color(0xFF1d1d1d),
                                    borderRadius: BorderRadius.circular(
                                        ScreenUtil().setWidth(20))),
                                padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: SvgPicture.asset(
                                    feed.hasLike == 0
                                        ? Images.iconHeartWhite
                                        : Images.iconLiked,
                                    width: ScreenUtil().setWidth(20),
                                    semanticsLabel: "icon_heart",
                                  ),
                                ),
                              )),
//                          Visibility(
//                            visible: !Keyboard().isKeyboardOpen(context) &&
//                                textController.text.isEmpty,
//                            child: GestureDetector(
//                              onTap: () => Navigation().navigateScreen(
//                                  context,
//                                  CommentSawerScreen(
//                                    feed: feed,
//                                  )),
//                              child: Container(
//                                height: ScreenUtil().setHeight(60),
//                                color: Colors.white,
//                                padding: EdgeInsets.symmetric(
//                                    horizontal: ScreenUtil().setWidth(10)),
//                                child: SvgPicture.asset(
//                                  Images.iconPersonVerified,
//                                  semanticsLabel: "icon_verified",
//                                ),
//                              ),
//                            ),
//                          ),
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
        },
      ),
    );
  }
}
