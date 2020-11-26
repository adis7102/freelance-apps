import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:soedja_freelance/old_ver/components/button.dart';
import 'package:soedja_freelance/old_ver/constants/assets.dart';
import 'package:soedja_freelance/old_ver/constants/strings.dart';
import 'package:soedja_freelance/old_ver/constants/urls.dart';
import 'package:soedja_freelance/old_ver/models/feeds.dart';
import 'package:soedja_freelance/old_ver/models/user.dart';
import 'package:soedja_freelance/old_ver/screens/feeds/detail_screen.dart';
import 'package:soedja_freelance/old_ver/screens/feeds/feeds_screen.dart';
import 'package:soedja_freelance/old_ver/screens/profile/profile_screen.dart';
import 'package:soedja_freelance/old_ver/services/feeds.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';
import 'package:soedja_freelance/old_ver/utils/helpers.dart';
import 'package:soedja_freelance/old_ver/utils/keyboard.dart';
import 'package:soedja_freelance/old_ver//utils/navigation.dart';
import 'package:soedja_freelance/old_ver/components/text_input.dart' as EditText;
import 'package:soedja_freelance/old_ver/components/text_input.dart';

class SearchHomeScreen extends StatefulWidget {
  final Function onUpdate;

  SearchHomeScreen({
    this.onUpdate,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SearchHomeScreen();
  }
}

class _SearchHomeScreen extends State<SearchHomeScreen> {
  TextEditingController searchController = new TextEditingController();

  ScrollController controller = new ScrollController();

  int index = 0;

  int page = 1;
  int limit = 10;
  String title = '';

  List<Feeds> feedList;
  List<FeedProfiles> feedProfilesList;
  bool isEmpty = true;
  bool isLoading = false;
  bool disableLoad = false;
  bool isLoadMore = false;

  bool onSearch = false;

  void scrollListener() {
    if (controller.position.pixels >
        controller.position.maxScrollExtent - 100) {
      if (isLoadMore && !isLoading && !disableLoad) {
        setState(() {
          disableLoad = true;
          page++;
          if (index == 0) {
            feedList.add(Feeds());
            feedList.add(Feeds());
          } else {
            feedProfilesList.add(FeedProfiles());
          }
        });

        Future.delayed(Duration(seconds: 1), () => fetchFeeds());
      }
    }
  }

  void fetchFeeds() {
    if (index == 0) {
      getFeeds(
          context: context,
          payload: FeedsPayload(limit: limit, page: page, title: title));
    } else {
      getProfiles(
          context: context,
          payload: FeedsPayload(limit: limit, page: page, title: title));
    }
  }

