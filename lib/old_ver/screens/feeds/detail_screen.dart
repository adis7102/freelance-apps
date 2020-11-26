import 'dart:async';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:soedja_freelance/old_ver/components/button.dart';
import 'package:soedja_freelance/old_ver/components/dots.dart';
import 'package:soedja_freelance/old_ver/components/text_input.dart' as EditText;
import 'package:soedja_freelance/old_ver/components/text_input.dart';
import 'package:soedja_freelance/old_ver/constants/assets.dart';
import 'package:soedja_freelance/old_ver/constants/strings.dart';
import 'package:soedja_freelance/old_ver/constants/urls.dart';
import 'package:soedja_freelance/old_ver/models/comment.dart';
import 'package:soedja_freelance/old_ver/models/feeds.dart';
import 'package:soedja_freelance/old_ver/models/user.dart';
import 'package:soedja_freelance/old_ver/screens/portfolio/create_screen.dart';
import 'package:soedja_freelance/old_ver/screens/profile/profile_screen.dart';
import 'package:soedja_freelance/old_ver/services/comment.dart';
import 'package:soedja_freelance/old_ver/services/feeds.dart';
import 'package:soedja_freelance/old_ver/services/user.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';
import 'package:soedja_freelance/old_ver/utils/helpers.dart';
import 'package:soedja_freelance/old_ver/utils/keyboard.dart';
import 'package:soedja_freelance/old_ver/utils/navigation.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'edit_screen.dart';

class FeedsDetailScreen extends StatefulWidget {
  final Feeds item;
  final int index;
  final Function(Feeds) onUpdate;
  final String before;
  final List<File> pictures;

  FeedsDetailScreen({
    @required this.item,
    @required this.index,
    @required this.onUpdate,
    this.before,
    this.pictures,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FeedsDetailScreen();
  }
}

class _FeedsDetailScreen extends State<FeedsDetailScreen> {
  ScrollController controller = new ScrollController();

  Feeds feeds = new Feeds();
  bool isLoadingFeeds = false;

//  YoutubePlayerController youtubeController;

  TextEditingController textController = new TextEditingController();

  double scrolledHeight = 0;
  int indexGallery = 0;

  int page = 1;
  int limit = 10;
  String title = '';

  List<Comment> commentList;
  bool isEmpty = false;
  bool isLoading = true;
  bool disableLoad = false;
  bool isLoadMore = false;

  Completer<WebViewController> _controller = Completer<WebViewController>();

  void scrollListener() {
    setState(() {
      scrolledHeight = controller.position.pixels;
    });

    if (controller.position.pixels >
        controller.position.maxScrollExtent - 100) {
      if (isLoadMore && !isLoading && !disableLoad) {
        setState(() {
          disableLoad = true;
          page++;
        });

        Future.delayed(Duration(seconds: 0), () => fetchComment());
      }
    }
  }

  void fetchComment() {
    CommentPayload payload = new CommentPayload();
    payload = new CommentPayload(limit: limit, page: page);

    getComments(context: context, payload: payload);
  }

  void getComments({BuildContext context, CommentPayload payload}) async {
    CommentService()
        .getComment(payload: payload, feedId: feeds.portfolioId)
        .then((response) {
      if (page > 1) {
        if (response.length > 0) {
          setState(() {
            if (response.length < 10) {
              isLoadMore = false;
              disableLoad = true;
            } else {
              disableLoad = false;
            }
            commentList.addAll(response);
          });
        } else {
          setState(() {
            isLoadMore = false;
            disableLoad = true;
          });
        }
      } else {
        if (response.length > 0) {
          setState(() {
            isLoading = false;
            isEmpty = false;
            isLoadMore = true;
            disableLoad = false;
            commentList = response;
          });
        } else {
          setState(() {
            isLoading = false;
            disableLoad = true;
            isEmpty = true;
          });
        }
      }
    });
  }

