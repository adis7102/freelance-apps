import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:soedja_freelance/old_ver/components/button.dart';
import 'package:soedja_freelance/old_ver/constants/assets.dart';
import 'package:soedja_freelance/old_ver/constants/strings.dart';
import 'package:soedja_freelance/old_ver/constants/urls.dart';
import 'package:soedja_freelance/old_ver/models/feeds.dart';
import 'package:soedja_freelance/old_ver/models/portfolio.dart';
import 'package:soedja_freelance/old_ver/models/user.dart';
import 'package:soedja_freelance/old_ver/screens/account/account_screen.dart';
import 'package:soedja_freelance/old_ver/screens/feeds/detail_screen.dart';
import 'package:soedja_freelance/old_ver/screens/feeds/feeds_screen.dart';
import 'package:soedja_freelance/old_ver/screens/follows/follows_screen.dart';
import 'package:soedja_freelance/old_ver/screens/profile/info_screen.dart';
import 'package:soedja_freelance/old_ver/services/portfolio.dart';
import 'package:soedja_freelance/old_ver/services/user.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';
import 'package:soedja_freelance/old_ver/utils/helpers.dart';
import 'package:soedja_freelance/old_ver/utils/navigation.dart';

class ProfileScreen extends StatefulWidget {
  final Profile profile;
  final Feeds feeds;
  final String before;

  ProfileScreen({
    this.profile,
    this.feeds,
    this.before,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProfileScreen();
  }
}

class _ProfileScreen extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  Profile profile = new Profile();

  bool isExpandedAbout = false;

  int indexTab = 0;
  TabController tabController;

  ScrollController controller = new ScrollController();

  int page = 1;
  int limit = 10;
  String title = '';

  List<Portfolio> portfolioList = new List<Portfolio>();
  bool isEmpty = false;
  bool isLoading = true;
  bool disableLoad = false;
  bool isLoadMore = false;

  bool isLoadingFollows = true;
  FollowData followData = new FollowData(follower: 0, following: 0);

  void scrollListener() {
    if (controller.position.pixels >
        controller.position.maxScrollExtent - 100) {
      if (isLoadMore && !isLoading && !disableLoad) {
        setState(() {
          disableLoad = true;
          page++;
          if (indexTab == 0) {
            portfolioList.add(Portfolio());
            portfolioList.add(Portfolio());
          }
        });

        Future.delayed(Duration(seconds: 1), () => fetchPortfolio());
      }
    }
  }

  void fetchPortfolio() {
    if (indexTab == 0) {
      getPortfolio(
          context: context,
          payload:
              PortfolioListPayload(limit: limit, page: page, title: title));
    }
  }

