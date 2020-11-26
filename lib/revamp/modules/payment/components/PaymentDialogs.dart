import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:soedja_freelance/old_ver/components/button.dart';
import 'package:soedja_freelance/old_ver/constants/assets.dart';
import 'package:soedja_freelance/old_ver/constants/strings.dart';
import 'package:soedja_freelance/old_ver/models/feeds.dart';
import 'package:soedja_freelance/old_ver/models/portfolio.dart';
import 'package:soedja_freelance/old_ver/models/user.dart';
import 'package:soedja_freelance/old_ver/screens/dashboard/dashboard.dart';
import 'package:soedja_freelance/old_ver/screens/feeds/detail_screen.dart';
import 'package:soedja_freelance/old_ver/screens/portfolio/create_screen.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';
// import 'package:soedja_freelance/old_ver/utils/helpers.dart';
import 'package:soedja_freelance/old_ver/utils/keyboard.dart';
import 'package:soedja_freelance/old_ver/utils/navigation.dart';
import 'package:soedja_freelance/revamp/modules/invoice/bloc/invoice_bloc.dart';
import 'package:soedja_freelance/revamp/modules/invoice/bloc/invoice_state.dart';
import 'package:soedja_freelance/revamp/modules/payment/components/payment_confirmation.dart';
import 'package:intl/intl.dart';
import '../../../helpers/helper.dart';
import '../bloc/payment_bloc.dart';
import '../bloc/payment_state.dart';
import '../components/payment_component.dart';
import '../../portfolio/components/portfolio_components.dart';
import '../../profile/models/profile_models.dart';

showPaymentMethod(
    {BuildContext context,
    String statusPayment,
    String paymentOf,
    PaymentBloc paymentBloc,
    InvoiceBloc invoiceBloc,
    int nominal,
    String type,
    parentId,
    String comment,
    ProfileDetail profileDetail,
    ProfileDetail profile}) {
  switch (type) {
    case 'sawer':
      paymentBloc.requestGiveSupport(context, parentId, nominal, comment);
      break;
    case 'belislot':
      invoiceBloc.requestPostSlotPayment(context, parentId);
      break;
    default:
  }

  String _paymentMethod;
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
        Size size = MediaQuery.of(context).size;
        return GestureDetector(
          onVerticalDragStart: (_) {},
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            padding: EdgeInsets.only(top: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(40)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 32, bottom: 16),
                        child: Text(
                          'Metode Pembayaran',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 17.0),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        color: Color(0xFFF4F4F7),
                        height: 19,
                      ),
                      GestureDetector(
                        onTap: () {
                          setModalState(() {
                            _paymentMethod = 'gopay';
                          });
                        },
                        child: Container(
                          color: Colors.white,
                          height: ScreenUtil().setHeight(50),
                          margin: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Image.asset(
                                  'assets/bank/gopay.png',
                                  width: 100,
                                ),
                              ),
                              Radio(
                                  value: 'gopay',
                                  groupValue: _paymentMethod,
                                  onChanged: (value) {
                                    setModalState(() {
                                      _paymentMethod = value;
                                    });
                                  })
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(left: 20, right: 80, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'assets/bank/BNI.png',
                                width: 35,
                              ),
                            ),
                            Container(
                              child: Image.asset(
                                'assets/bank/mandiri.png',
                                width: 45,
                              ),
                            ),
                            Container(
                              child: Image.asset(
                                'assets/bank/img_logo_bca.png',
                                width: 42,
                              ),
                            ),
                            Container(
                              child: Image.asset(
                                'assets/bank/permata.png',
                                width: 50,
                              ),
                            ),
                            Container(
                              child: Image.asset(
                                'assets/bank/BRI.png',
                                width: 55,
                              ),
                            ),
                          ],
                        ),
                      ),
                      YellowBanner(
                        message:
                            'Pembayaran e-wallet dibawah ini menggunakan handphone.',
                        fontSize: 12,
                      ),
                      GestureDetector(
                        onTap: () {
                          setModalState(() {
                            _paymentMethod = 'ovo';
                          });
                        },
                        child: Container(
                          color: Colors.white,
                          height: ScreenUtil().setHeight(50),
                          margin:
                              EdgeInsets.only(left: 20, right: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Image.asset(
                                  'assets/bank/ovo.png',
                                  width: 45,
                                ),
                              ),
                              Radio(
                                  value: 'ovo',
                                  groupValue: _paymentMethod,
                                  onChanged: (value) {
                                    setModalState(() {
                                      _paymentMethod = value;
                                    });
                                    print(_paymentMethod);
                                  })
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setModalState(() {
                            _paymentMethod = 'dana';
                          });
                        },
                        child: Container(
                          color: Colors.white,
                          height: ScreenUtil().setHeight(50),
                          margin:
                              EdgeInsets.only(left: 20, right: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Image.asset(
                                  'assets/bank/dana.png',
                                  width: 55,
                                ),
                              ),
                              Radio(
                                  value: 'dana',
                                  groupValue: _paymentMethod,
                                  onChanged: (value) {
                                    setModalState(() {
                                      _paymentMethod = value;
                                    });
                                    print(_paymentMethod);
                                  })
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setModalState(() {
                            _paymentMethod = 'linkaja';
                          });
                        },
                        child: Container(
                          color: Colors.white,
                          height: ScreenUtil().setHeight(50),
                          margin: EdgeInsets.only(left: 20, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Image.asset(
                                  'assets/bank/linkaja.png',
                                  width: 35,
                                ),
                              ),
                              Radio(
                                  value: 'linkaja',
                                  groupValue: _paymentMethod,
                                  onChanged: (value) {
                                    setModalState(() {
                                      _paymentMethod = value;
                                    });
                                    print(_paymentMethod);
                                  })
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                type == 'sawer'
                    ? StreamPaymentSawer(
                        statusPayment: statusPayment,
                        paymentOf: paymentOf,
                        paymentBloc: paymentBloc,
                        nominal: nominal,
                        type: type,
                        parentId: parentId,
                        comment: comment,
                        profileDetail: profileDetail,
                        profile: profile,
                        paymentMethod: _paymentMethod)
                    : type == 'belislot'
                        ? StreamPaymentBeliSlot(
                            statusPayment: statusPayment,
                            paymentOf: paymentOf,
                            invoiceBloc: invoiceBloc,
                            paymentBloc: paymentBloc,
                            nominal: nominal,
                            type: type,
                            parentId: parentId,
                            comment: comment,
                            profileDetail: profileDetail,
                            profile: profile,
                            paymentMethod: _paymentMethod)
                        : Container(
                            child: Text('data'),
                          )
              ],
            ),
          ),
        );
      });
    },
  );
}

