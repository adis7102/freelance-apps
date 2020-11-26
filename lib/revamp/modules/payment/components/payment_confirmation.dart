import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soedja_freelance/revamp/modules/invoice/bloc/invoice_bloc.dart';
import 'package:soedja_freelance/revamp/modules/payment/components/payment_success.dart';

import '../../../../old_ver/utils/helpers.dart';
import '../../../../old_ver/utils/helpers.dart';
import '../../../helpers/helper.dart';
import '../../../helpers/navigation_helper.dart';
import '../../../helpers/navigation_helper.dart';
import '../../portfolio/bloc/portfolio_bloc.dart';
import '../../portfolio/bloc/portfolio_bloc.dart';
import '../../portfolio/bloc/portfolio_state.dart';
import '../../portfolio/screens/detail_portfolio_screen.dart';
import '../../profile/models/profile_models.dart';
import '../bloc/payment_bloc.dart';
import '../bloc/payment_state.dart';

class PaymentConfirmation extends StatefulWidget {
  final String type;
  final PaymentBloc paymentBloc;
  final InvoiceBloc invoiceBloc;
  final String paymentMethod;
  final String paymentOf;
  final int nominalPembayaran;
  final String comment;
  final String portfolioId;
  final String paymentId;
  final ProfileDetail profile;

  PaymentConfirmation(
      {Key key,
      this.paymentMethod,
      this.paymentBloc,
      this.invoiceBloc,
      this.paymentOf,
      this.nominalPembayaran,
      this.portfolioId,
      this.comment,
      this.paymentId,
      this.profile,
      this.type})
      : super(key: key);

  @override
  _PaymentConfirmationState createState() => _PaymentConfirmationState();
}

class _PaymentConfirmationState extends State<PaymentConfirmation> {
  PortfolioBloc portfolioBloc = new PortfolioBloc();
  int _totalPembayaran = 0;
  int _adminFee = 0;

  @override
  void initState() {
    switch (widget.type) {
      case 'belislot':
        _totalPembayaran = widget.nominalPembayaran;
        break;
      case 'bayarinvoice':
        _totalPembayaran = widget.nominalPembayaran + (8500 * 2);
        _adminFee = 8500;
        break;
      case 'sawer':
        _totalPembayaran = widget.nominalPembayaran;
        break;
      default:
    }
    super.initState();
  }

