import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/assets/avatar.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/modules/account/screens/about_screen.dart';
import 'package:soedja_freelance/revamp/modules/account/screens/invite_screen.dart';
import 'package:soedja_freelance/revamp/modules/account/screens/privacy_policy_screen.dart';
import 'package:soedja_freelance/revamp/modules/account/screens/rate_screen.dart';
import 'package:soedja_freelance/revamp/modules/auth/screens/select_interest_screen.dart';

List listOnBoard = [
  {
    'image': Images.illustrationOnBoard1,
    'title': Texts.onBoardTitleOne,
    'subtitle': Texts.onBoardSubtitleOne,
  },
  {
    'image': Images.illustrationOnBoard2,
    'title': Texts.onBoardTitleTwo,
    'subtitle': Texts.onBoardSubtitleTwo,
  },
  {
    'image': Images.illustrationOnBoard3,
    'title': Texts.onBoardTitleThree,
    'subtitle': Texts.onBoardSubtitleThree,
  },
  {
    'image': Images.illustrationOnBoard4,
    'title': Texts.onBoardTitleFour,
    'subtitle': Texts.onBoardSubtitleFour,
  },
];

List listPhonebutton = [
  {'text': '1', 'value': '1', 'type': 'number'},
  {'text': '2', 'value': '2', 'type': 'number'},
  {'text': '3', 'value': '3', 'type': 'number'},
  {'text': '4', 'value': '4', 'type': 'number'},
  {'text': '5', 'value': '5', 'type': 'number'},
  {'text': '6', 'value': '6', 'type': 'number'},
  {'text': '7', 'value': '7', 'type': 'number'},
  {'text': '8', 'value': '8', 'type': 'number'},
  {'text': '9', 'value': '9', 'type': 'number'},
  {'text': '', 'value': '', 'type': 'empty'},
  {'text': '0', 'value': '0', 'type': 'number'},
  {'text': '<', 'value': ',', 'type': 'delete'},
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
//  {
//    'index': 2,
//    'icon': Icons.home,
//  },
  {
    'index': 3,
    'icon': Icons.notifications,
  },
  {
    'index': 4,
    'icon': Icons.account_circle,
  },
];

List listHomeMenu = [
  {
    'index': 0,
    'title': 'Linimasa',
    'desc': '',
    'icon': Images.iconHomeFeeds,
  },
  {
    'index': 1,
    'title': 'Kerja',
    'desc': '',
    'icon': Images.iconHomeWorks,
  },
  {
    'index': 2,
    'title': 'Studio',
    'desc': '',
    'icon': Images.iconHomeStudios,
  },
  {
    'index': 3,
    'title': 'QR Code',
    'desc': '',
    'icon': Images.iconHomeQrCodes,
  },
];

List drawerMenu = [
  {
    'index': 0,
    'title': 'Bantuan Via Whatsapp',
    'icon': Icon(
      Icons.perm_phone_msg,
      color: Colors.black,
    ),
  },
  {
    'index': 1,
    'title': 'Panduan Aplikasi',
    'icon': Icon(
      Icons.book,
      color: Colors.black,
    ),
  },
  {
    'index': 2,
    'title': 'Kelola Linimasa',
    'desc': '',
    'icon': Image.asset(
      Images.imgLogoOnlyBlack,
      width: 24,
      height: 24,
    ),
  },
  {
    'index': 3,
    'title': 'Pengaturan & Keluar',
    'desc': '',
    'icon': Icon(
      Icons.settings,
      color: Colors.black,
    ),
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

List otherMenuList = [
  {
    'menuId': '01',
    'menuTitle': Texts.menuRateTitle,
    'menuIcon': Icon(
      Icons.star_border,
      color: Colors.black,
      size: ScreenUtil().setWidth(20),
    ),
    'menuScreen': RateScreen(
      title: Texts.rateScreenTitle,
    ),
  },
  {
    'menuId': '02',
    'menuTitle': Texts.menuPrivacyTitle,
    'menuIcon': Icon(
      Icons.description,
      color: Colors.black,
      size: ScreenUtil().setWidth(20),
    ),
    'menuScreen': PrivacyPolicyScreen(
      title: Texts.privacyScreenTitle,
    ),
  },
  {
    'menuId': '03',
    'menuTitle': Texts.menuAboutTitle,
    'menuIcon': Image.asset(
      Images.imgLogoOnlyBlack,
      width: ScreenUtil().setWidth(20),
    ),
    'menuScreen': AboutSoedjaScreen(
      title: Texts.aboutScreenTitle,
    ),
  },
  {
    'menuId': '04',
    'menuTitle': Texts.menuInviteTitle,
    'menuIcon': Icon(
      Icons.share,
      color: Colors.black,
      size: ScreenUtil().setWidth(20),
    ),
    'menuScreen': InviteFriendScreen(
      title: Texts.inviteScreenTitle,
    ),
  },
//  {
//    'menuId': '04',
//    'menuTitle': Texts.menuInterestTitle,
//    'menuIcon': Image.asset(
//      Images.imgLogoOnlyBlack,
//      width: ScreenUtil().setWidth(20),
//    ),
//    'menuScreen': SelectInterestScreen(),
//  },
];

List infoAppList = [
  {
    'label': Texts.developer,
    'value': Texts.ptSoedja,
  },
  {
    'label': Texts.sizeAppLabel,
    'value': Texts.sizeApp,
  },
  {
    'label': Texts.categories,
    'value': Texts.categoriesValue,
  },
  {
    'label': Texts.versionApp,
    'value': Texts.versionValue,
  },
];

List withdrawNotes = [
  {
    "index": 1,
    "notes":
        "Kami sarankan memasukan nomor rekening atas nama pribadi kamu dan tidak menggunakan nama / rekening orang lain.",
  },
  {
    "index": 2,
    "notes":
        "Hal ini dilakukan untuk proses verifikasi yang lebih cepat dan keamanan transaksi.",
  }
];

List withdrawDetailsNotes = [
  {
    "index": 1,
    "notes":
        "Tim kami sewaktu-waktu akan menghubungi kamu untuk melakukan proses verifikasi request penarikan uang.",
  },
  {
    "index": 2,
    "notes": "Hal ini dilakukan untuk menjaga keamanan transaksi tarik uang.",
  },
  {
    "index": 3,
    "notes":
        "Request tarik uang dapat memakan waktu maksimum 2 x 24 Jam berdasarkan nomor antrian.",
  }
];

List qrCodeNotes = [
  {
    "index": 1,
    "notes":
        "Membantu klien untuk melakukan direct match kepada kamu untuk proyek yang ingin mereka undang.",
  },
  {
    "index": 2,
    "notes": "Menemukan proyek yang sedang available secara langsung via QR",
  }
];
