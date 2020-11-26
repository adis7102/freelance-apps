import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/modules/invoice/bloc/invoice_bloc.dart';
import 'package:soedja_freelance/revamp/modules/invoice/bloc/invoice_state.dart';
import 'package:soedja_freelance/revamp/modules/invoice/components/invoice_widget.dart';
import 'package:soedja_freelance/revamp/modules/invoice/models/invoice_model.dart';
import 'package:soedja_freelance/revamp/modules/invoice/screens/history_invoice.dart';
import 'package:soedja_freelance/revamp/modules/invoice/screens/redeem_invoice.dart';
import 'package:soedja_freelance/revamp/modules/payment/bloc/payment_bloc.dart';
import 'package:soedja_freelance/revamp/modules/payment/components/PaymentDialogs.dart';
import 'package:soedja_freelance/revamp/modules/wallet/components/blueCircle.dart';
import '../../../../old_ver/components/dialog.dart';
import '../../../helpers/navigation_helper.dart';
import '../../../helpers/navigation_helper.dart';
import '../../portfolio/components/portfolio_components.dart';

class ListHargaInvoice extends StatefulWidget {
  ListHargaInvoice({Key key}) : super(key: key);

  @override
  _ListHargaInvoiceState createState() => _ListHargaInvoiceState();
}

class _ListHargaInvoiceState extends State<ListHargaInvoice> {
  InvoiceBloc invoiceBloc = new InvoiceBloc();
  PaymentBloc paymentBloc = new PaymentBloc();

  List<SlotPricePayload> priceList = new List<SlotPricePayload>();

