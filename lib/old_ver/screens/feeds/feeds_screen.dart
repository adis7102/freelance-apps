import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:soedja_freelance/old_ver/components/button.dart';
import 'package:soedja_freelance/old_ver/constants/assets.dart';
import 'package:soedja_freelance/old_ver/constants/local_storage.dart';
import 'package:soedja_freelance/old_ver/constants/strings.dart';
import 'package:soedja_freelance/old_ver/constants/urls.dart';
import 'package:soedja_freelance/old_ver/models/feeds.dart';
import 'package:soedja_freelance/old_ver/models/user.dart';
import 'package:soedja_freelance/old_ver/screens/feeds/detail_screen.dart';
import 'package:soedja_freelance/old_ver/screens/interest/interest_screen.dart';
import 'package:soedja_freelance/old_ver/screens/profile/profile_screen.dart';
import 'package:soedja_freelance/old_ver/services/feeds.dart';
import 'package:soedja_freelance/old_ver/services/user.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';
import 'package:soedja_freelance/old_ver/utils/helpers.dart';
import 'package:soedja_freelance/old_ver/utils/local_storage.dart';
import 'package:soedja_freelance/old_ver/utils/navigation.dart';

class FeedsScreen extends StatefulWidget {
  final Profile profile;

  FeedsScreen({
    this.profile,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FeedsScreen();
  }
}

class _FeedsScreen extends State<FeedsScreen> {
  ScrollController controller = new ScrollController();

  int page = 1;
  int limit = 10;
  String title = '';

  List<Feeds> feedList;
  bool isEmpty = false;
  bool isLoading = true;
  bool disableLoad = false;
  bool isLoadMore = false;

  void scrollListener() {
    if (controller.position.pixels >
        controller.position.maxScrollExtent -
            MediaQuery.of(context).size.width) {
      if (isLoadMore && !isLoading && !disableLoad) {
        setState(() {
          disableLoad = true;
          page++;
          feedList.add(Feeds());
        });

        Future.delayed(Duration(seconds: 1), () => fetchFeeds());
      }
    }
  }

  void fetchFeeds() {
    FeedsPayload payload = new FeedsPayload();
    payload = new FeedsPayload(limit: limit, page: page, title: title);

    getFeeds(context: context, payload: payload);
  }