  void getFeeds({BuildContext context, FeedsPayload payload}) async {
    FeedsService().getFeeds(context, payload).then((response) {
      onSearch = false;

      if (page > 1) {
        feedList.removeLast();
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

  void getProfiles({BuildContext context, FeedsPayload payload}) async {
    FeedsService().getProfiles(context, payload).then((response) {
      onSearch = false;

      if (page > 1) {
        feedProfilesList.removeLast();
        if (response.length > 0) {
          setState(() {
            if (response.length < 10) {
              isLoadMore = false;
              disableLoad = true;
            }
            feedProfilesList.addAll(response);
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
            feedProfilesList = response;
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

  void followProfile(FeedProfiles item, int position) async {
    FollowPayload payload = new FollowPayload(followingId: item.userId);
    if (item.hasFollow == 0) {
      FeedsService().follow(context, payload).then((response) async {
        if (response.followingId != null) {
          setState(() {
            feedProfilesList[position].hasFollow = 1;
          });
        }
      });
    } else {
      FeedsService().deleteFollow(context, item).then((response) async {
        if (response) {
          setState(() {
            feedProfilesList[position].hasFollow = 0;
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

  @override
  void initState() {
    feedList = new List<Feeds>();
    feedProfilesList = new List<FeedProfiles>();
    controller.addListener(scrollListener);
//    fetchFeeds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () => widget.onUpdate(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: appBarSection(
              context: context,
              onUpdate: widget.onUpdate,
              size: size,
              props: new TextInputProps(
                  controller: searchController,
                  hintText: Strings.searchInspiration,
                  validator: null,
                  keyboardType: TextInputType.text,
                  onFieldSubmitted: (val) {}),
              onChanged: (val) {
                if (val.isNotEmpty) {
                  if (!onSearch) {
                    print(val);

                    onSearch = true;

                    Timer(Duration(seconds: 1), () {
                      setState(() {
                        title = searchController.text;
                        page = 1;
                        isLoading = true;
                      });
                      Future.delayed(Duration(seconds: 0), () => fetchFeeds());
                    });
                  }
                } else {
                  setState(() {
                    page = 1;
                    title = '';
                    feedList.clear();
                    feedProfilesList.clear();
                    isEmpty = true;
                  });
                }
              },
              onClear: () {
                Keyboard().closeKeyboard(context);
                setState(() {
                  searchController.clear();
                  page = 1;
                  title = '';
                  feedList.clear();
                  feedProfilesList.clear();
                  isEmpty = true;
//                  isLoading = true;
                });
//                Future.delayed(Duration(seconds: 1), () => fetchFeeds());
              },
              onChangedTab: (val) {
                setState(() {
                  index = val;
                });
                if (searchController.text.isNotEmpty) {
                  setState(() {
                    page = 1;
                    isLoading = true;
                  });
                  Future.delayed(Duration(seconds: 1), () => fetchFeeds());
                }
              }),
          body: GestureDetector(
            onTap: () => Keyboard().closeKeyboard(context),
            child: bodySection(
              context: context,
              index: index,
              isEmpty: isEmpty,
              isLoading: isLoading,
              size: size,
              controller: controller,
              list: feedList,
              profileList: feedProfilesList,
              onBookmark: (val, index) => bookmarkFeed(val, index),
              onFollow: (val, index) => followProfile(val, index),
              onUpdate: (val, index) => updateFeeds(val, index),
            ),
          ),
        ),
      ),
    );
  }
}

Widget appBarSection({
  BuildContext context,
  int index,
  Size size,
  TextInputProps props,
  Function(String) onChanged,
  Function(int) onChangedTab,
  Function onClear,
  Function onUpdate,
}) {
  return AppBar(
    backgroundColor: AppColors.white,
    titleSpacing: 0.0,
    elevation: .5,
    iconTheme: IconThemeData(),
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: AppColors.black,
      ),
      onPressed: () => onUpdate(),
    ),
    title: Container(
      height: 50.0,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.center,
      child: Container(
        height: 40.0,
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: AppColors.grey707070, width: .2)),
        child: Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Icon(
                Icons.search,
                color: AppColors.black,
              ),
              SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: EditText.TextInput(
                  props: props,
                  padding:
                      EdgeInsets.symmetric(vertical: -12.0, horizontal: 8.0),
                  border: InputBorder.none,
                  onChanged: (val) {
                    onChanged(val);
                  },
                ),
              ),
              Visibility(
                visible: props.controller.text.length > 0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: ButtonPrimary(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Icon(
                      Icons.close,
                      color: AppColors.white,
                      size: 14.0,
                    ),
                    buttonColor: AppColors.grey707070,
                    padding: EdgeInsets.all(2.0),
                    onTap: onClear,
                  ),
                ),
              ),
            ],
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.0),
      ),
    ),
    bottom: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: tabSection(
            context: context,
            size: size,
            index: index,
            onChange: (val) => onChangedTab(val))),
  );
}

Widget tabSection({
  BuildContext context,
  int index,
  Size size,
  Function(int) onChange,
}) {
  return Container(
    height: 50.0,
    width: size.width,
    decoration: BoxDecoration(
        border:
            Border(top: BorderSide(color: AppColors.grey707070, width: .2))),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: TabBar(
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 3.0),
          insets: EdgeInsets.symmetric(horizontal: 16.0)),
      labelColor: AppColors.black,
      labelStyle: TextStyle(
        fontFamily: Fonts.ubuntu,
        fontSize: 12.0,
      ),
      onTap: (val) => onChange(val),
      tabs: [
        Tab(text: Strings.content),
        Tab(text: Strings.nameAccount),
      ],
    ),
  );
}

Widget bodySection({
  BuildContext context,
  int index,
  bool isLoading,
  bool isEmpty,
  List<Feeds> list,
  List<FeedProfiles> profileList,
  ScrollController controller,
  Size size,
  Function(Feeds, int) onBookmark,
  Function(FeedProfiles, int) onFollow,
  Function(Feeds, int) onUpdate,
}) {
  if (isLoading) {
    return loaderSection(context: context, size: size, count: 6, index: index);
  } else {
    if (isEmpty) {
      return emptySection(context: context, size: size);
    } else {
      return feedListSection(
        context: context,
        size: size,
        controller: controller,
        list: list,
        profilesList: profileList,
        index: index,
        onBookmark: (val, index) => onBookmark(val, index),
        onFollow: (val, index) => onFollow(val, index),
        onUpdate: (val, index) => onUpdate(val, index),
      );
    }
  }
}

Widget loaderSection({BuildContext context, Size size, int count, int index}) {
  if (index == 0) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: count,
      shrinkWrap: true,
      staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
      mainAxisSpacing: 16.0,
      crossAxisSpacing: 16.0,
      padding: EdgeInsets.all(16.0),
      itemBuilder: (BuildContext context, int index) {
        return loaderFeeds(context: context, size: size);
      },
    );
  } else {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.all(16.0),
      separatorBuilder: (BuildContext context, int index) => dividerLine(),
      itemCount: count + 4,
      itemBuilder: (BuildContext context, int index) {
        return loaderAccount(context: context, size: size);
      },
    );
  }
}

Widget loaderFeeds({BuildContext context, Size size}) {
  return Shimmer.fromColors(
    baseColor: AppColors.light,
    highlightColor: AppColors.lighter,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          color: AppColors.light,
          height: (size.width - (16 * 3)) / 2,
          width: (size.width - (16 * 3)) / 2,
        ),
        SizedBox(height: 16.0),
        Container(
          color: AppColors.light,
          height: 13.0,
          width: (size.width - (16 * 3)) / 2,
        ),
        SizedBox(height: 4.0),
        Container(
          color: AppColors.light,
          height: 13.0,
          width: (size.width - (16 * 3)) / 3,
        ),
        SizedBox(height: 16.0),
        Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                color: AppColors.light,
                width: 32.0,
                height: 32.0,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    color: AppColors.light,
                    height: 13.0,
                    width: 100.0,
                  ),
                  SizedBox(height: 4.0),
                  Container(
                    color: AppColors.light,
                    height: 13.0,
                    width: 200.0,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                color: AppColors.light,
                width: 24.0,
                height: 24.0,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget loaderAccount({BuildContext context, Size size}) {
  return Shimmer.fromColors(
    baseColor: AppColors.light,
    highlightColor: AppColors.lighter,
    child: Row(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            color: AppColors.light,
            width: 32.0,
            height: 32.0,
          ),
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                color: AppColors.light,
                width: 120.0,
                height: 12.0,
              ),
              SizedBox(height: 4.0),
              Container(
                color: AppColors.light,
                width: 100.0,
                height: 12.0,
              ),
            ],
          ),
        ),
        SizedBox(width: 16.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            color: AppColors.light,
            width: 100.0,
            height: 30.0,
          ),
        ),
      ],
    ),
  );
}