  void giveComment() {
    GiveCommentPayload payload = new GiveCommentPayload(
        parentId: feeds.portfolioId, comment: textController.text);
    FeedsService().comment(context, payload).then((response) {
      if (response.comment != null) {
        setState(() {
          commentList.insert(
            0,
            Comment(
              comment: response.comment,
              createdAt: response.createdAt,
              userData: UserData(name: profile.name, picture: profile.picture),
            ),
          );
          textController.clear();
          feeds.commentCount++;
        });
      }

      if (isEmpty) {
        setState(() {
          isEmpty = false;
        });
      }
    });
  }

  Profile profile = new Profile();

  void fetchProfile() {
    UserService().getProfile(context).then((response) async {
      setState(() {
        profile = response;
      });
    });
  }

  void bookmarkFeed(Feeds item) async {
    BookmarkPayload payload =
        new BookmarkPayload(portfolioId: item.portfolioId);
    if (item.hasBookmark == 0) {
      FeedsService().bookmark(context, payload).then((response) async {
        if (response.portfolioId != null) {
          setState(() {
            feeds.hasBookmark = 1;
          });
        }
      });
    } else {
      FeedsService().deleteBookmark(context, item).then((response) async {
        if (response) {
          setState(() {
            feeds.hasBookmark = 0;
          });
        }
      });
    }
  }

  void likeFeed(Feeds item) async {
    LikePayload payload = new LikePayload(contentId: item.portfolioId);

    if (item.hasLike == 0) {
      FeedsService().like(context, payload).then((response) async {
        if (response.contentId != null) {
          setState(() {
            feeds.hasLike = 1;
            feeds.likeCount++;
          });
        }
      });
    } else {
      FeedsService().deleteLike(context, item).then((response) async {
        if (response) {
          setState(() {
            feeds.hasLike = 0;
            feeds.likeCount--;
          });
        }
      });
    }
  }

//  PlayerState _playerState;
//  YoutubeMetaData _videoMetaData;
//  double _volume = 100;
//  bool _muted = false;
//  bool _isPlayerReady = false;

//  void fetchYoutube() {
//    youtubeController = YoutubePlayerController(
//      initialVideoId: feeds.youtubeUrl,
//      flags: const YoutubePlayerFlags(
//        mute: false,
//        autoPlay: false,
//        disableDragSeek: false,
//        loop: false,
//        isLive: false,
//        forceHD: false,
//        enableCaption: true,
//      ),
//    )..addListener(youtubeListener);
//  }

//  void youtubeListener() {
//    if (_isPlayerReady && mounted && !youtubeController.value.isFullScreen) {
//      setState(() {
//        _playerState = youtubeController.value.playerState;
//        _videoMetaData = youtubeController.metadata;
//      });
//    }
//  }

  @override
  void initState() {
    if(widget.before == 'notification'){
//      fetchPortfolio();
      setState(() {
        isLoadingFeeds = true;
      });
    }
    feeds = widget.item;
//    fetchYoutube();
    controller.addListener(scrollListener);
    commentList = new List<Comment>();
    if (widget.before != 'preview' && widget.before != 'notification') {
      fetchComment();
    }
    fetchProfile();
    super.initState();
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
//    youtubeController.pause();
    super.deactivate();
  }

  @override
  void dispose() {
//    youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () => widget.onUpdate(feeds),
      child: Scaffold(
        appBar: appBarSection(
          context: context,
          item: feeds,
          before: widget.before,
          height: scrolledHeight,
          size: size,
          onUpdate: () => widget.onUpdate(feeds),
          onBookmark: (val) => bookmarkFeed(val),
          profile: profile,
        ),
        body: bodySection(
          isLoadingFeeds: isLoadingFeeds,
          context: context,
          profile: profile,
          before: widget.before,
          item: feeds,
          controller: controller,
          pictures: widget.pictures,
          index: indexGallery,
          size: size,
          onChangeGallery: (val) {
            setState(() {
              indexGallery = val;
            });
          },
          onLike: (val) => likeFeed(val),
          props: new TextInputProps(
              controller: textController,
              hintText: Strings.hintComment,
              validator: null,
              keyboardType: TextInputType.text,
              onFieldSubmitted: (val) {
                giveComment();
              }),
          onChanged: (val) {
            setState(() {});
          },
          webController: _controller,
          onComment: giveComment,
          isLoading: isLoading,
          isEmpty: isEmpty,
          isLoadMore: isLoadMore,
          disableLoad: disableLoad,
          list: commentList,
        ),
      ),
    );
  }
}