  @override
  void dispose() { 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
          'Konfirmasi Pembayaran',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(
                        left: ScreenUtil().setWidth(40),
                        top: ScreenUtil().setHeight(30)),
                    child: Image.asset(
                      'assets/bank/${widget.paymentMethod}.png',
                      width: ScreenUtil().setWidth(75),
                    )),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(40),
                      vertical: ScreenUtil().setHeight(20)),
                  child: Divider(
                    thickness: ScreenUtil().setHeight(1),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(10),
                      horizontal: ScreenUtil().setWidth(40)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text(
                          'ORDER',
                          style: TextStyle(
                              color: Color(0xFF8E8F9C),
                              fontWeight: FontWeight.w800,
                              fontSize: ScreenUtil().setSp(14)),
                        ),
                      ),
                      Container(
                        child: Text(
                          widget.paymentOf,
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: ScreenUtil().setSp(14)),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(40),
                      vertical: ScreenUtil().setHeight(20)),
                  child: Divider(
                    thickness: ScreenUtil().setHeight(1),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(20)),
                  height: ScreenUtil().setHeight(180),
                  child: Stack(children: <Widget>[
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: ScreenUtil().setHeight(95),
                        decoration: BoxDecoration(
                            color: Color(0xFFF4F4F7),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenUtil().setHeight(15)))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(20),
                                  right: ScreenUtil().setWidth(20)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: ScreenUtil().setWidth(15),
                                          height: ScreenUtil().setHeight(15),
                                          margin: EdgeInsets.only(
                                              right: ScreenUtil().setWidth(5)),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFF8E8E93)),
                                        ),
                                        Text(
                                          'Admin Fee',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: ScreenUtil().setSp(15)),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      currencyIDR
                                        .format(_adminFee),
                                      style: TextStyle(
                                          color: Color(0xFF8E8F9C),
                                          fontWeight: FontWeight.w800,
                                          fontSize: ScreenUtil().setSp(14)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(27)),
                              child: Dash(
                                  direction: Axis.vertical,
                                  length: ScreenUtil().setHeight(25),
                                  dashLength: 5,
                                  dashColor: Color(0xFF8E8E93)),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(20),
                                  right: ScreenUtil().setWidth(20)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: ScreenUtil().setWidth(15),
                                          height: ScreenUtil().setHeight(15),
                                          margin: EdgeInsets.only(
                                              right: ScreenUtil().setWidth(5)),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFF8E8E93)),
                                        ),
                                        Text(
                                          'Pajak',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: ScreenUtil().setSp(15)),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      'Rp 0',
                                      style: TextStyle(
                                          color: Color(0xFF8E8F9C),
                                          fontWeight: FontWeight.w800,
                                          fontSize: ScreenUtil().setSp(14)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                left: ScreenUtil().setWidth(20),
                                right: ScreenUtil().setWidth(20),
                                bottom: ScreenUtil().setHeight(15)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: ScreenUtil().setWidth(5)),
                                        child: SvgPicture.asset(
                                          'assets/svg/icon_price.svg',
                                          width: ScreenUtil().setWidth(15),
                                        ),
                                      ),
                                      Text(
                                        'Nominal Pembayaran',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: ScreenUtil().setSp(15)),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    currencyIDR
                                        .format(widget.nominalPembayaran),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: ScreenUtil().setSp(14)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: ScreenUtil().setWidth(20),
                                right: ScreenUtil().setWidth(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: ScreenUtil().setWidth(5)),
                                        child: SvgPicture.asset(
                                          'assets/svg/icon_price.svg',
                                          width: ScreenUtil().setWidth(15),
                                        ),
                                      ),
                                      Text(
                                        'Biaya Layanan',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: ScreenUtil().setSp(15)),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    currencyIDR
                                        .format(_adminFee),
                                    style: TextStyle(
                                        color: Color(0xFF8E8F9C),
                                        fontWeight: FontWeight.w800,
                                        fontSize: ScreenUtil().setSp(14)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: ScreenUtil().setWidth(27)),
                            child: Dash(
                                direction: Axis.vertical,
                                length: ScreenUtil().setHeight(65),
                                dashLength: 5,
                                dashColor: Color(0xFF8E8E93)),
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(40),
                      vertical: ScreenUtil().setHeight(20)),
                  child: Divider(
                    thickness: ScreenUtil().setHeight(1),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'TOTAL PEMBAYARAN',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: ScreenUtil().setSp(13.5)),
                      ),
                      Text(
                        currencyIDR.format(_totalPembayaran),
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: ScreenUtil().setSp(13.5)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    height: 56,
                    child: StreamBuilder<PaymentStateXendit>(
                        stream: widget.paymentBloc.getPaymentXendit,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.isLoading) {
                              return FlatButtonLoading(
                                  context: context,
                                  size: size,
                                  color: Colors.black,
                                  margin: EdgeInsets.zero);
                            } else if (snapshot.data.hasError) {
                              onWidgetDidBuild(() {
                                if (snapshot.data.standby) {
                                  showDialogMessage(
                                      context,
                                      snapshot.data.message,
                                      "Terjadi kesalahan dalam mengirim. Silahkan coba lagi.");
                                  widget.paymentBloc.unStandBy();
                                }
                              });
                            } else if (snapshot.data.isSuccess) {
                              SchedulerBinding.instance.addPostFrameCallback((_) {
                                switch (widget.type) {
                                  case 'sawer':
                                    SuccessPayment(context: context, type: 'success', backTo: 'KEMBALI KE PORTFOLIO', title: 'Pembayaran', nominal: widget.nominalPembayaran, user: widget.profile, typeParent: widget.type);   
                                    break;
                                  case 'belislot':
                                    SuccessPayment(context: context, type: 'success', backTo: 'KEMBALI KE MENU SLOT', title: 'Pembayaran', nominal: widget.nominalPembayaran, paymentOf: widget.paymentOf, typeParent: widget.type);   
                                    break;
                                  default:
                                }
                              });
                              widget.paymentBloc.unStandBy();
                            }
                          }
                          return FlatButton(
                              onPressed: () {
                                print(widget.paymentId);
                                widget.paymentBloc.requestPaymentXendit(context,
                                    widget.paymentId, widget.paymentMethod);
                              },
                              color: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                'BAYAR SEKARANG',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 17),
                              ));
                        }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}