Widget feedListSection({
  BuildContext context,
  int index,
  Size size,
  ScrollController controller,
  List<Feeds> list,
  List<FeedProfiles> profilesList,
  Function(Feeds, int) onBookmark,
  Function(FeedProfiles, int) onFollow,
  Function(Feeds, int) onUpdate,
}) {
  if (index == 0) {
    return StaggeredGridView.countBuilder(
      controller: controller,
      crossAxisCount: 4,
      itemCount: list.length,
      shrinkWrap: true,
      staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
      mainAxisSpacing: 16.0,
      crossAxisSpacing: 16.0,
      padding: EdgeInsets.all(16.0),
      itemBuilder: (BuildContext context, int index) {
        return cardFeeds(
            context: context,
            item: list[index],
            index: index,
            size: size,
            isLoading: list[index].category == null,
            onBookmark: (val) => onBookmark(val, index),
            onUpdate: (val) => onUpdate(val, index));
      },
    );
  } else {
    return ListView.separated(
      controller: controller,
      shrinkWrap: true,
      padding: EdgeInsets.all(16.0),
      separatorBuilder: (BuildContext context, int index) => dividerLine(),
      itemCount: profilesList.length,
      itemBuilder: (BuildContext context, int index) {
        return cardAccount(
            context: context,
            item: profilesList[index],
            isLoading: profilesList[index].name == null,
            size: size,
            onFollow: (val) => onFollow(val, index));
      },
    );
  }
}