Widget appBarSection({
  BuildContext context,
  String before,
  Feeds item,
  double height,
  Size size,
  Function onUpdate,
  Function(Feeds) onBookmark,
  Profile profile,
}) {
  return AppBar(
    backgroundColor: AppColors.white,
    elevation: 1.0,
    iconTheme: IconThemeData(),
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: AppColors.black,
      ),
      onPressed: onUpdate,
    ),
    title: Visibility(
      visible: height > size.width + 80.0,
      child: Text(
        item.title ?? 'Title Portfolio',
        style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15.0),
      ),
    ),
    actions: <Widget>[
      Visibility(
        visible: before != 'preview',
        child: IconButton(
            icon: Icon(
              Icons.share,
              color: AppColors.black,
            ),
            onPressed: () => {}),
      ),
      Visibility(
        visible: before != 'preview' && profile.userId != null,
        child: profile.userId == item.userId
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ButtonPrimary(
                    context: context,
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    borderRadius: BorderRadius.circular(20.0),
                    child: Icon(Icons.edit, color: AppColors.black),
                    buttonColor: AppColors.light,
                    onTap: () => Navigation().navigateScreen(
                        context,
                        PortfolioCreateScreen(
                          before: 'detail',
                          item: item,
                        ))),
              )
            : IconButton(
                icon: item.hasBookmark == 0
                    ? Icon(
                        Icons.bookmark_border,
                        color: AppColors.black,
                      )
                    : Icon(
                        Icons.bookmark,
                        color: AppColors.green,
                      ),
                onPressed: () => onBookmark(item)),
      ),
      Visibility(
        visible: before == 'preview',
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: ButtonPrimary(
              borderRadius: BorderRadius.circular(15.0),
              buttonColor: AppColors.primary,
              child: Text(
                'Preview'.toUpperCase(),
                style: TextStyle(color: AppColors.white, fontSize: 10.0),
              )),
        ),
      ),
      SizedBox(width: 16.0),
    ],
  );
}

Widget bodySection({
  BuildContext context,
  bool isLoadingFeeds,
  String before,
  Profile profile,
  ScrollController controller,
  Feeds item,
  List<File> pictures,
  Size size,
  int index,
  Function(int) onChangeGallery,
//  YoutubePlayerController playerController,
  Completer<WebViewController> webController,
  Function(String) onChanged,
  TextInputProps props,
  bool isLoading,
  bool isEmpty,
  bool isLoadMore,
  bool disableLoad,
  List<Comment> list,
  Function onComment,
  Function(Feeds) onLike,
  Function youtubeListener,
}) {
  if(!isLoadingFeeds){
    return GestureDetector(
      onTap: () => Keyboard().closeKeyboard(context),
      child: ListView(
        controller: controller,
        padding: EdgeInsets.only(bottom: 24.0),
        children: <Widget>[
          gallerySection(
              context: context,
              before: before,
              size: size,
              gallery: item.pictures ?? [],
              pictures: pictures,
              index: index,
              onChanged: (val) => onChangeGallery(val)),
          dividerLine(),
          descriptionSection(
            context: context,
            size: size,
            item: item,
            before: before,
//          playerController: playerController,
            youtubeListener: youtubeListener,
            webController: webController,
            profile: profile,
          ),
          dividerColor(),
          categorySection(context: context, item: item),
          dividerColor(height: 32.0),
          before != 'preview'
              ? commentFieldSection(
            context: context,
            profile: profile,
            item: item,
            props: props,
            onChanged: (val) => onChanged(val),
            onLike: (val) => onLike(val),
            onComment: onComment,
          )
              : Container(),
          dividerLine(),
          before != 'preview'
              ? commentSection(
            context: context,
            item: item,
            list: list,
            isLoading: isLoading,
            isEmpty: isEmpty,
            isLoadMore: isLoadMore,
            disableLoad: disableLoad,
            size: size,
          )
              : Container(),
        ],
      ),
    );
  }

  return Container();
}