  void getFeeds({BuildContext context, FeedsPayload payload}) async {
    FeedsService().getFeeds(context, payload).then((response) {
      if (page > 1) {
        feedList.removeLast();
        if (response.length > 0) {
          setState(() {
            if (response.length < 10) {
              isLoadMore = false;
              disableLoad = true;
            } else {
              disableLoad = false;
            }
            feedList.addAll(response);
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
            feedList = response;
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

  void likeFeed(Feeds item, int position) async {
    LikePayload payload = new LikePayload(contentId: item.portfolioId);

    if (item.hasLike == 0) {
      FeedsService().like(context, payload).then((response) async {
        if (response.contentId != null) {
          setState(() {
            feedList[position].hasLike = 1;
            feedList[position].likeCount++;
          });
        }
      });
    } else {
      FeedsService().deleteLike(context, item).then((response) async {
        if (response) {
          setState(() {
            feedList[position].hasLike = 0;
            feedList[position].likeCount--;
          });
        }
      });
    }
  }

  void bookmarkFeed(Feeds item, int position) async {
    BookmarkPayload payload =
        new BookmarkPayload(portfolioId: item.portfolioId);
    if (item.hasBookmark == 0) {
      FeedsService().bookmark(context, payload).then((response) async {
        if (response.portfolioId != null) {
          setState(() {
            feedList[position].hasBookmark = 1;
          });
        }
      });
    } else {
      FeedsService().deleteBookmark(context, item).then((response) async {
        if (response) {
          setState(() {
            feedList[position].hasBookmark = 0;
          });
        }
      });
    }
  }

  void updateFeeds(Feeds item, int position) {
    setState(() {
      feedList[position] = item;
    });
  }

  void fetchInterest() async {
    await LocalStorage.get(LocalStorageKey.ShowInterest).then((value) {
      if (value == null) {
        Navigation().navigateScreen(
            context,
            InterestScreen(
              before: 'feeds',
              profile: profile,
              update: () {
                setState(() {
                  isLoading = true;
                  page = 1;
                });
                fetchFeeds();
              },
            ));
      }
    });
  }

  Profile profile = new Profile();

  void fetchProfile() {
    UserService().getProfile(context).then((value) async {
      setState(() {
        profile = value;
      });
    });
  }

  @override
  void initState() {
    feedList = new List<Feeds>();
    controller.addListener(scrollListener);
    fetchProfile();
    fetchFeeds();
    fetchInterest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            page = 1;
            isLoading = true;
          });
          fetchFeeds();

          return;
        },
        child: contentSection(
          context: context,
          isEmpty: isEmpty,
          isLoading: isLoading,
          size: size,
          controller: controller,
          list: feedList,
          isLoadMode: isLoadMore,
          disableLoad: disableLoad,
          profile: profile,
          onLike: (val, index) => likeFeed(val, index),
          onBookmark: (val, index) => bookmarkFeed(val, index),
          onUpdate: (val, index) => updateFeeds(val, index),
        ),
      ),
    );
  }
}

Widget contentSection({
  BuildContext context,
  bool isLoading,
  bool isEmpty,
  List<Feeds> list,
  ScrollController controller,
  Size size,
  bool isLoadMode,
  bool disableLoad,
  Function(Feeds, int) onLike,
  Function(Feeds, int) onBookmark,
  Function(Feeds, int) onUpdate,
  Profile profile,
}) {
  if (isLoading) {
    return loaderSection(context: context, size: size, count: 3);
  } else {
    if (isEmpty) {
      return emptySection(context: context, size: size);
    } else {
      return feedListSection(
        context: context,
        size: size,
        controller: controller,
        list: list,
        profile: profile,
        isLoadMore: isLoadMode,
        isLoading: isLoading,
        disableLoad: disableLoad,
        onLike: (val, index) => onLike(val, index),
        onBookmark: (val, index) => onBookmark(val, index),
        onUpdate: (val, index) => onUpdate(val, index),
      );
    }
  }
}

Widget loaderSection({BuildContext context, Size size, int count}) {
  return ListView.separated(
    shrinkWrap: true,
    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40.0),
    separatorBuilder: (BuildContext context, int index) =>
        SizedBox(height: 16.0),
    itemCount: count,
    itemBuilder: (BuildContext context, int index) {
      return loaderFeeds(context: context, size: size);
    },
  );
}

Widget loaderFeeds({BuildContext context, Size size}) {
  return Container(
    color: AppColors.light,
    height: size.width,
    width: size.width,
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Shimmer.fromColors(
            child: Container(
                width: size.width, height: size.width, color: AppColors.white),
            baseColor: AppColors.light,
            highlightColor: AppColors.lighter),
        Container(
          height: 115.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                    color: AppColors.black.withOpacity(.2),
                    blurRadius: 5,
                    offset: Offset(0.0, 4.0))
              ]),
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.all(16.0),
          child: Shimmer.fromColors(
            baseColor: AppColors.light,
            highlightColor: AppColors.lighter,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                            width: 36.0, height: 36.0, color: AppColors.white),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                width: 150.0,
                                height: 20.0,
                                color: AppColors.white),
                            SizedBox(height: 4.0),
                            Container(
                                width: 100.0,
                                height: 15.0,
                                color: AppColors.white),
                          ],
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Container(
                          width: 25.0, height: 25.0, color: AppColors.white),
                      SizedBox(width: 4.0),
                      Container(
                          width: 25.0, height: 25.0, color: AppColors.white),
                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: <Widget>[
                    Container(
                        width: 25.0, height: 25.0, color: AppColors.white),
                    SizedBox(width: 16.0),
                    Container(
                        width: 100.0, height: 30.0, color: AppColors.white),
                    Expanded(child: SizedBox(width: 16.0)),
                    Container(
                        width: 25.0, height: 25.0, color: AppColors.white),
                    SizedBox(width: 4.0),
                    Container(
                        width: 30.0, height: 20.0, color: AppColors.white),
                    SizedBox(width: 16.0),
                    Container(
                        width: 25.0, height: 25.0, color: AppColors.white),
                    SizedBox(width: 4.0),
                    Container(
                        width: 30.0, height: 20.0, color: AppColors.white),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget emptySection({BuildContext context, Size size}) {
  return ListView(
    children: <Widget>[
      SizedBox(height: 100.0),
      Image.asset(
        Assets.illustrationEmptyFeeds,
        width: 80.0,
        height: 80.0,
      ),
      SizedBox(height: 8.0),
      Text(
        Strings.notFound,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: AppColors.dark,
            fontSize: 20.0,
            height: 1.5,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5),
      ),
      SizedBox(height: 16.0),
      Text(
        Strings.emptyFeeds,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: AppColors.dark.withOpacity(.7),
            fontSize: 12.0,
            height: 1.5,
            letterSpacing: 0.5),
      ),
    ],
  );
}

Widget feedListSection({
  BuildContext context,
  Size size,
  ScrollController controller,
  List<Feeds> list,
  bool isLoading,
  bool isLoadMore,
  bool disableLoad,
  Function(Feeds, int) onLike,
  Function(Feeds, int) onBookmark,
  Function(Feeds, int) onUpdate,
  Profile profile,
}) {
  return ListView.separated(
    controller: controller,
    shrinkWrap: true,
    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40.0),
    separatorBuilder: (BuildContext context, int index) => SizedBox(
      height: 16.0,
    ),
    itemCount: list.length,
    itemBuilder: (BuildContext context, int index) {
      return cardFeeds(
          context: context,
          item: list[index],
          index: index,
          size: size,
          profile: profile,
          isLoading: list[index].category == null,
          onLike: (val) => onLike(val, index),
          onBookmark: (val) => onBookmark(val, index),
          onUpdate: (val) => onUpdate(val, index));
    },
  );
}