Widget StreamPaymentSawer(
    {BuildContext context,
    String statusPayment,
    String paymentOf,
    PaymentBloc paymentBloc,
    int nominal,
    String type,
    parentId,
    String comment,
    ProfileDetail profileDetail,
    ProfileDetail profile,
    String paymentMethod}) {
  return StatefulBuilder(
      builder: (BuildContext context, StateSetter setModalState) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: 56,
              child: StreamBuilder<PaymentState>(
                  stream: paymentBloc.getPaymentStatus,
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
                            showDialogMessage(context, snapshot.data.message,
                                "Terjadi kesalahan dalam mengirim. Silahkan coba lagi.");
                            paymentBloc.unStandBy();
                          }
                        });
                      } else if (snapshot.data.isSuccess) {
                        onWidgetDidBuild(() {
                          if (snapshot.data.standby) {
                            print(snapshot.data.data.payload.paymentId);
                            Container(
                              height: ScreenUtil().setHeight(56),
                              width: size.width,
                              child: FlatButtonText(
                                  context: context,
                                  color: Colors.black,
                                  text: "Lanjut Membayar".toUpperCase(),
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenUtil().setSp(15)),
                                  onPressed: paymentMethod == null
                                      ? null
                                      : () async {
                                          if (paymentMethod == 'gopay') {
                                            PaymentComponents().showPayment(
                                                profile: profile,
                                                payload:
                                                    snapshot.data.data.payload);
                                            paymentBloc.unStandBy();
                                          } else {
                                            Navigation().navigateScreen(
                                                context,
                                                PaymentConfirmation(
                                                  paymentBloc: paymentBloc,
                                                  paymentMethod: paymentMethod,
                                                  paymentOf: paymentOf,
                                                  nominalPembayaran:
                                                      nominal.toInt(),
                                                  portfolioId: parentId,
                                                  type: type,
                                                  paymentId: snapshot.data.data
                                                      .payload.paymentId,
                                                  profile: profileDetail,
                                                ));
                                          }
                                        }),
                            );
                          }
                        });
                      }
                    }
                    return Container(
                      height: ScreenUtil().setHeight(56),
                      width: size.width,
                      child: FlatButtonText(
                          context: context,
                          color: Colors.black,
                          text: "Lanjut Membayar".toUpperCase(),
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(15)),
                          onPressed: paymentMethod == null
                              ? null
                              : () {
                                  if (paymentMethod == 'gopay') {
                                    PaymentComponents().showPayment(
                                        profile: profile,
                                        payload: snapshot.data.data.payload);
                                    paymentBloc.unStandBy();
                                  } else {
                                    Navigation().navigateScreen(
                                        context,
                                        PaymentConfirmation(
                                          paymentBloc: paymentBloc,
                                          paymentMethod: paymentMethod,
                                          paymentOf: paymentOf,
                                          nominalPembayaran: nominal.toInt(),
                                          portfolioId: parentId,
                                          type: type,
                                          paymentId: snapshot
                                              .data.data.payload.paymentId,
                                          profile: profileDetail,
                                        ));
                                  }
                                }),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  });
}