Widget gallerySection({
  BuildContext context,
  String before,
  Size size,
  List<Picture> gallery,
  List<File> pictures,
  int index,
  Function(int) onChanged,
}) {
  if (before != 'preview') {
    return Container(
      width: size.width,
      height: size.width + 20.0,
      child: Column(
        children: <Widget>[
          Expanded(
            child: CarouselSlider.builder(
              options: CarouselOptions(
                height: size.width,
                initialPage: index,
                onPageChanged: (val, reason) {
                  onChanged(val);
                },
                autoPlay: gallery.length > 1,
                scrollPhysics: gallery.length > 1
                    ? ClampingScrollPhysics()
                    : NeverScrollableScrollPhysics(),
                viewportFraction: 1.0,
              ),
              itemCount: gallery.length ?? 1,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    color: AppColors.light,
                    child: FadeInImage.assetNetwork(
                      placeholder: Assets.imgPlaceholder,
                      image: gallery.length > 0
                          ? BaseUrl.SoedjaAPI + '/' + gallery[index].path
                          : '',
                      width: size.width,
                      height: size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16.0),
          SliderDots(
            total: gallery.length,
            index: index,
          ),

        ],
      ),
    );
  }
  return Container(
    width: size.width,
    height: size.width + 20.0,
    child: Column(
      children: <Widget>[
        Expanded(
          child: CarouselSlider.builder(
            options: CarouselOptions(
              height: size.width,
              initialPage: index,
              onPageChanged: (val, reason) {
                onChanged(val);
              },
              autoPlay: pictures.length > 1,
              scrollPhysics: pictures.length > 1
                  ? ClampingScrollPhysics()
                  : NeverScrollableScrollPhysics(),
              viewportFraction: 1.0,
            ),
            itemCount: pictures.length ?? 1,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: AppColors.light,
                child: Image.file(
                  pictures[index],
                  width: size.width,
                  height: size.width,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
        SizedBox(height: 16.0),
        SliderDots(
          total: pictures.length,
          index: index,
        ),
      ],
    ),
  );
}

Widget dividerLine(
    {double height, Color color, double indent, double endIndent}) {
  return Divider(
    height: height ?? 32.0,
    thickness: .2,
    color: color ?? AppColors.grey707070,
    indent: indent,
    endIndent: endIndent,
  );
}

Widget dividerColor({
  double height,
  Color color,
}) {
  return Container(
    color: color ?? AppColors.light,
    height: height ?? 16.0,
    width: double.maxFinite,
    alignment: Alignment.centerLeft,
  );
}

Widget dividerText({
  double height,
  double width,
  Color color,
  Widget child,
  EdgeInsets padding,
}) {
  return Container(
    color: color ?? AppColors.light,
    child: child,
    padding: padding,
    height: height,
    width: width ?? double.infinity,
  );
}

Widget descriptionSection({
  BuildContext context,
  Size size,
  String before,
  Feeds item,
//  YoutubePlayerController playerController,
  Function youtubeListener,
  Completer<WebViewController> webController,
  Profile profile,
}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          item.title ?? 'Title Portfolio',
          style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20.0),
        ),
        dividerLine(height: 40.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                color: AppColors.light,
                child: FadeInImage.assetNetwork(
                  placeholder: avatar(item.userData.name),
                  image: BaseUrl.SoedjaAPI + '/' + item.userData.picture,
                  width: 36.0,
                  height: 36.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 8.0),
            ButtonPrimary(
              padding: EdgeInsets.all(2.0),
              buttonColor: AppColors.white,
              onTap: () {
                if (profile.userId != item.userId) {
                  Navigation().navigateScreen(
                      context,
                      ProfileScreen(
                        before: 'feeds',
                        profile: Profile(
                          name: item.userData.name,
                          picture: item.userData.picture,
                          province: item.userData.province,
                          profession: item.userData.profession,
                          rating: item.userData.rating,
                          about: item.userData.about,
                        ),
                        feeds: item,
                      ));
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.userData.name ?? 'Owner Name',
                    style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    item.userData.profession ?? 'Owner Profession',
                    style: TextStyle(
                        color: AppColors.black.withOpacity(.6), fontSize: 12.0),
                  ),
                ],
              ),
            ),
            Expanded(flex: 2,child: SizedBox(width: 8.0)),
            Expanded(flex: 3,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    color: AppColors.black,
                    size: 12.0,
                  ),
                  Expanded(
                    child: Text(
                      '${item.userData.province}, Indonesia',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 24.0),
        Text(
          item.description ?? 'Description Portfolio',
          style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.normal,
              height: 1.5,
              fontSize: 12.0),
        ),
        SizedBox(height: 16.0),
//        ClipRRect(
//          borderRadius: BorderRadius.circular(20.0),
//          child: Container(
//            color: AppColors.light,
//            height: 200.0,
//            width: size.width,
//            child: WebView(
//              initialUrl: 'https://www.youtube.com/watch?v=${item.youtubeUrl}',
//              onWebViewCreated: (WebViewController webViewController) {
//                webController.complete(webViewController);
//              },
//            ),
//          ),
//        ),
//        ClipRRect(
//          borderRadius: BorderRadius.circular(5.0),
//          child: YoutubePlayer(
//            controller: playerController,
//            showVideoProgressIndicator: true,
//          progressColors: ProgressColors(
//            playedColor: Colors.amber,
//            handleColor: Colors.amberAccent,
//          ),
//            onReady: () {
//              playerController.addListener(youtubeListener);
//            },
//          ),
//        ),
      ],
    ),
  );
}

