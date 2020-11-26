import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/contact/bloc/contact_bloc.dart';
import 'package:soedja_freelance/revamp/modules/contact/bloc/contact_state.dart';
import 'package:soedja_freelance/revamp/modules/contact/models/contact_models.dart';
import 'package:soedja_freelance/revamp/modules/contact/services/contact_services.dart';
import 'package:soedja_freelance/revamp/modules/invoice/bloc/invoice_bloc.dart';
import 'package:soedja_freelance/revamp/modules/invoice/bloc/invoice_state.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/components/portfolio_components.dart';
import 'package:soedja_freelance/revamp/modules/wallet/bloc/wallet_bloc.dart';
import 'package:soedja_freelance/revamp/modules/wallet/bloc/wallet_state.dart';
import 'package:soedja_freelance/revamp/modules/wallet/components/wallet_components.dart';
import 'package:soedja_freelance/revamp/modules/wallet/models/wallet_model.dart';
import 'package:soedja_freelance/revamp/modules/wallet/screens/wallet_screens.dart';
import 'package:soedja_freelance/revamp/modules/works/components/works_components.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';
import 'package:soedja_freelance/revamp/modules/wallet/components/blueCircle.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/contact/screens/list_kontak_klien.dart';

class WorkScreen extends StatefulWidget {
  final AuthBloc authBloc;
  final TabController tabController;

  const WorkScreen({Key key, this.authBloc, this.tabController})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WorkScreen();
  }
}

class _WorkScreen extends State<WorkScreen> {
  WalletBloc walletBloc = new WalletBloc();
  InvoiceBloc invoiceBloc = new InvoiceBloc();
  KontakBloc kontakBloc = new KontakBloc();

  bool isAutoBid = false;

  ListKontakResponse kontakResponse = new ListKontakResponse();

