import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:soedja_freelance/revamp/assets/lotties.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/dashboard/screens/dashboard_screen.dart';
import 'package:soedja_freelance/revamp/modules/payment/models/payment_models.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/models/portfolio_models.dart';

import '../../profile/models/profile_models.dart';

SuccessPayment(
    {BuildContext context,
    String type,
    String title,
    int nominal,
    ProfileDetail user,
    PaymentPayload payment,
    String backTo,
    String paymentOf,
    String typeParent}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Color(0xFF1C1C1C),
    context: context,
    enableDrag: false,
    builder: (BuildContext context) {
      Size size = MediaQuery.of(context).size;
      return Stack(children: <Widget>[
        Container(
          height: size.height / 2,
          color: Colors.black,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: ScreenUtil().setHeight(20)),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context, 'successpayment');
                    });
                  }),
            ),
            LottieBuilder.asset(
              Lotties.successIcon,
              height: ScreenUtil().setHeight(170),
              repeat: false,
            ),
            Text(
              title.toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(24)),
            ),
            SizedBox(height: ScreenUtil().setHeight(10)),
            Text(
              type == 'success' ? Texts.paymentSuccess : Texts.paymentFailed,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 21.0,
                  fontWeight: FontWeight.w800),
            ),

            // disini
            typeParent == 'sawer'
                ? PaymentSuccessSawer(nominal: nominal, user: user)
                : PaymentSuccessBeliSlot(
                    nominal: nominal, paymentOf: paymentOf),
            Expanded(child: Container()),
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              child: Visibility(
                visible: type != "delete",
                child: Container(
                  height: ScreenUtil().setHeight(56),
                  width: size.width,
                  child: FlatButtonText(
                    context: context,
                    color: Colors.black,
                    side: BorderSide(color: Colors.white, width: .5),
                    text: backTo,
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(15)),
                    onPressed: () {
                      switch (backTo) {
                        case 'KEMBALI KE PORTFOLIO':
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context, 'successpayment');
                          });
                          break;
                        case 'KEMBALI KE MENU SLOT':
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context, 'successpayment');
                          });
                          break;
                        default:
                      }
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(20)),
          ],
        ),
      ]);
    },
  );
}

Widget PaymentSuccessSawer({int nominal, ProfileDetail user}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
    child: Column(
      children: <Widget>[
        Divider(
          height: ScreenUtil().setHeight(60),
          color: Colors.white,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
              child: Text(
                'PEMBAYARAN',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: ScreenUtil().setSp(12),
                    color: Color(0xFF707070)),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(20),
                    vertical: ScreenUtil().setHeight(22)),
                decoration: BoxDecoration(
                    color: Color(0xFFF4F4F7),
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setHeight(5))),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Dukungan Kepada',
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(12),
                            color: Color(0xFF626263),
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(10),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${user.name}',
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(12),
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(height: ScreenUtil().setHeight(20)),
            Container(
              margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'TOTAL NOMINAL',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: ScreenUtil().setSp(12),
                          color: Color(0xFF707070)),
                    ),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(10)),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Rp ${formatCurrency.format(nominal)}',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: ScreenUtil().setSp(17),
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(10)),
            // Container(
            //   child: Text(
            //     'LINK PEMBAYARAN INVOICE',
            //     style: TextStyle(
            //         fontWeight: FontWeight.w800,
            //         fontSize: ScreenUtil().setSp(12),
            //         color: Colors.white),
            //   ),
            // ),
            // SizedBox(height: ScreenUtil().setHeight(10)),
            // Container(
            //     padding: EdgeInsets.symmetric(
            //         horizontal: ScreenUtil().setWidth(20),
            //         vertical: ScreenUtil().setHeight(22)),
            //     decoration: BoxDecoration(
            //         color: Colors.black,
            //         borderRadius: BorderRadius.circular(
            //             ScreenUtil().setHeight(5))),
            //     child: Row(
            //       children: <Widget>[
            //         Text(
            //           '${}',,
            //           maxLines: 1,
            //           overflow: TextOverflow.ellipsis,
            //           style: TextStyle(
            //               color: Colors.black,
            //               fontSize: ScreenUtil().setSp(17),
            //               fontWeight: FontWeight.bold),
            //         ),
            //         FlatButton(
            //           onPressed: () {},
            //           child: Text(

            //             style: TextStyle(
            //               color: Colors.white,
            //               fontWeight: FontWeight.w800,
            //               fontSize: ScreenUtil().setSp(8)
            //             ),
            //           )
            //         )
            //       ],
            //     ))
          ],
        ),
        // SizedBox(height: ScreenUtil().setHeight(10)),
        Divider(
          height: ScreenUtil().setHeight(30),
          color: Colors.white,
        ),
        // Row(
        //   children: <Widget>[
        //     Expanded(
        //       child: Text(
        //         Texts.timeCreate + ' :',
        //         style: TextStyle(
        //             color: Colors.white.withOpacity(.5),
        //             fontWeight: FontWeight.normal,
        //             fontSize: ScreenUtil().setSp(10)),
        //       ),
        //     ),
        //     SizedBox(width: ScreenUtil().setWidth(10)),
        //     Expanded(
        //       child: Text(
        //           dateFormat(date: item.createdAt),
        //         textAlign: TextAlign.end,
        //         style: TextStyle(
        //             color: Colors.white.withOpacity(.5),
        //             fontSize: ScreenUtil().setSp(10),
        //             fontWeight: FontWeight.normal),
        //       ),
        //     ),
        //   ],
        // ),
        SizedBox(height: ScreenUtil().setHeight(10)),
      ],
    ),
  );
}