  @override
  void initState() {
    invoiceBloc.requestGetPriceListSlot(context);
    invoiceBloc.requestGetTotalSlot(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
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
          'Top Up',
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
        actions: <Widget>[
          StreamBuilder<GetSlotState>(
            stream: invoiceBloc.getSlot,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.isLoading) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(10)),
                    decoration: BoxDecoration(
                      color: Color(0xFFF4F4F4),
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setSp(25)),
                    ),
                    height: ScreenUtil().setHeight(40),
                    width: ScreenUtil().setWidth(140),
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(8)),
                  );
                } else if (snapshot.data.hasError) {
                  onWidgetDidBuild(() {
                    if (snapshot.data.standby) {
                      showDialogMessage(context, snapshot.data.message,
                          "Terjadi Kesalahan, silahkan coba lagi.");
                      invoiceBloc.unStandBy();
                    }
                  });
                } else if (snapshot.data.isSuccess) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setSp(25)),
                        border: Border.all(color: Color(0xFFDCDCDC))),
                    margin: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(10)),
                    width: ScreenUtil().setWidth(148),
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin:
                              EdgeInsets.only(right: ScreenUtil().setWidth(4)),
                          child: Image.asset(
                            'assets/icons/rocket_b.png',
                            width: ScreenUtil().setWidth(23),
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
                          height: ScreenUtil().setHeight(35),
                          width: ScreenUtil().setWidth(35),
                          decoration: BoxDecoration(
                            color: Color(0xFFF4F4F7),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${snapshot.data.data.payload.slot.toString()}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(12),
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
              }
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(ScreenUtil().setSp(25)),
                    border: Border.all(color: Color(0xFFDCDCDC))),
                margin:
                    EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
                width: ScreenUtil().setWidth(148),
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: ScreenUtil().setWidth(4)),
                      child: Image.asset(
                        'assets/icons/rocket_b.png',
                        width: ScreenUtil().setWidth(23),
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
                      height: ScreenUtil().setHeight(35),
                      width: ScreenUtil().setWidth(35),
                      decoration: BoxDecoration(
                        color: Color(0xFFF4F4F7),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          snapshot.data.data.payload.slot != null
                              ? '${snapshot.data.data.payload.slot.toString()}'
                              : '0',
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(12),
                              fontWeight: FontWeight.w800,
                              color: Colors.black),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(right: ScreenUtil().setWidth(5)),
            child: IconButton(
                icon: Icon(
                  Icons.history,
                  color: Colors.black,
                ),
                onPressed: () =>
                    {Navigation().navigateScreen(context, HistoryInvoice())}),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: ScreenUtil().setHeight(118),
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Color(0xFF2D5ADF),
                    ),
                  ),
                  Container(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        'assets/illustrations/matahari.png',
                        width: ScreenUtil().setWidth(149),
                      )),
                  Container(
                    margin: EdgeInsets.only(
                        left: ScreenUtil().setWidth(20),
                        right: ScreenUtil().setWidth(20),
                        top: ScreenUtil().setHeight(30)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(60)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: ScreenUtil().setWidth(3)),
                                child: Text(
                                  'Kelola Bisnis Freelance',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: ScreenUtil().setSp(15)),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: ScreenUtil().setWidth(15)),
                                child: Text(
                                  'Lebih Professional',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: ScreenUtil().setSp(17.5)),
                                ),
                              ),
                              Container(
                                child: Text(
                                  'Bikin klien happy pakai invoice canggih.',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: ScreenUtil().setSp(10)),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Text(
                            'Pilih Plan',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: ScreenUtil().setSp(12)),
                          ),
                        ),
                        YellowBanner(
                            message:
                                "Tidak ada batas waktu pemakaian untuk setiap slot yang kamu punya.",
                            margin: EdgeInsets.symmetric(
                                horizontal: 0,
                                vertical: ScreenUtil().setHeight(10)),
                            fontSize: ScreenUtil().setSp(10)),
                        Container(
                          margin: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(20)),
                          child: StreamBuilder<GetPriceListSlotState>(
                              stream: invoiceBloc.getPriceListSlot,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data.isLoading) {
                                    return CardSlotPriceLoading();
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
                                    priceList = snapshot.data.data.payload;
                                  }
                                }
                                return ListView.builder(
                                    shrinkWrap: true,
                                    primary: false,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: priceList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return CardSlotPrice(
                                          context: context,
                                          paymentOf:
                                              '${priceList[index].slot.toString()} Slot Invoice',
                                          nominal: priceList[index].price,
                                          type: 'belislot',
                                          contentInCircle:
                                              '${priceList[index].slot.toString()}',
                                          pricePayload: priceList[index],
                                          invoiceBloc: invoiceBloc,
                                          paymentBloc: paymentBloc,
                                          parentId: priceList[index].slotId
                                          );
                                    });
                              }),
                        ),
                        // Container(
                        //   margin: EdgeInsets.only(
                        //       left: ScreenUtil().setWidth(15),
                        //       right: ScreenUtil().setWidth(15),
                        //       bottom: ScreenUtil().setHeight(60)),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: <Widget>[
                        //       Text(
                        //         'Atau Punya Voucher?',
                        //         style: TextStyle(
                        //             fontWeight: FontWeight.w800,
                        //             fontSize: ScreenUtil().setSp(10)),
                        //       ),
                        //       // GestureDetector(
                        //       //   onTap: () {
                        //       //     Navigation().navigateScreen(
                        //       //       context,
                        //       //       RedeemInvoice()
                        //       //     );
                        //       //   },
                        //       //     child: Row(
                        //       //     children: <Widget>[
                        //       //       Container(
                        //       //         margin: EdgeInsets.only(
                        //       //             right: ScreenUtil().setWidth(5)),
                        //       //         child: Icon(Icons.add_circle_outline,
                        //       //             size: ScreenUtil().setSp(25),
                        //       //             color: Color(0xFF2955D3)),
                        //       //       ),
                        //       //       Text(
                        //       //         'REDEEM SLOT',
                        //       //         style: TextStyle(
                        //       //             fontWeight: FontWeight.w800,
                        //       //             fontSize: ScreenUtil().setSp(10),
                        //       //             color: Color(0xFF2955D3)),
                        //       //       ),
                        //       //     ],
                        //       //   ),
                        //       // )
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setHeight(35),
                vertical: ScreenUtil().setWidth(20)),
            decoration: BoxDecoration(
              color: Color(0xFFF4F4F7),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Text(
                          'Slot/Kuota Invoice adalah produk digital yang di kelola oleh PT SOEMBERDJAYA MASYARAKAT dan bukan merupakan alat tukar atau pembayaran yang digunakan secara umum.',
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(8),
                              height: ScreenUtil().setHeight(1.7),
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF707070)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
