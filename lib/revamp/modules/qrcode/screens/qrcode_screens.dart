import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/lists.dart';
import 'package:soedja_freelance/revamp/assets/urls.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/account/components/share_components.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_state.dart';
import 'package:soedja_freelance/revamp/modules/auth/models/auth_models.dart';
import 'package:soedja_freelance/revamp/modules/profile/models/profile_models.dart';
import 'package:soedja_freelance/revamp/modules/profile/screens/profile_detail_screen.dart';
import 'package:soedja_freelance/revamp/modules/profile/services/profile_services.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

class QrCodeScreen extends StatefulWidget {
  final AuthBloc authBloc;
  final ProfileDetail authUser;

  const QrCodeScreen({Key key, this.authBloc, @required this.authUser})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _QrCodeScreen();
  }
}

class _QrCodeScreen extends State<QrCodeScreen> {
//  ProfileDetail profile = new ProfileDetail();

  @override
  void initState() {
    print("Auth User" + widget.authUser.toJson().toString());
    super.initState();
  }

  void scan() async {
    var data = await BarcodeScanner.scan();

    if (data.rawContent.contains("profile")) {
//      showDialogMessage(context, data.rawContent.replaceAll("profile.", ""),
//          "Terjadi Kesalahan, silahkan coba lagi.");
      Navigation().navigateScreen(
          context,
          ProfileDetailScreen(
            authUser: widget.authUser,
            authBloc: widget.authBloc,
            profileDetail: ProfileDetail(
                userId: data.rawContent.replaceAll("profile.", "")),
            before: "scan",
          ));
    } else {
      showDialogMessage(context, "QR Code Tidak Valid.",
          "Terjadi Kesalahan, silahkan coba lagi.");
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: ListView(
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(30)),
            child: Text(
              "QR CODE AKUN",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: ScreenUtil().setSp(15)),
            ),
          ),
          Container(
            height: ScreenUtil().setHeight(200),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Center(
                    child: QrImage(
                      data: "profile.${widget.authUser.userId}",
                      version: QrVersions.auto,
                      size: ScreenUtil().setHeight(200),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setSp(30)),
                      child: Container(
                        width: ScreenUtil().setWidth(50),
                        color: Colors.black.withOpacity(.05),
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: FadeInImage.assetNetwork(
                              placeholder: avatar(widget.authUser.name),
                              fit: BoxFit.cover,
                              image: widget.authUser.picture.length > 0
                                  ? BaseUrl.SoedjaAPI +
                                      "/" +
                                      widget.authUser.picture
                                  : ""),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
//          StreamBuilder<GetProfileState>(
//              stream: widget.authBloc.getProfile,
//              builder: (context, snapshot) {
//                if (snapshot.hasData) {
//                  if (snapshot.data.isLoading) {
//                    return Container(
//                        height: ScreenUtil().setHeight(200),
//                        child: Center(
//                            child: SmallLayoutLoading(context, Colors.black)));
//                  } else if (snapshot.data.hasError) {
//                    if (snapshot.data.standby) {
//                      onWidgetDidBuild(() {
//                        showDialogMessage(context, snapshot.data.message,
//                            "Terjadi kesalahan, silahkan coba lagi.");
//                      });
//                      widget.authBloc.unStandBy();
//                    }
//                  } else if (snapshot.data.isSuccess) {
//                    if (snapshot.data.standby) {
//                      profile = snapshot.data.data.payload;
//                    }
//                    return Container(
//                      height: ScreenUtil().setHeight(200),
//                      child: Stack(
//                        children: <Widget>[
//                          Positioned.fill(
//                            child: Center(
//                              child: QrImage(
//                                data: profile.userId,
//                                version: QrVersions.auto,
//                                size: ScreenUtil().setHeight(200),
//                              ),
//                            ),
//                          ),
//                          Positioned.fill(
//                            child: Center(
//                              child: ClipRRect(
//                                borderRadius: BorderRadius.circular(
//                                    ScreenUtil().setSp(30)),
//                                child: Container(
//                                  width: ScreenUtil().setWidth(50),
//                                  color: Colors.black.withOpacity(.05),
//                                  child: AspectRatio(
//                                    aspectRatio: 1 / 1,
//                                    child: FadeInImage.assetNetwork(
//                                        placeholder: avatar(profile.name),
//                                        fit: BoxFit.cover,
//                                        image: profile.picture.length > 0
//                                            ? BaseUrl.SoedjaAPI +
//                                                "/" +
//                                                profile.picture
//                                            : ""),
//                                  ),
//                                ),
//                              ),
//                            ),
//                          ),
//                        ],
//                      ),
//                    );
//                  }
//                }
//                return Container(
//                  height: ScreenUtil().setHeight(200),
//                );
//              }),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(30)),
            child: Text(
              "ATAU",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: ScreenUtil().setSp(15)),
            ),
          ),
          Row(
            children: <Widget>[
              SizedBox(width: ScreenUtil().setWidth(20)),
              Expanded(
                  flex: 1,
                  child: Container(
                    height: ScreenUtil().setHeight(56),
                    child: FlatButtonWidget(
                        color: Colors.white,
                        side: BorderSide(
                            color: Colors.black.withOpacity(.5), width: .2),
                        onPressed: scan,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Scan Qr".toUpperCase(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenUtil().setSp(15),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            SizedBox(width: ScreenUtil().setWidth(10)),
                            Container(
                              width: ScreenUtil().setWidth(16),
                              child: AspectRatio(
                                aspectRatio: 1 / 1,
                                child: Image.asset(
                                  Images.iconScanQrBlack,
                                  width: ScreenUtil().setWidth(16),
                                ),
                              ),
                            ),
                          ],
                        )),
                  )),
              SizedBox(width: ScreenUtil().setWidth(10)),
              Expanded(
                  flex: 1,
                  child: Container(
                    height: ScreenUtil().setHeight(56),
                    child: FlatButtonWidget(
                        color: Colors.white,
                        side: BorderSide(
                            color: Colors.black.withOpacity(.5), width: .2),
                        onPressed: () => shareApp(context),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Share Qr".toUpperCase(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenUtil().setSp(15),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            SizedBox(width: ScreenUtil().setWidth(10)),
                            Container(
                              width: ScreenUtil().setWidth(16),
                              child: AspectRatio(
                                aspectRatio: 1 / 1,
                                child: Icon(
                                  Icons.share,
                                  size: ScreenUtil().setWidth(16),
                                ),
                              ),
                            ),
                          ],
                        )),
                  )),
              SizedBox(width: ScreenUtil().setWidth(20)),
            ],
          ),
          SizedBox(height: ScreenUtil().setHeight(40)),
          DividerWidget(
            child: Text(
              "Kegunaan Qr Code".toUpperCase(),
              style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(10),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(qrCodeNotes.length, (index) {
              return DividerWidget(
                color: isOdd(qrCodeNotes[index]['index']) ? Colors.white : null,
                padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(10),
                    horizontal: ScreenUtil().setWidth(20)),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: ScreenUtil().setHeight(32),
                      decoration: BoxDecoration(
                        color: isOdd(qrCodeNotes[index]['index'])
                            ? ColorApps.light
                            : Colors.white,
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setHeight(18)),
                      ),
                      padding: EdgeInsets.all(ScreenUtil().setHeight(5)),
                      margin: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Container(
                          height: ScreenUtil().setHeight(32),
                          alignment: Alignment.center,
                          child: Text(
                            "${qrCodeNotes[index]['index']}.",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: ScreenUtil().setSp(10),
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        qrCodeNotes[index]['notes'],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenUtil().setSp(10),
                          fontWeight: FontWeight.normal,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          SizedBox(height: ScreenUtil().setHeight(20)),
        ],
      ),
    );
  }
}