Widget categorySection({BuildContext context, Feeds item}) {
  return Container(
    padding: EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        chipItem(
          child: Text(
            item.subCategory ?? 'Sub Category Portfolio',
            style: TextStyle(color: AppColors.white, fontSize: 10.0),
          ),
        ),
        dividerLine(),
      ],
    ),
  );
}

Widget chipItem({Widget child}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
        color: AppColors.black, borderRadius: BorderRadius.circular(15.0)),
    child: child,
  );
}

Widget commentFieldSection({
  BuildContext context,
  Profile profile,
  Feeds item,
  TextInputProps props,
  Function(String) onChanged,
  Function(Feeds) onLike,
  Function onComment,
}) {
  return Container(
    padding: EdgeInsets.all(24.0),
    height: 230.0,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ButtonPrimary(
              buttonColor: AppColors.white,
              borderRadius: BorderRadius.circular(15.0),
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              onTap: () => onLike(item),
              child: item.hasLike == 0
                  ? Image.asset(
                      Assets.iconDislike,
                      height: 22.0,
                      width: 22.0,
                    )
                  : Image.asset(
                      Assets.iconLike,
                      height: 22.0,
                      width: 22.0,
                    ),
            ),
            SizedBox(width: 8.0),
            Text(
              currency.format(item.likeCount ?? 0),
              style: TextStyle(color: AppColors.black, fontSize: 16.0),
            )
          ],
        ),
        SizedBox(height: 16.0),
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Container(
                  color: AppColors.light,
                  child: FadeInImage.assetNetwork(
                    placeholder: avatar(profile.name),
                    image: profile.picture != null
                        ? BaseUrl.SoedjaAPI + '/' + profile.picture
                        : '',
                    width: 46.0,
                    height: 46.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      border:
                          Border.all(color: AppColors.grey707070, width: .2)),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: EditText.TextInput(
                          props: props,
                          border: InputBorder.none,
                          fontSize: 12.0,
                          minLines: 1,
                          maxLines: 10,
                          maxLength: 255,
                          onChanged: (val) {
                            onChanged(val);
                          },
                        ),
                      ),
                      dividerLine(height: 8.0),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 24.0),
                          Icon(
                            Icons.info,
                            color: AppColors.grey707070,
                            size: 20.0,
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            '${props.controller.text.length}/255',
                            style: TextStyle(
                                color: AppColors.grey707070, fontSize: 10.0),
                          ),
                          Expanded(
                            child: SizedBox(width: 8.0),
                          ),
                          ButtonPrimary(
                            onTap: onComment,
                            buttonColor: AppColors.white,
                            child: Text(
                              Strings.giveComment,
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                          SizedBox(width: 4.0),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget commentSection({
  BuildContext context,
  Feeds item,
  bool isLoading,
  bool isEmpty,
  bool isLoadMore,
  bool disableLoad,
  List<Comment> list,
  Size size,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 24.0),
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.message,
              color: AppColors.black,
              size: 20.0,
            ),
            SizedBox(width: 8.0),
            Text(
              currency.format(item.commentCount ?? 0),
              style: TextStyle(color: AppColors.black, fontSize: 16.0),
            ),
            Expanded(
              child: SizedBox(width: 8.0),
            ),
            Icon(
              Icons.sort,
              color: AppColors.black,
              size: 20.0,
            ),
            SizedBox(width: 8.0),
            Text(
              Strings.newer,
              style: TextStyle(color: AppColors.black, fontSize: 12.0),
            ),
          ],
        ),
        dividerLine(),
        contentSection(
            context: context,
            isEmpty: isEmpty,
            isLoading: isLoading,
            size: size,
            list: list),
      ],
    ),
  );
}