Widget StreamPaymentBeliSlot(
    {BuildContext context,
    String statusPayment,
    String paymentOf,
    InvoiceBloc invoiceBloc,
    PaymentBloc paymentBloc,
    int nominal,
    String type,
    parentId,
    String comment,
    ProfileDetail profileDetail,
    ProfileDetail profile,
    String paymentMethod}) {
  return StatefulBuilder(
      builder: (BuildContext context, StateSetter setModalState) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: 56,
              child: StreamBuilder<SlotPaymentState>(
                  stream: invoiceBloc.postSlotPayment,
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
                            showDialogMessage(context, snapshot.data.message,
                                "Terjadi kesalahan dalam mengirim. Silahkan coba lagi.");
                            invoiceBloc.unStandBy();
                          }
                        });
                      } else if (snapshot.data.isSuccess) {
                        onWidgetDidBuild(() {
                          if (snapshot.data.standby) {
                            print(snapshot.data.data.payload.paymentId);
                            Container(
                              height: ScreenUtil().setHeight(56),
                              width: size.width,
                              child: FlatButtonText(
                                  context: context,
                                  color: Colors.black,
                                  text: "Lanjut Membayar".toUpperCase(),
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenUtil().setSp(15)),
                                  onPressed: paymentMethod == null
                                      ? null
                                      : () async {
                                          if (paymentMethod == 'gopay') {
                                            PaymentComponents().showPayment(
                                                profile: profile,
                                                payload:
                                                    snapshot.data.data.payload);
                                            invoiceBloc.unStandBy();
                                          } else {
                                            Navigation().navigateScreen(
                                                context,
                                                PaymentConfirmation(
                                                  paymentBloc: paymentBloc,
                                                  paymentMethod: paymentMethod,
                                                  paymentOf: paymentOf,
                                                  nominalPembayaran:
                                                      nominal.toInt(),
                                                  portfolioId: parentId,
                                                  type: type,
                                                  paymentId: snapshot.data.data
                                                      .payload.paymentId,
                                                  profile: profileDetail,
                                                ));
                                          }
                                        }),
                            );
                          }
                        });
                      }
                    }
                    return Container(
                      height: ScreenUtil().setHeight(56),
                      width: size.width,
                      child: FlatButtonText(
                          context: context,
                          color: Colors.black,
                          text: "Lanjut Membayar".toUpperCase(),
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(15)),
                          onPressed: paymentMethod == null
                              ? null
                              : () {
                                  if (paymentMethod == 'gopay') {
                                    PaymentComponents().showPayment(
                                        profile: profile,
                                        payload: snapshot.data.data.payload);
                                    invoiceBloc.unStandBy();
                                  } else {
                                    Navigation().navigateScreen(
                                        context,
                                        PaymentConfirmation(
                                          paymentBloc: paymentBloc,
                                          paymentMethod: paymentMethod,
                                          paymentOf: paymentOf,
                                          nominalPembayaran: nominal.toInt(),
                                          portfolioId: parentId,
                                          type: type,
                                          paymentId: snapshot
                                              .data.data.payload.paymentId,
                                          profile: profileDetail,
                                        ));
                                  }
                                }),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  });
}