Widget cardFeeds({
  BuildContext context,
  int index,
  Feeds item,
  Size size,
  bool isLoading = false,
  Function(Feeds) onLike,
  Function(Feeds) onBookmark,
  Function(Feeds) onUpdate,
  Profile profile,
}) {
  if (!isLoading) {
    return GestureDetector(
      onTap: () => Navigation().navigateScreen(
          context,
          FeedsDetailScreen(
            item: item,
            index: index,
            onUpdate: (item) {
              onUpdate(item);
              Navigation().navigateBack(context);
            },
          )),
      child: Container(
        color: AppColors.light,
        height: size.width,
        width: size.width,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            FadeInImage.assetNetwork(
              placeholder: Assets.imgPlaceholder,
              image: item.pictures.length > 0
                  ? BaseUrl.SoedjaAPI + '/' + item.pictures[0].path
                  : '',
              width: size.width,
              height: size.width,
              fit: BoxFit.cover,
            ),
            Container(
              height: 115.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.black.withOpacity(.2),
                        blurRadius: 5,
                        offset: Offset(0.0, 4.0))
                  ]),
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            color: AppColors.light,
                            child: FadeInImage.assetNetwork(
                              placeholder: avatar(item.userData.name),
                              image: BaseUrl.SoedjaAPI +
                                  '/' +
                                  item.userData.picture,
                              width: 36.0,
                              height: 36.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (profile.userId == item.userId) {
                                Navigation().navigateScreen(
                                    context,
                                    FeedsDetailScreen(
                                      item: item,
                                      index: index,
                                      onUpdate: (item) {
                                        onUpdate(item);
                                        Navigation().navigateBack(context);
                                      },
                                    ));
                              } else {
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
                            child: Container(
                              color: AppColors.white,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    item.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0),
                                  ),
                                  SizedBox(height: 2.0),
                                  Text(
                                    item.userData.name,
                                    style: TextStyle(
                                        color: AppColors.black.withOpacity(.6),
                                        fontSize: 10.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        ButtonPrimary(
                          onTap: () => onBookmark(item),
                          buttonColor: AppColors.white,
                          padding: EdgeInsets.all(4.0),
                          child: item.hasBookmark == 0
                              ? Icon(
                                  Icons.bookmark_border,
                                  color: AppColors.black,
                                )
                              : Icon(
                                  Icons.bookmark,
                                  color: AppColors.green,
                                ),
                        ),
                        ButtonPrimary(
                            buttonColor: AppColors.white,
                            padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.more_vert,
                              color: AppColors.black,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: <Widget>[
                      ButtonPrimary(
                        onTap: () => onLike(item),
                        height: 25.0,
                        width: 25.0,
                        buttonColor: AppColors.white,
                        padding: EdgeInsets.all(4.0),
                        borderRadius: BorderRadius.circular(20.0),
                        child: item.hasLike == 1
                            ? Image.asset(
                                Assets.iconLike,
                                height: 20.0,
                                width: 20.0,
                              )
                            : Image.asset(
                                Assets.iconDislike,
                                height: 20.0,
                                width: 20.0,
                              ),
                      ),
                      SizedBox(width: 8.0),
                      ButtonPrimary(
                          onTap: () => Navigation().navigateScreen(
                              context,
                              FeedsDetailScreen(
                                item: item,
                                index: index,
                                onUpdate: (item) {
                                  onUpdate(item);
                                  Navigation().navigateBack(context);
                                },
                              )),
                          buttonColor: AppColors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                              color: AppColors.grey707070, width: .2),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 6.0),
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                Assets.iconComment,
                                height: 20.0,
                                width: 20.0,
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                Strings.comment,
                                style: TextStyle(
                                    color: AppColors.black.withOpacity(.6),
                                    fontSize: 10.0),
                              )
                            ],
                          )),
                      Expanded(child: SizedBox(width: 16.0)),
                      Image.asset(
                        Assets.iconLikeCount,
                        height: 25.0,
                        width: 25.0,
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        currency.format(item.likeCount),
                        style:
                            TextStyle(color: AppColors.black, fontSize: 12.0),
                      ),
                      SizedBox(width: 16.0),
                      Image.asset(
                        Assets.iconCommentCount,
                        height: 25.0,
                        width: 25.0,
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        currency.format(item.commentCount),
                        style:
                            TextStyle(color: AppColors.black, fontSize: 12.0),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  } else {
    return loaderFeeds(context: context, size: size);
  }
}
