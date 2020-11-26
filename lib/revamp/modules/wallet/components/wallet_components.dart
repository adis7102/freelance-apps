import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/modules/contact/bloc/contact_bloc.dart';
import 'package:soedja_freelance/revamp/modules/contact/bloc/contact_state.dart';
import 'package:soedja_freelance/revamp/modules/contact/models/contact_models.dart';
import 'package:soedja_freelance/revamp/modules/invoice/bloc/invoice_bloc.dart';
import 'package:soedja_freelance/revamp/modules/invoice/bloc/invoice_state.dart';
import 'package:soedja_freelance/revamp/modules/invoice/screens/form_invoice.dart';
import 'package:soedja_freelance/revamp/modules/wallet/models/wallet_model.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:soedja_freelance/revamp/modules/invoice/screens/list_harga_invoice.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';

Widget WalletAmount(BuildContext context, int amount, bool showChevron) {
  return Row(
    children: <Widget>[
      ClipRRect(
        borderRadius: BorderRadius.circular(ScreenUtil().setSp(20)),
        child: Container(
          width: ScreenUtil().setWidth(35),
          color: Colors.black,
          alignment: Alignment.center,
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: Icon(
              Icons.account_balance_wallet,
              color: Colors.white,
              size: ScreenUtil().setSp(20),
            ),
          ),
        ),
      ),
      SizedBox(width: ScreenUtil().setWidth(10)),
      Text(
        "Rp",
        style: TextStyle(
            color: Colors.black.withOpacity(.8),
            fontWeight: FontWeight.normal,
            fontSize: ScreenUtil().setSp(10)),
      ),
      SizedBox(width: ScreenUtil().setWidth(10)),
      Text(
        formatCurrency.format(amount),
        style: TextStyle(
            color: Colors.black.withOpacity(.8),
            fontWeight: FontWeight.bold,
            fontSize: ScreenUtil().setSp(15)),
      ),
      SizedBox(width: ScreenUtil().setWidth(10)),
      Visibility(
        visible: showChevron,
        child: Icon(
          Icons.arrow_forward_ios,
          color: Colors.black,
          size: ScreenUtil().setSp(20),
        ),
      ),
    ],
  );
}

Widget CardWalletLoader(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(ScreenUtil().setSp(5)),
      boxShadow: [
        BoxShadow(blurRadius: 5, offset: Offset(1, 3), color: Colors.black26)
      ],
    ),
    margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(15)),
    padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(30),
        vertical: ScreenUtil().setHeight(20)),
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(ScreenUtil().setSp(20)),
              child: Container(
                width: ScreenUtil().setWidth(35),
                color: Colors.black.withOpacity(.05),
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                ),
              ),
            ),
            SizedBox(width: ScreenUtil().setWidth(10)),
            Text(
              "Rp",
              style: TextStyle(
                  color: Colors.black.withOpacity(.8),
                  fontWeight: FontWeight.normal,
                  fontSize: ScreenUtil().setSp(10)),
            ),
            SizedBox(width: ScreenUtil().setWidth(10)),
          ],
        ),
      ],
    ),
  );
}

Widget CardWallet(
    {BuildContext context,
    Wallet wallet,
    bool isActive,
    Function onClickWallet,
    Function(bool) onActivation}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(ScreenUtil().setSp(5)),
      boxShadow: [
        BoxShadow(blurRadius: 5, offset: Offset(1, 3), color: Colors.black26)
      ],
    ),
    margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(15)),
    padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(30),
        vertical: ScreenUtil().setHeight(20)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Row(
          children: <Widget>[
            GestureDetector(
              onTap: onClickWallet,
              child: Container(
                color: Colors.white,
                child: WalletAmount(context, wallet.amount, true),
              ),
            ),
            Expanded(child: Container()),
            CupertinoSwitch(
              value: isActive,
              onChanged: (value) {
                onActivation(value);
              },
              activeColor: ColorApps.green,
              trackColor: ColorApps.light,
            ),
          ],
        ),
        SizedBox(height: ScreenUtil().setHeight(10)),
        Text(
          isActive ? "Non-Aktifkan Auto Bid" : "Aktifkan Auto Bid",
          style: TextStyle(
            fontSize: ScreenUtil().setSp(10),
            color: Colors.black.withOpacity(.8),
            fontWeight: FontWeight.normal,
          ),
        )
      ],
    ),
  );
}