  void getPortfolio(
      {BuildContext context, PortfolioListPayload payload}) async {
    PortfolioService()
        .getPortfolio(context, profile.userId, payload)
        .then((response) {
      if (page > 1) {
        portfolioList.removeLast();
        portfolioList.removeLast();
        if (response.length > 0) {
          setState(() {
            if (response.length < 10) {
              isLoadMore = false;
              disableLoad = true;
            } else {
              disableLoad = false;
            }
            portfolioList.addAll(response);
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
            portfolioList = response;
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

  void fetchProfile() {
    UserService().getProfile(context).then((value) async {
      setState(() {
        profile = value;
      });

      Future.delayed(Duration(seconds: 0), () => fetchFollows());
    });
  }

  void fetchFeedsProfile() {
    UserService()
        .getFeedsProfile(context, widget.feeds.userId)
        .then((value) async {
      setState(() {
        profile = value;
      });

      Future.delayed(Duration(seconds: 0), () => fetchFollows());
    });
  }

  void fetchFollows() {
    UserService().getFollows(context, profile.userId).then((response) async {
      if (response.following != null) {
        setState(() {
          followData = response;
        });
      }
      setState(() {
        isLoadingFollows = false;
      });
      fetchPortfolio();
    });
  }

  void refresh() {
    page = 1;
    isLoading = true;
    if (indexTab == 0) {
      fetchPortfolio();
    }
  }

  @override
  void initState() {
    profile = widget.profile;
    tabController = new TabController(length: 2, vsync: this);
    controller.addListener(scrollListener);
    if (widget.before == 'feeds') {
      fetchFeedsProfile();
    } else {
      fetchProfile();
    }
//    fetchPortfolio();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBarSection(
          context: context, profile: profile, feeds: widget.feeds),
      body: DefaultTabController(
        length: 2,
        initialIndex: indexTab,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Container(
                              color: AppColors.light,
                              child: FadeInImage.assetNetwork(
                                placeholder: avatar(profile.name != null ? profile.name : 'Nama Freelancer'),
                                image: profile.picture.length > 0
                                    ? BaseUrl.SoedjaAPI + '/' + profile.picture
                                    : '',
                                width: 60.0,
                                height: 60.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 8.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        profile.name != null ? profile.name : 'Nama Freelancer',
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    Image.asset(
                                      Assets.iconRate,
                                      height: 18.0,
                                      width: 18.0,
                                    ),
                                    SizedBox(
                                      width: 4.0,
                                    ),
                                    Text(
                                      currency.format(profile.rating != null ? profile.rating : 0),
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color:
                                              AppColors.dark.withOpacity(.7)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  profile.profession != null
                                      ? profile.profession
                                      : 'Belum ada profesi',
                                  style: TextStyle(
                                    color: AppColors.grey707070,
                                    fontSize: 12.0,
                                  ),
                                ),
                                dividerLine(height: 32.0),
                                Row(
                                  children: <Widget>[
                                    ButtonPrimary(
                                        buttonColor: AppColors.black,
                                        onTap: () =>
                                            Navigation().navigateScreen(
                                                context,
                                                ProfileInfoScreen(
                                                  profile: profile,
                                                )),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 16.0),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Text(
                                          Strings.editProfile,
                                          style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: 12.0,
                                          ),
                                        )),
                                    Expanded(
                                      child: SizedBox(
                                        width: 16.0,
                                      ),
                                    ),
                                    ButtonPrimary(
                                      padding: EdgeInsets.all(2.0),
                                      buttonColor: AppColors.white,
                                      onTap: () => Navigation().navigateScreen(
                                          context,
                                          FollowsDataScreen(
                                            profile: profile,
                                            before: 'follower',
                                          )),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            Strings.follower,
                                            style: TextStyle(
                                                color: AppColors.dark
                                                    .withOpacity(.7),
                                                fontSize: 12.0),
                                          ),
                                          SizedBox(height: 8.0),
                                          isLoadingFollows
                                              ? Shimmer.fromColors(
                                                  child: Container(
                                                    height: 13.0,
                                                    width: 40.0,
                                                    decoration: BoxDecoration(
                                                        color: AppColors.light,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0)),
                                                  ),
                                                  baseColor: AppColors.light,
                                                  highlightColor:
                                                      AppColors.lighter,
                                                )
                                              : Text(
                                                  currency.format(
                                                      followData.follower),
                                                  style: TextStyle(
                                                      color: AppColors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12.0),
                                                ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 16.0),
                                    ButtonPrimary(
                                      padding: EdgeInsets.all(2.0),
                                      buttonColor: AppColors.white,
                                      onTap: () => Navigation().navigateScreen(
                                          context,
                                          FollowsDataScreen(
                                            profile: profile,
                                            before: 'following',
                                          )),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            Strings.following,
                                            style: TextStyle(
                                                color: AppColors.dark
                                                    .withOpacity(.7),
                                                fontSize: 12.0),
                                          ),
                                          SizedBox(height: 8.0),
                                          isLoadingFollows
                                              ? Shimmer.fromColors(
                                                  child: Container(
                                                    height: 13.0,
                                                    width: 40.0,
                                                    decoration: BoxDecoration(
                                                        color: AppColors.light,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0)),
                                                  ),
                                                  baseColor: AppColors.light,
                                                  highlightColor:
                                                      AppColors.lighter,
                                                )
                                              : Text(
                                                  currency.format(
                                                      followData.following),
                                                  style: TextStyle(
                                                      color: AppColors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12.0),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    dividerColor(height: 24.0),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            Strings.about,
                            style: TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            profile.about != null
                                && profile.about.length > 1 ? profile.about
                                : 'Belum ada tentang profil',
                            maxLines: !isExpandedAbout ? 3 : null,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 12.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
//                          Visibility(
//                            visible: profile.about != null && profile.about.length > 255,
//                            child: Row(
//                              children: <Widget>[
//                                ButtonPrimary(
//                                  buttonColor: AppColors.white,
//                                  padding: EdgeInsets.all(4.0),
//                                  onTap: () {
//                                    setState(() {
//                                      isExpandedAbout = !isExpandedAbout;
//                                    });
//                                  },
//                                  child: Text(
//                                    isExpandedAbout
//                                        ? Strings.readLess
//                                        : Strings.readMore,
//                                    style: TextStyle(
//                                      color: AppColors.primary,
//                                      fontSize: 12.0,
//                                    ),
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
                        ],
                      ),
                    ),
                    dividerColor(height: 24.0),
                  ],
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: tabController,
                    onTap: (val) {
                      indexTab = val;
                      print(indexTab);
                      refresh();
                      setState(() {});
                    },
                    labelColor: AppColors.primary,
                    unselectedLabelColor: AppColors.dark.withOpacity(.7),
                    indicatorColor: AppColors.primary,
                    labelPadding: EdgeInsets.symmetric(),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    unselectedLabelStyle: TextStyle(
                      color: AppColors.dark.withOpacity(.7),
                      fontWeight: FontWeight.normal,
                      fontSize: 12.0,
                      fontFamily: Fonts.ubuntu,
                    ),
                    labelStyle: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      fontFamily: Fonts.ubuntu,
                    ),
                    tabs: [
                      Tab(text: Strings.work.toUpperCase()),
                      Tab(text: Strings.background.toUpperCase()),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: bodySection(
            context: context,
            index: indexTab,
            isEmpty: isEmpty,
            isLoading: isLoading,
            size: size,
            profile: profile,
            controller: controller,
            portfolioList: portfolioList,
            onUpdate: (val, index) {},
          ),
        ),
      ),
    );
  }
}

Widget appBarSection({BuildContext context, Profile profile, Feeds feeds}) {
  return AppBar(
    backgroundColor: AppColors.white,
    elevation: 1.0,
    textTheme: TextTheme(),
    automaticallyImplyLeading: false,
    leading: feeds.userId != null
        ? IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.black,
            ),
            onPressed: () => Navigation().navigateBack(context),
          )
        : null,
    title: feeds.userId == null
        ? Text(
            Strings.myProfile,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          )
        : null,
    actions: <Widget>[
      IconButton(
          icon: Icon(
            Icons.share,
            color: AppColors.black,
          ),
          onPressed: () => {}),
      Visibility(
        visible: feeds.userId == null,
        child: IconButton(
          icon: Icon(
            Icons.settings,
            color: AppColors.black,
          ),
          onPressed: () => Navigation().navigateScreen(
              context,
              AccountScreen(
                profile: profile,
              )),
        ),
      ),
    ],
  );
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(
    this._tabBar,
  );

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Column(
      children: <Widget>[
        Container(
          height: 48.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border(
                bottom: BorderSide(
                    color: AppColors.dark.withOpacity(.3), width: .5)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: _tabBar,
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class _SliverHeader extends SliverPersistentHeaderDelegate {
  _SliverHeader(
    this.row,
  );

  final Row row;

  @override
  double get minExtent => 50.0;

  @override
  double get maxExtent => 50.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Column(
      children: <Widget>[
        Container(
          height: 45.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border(
                bottom: BorderSide(
                    color: AppColors.dark.withOpacity(.3), width: .5)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: row,
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(_SliverHeader oldDelegate) {
    return false;
  }
}

Widget bodySection({
  BuildContext context,
  int index,
  bool isLoading,
  bool isEmpty,
  Profile profile,
  List<Portfolio> portfolioList,
  ScrollController controller,
  Size size,
  Function(Portfolio, int) onUpdate,
}) {
  if (isLoading) {
    return loaderSection(context: context, size: size, count: 6, index: index);
  } else {
    if (isEmpty) {
      return emptyProfileSection(context: context, size: size);
    } else {
      return portfolioListSection(
        context: context,
        size: size,
        profile: profile,
        controller: controller,
        list: portfolioList,
        index: index,
        onUpdate: (val, index) => onUpdate(val, index),
      );
    }
  }
}

Widget emptyProfileSection({BuildContext context, Size size}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
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
        SizedBox(height: 8.0),
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
    ),
  );
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
  }
  return Container();
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              color: AppColors.light,
              height: 13.0,
              width: 100,
            ),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.light,
                  borderRadius: BorderRadius.circular(12.0)),
              height: 23.0,
              width: 23.0,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget portfolioListSection({
  BuildContext context,
  int index,
  Size size,
  Profile profile,
  ScrollController controller,
  List<Portfolio> list,
  Function(Portfolio, int) onUpdate,
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
        return cardPortfolio(
            context: context,
            item: list[index],
            index: index,
            size: size,
            isLoading: list[index].category == null,
            onUpdate: (val) => onUpdate(val, index));
      },
    );
  }
  return Container();
}

Widget cardPortfolio({
  BuildContext context,
  int index,
  Portfolio item,
  Size size,
  bool isLoading = false,
  Function(Portfolio) onUpdate,
}) {
  if (!isLoading) {
    return GestureDetector(
      onTap: () {},
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
              Text(
                item.subCategory ?? '',
                style: TextStyle(color: AppColors.dark, fontSize: 11.0),
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
