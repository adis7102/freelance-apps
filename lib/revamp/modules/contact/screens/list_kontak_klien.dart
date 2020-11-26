import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/modules/contact/bloc/contact_bloc.dart';
import 'package:soedja_freelance/revamp/modules/contact/bloc/contact_state.dart';
import 'package:soedja_freelance/revamp/modules/contact/components/contact_components.dart';
import 'package:soedja_freelance/revamp/modules/contact/models/contact_models.dart';
import 'package:async/async.dart';
import 'package:soedja_freelance/revamp/modules/invoice/screens/form_invoice.dart';
import 'package:soedja_freelance/revamp/modules/wallet/components/blueCircle.dart';

import '../../../../old_ver/components/dialog.dart';
import '../../../helpers/navigation_helper.dart';

class ListKontakKlien extends StatefulWidget {
  final ListKontakResponse kontakResponse;
  ListKontakKlien({Key key, this.kontakResponse}) : super(key: key);

  @override
  _ListKontakKlienState createState() => _ListKontakKlienState();
}

class _ListKontakKlienState extends State<ListKontakKlien> {
  CancelableOperation cancelableOperation;
  ScrollController listController = new ScrollController();
  KontakBloc kontakBloc = new KontakBloc();
  List<ClientData> listKontak = new List<ClientData>();

  @override
  void initState() {
    kontakBloc.requestGetListKontak(context, '');
    super.initState();
  }

  // void scrollListener() {
  //   if (listController.position.pixels >
  //       listController.position.maxScrollExtent -
  //           MediaQuery.of(context).size.width) {
  //     if (isLoadMore) {
  //       page++;
  //       feedList.add(Feed());
  //       feedBloc.requestGetList(context, limit, page, title);
  //       isLoadMore = false;
  //     }
  //   }
  // }

