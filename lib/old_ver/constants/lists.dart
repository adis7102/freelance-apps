import 'package:flutter/material.dart';
import 'package:soedja_freelance/old_ver/constants/assets.dart';
import 'package:soedja_freelance/old_ver/constants/strings.dart';
import 'package:soedja_freelance/old_ver/screens/account/about_screen.dart';
import 'package:soedja_freelance/old_ver/screens/account/invite_screen.dart';
import 'package:soedja_freelance/old_ver/screens/account/privacy_policy_screen.dart';
import 'package:soedja_freelance/old_ver/screens/account/rate_screen.dart';
import 'package:soedja_freelance/old_ver/screens/interest/interest_screen.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';

List listOnBoard = [
  {
    'image': Assets.illustrationOnBoardOne,
    'title': Strings.onBoardTitleOne,
    'subtitle': Strings.onBoardSubtitleOne,
  },
  {
    'image': Assets.illustrationOnBoardTwo,
    'title': Strings.onBoardTitleTwo,
    'subtitle': Strings.onBoardSubtitleTwo,
  },
  {
    'image': Assets.illustrationOnBoardThree,
    'title': Strings.onBoardTitleThree,
    'subtitle': Strings.onBoardSubtitleThree,
  },
];

List listDashboardMenu = [
  {
    'index': 0,
    'icon': Icons.home,
  },
  {
    'index': 1,
    'icon': Icons.explore,
  },
  {
    'index': 2,
    'icon': Icons.home,
  },
  {
    'index': 3,
    'icon': Icons.notifications,
  },
  {
    'index': 4,
    'icon': Icons.account_circle,
  },
];

List listCategoryHome = [
  {
    'index': 0,
    'icon': Assets.iconFeeds,
    'title': Strings.feedsTitle,
    'subtitle': Strings.feedsSubtitle,
  },
  {
    'index': 1,
    'icon': Assets.iconWorks,
    'title': Strings.worksTitle,
    'subtitle': Strings.worksSubtitle,
  },
  {
    'index': 2,
    'icon': Assets.iconVoices,
    'title': Strings.podCastTitle,
    'subtitle': Strings.podCastSubtitle,
  },
  {
    'index': 3,
    'icon': Assets.iconNews,
    'title': Strings.newsTitle,
    'subtitle': Strings.newsSubtitle,
  },
  {
    'index': 4,
    'icon': Assets.iconVideos,
    'title': Strings.videosTitle,
    'subtitle': Strings.videosSubtitle,
  },
  {
    'index': 5,
    'icon': Assets.iconEvents,
    'title': Strings.eventsTitle,
    'subtitle': Strings.eventsSubtitle,
  },
];

List listCategoryPortfolio = [
  {
    'index': 1,
    'title': Strings.selectCategory,
  },
  {
    'index': 2,
    'title': Strings.selectSubCategory,
  },
  {
    'index': 3,
    'title': Strings.selectTypeCategory,
  },
];

List listWorksComingSoon = [
  {
    'index': 0,
    'title': Strings.autoBid,
    'icon': Assets.iconAutoBid,
  },
  {
    'index': 1,
    'title': Strings.autoMatch,
    'icon': Assets.iconAutoMatch,
  },
  {
    'index': 2,
    'title': Strings.soedjaBilling,
    'icon': Assets.iconSoedjaBilling,
  },
  {
    'index': 3,
    'title': Strings.invitation,
    'icon': Assets.iconInvitation,
  },
  {
    'index': 4,
    'title': Strings.directMatch,
    'icon': Assets.iconDirectMatch,
  },
];


List otherMenuList = [
  {
    'menuId': '01',
    'menuTitle': Strings.menuRateTitle,
    'menuIcon': Icon(
      Icons.star_border,
      color: AppColors.black,
    ),
    'menuScreen': RateScreen(
      title: Strings.rateScreenTitle,
    ),
  },
  {
    'menuId': '02',
    'menuTitle': Strings.menuPrivacyTitle,
    'menuIcon': Icon(
      Icons.description,
      color: AppColors.black,
    ),
    'menuScreen': PrivacyPolicyScreen(
      title: Strings.privacyScreenTitle,
    ),
  },
  {
    'menuId': '03',
    'menuTitle': Strings.menuAboutTitle,
    'menuIcon': Image.asset(Assets.imgLogoOnlyBlack, width: 20.0, height: 20.0,),
    'menuScreen': AboutSoedjaScreen(
      title: Strings.aboutScreenTitle,
    ),
  },
  {
    'menuId': '04',
    'menuTitle': Strings.menuInviteTitle,
    'menuIcon': Icon(
      Icons.share,
      color: AppColors.black,
    ),
    'menuScreen': InviteFriendScreen(
      title: Strings.inviteScreenTitle,
    ),
  },
  {
    'menuId': '04',
    'menuTitle': Strings.menuInterestTitle,
    'menuIcon': Image.asset(Assets.imgLogoOnlyBlack, width: 20.0, height: 20.0,),
    'menuScreen': InterestScreen(),
  },
];


List infoAppList = [
  {
    'label': Strings.developer,
    'value': Strings.ptSoedja,
  },
  {
    'label': Strings.sizeAppLabel,
    'value': Strings.sizeApp,
  },
  {
    'label': Strings.categories,
    'value': Strings.categoriesValue,
  },
];

List avatarList = [
  {
    'name': 'A',
    'value': Avatar.A,
  },
  {
    'name': 'B',
    'value': Avatar.B,
  },
  {
    'name': 'C',
    'value': Avatar.C,
  },
  {
    'name': 'D',
    'value': Avatar.D,
  },
  {
    'name': 'E',
    'value': Avatar.E,
  },
  {
    'name': 'F',
    'value': Avatar.F,
  },
  {
    'name': 'G',
    'value': Avatar.G,
  },
  {
    'name': 'H',
    'value': Avatar.H,
  },
  {
    'name': 'I',
    'value': Avatar.I,
  },
  {
    'name': 'J',
    'value': Avatar.J,
  },
  {
    'name': 'K',
    'value': Avatar.K,
  },
  {
    'name': 'L',
    'value': Avatar.L,
  },
  {
    'name': 'M',
    'value': Avatar.M,
  },
  {
    'name': 'N',
    'value': Avatar.N,
  },
  {
    'name': 'O',
    'value': Avatar.O,
  },
  {
    'name': 'P',
    'value': Avatar.P,
  },
  {
    'name': 'Q',
    'value': Avatar.Q,
  },
  {
    'name': 'R',
    'value': Avatar.R,
  },
  {
    'name': 'S',
    'value': Avatar.S,
  },
  {
    'name': 'T',
    'value': Avatar.T,
  },
  {
    'name': 'U',
    'value': Avatar.U,
  },
  {
    'name': 'V',
    'value': Avatar.V,
  },
  {
    'name': 'W',
    'value': Avatar.W,
  },
  {
    'name': 'X',
    'value': Avatar.X,
  },
  {
    'name': 'Y',
    'value': Avatar.Y,
  },
  {
    'name': 'Z',
    'value': Avatar.Z,
  },
];