Widget PaymentSuccessBeliSlot({int nominal, String paymentOf}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
    child: Column(
      children: <Widget>[
        Divider(
          height: ScreenUtil().setHeight(60),
          color: Colors.white,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
              child: Text(
                'PEMBAYARAN',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: ScreenUtil().setSp(12),
                    color: Color(0xFF707070)),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(20),
                    vertical: ScreenUtil().setHeight(22)),
                decoration: BoxDecoration(
                    color: Color(0xFFF4F4F7),
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setHeight(5))),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Pembelian Slot',
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(12),
                            color: Color(0xFF626263),
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(10),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${paymentOf}',
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(12),
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(height: ScreenUtil().setHeight(20)),
            Container(
              margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'JUMLAH SLOT',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: ScreenUtil().setSp(12),
                          color: Color(0xFF707070)),
                    ),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(10)),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${paymentOf.split(' ')[0]}',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: ScreenUtil().setSp(17),
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'HARGA PERSLOT',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: ScreenUtil().setSp(12),
                          color: Color(0xFF707070)),
                    ),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(10)),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Rp ${5500}',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: ScreenUtil().setSp(17),
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(10)),
            Container(
              margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'TOTAL NOMINAL',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: ScreenUtil().setSp(12),
                          color: Color(0xFF707070)),
                    ),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(10)),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Rp ${formatCurrency.format(nominal)}',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: ScreenUtil().setSp(17),
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(10)),
            // Container(
            //   child: Text(
            //     'LINK PEMBAYARAN INVOICE',
            //     style: TextStyle(
            //         fontWeight: FontWeight.w800,
            //         fontSize: ScreenUtil().setSp(12),
            //         color: Colors.white),
            //   ),
            // ),
            // SizedBox(height: ScreenUtil().setHeight(10)),
            // Container(
            //     padding: EdgeInsets.symmetric(
            //         horizontal: ScreenUtil().setWidth(20),
            //         vertical: ScreenUtil().setHeight(22)),
            //     decoration: BoxDecoration(
            //         color: Colors.black,
            //         borderRadius: BorderRadius.circular(
            //             ScreenUtil().setHeight(5))),
            //     child: Row(
            //       children: <Widget>[
            //         Text(
            //           '${}',,
            //           maxLines: 1,
            //           overflow: TextOverflow.ellipsis,
            //           style: TextStyle(
            //               color: Colors.black,
            //               fontSize: ScreenUtil().setSp(17),
            //               fontWeight: FontWeight.bold),
            //         ),
            //         FlatButton(
            //           onPressed: () {},
            //           child: Text(

            //             style: TextStyle(
            //               color: Colors.white,
            //               fontWeight: FontWeight.w800,
            //               fontSize: ScreenUtil().setSp(8)
            //             ),
            //           )
            //         )
            //       ],
            //     ))
          ],
        ),
        // SizedBox(height: ScreenUtil().setHeight(10)),
        Divider(
          height: ScreenUtil().setHeight(30),
          color: Colors.white,
        ),
        // Row(
        //   children: <Widget>[
        //     Expanded(
        //       child: Text(
        //         Texts.timeCreate + ' :',
        //         style: TextStyle(
        //             color: Colors.white.withOpacity(.5),
        //             fontWeight: FontWeight.normal,
        //             fontSize: ScreenUtil().setSp(10)),
        //       ),
        //     ),
        //     SizedBox(width: ScreenUtil().setWidth(10)),
        //     Expanded(
        //       child: Text(
        //           dateFormat(date: item.createdAt),
        //         textAlign: TextAlign.end,
        //         style: TextStyle(
        //             color: Colors.white.withOpacity(.5),
        //             fontSize: ScreenUtil().setSp(10),
        //             fontWeight: FontWeight.normal),
        //       ),
        //     ),
        //   ],
        // ),
        SizedBox(height: ScreenUtil().setHeight(10)),
      ],
    ),
  );
}