Widget contentSection({
  BuildContext context,
  bool isLoading,
  bool isEmpty,
  List<Comment> list,
  Size size,
}) {
  if (isLoading) {
    return loaderSection(context: context, size: size, count: 3);
  } else {
    if (isEmpty) {
      return emptyCommentSection(context: context, size: size);
    } else {
      return commentList(context: context, size: size, list: list);
    }
  }
}

Widget emptyCommentSection({
  BuildContext context,
  Size size,
}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 24.0),
        LottieBuilder.asset(
          Lotties.emptyComment,
          width: size.width / 3,
        ),
        SizedBox(height: 8.0),
        Text(
          Strings.emptyComment,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppColors.grey707070,
              fontSize: 10,
              height: 1.5,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5),
        )
      ],
    ),
  );
}

Widget loaderSection({BuildContext context, Size size, int count}) {
  return ListView.separated(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40.0),
    separatorBuilder: (BuildContext context, int index) =>
        SizedBox(height: 24.0),
    itemCount: count,
    itemBuilder: (BuildContext context, int index) {
      return loaderFeeds(context: context, size: size);
    },
  );
}

Widget loaderFeeds({BuildContext context, Size size}) {
  return Shimmer.fromColors(
    baseColor: AppColors.light,
    highlightColor: AppColors.lighter,
    child: Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: Container(
              color: AppColors.light,
              width: 46.0,
              height: 46.0,
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 4.0),
                Row(
                  children: <Widget>[
                    Container(
                      color: AppColors.light,
                      width: 100.0,
                      height: 12.0,
                    ),
                    Expanded(child: SizedBox(height: 4.0)),
                    Container(
                      color: AppColors.light,
                      width: 100.0,
                      height: 10.0,
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Container(
                  color: AppColors.light,
                  width: size.width,
                  height: 12.0,
                ),
                SizedBox(height: 4.0),
                Container(
                  color: AppColors.light,
                  width: 130.0,
                  height: 12.0,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget commentList({
  BuildContext context,
  Size size,
  ScrollController controller,
  List<Comment> list,
}) {
  return ListView.separated(
    controller: controller,
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    separatorBuilder: (BuildContext context, int index) =>
        SizedBox(height: 24.0),
    itemCount: list.length,
    itemBuilder: (BuildContext context, int index) {
      return itemComment(context: context, item: list[index], size: size);
    },
  );
}

Widget itemComment({
  BuildContext context,
  Comment item,
  Size size,
}) {
  return Container(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: Container(
            color: AppColors.light,
            child: FadeInImage.assetNetwork(
              placeholder: avatar(item.userData.name),
              image: BaseUrl.SoedjaAPI + '/' + item.userData.picture ?? '',
              width: 46.0,
              height: 46.0,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 4.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      item.userData.name ?? 'Owner Name',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0),
                    ),
                  ),
                  Text(
                    dateFormat(date: item.createdAt),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(color: AppColors.grey707070, fontSize: 10.0),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Text(
                item.comment ?? '',
                style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 12.0),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
