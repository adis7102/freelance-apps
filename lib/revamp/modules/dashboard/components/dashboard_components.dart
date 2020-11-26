import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:soedja_freelance/old_ver/constants/assets.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/sharedpref_keys.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/helpers/sharedpref_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/components/portfolio_components.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/screens/create_portfolio_screen.dart';
import 'package:soedja_freelance/revamp/modules/profile/models/profile_models.dart';

DialogSupportCenterWhatsapp(BuildContext context, Function onChat) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(ScreenUtil().setSp(10))),
          ),
          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(30)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                Images.imgWhatsAppLogo,
                width: ScreenUtil().setWidth(97),
                height: ScreenUtil().setHeight(28),
              ),
              SizedBox(height: ScreenUtil().setHeight(20)),
              DividerWidget(
                  height: ScreenUtil().setHeight(29),
                  margin: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(20))),
              SizedBox(height: ScreenUtil().setHeight(20)),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                child: Text(
                  "Hey, kami disini untuk membantu pengalaman kamu"
                  "menggunakan aplikasi SOEDJA lebih baik. Silahkan pilih tombol"
                  "dibawah ini untuk memulai melaporkan kendala.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: ScreenUtil().setSp(12),
                  ),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(20)),
              YellowBanner(
                  message:
                      "Kami akan melakukan response chat kamu dalam waktu beberapa jam"),
              SizedBox(height: ScreenUtil().setHeight(30)),
              Container(
                height: ScreenUtil().setHeight(56),
                width: size.width,
                margin:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                child: FlatButtonText(
                    context: context,
                    color: Colors.black,
                    text: "Chat Admin".toUpperCase(),
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(15)),
                    onPressed: onChat),
              ),
            ],
          ),
        );
      });
}

class Notifikasi {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> showNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'info01', 'SOEDJA', 'Notifikasi Info',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: 'item x');
  }

  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }
}

Widget contentTips({
  BuildContext context,
  int index,
  Function onNext,
  Function onBack,
  Function onClose,
}) {
  return Container(
    height: 110,
    width: 300,
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(5)),
    padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 2,
                color: AppColors.primary,
              ),
              SizedBox(width: 10),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: showCaseList[index]['title'],
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: Fonts.ubuntu,
                    ),
                    children: [
                      TextSpan(
                        text: "\n\n${showCaseList[index]['subtitle']}",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          fontFamily: Fonts.ubuntu,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  ShowCaseWidget.of(context).dismiss();
                  onClose();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFEBEBEB),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(2),
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
//            index != 0
//                ? GestureDetector(
//                    onTap: onBack,
//                    child: Container(
//                      decoration: BoxDecoration(
//                        color: Colors.black,
//                        borderRadius: BorderRadius.circular(20),
//                      ),
//                      padding: EdgeInsets.all(4),
//                      child: Icon(
//                        Icons.arrow_back_ios,
//                        color: Colors.white,
//                        size: 15,
//                      ),
//                    ),
//                  )
//                :
            Container(),
            Container(
              height: 35,
              child: FlatButtonText(
                onPressed: onNext,
                text: index == 9 ? "SELESAI" : "LANJUT",
                textStyle: TextStyle(color: AppColors.primary, fontSize: 12),
                color: Colors.white,
                padding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

List showCaseList = [
  {
    "title": "Timeline Inspirasi.",
    "subtitle": "Disini konten para kreator yang diikuti.",
  },
  {
    "title": "Buka Pendapatan.",
    "subtitle": "Galang interaksi & cari klien disini.",
  },
  {
    "title": "Streaming Video.",
    "subtitle": "Inspirasi & program dari kreator.",
  },
  {
    "title": "QR Code",
    "subtitle": "Gunakan untuk banyak kemudahan.",
  },
  {
    "title": "Daftar Konten.",
    "subtitle": "Simpan & buat list konten favorite.",
  },
  {
    "title": "Pencarian.",
    "subtitle": "Cari portfolio, konten & kreator.",
  },
  {
    "title": "Jelajahi Portfolio.",
    "subtitle": "Semua konten dalam satu halaman.",
  },
  {
    "title": "Upload Konten.",
    "subtitle": "Publikasi karya, portfolio & video.",
  },
  {
    "title": "Aktivitas Terbaru.",
    "subtitle": "Notifikasi dari konten kamu.",
  },
  {
    "title": "Profile Kreator",
    "subtitle": "Kelola informasi tentang kamu.",
  },
];

Future<dynamic> showFirstTipsDialog({
  BuildContext context,
  Function(String) onTap,
  ProfileDetail authUser,
}) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      Size size = MediaQuery.of(context).size;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigation().navigateBack(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFEBEBEB),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
          SizedBox(height: 10),
          Container(
            width: size.width,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  "assets/images/img_soedja_logo_only.png",
                  height: 30,
                  width: 30,
                ),
                SizedBox(height: 10),
                Text(
                  "Selamat Datang,\n${authUser.name}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(20),
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Kami sangat senang kamu telah menjadi bagian"
                  "\ndari komunitas kreatif SOEDJA.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: ScreenUtil().setSp(14),
                    height: 1.5,
                  ),
                ),
                Divider(height: 40),
                Text(
                  "Mulai bangun kolaborasi dengan : ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(14),
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Color(0xFF707070), width: .2)),
                  child: ListTile(
                    onTap: () {
                      onTap("explore");
                    },
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    leading: Icon(
                      Icons.card_giftcard,
                      color: Colors.black,
                    ),
                    title: Text(
                      "Cari konten & Dukung kreator ",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Color(0xFF707070), width: .2)),
                  child: ListTile(
                    onTap: () {
                      onTap("portfolio");
                    },
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    leading: Image.asset("assets/icons/ic_store.png"),
                    title: Text(
                      "Publikasi portfolio untuk cari klien",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Color(0xFF707070), width: .2)),
                  child: ListTile(
                    onTap: () {
                      onTap("studio");
                    },
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    leading: Image.asset("assets/icons/ic_money.png"),
                    title: Text(
                      "Galang pendapatan dari program video",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      );
    },
  );
}