Widget CardWalletWithInvoice(
    {BuildContext context,
    InvoiceBloc invoiceBloc,
    Wallet wallet,
    bool isLoading,
    ListKontakResponse listKontak,
    KontakBloc kontakBloc}) {
  return Container(
    child: Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(ScreenUtil().setSp(15)),
                topRight: Radius.circular(ScreenUtil().setSp(15))),
            border: Border.all(color: Color(0xFFEAEAEA)),
          ),
          padding: EdgeInsets.all(ScreenUtil().setWidth(18)),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Saldo Aktif, klik & Cek Riwayat',
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(10),
                                color: Color(0xFF707070),
                                fontWeight: FontWeight.w800),
                          ),
                          RotationTransition(
                              turns: AlwaysStoppedAnimation(180 / 360),
                              child: Icon(
                                Icons.keyboard_backspace,
                                size: ScreenUtil().setSp(12),
                                color: Color(0xFF707070),
                              ))
                        ],
                      ),
                    ),
                    StreamBuilder(
                      stream: invoiceBloc.getSlot,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.isLoading) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFF4F4F4),
                                borderRadius: BorderRadius.circular(
                                    ScreenUtil().setSp(25)),
                              ),
                              height: ScreenUtil().setHeight(40),
                              width: ScreenUtil().setWidth(140),
                              padding: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(8)),
                            );
                          } else if (snapshot.data.hasError) {
                            onWidgetDidBuild(() {
                              if (snapshot.data.standby) {
                                showDialogMessage(
                                    context,
                                    snapshot.data.message,
                                    "Terjadi Kesalahan, silahkan coba lagi.");
                                invoiceBloc.unStandBy();
                              }
                            });
                          } else if (snapshot.data.isSuccess) {
                            return GestureDetector(
                              onTap: () {
                                Navigation().navigateScreen(
                                    context, ListHargaInvoice());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        ScreenUtil().setSp(25)),
                                    border:
                                        Border.all(color: Color(0xFFDCDCDC))),
                                height: ScreenUtil().setHeight(40),
                                width: ScreenUtil().setWidth(140),
                                padding: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(8)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                          right: ScreenUtil().setWidth(4)),
                                      child: Image.asset(
                                        'assets/icons/rocket_b.png',
                                        width: 25,
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        'Slot Invoice',
                                        style: TextStyle(
                                            color: Color(0xFF707070),
                                            fontSize: ScreenUtil().setSp(9),
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                    Container(
                                      height: ScreenUtil().setHeight(40),
                                      width: ScreenUtil().setWidth(40),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF4F4F7),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${snapshot.data.data.payload.slot}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: ScreenUtil().setSp(13),
                                              fontWeight: FontWeight.w800,
                                              color: Colors.black),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                        }
                        return GestureDetector(
                          onTap: () {
                            Navigation().navigateScreen(
                                context,
                                ListHargaInvoice(
                                    // authBloc: widget.authBloc,
                                    //  version: widget.version,
                                    ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    ScreenUtil().setSp(25)),
                                border: Border.all(color: Color(0xFFDCDCDC))),
                            height: ScreenUtil().setHeight(40),
                            width: ScreenUtil().setWidth(140),
                            padding:
                                EdgeInsets.only(left: ScreenUtil().setWidth(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(4)),
                                  child: Image.asset(
                                    'assets/icons/rocket_b.png',
                                    width: 25,
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    'Slot Invoice',
                                    style: TextStyle(
                                        color: Color(0xFF707070),
                                        fontSize: ScreenUtil().setSp(9),
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                                Container(
                                  height: ScreenUtil().setHeight(40),
                                  width: ScreenUtil().setWidth(40),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF4F4F7),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '0',
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(13),
                                          fontWeight: FontWeight.w800,
                                          color: Colors.black),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                right: ScreenUtil().setWidth(3)),
                            child: Text(
                              'Rp',
                              style: TextStyle(
                                  color: Color(0xFF13985B),
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              isLoading
                                  ? '0'
                                  : '${formatCurrency.format(wallet.amount)}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(25),
                                  fontWeight: FontWeight.w800),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigation().navigateScreen(
                          context,
                          ListHargaInvoice(
                              // authBloc: widget.authBloc,
                              //  version: widget.version,
                              ));
                    },
                    child: Column(
                      children: <Widget>[
                        Triangle.isosceles(
                          edge: Edge.TOP,
                          child: Container(
                              color: Colors.black,
                              width: ScreenUtil().setWidth(30),
                              height: ScreenUtil().setHeight(8)),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(ScreenUtil().setSp(25)),
                              color: Colors.black),
                          height: ScreenUtil().setHeight(35),
                          width: ScreenUtil().setWidth(140),
                          child: Center(
                            child: Text(
                              'Beli Kuota Invoice Yuk.',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(9),
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(ScreenUtil().setWidth(18)),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF1B44A6), Color(0xFF2E5CE3)]),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(ScreenUtil().setSp(15)),
                  bottomRight: Radius.circular(ScreenUtil().setSp(15)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              StreamBuilder<GetStatisticState>(
                  stream: invoiceBloc.getStatisticStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.isLoading) {
                        return Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  right: ScreenUtil().setWidth(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      margin: EdgeInsets.only(
                                          bottom: ScreenUtil().setHeight(5)),
                                      height: ScreenUtil().setSp(10),
                                      width: ScreenUtil().setWidth(65),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2)))),
                                  Container(
                                      height: ScreenUtil().setSp(12),
                                      width: ScreenUtil().setWidth(45),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2)))),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  right: ScreenUtil().setWidth(15)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      margin: EdgeInsets.only(
                                          bottom: ScreenUtil().setHeight(5)),
                                      height: ScreenUtil().setSp(12),
                                      width: ScreenUtil().setWidth(65),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2)))),
                                  Container(
                                      height: ScreenUtil().setSp(12),
                                      width: ScreenUtil().setWidth(55),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2)))),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else if (snapshot.data.hasError) {
                        onWidgetDidBuild(() {
                          if (snapshot.data.standby) {
                            showDialogMessage(context, snapshot.data.message,
                                "Terjadi Kesalahan, silahkan coba lagi.");
                            kontakBloc.unStandBy();
                          }
                        });
                      } else if (snapshot.data.isSuccess) {
                        return Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  right: ScreenUtil().setWidth(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        bottom: ScreenUtil().setHeight(5)),
                                    child: Text(
                                      'Menunggu Pembayaran',
                                      style: TextStyle(
                                          color: Color(0xFFFDC72B),
                                          fontSize: ScreenUtil().setSp(8),
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: ScreenUtil().setWidth(3)),
                                        child: Text(
                                          'Rp',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: ScreenUtil().setSp(9)),
                                        ),
                                      ),
                                      Text(
                                        formatCurrency.format(snapshot.data.data.payload.paymentWaiting),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                            fontSize: ScreenUtil().setSp(19)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  right: ScreenUtil().setWidth(15)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        bottom: ScreenUtil().setHeight(5)),
                                    child: Text(
                                      'Invoice Aktif',
                                      style: TextStyle(
                                          color: Color(0xFFFDC72B),
                                          fontSize: ScreenUtil().setSp(8),
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                  Text(
                                    snapshot.data.data.payload.invoiceActive.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: ScreenUtil().setSp(19)),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                    }
                    return Row(
                      children: <Widget>[
                        Container(
                          margin:
                              EdgeInsets.only(right: ScreenUtil().setWidth(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: ScreenUtil().setHeight(5)),
                                child: Text(
                                  'Menunggu Pembayaran',
                                  style: TextStyle(
                                      color: Color(0xFFFDC72B),
                                      fontSize: ScreenUtil().setSp(8),
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: ScreenUtil().setWidth(3)),
                                    child: Text(
                                      'Rp',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                          fontSize: ScreenUtil().setSp(9)),
                                    ),
                                  ),
                                  Text(
                                    '0',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: ScreenUtil().setSp(19)),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(right: ScreenUtil().setWidth(15)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: ScreenUtil().setHeight(5)),
                                child: Text(
                                  'Invoice Aktif',
                                  style: TextStyle(
                                      color: Color(0xFFFDC72B),
                                      fontSize: ScreenUtil().setSp(8),
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              Text(
                                '0',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: ScreenUtil().setSp(19)),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
              StreamBuilder<ListKontakState>(
                  stream: kontakBloc.getKontak,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.isLoading) {
                        return FlatButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(24),
                                vertical: ScreenUtil().setHeight(18)),
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    ScreenUtil().setHeight(25))),
                            color: Colors.white,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(5)),
                                  child: Icon(Icons.eject,
                                      color: Colors.white,
                                      size: ScreenUtil().setHeight(13)),
                                ),
                                Text(
                                  'Kirim Invoice',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: ScreenUtil().setSp(12)),
                                ),
                              ],
                            ));
                      } else if (snapshot.data.hasError) {
                        onWidgetDidBuild(() {
                          if (snapshot.data.standby) {
                            showDialogMessage(context, snapshot.data.message,
                                "Terjadi Kesalahan, silahkan coba lagi.");
                            kontakBloc.unStandBy();
                          }
                        });
                      } else if (snapshot.data.isSuccess) {
                        return FlatButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(24),
                                vertical: ScreenUtil().setHeight(18)),
                            onPressed: () async {
                              String _successSendInvoice = await Navigation()
                                  .navigateScreen(context,
                                      FormInvoice(listKontak: listKontak));

                              if (_successSendInvoice == 'successcreate') {
                                invoiceBloc.requestGetTotalSlot(context);
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    ScreenUtil().setHeight(25))),
                            color: Colors.white,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(5)),
                                  child: Icon(Icons.eject,
                                      color: Color(0xFF1B44A6),
                                      size: ScreenUtil().setHeight(13)),
                                ),
                                Text(
                                  'Kirim Invoice',
                                  style: TextStyle(
                                      color: Color(0xFF1B44A6),
                                      fontWeight: FontWeight.w800,
                                      fontSize: ScreenUtil().setSp(12)),
                                ),
                              ],
                            ));
                      }
                    }
                    return FlatButton(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(24),
                            vertical: ScreenUtil().setHeight(18)),
                        onPressed: () async {
                          String _successSendInvoice = await Navigation()
                              .navigateScreen(
                                  context, FormInvoice(listKontak: listKontak));

                          if (_successSendInvoice == 'successcreate') {
                            invoiceBloc.requestGetTotalSlot(context);
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                ScreenUtil().setHeight(25))),
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  right: ScreenUtil().setWidth(5)),
                              child: Icon(Icons.eject,
                                  color: Color(0xFF1B44A6),
                                  size: ScreenUtil().setHeight(13)),
                            ),
                            Text(
                              'Kirim Invoice',
                              style: TextStyle(
                                  color: Color(0xFF1B44A6),
                                  fontWeight: FontWeight.w800,
                                  fontSize: ScreenUtil().setSp(12)),
                            ),
                          ],
                        ));
                  }),
            ],
          ),
        )
      ],
    ),
  );
}

