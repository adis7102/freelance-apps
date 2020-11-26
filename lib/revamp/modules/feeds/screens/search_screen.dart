import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/assets/fonts.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/feeds/bloc/feed_bloc.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';
import 'package:soedja_freelance/revamp/modules/feeds/screens/search_feeds_screen.dart';
import 'package:soedja_freelance/revamp/modules/profile/bloc/profile_bloc.dart';
import 'package:soedja_freelance/revamp/modules/profile/models/profile_models.dart';
import 'package:soedja_freelance/revamp/modules/profile/screens/profile_search_screen.dart';

class SearchScreen extends StatefulWidget {
  final AuthBloc authBloc;
  final ProfileDetail authUser;
  final String title;
  final int index;

  const SearchScreen({
    Key key,
    @required this.authBloc,
    @required this.authUser,
    @required this.title,
    this.index = 0,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchScreen();
  }
}

class _SearchScreen extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  int tabIndex = 0;

  TextEditingController searchController = new TextEditingController();
  FeedBloc feedBloc = new FeedBloc();
  ProfileBloc profileBloc = new ProfileBloc();
  bool isTyping = false;

  @override
  void initState() {
    setTitle();
    super.initState();
  }

  setTitle() {
    setState(() {
      searchController.text = widget.title;
      tabIndex = widget.index;
      tabController =
          new TabController(vsync: this, length: 2, initialIndex: tabIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0,
        elevation: 1.0,
        leading: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: Container(
            height: AppBar().preferredSize.height,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black.withOpacity(.5), width: .2))),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () => Navigation().navigateBack(context),
            ),
          ),
        ),
        title: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: Container(
            height: AppBar().preferredSize.height,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black.withOpacity(.5), width: .2))),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Colors.black.withOpacity(.5), width: .2),
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setSp(25))),
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(15),
                        vertical: ScreenUtil().setHeight(10)),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          color: Colors.black,
                          size: ScreenUtil().setSp(24),
                        ),
                        SizedBox(width: ScreenUtil().setWidth(10)),
                        Expanded(
                          child: Container(
                            height: ScreenUtil().setHeight(30),
                            alignment: Alignment.center,
                            child: TextFormFieldOutline(
                                controller: searchController,
                                hint: Texts.searchInspiration,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: Texts.searchInspiration,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: ScreenUtil().setHeight(12)),
                                ),
                                onChanged: (val) {
//                                if (!isTyping) {
//                                  isTyping = true;
                                  setState(() {});
//                                  Future.delayed(Duration(seconds: 2))
//                                      .whenComplete(() {
//                                    isTyping = false;
//                                    if (tabIndex == 0) {
//                                      setState(() {
//                                        feedBloc.requestSearchList(context, 10,
//                                            1, searchController.text);
//                                        feedBloc.unStandBy();
//                                      });
//                                    } else {
//                                      setState(() {
//                                        profileBloc.requestSearchProfile(
//                                            context,
//                                            10,
//                                            1,
//                                            searchController.text);
//                                        profileBloc.unStandBy();
//                                      });
//                                    }
//                                  });
//                                }
                                },
                                onFieldSubmitted: (val) {
                                  Navigation().navigateScreen(
                                      context,
                                      SearchScreen(
                                        authUser: widget.authUser,
                                        authBloc: widget.authBloc,
                                        title: searchController.text,
                                        index: tabIndex,
                                      ));
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: ScreenUtil().setWidth(30)),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(56),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black.withOpacity(.5), width: .2))),
            child: TabBar(
              controller: tabController,
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(12),
                fontWeight: FontWeight.w500,
                fontFamily: Fonts.ubuntu,
              ),
              unselectedLabelStyle: TextStyle(
                color: Colors.black.withOpacity(.5),
                fontSize: ScreenUtil().setSp(12),
                fontWeight: FontWeight.normal,
                fontFamily: Fonts.ubuntu,
              ),
              onTap: (val) {
                tabIndex = val;
              },
              tabs: <Widget>[
                Tab(
                  text: "Konten",
                ),
                Tab(
                  text: "Nama Akun",
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                SearchFeedsScreen(
                  authBloc: widget.authBloc,
                  feedBloc: feedBloc,
                  title: widget.title,
                  authUser: widget.authUser,
                ),
                SearchProfileScreen(
                  authBloc: widget.authBloc,
                  profileBloc: profileBloc,
                  profileAuth: widget.authUser,
                  title: widget.title,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