  getListClient(name) {
    kontakBloc.requestGetListKontak(context, name);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 1.0,
          textTheme: TextTheme(),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          titleSpacing: ScreenUtil().setWidth(8),
          title: Text(
            'Kontak Klien',
            style: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil().setSp(17),
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigation().navigateBack(context);
            },
            child: Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.all(0),
              child: Icon(Icons.chevron_left, size: ScreenUtil().setSp(40)),
            ),
          ),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(20)),
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(15)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin:
                              EdgeInsets.only(right: ScreenUtil().setWidth(10)),
                          height: ScreenUtil().setHeight(40),
                          child: TextField(
                            onChanged: (value) {
                              cancelableOperation?.cancel();

                              cancelableOperation =
                                  CancelableOperation.fromFuture(Future.delayed(
                                      Duration(milliseconds: 1500), () {
                                getListClient(value);
                              }));
                            },
                            decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.search, color: Colors.black),
                                focusColor: Color(0xFF707070),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(ScreenUtil().setHeight(25)),
                                  ),
                                ),
                                filled: true,
                                hintStyle: TextStyle(
                                    color: Color(0xFF707070),
                                    fontWeight: FontWeight.w800,
                                    fontSize: ScreenUtil().setSp(14)),
                                hintText: "Cari Nama Klien..",
                                fillColor: Colors.white70),
                          ),
                        ),
                      ),
                      Container(
                        height: ScreenUtil().setHeight(40),
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(12)),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(
                                ScreenUtil().setHeight(25))),
                        child: FlatButton(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    ScreenUtil().setHeight(25))),
                            onPressed: () {
                              CreateContactModal(
                                  context: context,
                                  kontakBloc: kontakBloc,
                                  getListClient: getListClient,
                                  listKontak: widget.kontakResponse);
                            },
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(5)),
                                  child: Icon(
                                    Icons.person_add,
                                    color: Colors.white,
                                    size: ScreenUtil().setSp(18),
                                  ),
                                ),
                                Text(
                                  'Kontak',
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(11.5),
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            )),
                      )
                    ],
                  ),
                ),
                // Container(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.stretch,
                //     children: <Widget>[
                //       Container(
                //         margin: EdgeInsets.only(
                //             left: ScreenUtil().setWidth(20),
                //             bottom: ScreenUtil().setHeight(25)),
                //         child: Text(
                //           'Semua klien (${widget.kontakResponse.payload.total})',
                //           style: TextStyle(
                //               color: Color(0xFF707070),
                //               fontWeight: FontWeight.w800,
                //               fontSize: ScreenUtil().setSp(12)),
                //         ),
                //       ),
                //       Container(
                //           margin: EdgeInsets.symmetric(
                //               horizontal: ScreenUtil().setWidth(20)),
                //           child: ListView.builder(
                //               shrinkWrap: true,
                //               primary: false,
                //               itemCount:
                //                   widget.kontakResponse.payload.rows.length,
                //               physics: NeverScrollableScrollPhysics(),
                //               itemBuilder: (BuildContext context, int index) {
                //                 return ContactRow(
                //                     context: context,
                //                     clientData: widget
                //                         .kontakResponse.payload.rows[index]);
                //               }))
                //     ],
                //   ),
                // )
                StreamBuilder<ListKontakState>(
                    stream: kontakBloc.getKontak,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.isLoading) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(20),
                                    bottom: ScreenUtil().setHeight(25)),
                                width: ScreenUtil().setWidth(100),
                                height: ScreenUtil().setHeight(15),
                                decoration: BoxDecoration(
                                    color: Color(0xFFF0F0F0),
                                    borderRadius: BorderRadius.circular(
                                        ScreenUtil().setHeight(5))),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(20)),
                                child: Column(
                                  children: <Widget>[
                                    ContactRowLoading(context: context),
                                    ContactRowLoading(context: context),
                                  ],
                                ),
                              )
                            ],
                          );
                        } else if (snapshot.data.hasError) {
                          onWidgetDidBuild(() {
                            showDialogMessage(context, snapshot.data.message,
                                "Terjadi kesalahan. Silahkan coba lagi.");
                            kontakBloc.unStandBy();
                          });
                          return Container(
                              child: Center(child: ShowErrorState()));
                        } else if (snapshot.data.isSuccess) {
                          listKontak = snapshot.data.data.payload.rows;
                        }
                      }

                      if (listKontak.length > 0 &&
                          snapshot.data.data.payload.total > 0) {
                        return Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(20),
                                    bottom: ScreenUtil().setHeight(25)),
                                child: Text(
                                  'Semua klien (${snapshot.data.data.payload.total})',
                                  style: TextStyle(
                                      color: Color(0xFF707070),
                                      fontWeight: FontWeight.w800,
                                      fontSize: ScreenUtil().setSp(12)),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: ScreenUtil().setWidth(20)),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      primary: false,
                                      itemCount: listKontak.length,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                              bottom:
                                                  ScreenUtil().setHeight(25)),
                                          child: Row(
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () {
                                                  ContactDetail(
                                                      context: context,
                                                      detailClient:
                                                          listKontak[index],
                                                      kontakBloc: kontakBloc,
                                                      getListClient:
                                                          getListClient,
                                                      listKontak:
                                                          snapshot.data.data);
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      right: ScreenUtil()
                                                          .setWidth(10)),
                                                  child: BlueCircle(
                                                      size: ScreenUtil()
                                                          .setHeight(40),
                                                      isIcon: false,
                                                      content: listKontak[index]
                                                              .name[0]
                                                              .toUpperCase() +
                                                          listKontak[index]
                                                              .name[1]
                                                              .toUpperCase(),
                                                      fontSize: 15),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    ContactDetail(
                                                        context: context,
                                                        detailClient:
                                                            listKontak[index],
                                                        kontakBloc: kontakBloc,
                                                        getListClient:
                                                            getListClient,
                                                        listKontak:
                                                            snapshot.data.data);
                                                  },
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: ScreenUtil()
                                                                .setHeight(5)),
                                                        child: Text(
                                                          listKontak[index]
                                                              .name,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(14),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        listKontak[index]
                                                            .representativeName,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(11),
                                                            color: Color(
                                                                0xFF707070)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Container(
                                                      height: ScreenUtil()
                                                          .setHeight(40),
                                                      width: ScreenUtil()
                                                          .setWidth(40),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.black,
                                                              width:
                                                                  ScreenUtil()
                                                                      .setWidth(
                                                                          .5)),
                                                          shape:
                                                              BoxShape.circle),
                                                      child: Center(
                                                        child: Image.asset(
                                                          'assets/icons/gmail.png',
                                                          width: ScreenUtil()
                                                              .setWidth(23),
                                                        ),
                                                      )),
                                                  Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  ScreenUtil()
                                                                      .setWidth(
                                                                          10)),
                                                      height: ScreenUtil()
                                                          .setHeight(40),
                                                      width: ScreenUtil()
                                                          .setWidth(40),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.black,
                                                              width:
                                                                  ScreenUtil()
                                                                      .setWidth(
                                                                          .5)),
                                                          shape:
                                                              BoxShape.circle),
                                                      child: Center(
                                                        child: Image.asset(
                                                          'assets/icons/whatsapp.png',
                                                          width: ScreenUtil()
                                                              .setWidth(23),
                                                        ),
                                                      )),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigation()
                                                          .navigateScreen(
                                                              context,
                                                              FormInvoice(
                                                                listKontak: widget
                                                                    .kontakResponse,
                                                                clientData:
                                                                    listKontak[
                                                                        index],
                                                              ));
                                                    },
                                                    child: Container(
                                                        height: ScreenUtil()
                                                            .setHeight(40),
                                                        width: ScreenUtil()
                                                            .setWidth(40),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black,
                                                                width: ScreenUtil()
                                                                    .setWidth(
                                                                        .5)),
                                                            shape: BoxShape
                                                                .circle),
                                                        child: Center(
                                                          child: Icon(
                                                            Icons
                                                                .markunread_mailbox,
                                                            color: Color(
                                                                0xFF2551C7),
                                                            size: ScreenUtil()
                                                                .setWidth(20),
                                                          ),
                                                        )),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                        /* ContactRow(
                                            context: context,
                                            clientData: listKontak[index],
                                            kontakBloc: kontakBloc,
                                            getListClient: getListClient
                                            ); */
                                      }))
                            ],
                          ),
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(20),
                                  bottom: ScreenUtil().setHeight(25)),
                              width: ScreenUtil().setWidth(100),
                              height: ScreenUtil().setHeight(15),
                              decoration: BoxDecoration(
                                  color: Color(0xFFF0F0F0),
                                  borderRadius: BorderRadius.circular(
                                      ScreenUtil().setHeight(5))),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(20)),
                              child: Column(
                                children: <Widget>[
                                  Center(
                                    child: Text(
                                      'Data Tidak Ditemukan!',
                                      style: TextStyle(
                                        fontSize: ScreenUtil().setSp(13),
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF666666),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      }
                    }),
              ],
            ),
          ],
        ));
  }
}