Widget CardWalletWithInvoiceLoading({
  BuildContext context,
}) {
  return Container(
    child: Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(ScreenUtil().setSp(15)),
                topRight: Radius.circular(ScreenUtil().setSp(15))),
            border: Border.all(color: Color(0xFFEAEAEA)),
          ),
          padding: EdgeInsets.all(ScreenUtil().setWidth(18)),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        height: ScreenUtil().setHeight(15),
                        width: ScreenUtil().setWidth(125),
                        decoration: BoxDecoration(
                            color: Color(0xFFF4F4F4),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5)))),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF4F4F4),
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setSp(25)),
                      ),
                      height: ScreenUtil().setHeight(40),
                      width: ScreenUtil().setWidth(140),
                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(8)),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(70),
                    height: ScreenUtil().setHeight(25),
                    decoration: BoxDecoration(
                      color: Color(0xFFF4F4F4),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Triangle.isosceles(
                        edge: Edge.TOP,
                        child: Container(
                            color: Color(0xFFF4F4F4),
                            width: ScreenUtil().setWidth(30),
                            height: ScreenUtil().setHeight(8)),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(ScreenUtil().setSp(25)),
                            color: Color(0xFFF4F4F4)),
                        height: ScreenUtil().setHeight(35),
                        width: ScreenUtil().setWidth(140),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(ScreenUtil().setWidth(18)),
          decoration: BoxDecoration(
              color: Color(0xFFF4F4F4),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(ScreenUtil().setSp(15)),
                  bottomRight: Radius.circular(ScreenUtil().setSp(15)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(
                                bottom: ScreenUtil().setHeight(5)),
                            height: ScreenUtil().setSp(10),
                            width: ScreenUtil().setWidth(65),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2)))),
                        Container(
                            height: ScreenUtil().setSp(12),
                            width: ScreenUtil().setWidth(45),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2)))),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: ScreenUtil().setWidth(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(
                                bottom: ScreenUtil().setHeight(5)),
                            height: ScreenUtil().setSp(12),
                            width: ScreenUtil().setWidth(65),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2)))),
                        Container(
                            height: ScreenUtil().setSp(12),
                            width: ScreenUtil().setWidth(55),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2)))),
                      ],
                    ),
                  ),
                ],
              ),
              FlatButton(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(24),
                      vertical: ScreenUtil().setHeight(18)),
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setHeight(25))),
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.only(right: ScreenUtil().setWidth(5)),
                        child: Icon(Icons.eject,
                            color: Colors.white,
                            size: ScreenUtil().setHeight(13)),
                      ),
                      Text(
                        'Kirim Invoice',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: ScreenUtil().setSp(12)),
                      ),
                    ],
                  ))
            ],
          ),
        )
      ],
    ),
  );
}