Widget cardFeeds({
  BuildContext context,
  int index,
  Feeds item,
  Size size,
  bool isLoading = false,
  Function(Feeds) onBookmark,
  Function(Feeds) onUpdate,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: AppColors.light,
            child: FadeInImage.assetNetwork(
              placeholder: Assets.imgPlaceholder,
              image: item.pictures.length > 0
                  ? BaseUrl.SoedjaAPI + '/' + item.pictures[0].path
                  : '',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            item.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
                fontSize: 12.0),
          ),
          SizedBox(height: 16.0),
          Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  color: AppColors.light,
                  child: FadeInImage.assetNetwork(
                    placeholder: avatar(item.userData.name),
                    image: BaseUrl.SoedjaAPI + '/' + item.userData.picture,
                    width: 32.0,
                    height: 32.0,
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
                    Text(
                      item.userData.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 10.0),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      item.userData.province + ', Indonesia',
                      style: TextStyle(
                          color: AppColors.black.withOpacity(.6),
                          fontSize: 10.0),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.0),
              ButtonPrimary(
                onTap: () => onBookmark(item),
                buttonColor: AppColors.white,
                padding: EdgeInsets.all(4.0),
                child: item.hasBookmark == 0
                    ? Icon(
                        Icons.bookmark_border,
                        color: AppColors.black,
                        size: 16.0,
                      )
                    : Icon(
                        Icons.bookmark,
                        color: AppColors.green,
                        size: 16.0,
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  } else {
    return loaderFeeds(context: context, size: size);
  }
}

Widget cardAccount({
  BuildContext context,
  FeedProfiles item,
  Size size,
  bool isLoading = false,
  Function(FeedProfiles) onFollow,
}) {
  if (!isLoading) {
    return GestureDetector(
      onTap: () => Navigation().navigateScreen(
        context,
        ProfileScreen(
          profile: Profile(
            userId: item.userId,
            name: item.name,
            picture: item.picture,
            province: item.province,
            regency: item.regency,
          ),
          before: 'feeds',
          feeds: Feeds(userId: item.userId),
        ),
      ),
      child: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                color: AppColors.light,
                child: FadeInImage.assetNetwork(
                  placeholder: avatar(item.name),
                  image: BaseUrl.SoedjaAPI + '/' + item.picture,
                  width: 32.0,
                  height: 32.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 10.0),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    item.province + ', Indonesia',
                    style: TextStyle(
                        color: AppColors.black.withOpacity(.6), fontSize: 10.0),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.0),
            ButtonPrimary(
              buttonColor:
                  item.hasFollow == 0 ? AppColors.white : AppColors.black,
              onTap: () => onFollow(item),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              width: 100.0,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: AppColors.black, width: 1.0),
              child: Text(
                item.hasFollow == 0 ? Strings.follow : Strings.followed,
                style: TextStyle(
                    color:
                        item.hasFollow == 0 ? AppColors.black : AppColors.white,
                    fontSize: 12.0),
              ),
            ),
          ],
        ),
      ),
    );
  } else {
    return loaderAccount(context: context, size: size);
  }
}