SuccessCreateInvoice(
    {BuildContext context, String title, int nominal, ProfileDetail user}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Color(0xFF1C1C1C),
    context: context,
    enableDrag: false,
    builder: (BuildContext context) {
      Size size = MediaQuery.of(context).size;
      return Stack(children: <Widget>[
        Container(
          height: size.height / 2.1,
          color: Colors.black,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: ScreenUtil().setHeight(20)),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context, 'successcreate');
                    });
                  }),
            ),
            LottieBuilder.asset(
              Lotties.successIcon,
              height: ScreenUtil().setHeight(170),
              repeat: false,
            ),
            Text(
              title.toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(24)),
            ),
            SizedBox(height: ScreenUtil().setHeight(10)),
            Text(
              'Berhasil Di Buat!',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 21.0,
                  fontWeight: FontWeight.w800),
            ),

            // disini
            CreateInvoiceSuccessRows(nominal: nominal),
            Expanded(child: Container()),
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              child: Container(
                height: ScreenUtil().setHeight(56),
                width: size.width,
                child: FlatButtonText(
                  context: context,
                  color: Colors.black,
                  side: BorderSide(color: Colors.white, width: .5),
                  text: "DETAIL INVOICE",
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(15)),
                  onPressed: () {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      Navigator.pop(context);
                      Navigator.pop(context, 'successcreate');
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(20)),
          ],
        ),
      ]);
    },
  );
}

Widget CreateInvoiceSuccessRows({int nominal, String paymentOf}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
    child: Column(
      children: <Widget>[
        Divider(
          height: ScreenUtil().setHeight(60),
          color: Colors.white,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
              child: Text(
                'TAGIHAN KEPADA',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: ScreenUtil().setSp(10),
                    color: Color(0xFF707070)),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(20),
                    vertical: ScreenUtil().setHeight(22)),
                decoration: BoxDecoration(
                    color: Color(0xFFF4F4F7),
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setHeight(5))),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Pembelian Slot',
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(12),
                            color: Color(0xFF626263),
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(10),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'HAHAHA',
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(12),
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(height: ScreenUtil().setHeight(20)),
            Container(
              margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'TOTAL NOMINAL INVOICE',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: ScreenUtil().setSp(10),
                          color: Color(0xFF707070)),
                    ),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(10)),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Rp ${formatCurrency.format(1000)}',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: ScreenUtil().setSp(15),
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(10)),
            Container(
              child: Text(
                'LINK PEMBAYARAN INVOICE',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: ScreenUtil().setSp(10),
                    color: Colors.white),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(10)),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(10),
                    vertical: ScreenUtil().setHeight(10)),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setHeight(5))),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Text(
                          'https://soedja.com/orders/4518310035https://soedja.com/orders/4518310035https://soedja.com/orders/4518310035',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(15),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(80),
                      height: ScreenUtil().setHeight(30),
                      child: FlatButton(
                          onPressed: () {},
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  ScreenUtil().setHeight(25))),
                          child: Text(
                            'LALA',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: ScreenUtil().setSp(8)),
                          )),
                    )
                  ],
                ))
          ],
        ),
        SizedBox(height: ScreenUtil().setHeight(10)),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                        margin:
                            EdgeInsets.only(right: ScreenUtil().setWidth(10)),
                        child: Image.asset('assets/icons/whatsapp.png',
                            width: ScreenUtil().setWidth(23))),
                    Text(
                      'WhatsApp',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: ScreenUtil().setSp(10)),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                        margin:
                            EdgeInsets.only(right: ScreenUtil().setWidth(10)),
                        child: Image.asset('assets/icons/gmail.png',
                            width: ScreenUtil().setWidth(23))),
                    Text(
                      'Gmail',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: ScreenUtil().setSp(10)),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                        margin:
                            EdgeInsets.only(right: ScreenUtil().setWidth(10)),
                        child: Image.asset('assets/icons/telegram.png',
                            width: ScreenUtil().setWidth(23))),
                    Text(
                      'Telegram',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: ScreenUtil().setSp(10)),
                    )
                  ],
                ),
              ),
              Container(
                child: Icon(Icons.more_horiz,
                    color: Colors.white, size: ScreenUtil().setHeight(29)),
              )
            ],
          ),
        ),
        Divider(
          height: ScreenUtil().setHeight(30),
          color: Colors.white,
        ),
      ],
    ),
  );
}
