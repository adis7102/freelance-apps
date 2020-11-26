import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/lists.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/category/bloc/category_bloc.dart';
import 'package:soedja_freelance/revamp/modules/dashboard/components/dashboard_components.dart';
import 'package:soedja_freelance/revamp/modules/feeds/bloc/feed_bloc.dart';
import 'package:soedja_freelance/revamp/modules/feeds/screens/feeds_screen.dart';
import 'package:soedja_freelance/revamp/modules/feeds/screens/search_screen.dart';
import 'package:soedja_freelance/revamp/modules/feeds/screens/studio_screen.dart';
import 'package:soedja_freelance/revamp/modules/home/components/appbar_component.dart';
import 'package:soedja_freelance/revamp/modules/profile/models/profile_models.dart';
import 'package:soedja_freelance/revamp/modules/qrcode/screens/qrcode_screens.dart';
import 'package:soedja_freelance/revamp/modules/works/screens/work_screen.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

class HomeScreen extends StatefulWidget {
  final AuthBloc authBloc;
  final FeedBloc feedBloc;
  final ProfileDetail authUser;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final List<GlobalKey> keyList;
  final int homeIndex;
  final Function(int) onChangeIndex;
  final TabController tabController;
  final Function onClose;

  const HomeScreen({
    Key key,
    this.authBloc,
    this.scaffoldKey,
    this.authUser,
    this.feedBloc,
    this.keyList,
    this.homeIndex = 0,
    this.onChangeIndex,
    this.tabController,
    this.onClose,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

TabController tabController;

class _HomeScreen extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    print("Auth User" + widget.authUser.toJson().toString());
    super.initState();
    tabController = new TabController(
        vsync: this, length: 4, initialIndex: widget.homeIndex);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0,
        leading: LeadingDrawer(context, widget.scaffoldKey),
        title: Showcase.withWidget(
          disableAnimation: true,
          key: widget.keyList[5],
          container: contentTips(
            context: context,
            index: 5,
            onNext: () {
              ShowCaseWidget.of(context).startShowCase([widget.keyList[6]]);
            },
            onClose: widget.onClose,
          ),
          shapeBorder: CircleBorder(),
          width: 300,
          height: 120,
          child: TitleAppBar(
            context: context,
            onSearch: () => Navigation().navigateScreen(
                context,
                SearchScreen(
                  authBloc: widget.authBloc,
                  authUser: widget.authUser,
                  title: "",
                )),
          ),
        ),
        actions: <Widget>[
//          MessageAppBar(context),
          Showcase.withWidget(
            disableAnimation: true,
            key: widget.keyList[4],
            container: contentTips(
              context: context,
              index: 4,
              onNext: () {
                ShowCaseWidget.of(context)
                    .startShowCase([widget.keyList[5], widget.keyList[6]]);
              },
              onClose: widget.onClose,
            ),
            shapeBorder: CircleBorder(),
            width: 300,
            height: 120,
            child: BookmarkAppBar(context, widget.authUser, widget.authBloc),
          ),
        ],
        bottom: TabBar(
          labelColor: ColorApps.primary,
          isScrollable: true,
          unselectedLabelColor: Colors.black.withOpacity(.5),
          labelPadding: EdgeInsets.zero,
          indicatorSize: TabBarIndicatorSize.label,
          indicator: BoxDecoration(),
          controller: tabController,
          onTap: (index) {
            widget.onChangeIndex(index);
          },
          tabs: List.generate(
            listHomeMenu.length,
            (index) => TabHomeMenu(
              context,
              widget.homeIndex,
              index,
              [
                widget.keyList[0],
                widget.keyList[1],
                widget.keyList[2],
                widget.keyList[3],
              ],
              widget.keyList[4],
              widget.onClose,
            ),
          ),
        ),
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          FeedsScreen(
            authBloc: widget.authBloc,
            authUser: widget.authUser,
          ),
          WorkScreen(authBloc: widget.authBloc, tabController: tabController),
          StudioScreen(
            authBloc: widget.authBloc,
            feedBloc: widget.feedBloc,
            authUser: widget.authUser,
          ),
          QrCodeScreen(
            authBloc: widget.authBloc,
            authUser: widget.authUser,
          ),
//          FeedsScreen(
//            authBloc: widget.authBloc,
//            profileAuth: widget.profileAuth,
//          ),
//          WorkScreen(authBloc: widget.authBloc),
//          StudioScreen(
//            authBloc: widget.authBloc,
//            profileAuth: widget.profileAuth,
//          ),
//          QrCodeScreen(
//            authBloc: widget.authBloc,
//            profileAuth: widget.profileAuth,
//          ),
        ],
      ),
    );
  }
}

void changeIndex(int index) {
  tabController.animateTo(index);
}