  @override
  void initState() {
    walletBloc.requestGetWallet(context);
    invoiceBloc.requestGetTotalSlot(context);
    kontakBloc.requestGetListKontak(context, '');
    invoiceBloc.requestGetStatistic(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;

    return LiquidPullToRefresh(
      height: ScreenUtil().setHeight(90),
      color: Color(0xFF2D5ADF),
      backgroundColor: Colors.white,
      showChildOpacityTransition: false,
      onRefresh: () async {
        try {
          walletBloc.requestGetWallet(context);
          invoiceBloc.requestGetTotalSlot(context);
          kontakBloc.requestGetListKontak(context, '');
          invoiceBloc.requestGetStatistic(context);
        } catch (e) {
          print('[LOG ERROR WORKS] $e');
        }
      },
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.topRight,
                child: Image.asset('assets/illustrations/manyunberkuda.png',
                    width: ScreenUtil().setWidth(178)),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    StreamBuilder(
                        stream: widget.authBloc.getProfile,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.isLoading) {
                              return WorksProfileLoading(context: context);
                            } else if (snapshot.data.hasError) {
                              onWidgetDidBuild(() {
                                if (snapshot.data.standby) {
                                  showDialogMessage(
                                      context,
                                      snapshot.data.message,
                                      "Terjadi Kesalahan, silahkan coba lagi.");
                                  walletBloc.unStandBy();
                                }
                              });
                            } else if (snapshot.data.isSuccess) {
                              return WorksProfile(
                                  context: context,
                                  profile: snapshot.data.data);
                            }
                          }
                          return WorksProfileLoading(context: context);
                        }),
                    StreamBuilder<GetWalletState>(
                        stream: walletBloc.getWalletStatus,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.isLoading) {
                              return CardWalletWithInvoiceLoading(
                                  context: context);
                            } else if (snapshot.data.hasError) {
                              onWidgetDidBuild(() {
                                if (snapshot.data.standby) {
                                  showDialogMessage(
                                      context,
                                      snapshot.data.message,
                                      "Terjadi Kesalahan, silahkan coba lagi.");
                                  walletBloc.unStandBy();
                                }
                              });
                            } else if (snapshot.data.isSuccess) {
                              return CardWalletWithInvoice(
                                  context: context,
                                  wallet: snapshot.data.data.payload,
                                  invoiceBloc: invoiceBloc,
                                  listKontak: kontakResponse,
                                  isLoading: false,
                                  kontakBloc: kontakBloc);
                            }
                          }
                          return CardWalletWithInvoiceLoading(context: context);
                        }),
                    Container(
                      margin: EdgeInsets.only(
                          bottom: ScreenUtil().setHeight(20),
                          top: ScreenUtil().setHeight(25)),
                      child: Text(
                        'Kirim Invoice, Terima Pembayaran.',
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(12.5),
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(12),
                          right: ScreenUtil().setWidth(12),
                          bottom: ScreenUtil().setHeight(23)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          StreamBuilder<ListKontakState>(
                              stream: kontakBloc.getKontak,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data.isLoading) {
                                    return Row(
                                      children: <Widget>[
                                        Container(
                                          height: ScreenUtil().setHeight(36),
                                          width: ScreenUtil().setHeight(36),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF0F0F0),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: ScreenUtil().setWidth(10)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(
                                                    bottom: ScreenUtil()
                                                        .setHeight(4)),
                                                height:
                                                    ScreenUtil().setHeight(15),
                                                width:
                                                    ScreenUtil().setWidth(60),
                                                decoration: BoxDecoration(
                                                    color: Color(0xFFF0F0F0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            ScreenUtil()
                                                                .setHeight(5))),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    bottom: ScreenUtil()
                                                        .setHeight(4)),
                                                height:
                                                    ScreenUtil().setHeight(15),
                                                width:
                                                    ScreenUtil().setWidth(30),
                                                decoration: BoxDecoration(
                                                    color: Color(0xFFF0F0F0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            ScreenUtil()
                                                                .setHeight(5))),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    );
                                  } else if (snapshot.data.hasError) {
                                    onWidgetDidBuild(() {
                                      if (snapshot.data.standby) {
                                        showDialogMessage(
                                            context,
                                            snapshot.data.message,
                                            "Terjadi Kesalahan, silahkan coba lagi.");
                                        kontakBloc.unStandBy();
                                      }
                                    });
                                  } else if (snapshot.data.isSuccess) {
                                    kontakResponse = snapshot.data.data;
                                    return GestureDetector(
                                      onTap: () {
                                        Navigation().navigateScreen(
                                            context,
                                            ListKontakKlien(
                                              kontakResponse:
                                                  snapshot.data.data,
                                            ));
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          BlueCircle(
                                              size: ScreenUtil().setHeight(36),
                                              isIcon: true,
                                              icon: Icons.contacts),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left:
                                                    ScreenUtil().setWidth(10)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: ScreenUtil()
                                                          .setHeight(4)),
                                                  child: Text(
                                                    'Kontak Klien',
                                                    style: TextStyle(
                                                        fontSize: ScreenUtil()
                                                            .setSp(9),
                                                        fontWeight:
                                                            FontWeight.w800),
                                                  ),
                                                ),
                                                Text(
                                                  snapshot
                                                      .data.data.payload.total
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Color(0xFF22985B),
                                                    fontWeight: FontWeight.w800,
                                                    fontSize:
                                                        ScreenUtil().setSp(11),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                }
                                return GestureDetector(
                                  onTap: () {
                                    Navigation().navigateScreen(
                                        context, ListKontakKlien());
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      BlueCircle(
                                          size: ScreenUtil().setHeight(36),
                                          isIcon: true,
                                          icon: Icons.contacts),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: ScreenUtil().setWidth(10)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  bottom: ScreenUtil()
                                                      .setHeight(4)),
                                              child: Text(
                                                'Kontak Klien',
                                                style: TextStyle(
                                                    fontSize:
                                                        ScreenUtil().setSp(9),
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                            ),
                                            Text(
                                              '0',
                                              style: TextStyle(
                                                color: Color(0xFF22985B),
                                                fontWeight: FontWeight.w800,
                                                fontSize:
                                                    ScreenUtil().setSp(11),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                          StreamBuilder<GetStatisticState>(
                              stream: invoiceBloc.getStatisticStream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data.isLoading) {
                                    return Row(
                                      children: <Widget>[
                                        Container(
                                          height: ScreenUtil().setHeight(36),
                                          width: ScreenUtil().setHeight(36),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF0F0F0),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: ScreenUtil().setWidth(10)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(
                                                    bottom: ScreenUtil()
                                                        .setHeight(4)),
                                                height:
                                                    ScreenUtil().setHeight(15),
                                                width:
                                                    ScreenUtil().setWidth(60),
                                                decoration: BoxDecoration(
                                                    color: Color(0xFFF0F0F0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            ScreenUtil()
                                                                .setHeight(5))),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    bottom: ScreenUtil()
                                                        .setHeight(4)),
                                                height:
                                                    ScreenUtil().setHeight(15),
                                                width:
                                                    ScreenUtil().setWidth(30),
                                                decoration: BoxDecoration(
                                                    color: Color(0xFFF0F0F0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            ScreenUtil()
                                                                .setHeight(5))),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    );
                                  } else if (snapshot.data.hasError) {
                                    onWidgetDidBuild(() {
                                      if (snapshot.data.standby) {
                                        showDialogMessage(
                                            context,
                                            snapshot.data.message,
                                            "Terjadi Kesalahan, silahkan coba lagi.");
                                        kontakBloc.unStandBy();
                                      }
                                    });
                                  } else if (snapshot.data.isSuccess) {
                                    return GestureDetector(
                                        onTap: () {},
                                        child: Row(
                                          children: <Widget>[
                                            BlueCircle(
                                                size:
                                                    ScreenUtil().setHeight(36),
                                                isIcon: true,
                                                icon: Icons.send),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: ScreenUtil()
                                                      .setWidth(10)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: ScreenUtil()
                                                            .setHeight(4)),
                                                    child: Text(
                                                      'Invoice Aktif',
                                                      style: TextStyle(
                                                          fontSize: ScreenUtil()
                                                              .setSp(9),
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    ),
                                                  ),
                                                  Text(
                                                    snapshot.data.data.payload
                                                        .invoiceActive
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: Color(0xFF22985B),
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: ScreenUtil()
                                                          .setSp(11),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ));
                                  }
                                }
                                return Row(
                                  children: <Widget>[
                                    BlueCircle(
                                        size: ScreenUtil().setHeight(36),
                                        isIcon: true,
                                        icon: Icons.send),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(10)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                bottom:
                                                    ScreenUtil().setHeight(4)),
                                            child: Text(
                                              'Invoice Aktif',
                                              style: TextStyle(
                                                  fontSize:
                                                      ScreenUtil().setSp(9),
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                          Text(
                                            '0',
                                            style: TextStyle(
                                              color: Color(0xFF22985B),
                                              fontWeight: FontWeight.w800,
                                              fontSize: ScreenUtil().setSp(11),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              }),
                          Row(
                            children: <Widget>[
                              BlueCircle(
                                  size: ScreenUtil().setHeight(36),
                                  isIcon: true,
                                  icon: Icons.folder_special),
                              Container(
                                margin: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                          bottom: ScreenUtil().setHeight(4)),
                                      child: Text(
                                        'Proyek Saya',
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(9),
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                    Text(
                                      '25',
                                      style: TextStyle(
                                        color: Color(0xFF22985B),
                                        fontWeight: FontWeight.w800,
                                        fontSize: ScreenUtil().setSp(11),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
              color: Color(0xFFF4F4F7), height: ScreenUtil().setHeight(17)),
          Container(
            margin: EdgeInsets.only(
                top: ScreenUtil().setHeight(20),
                bottom: ScreenUtil().setHeight(17),
                left: ScreenUtil().setWidth(20)),
            child: Text(
              'Nge-Side-Hustle Yuk',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(13),
                  fontWeight: FontWeight.w800),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ScreenUtil().setHeight(15)),
                border: Border.all(color: Color(0xFFF2F2F2))),
            margin: EdgeInsets.only(
                left: ScreenUtil().setWidth(20),
                right: ScreenUtil().setWidth(20),
                bottom: ScreenUtil().setHeight(15)),
            padding: EdgeInsets.all(ScreenUtil().setHeight(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
                      child: Image.asset(
                        'assets/icons/speaker.png',
                        width: ScreenUtil().setWidth(55),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(10)),
                          child: Text(
                            'SOEDJA Studio',
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(13),
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: ScreenUtil().setHeight(3)),
                              child: Text(
                                'Bagi ilmu lewat video, dapat donasi hadiah',
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(9),
                                    color: Color(0xFF707070),
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            Text(
                              'uang langsung dari audience kamu.',
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(9),
                                  color: Color(0xFF707070),
                                  fontWeight: FontWeight.w800),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: ScreenUtil().setWidth(81),
                  child: FlatButton(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              ScreenUtil().setHeight(25))),
                      onPressed: () {
                        widget.tabController.animateTo(2);
                      },
                      child: Text(
                        'Mulai',
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(11),
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                      )),
                )
              ],
            ),
          ),
          // YellowBanner(
          //     message:
          //         "Jika proposal diterima, segera lakukan konfirmasi dalam masa 24 jam."),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ScreenUtil().setHeight(15)),
                border: Border.all(color: Color(0xFFF2F2F2))),
            padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
            margin: EdgeInsets.only(
                left: ScreenUtil().setHeight(20),
                right: ScreenUtil().setHeight(20),
                bottom: ScreenUtil().setHeight(50)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Kelola Klien",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(12),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                Container(
                  width: size.width,
                  height: ScreenUtil().setHeight(230),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(
                              ScreenUtil().setWidth(5),
                            ),
                          ),
                          padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Proposal Saya",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(12),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: ScreenUtil().setHeight(20)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Terkirim",
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(.5),
                                      fontSize: ScreenUtil().setSp(12),
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    "0",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(12),
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: ScreenUtil().setHeight(10)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Diterima",
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(.5),
                                      fontSize: ScreenUtil().setSp(12),
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    "0",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(12),
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: ScreenUtil().setHeight(10)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Ditolak",
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(.5),
                                      fontSize: ScreenUtil().setSp(12),
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    "0",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(12),
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                  child: SizedBox(
                                      height: ScreenUtil().setHeight(10))),
                              Container(
                                width: size.width,
                                height: ScreenUtil().setHeight(30),
                                child: FlatButtonText(
                                    context: context,
                                    text: "KELOLA",
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenUtil().setSp(10)),
                                    side: BorderSide(
                                        color: Colors.white, width: 1),
                                    borderRadius: BorderRadius.zero,
                                    onPressed: () =>
                                        DialogOnBoardWorks(context)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: ScreenUtil().setWidth(10)),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: GestureDetector(
                                onTap: () => DialogOnBoardWorks(context),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: ColorApps.light,
                                    borderRadius: BorderRadius.circular(
                                      ScreenUtil().setWidth(5),
                                    ),
                                  ),
                                  padding:
                                      EdgeInsets.all(ScreenUtil().setWidth(20)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Undangan",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: ScreenUtil().setSp(12),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          RotationTransition(
                                              turns: AlwaysStoppedAnimation(
                                                  180 / 360),
                                              child: Icon(
                                                Icons.keyboard_backspace,
                                                size: ScreenUtil().setSp(16),
                                              ))
                                        ],
                                      ),
                                      SizedBox(
                                          height: ScreenUtil().setHeight(20)),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Klien",
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(.5),
                                              fontSize: ScreenUtil().setSp(12),
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          Text(
                                            "0",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: ScreenUtil().setSp(12),
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: ScreenUtil().setHeight(10)),
                            GestureDetector(
                              onTap: () => DialogOnBoardWorks(context),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorApps.light,
                                  borderRadius: BorderRadius.circular(
                                    ScreenUtil().setWidth(5),
                                  ),
                                ),
                                padding:
                                    EdgeInsets.all(ScreenUtil().setWidth(20)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "Project",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        RotationTransition(
                                            turns: AlwaysStoppedAnimation(
                                                180 / 360),
                                            child: Icon(
                                              Icons.keyboard_backspace,
                                              size: ScreenUtil().setSp(16),
                                            ))
                                      ],
                                    ),
                                    SizedBox(
                                        height: ScreenUtil().setHeight(20)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "Berjalan",
                                          style: TextStyle(
                                            color: Colors.black.withOpacity(.5),
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          "0",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                        height: ScreenUtil().setHeight(10)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "Selesai",
                                          style: TextStyle(
                                            color: Colors.black.withOpacity(.5),
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          "0",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
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
                ),
                // SizedBox(height: ScreenUtil().setHeight(20)),
                // Text(
                //   "Semua project tersedia",
                //   style: TextStyle(
                //     color: Colors.black,
                //     fontSize: ScreenUtil().setSp(12),
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // SizedBox(height: ScreenUtil().setHeight(20)),
                // Container(
                //   height: ScreenUtil().setHeight(85),
                //   decoration: BoxDecoration(
                //     color: ColorApps.light,
                //     borderRadius: BorderRadius.circular(
                //       ScreenUtil().setWidth(5),
                //     ),
                //   ),
                //   padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                //   alignment: Alignment.center,
                //   child: Text(
                //     "Belum ada project",
                //     style: TextStyle(
                //       color: Colors.black.withOpacity(.5),
                //       fontSize: ScreenUtil().setSp(12),
                //       fontWeight: FontWeight.normal,
                //     ),
                //   ),
                // ),
                // SizedBox(height: ScreenUtil().setHeight(20)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
