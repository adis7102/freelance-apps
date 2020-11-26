import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/invoice/bloc/invoice_bloc.dart';
import 'package:soedja_freelance/revamp/modules/invoice/bloc/invoice_state.dart';
import 'package:soedja_freelance/revamp/modules/invoice/components/invoice_widget.dart';
import 'package:soedja_freelance/revamp/modules/invoice/models/invoice_model.dart';
import 'package:soedja_freelance/revamp/modules/wallet/components/blueCircle.dart';

class HistoryInvoice extends StatefulWidget {
  HistoryInvoice({Key key}) : super(key: key);

  @override
  _HistoryInvoiceState createState() => _HistoryInvoiceState();
}

class _HistoryInvoiceState extends State<HistoryInvoice> {
  InvoiceBloc invoiceBloc = new InvoiceBloc();

  List<RowHistorySlot> histories = new List<RowHistorySlot>();

  @override
  void initState() {
    invoiceBloc.requestGetHistoryPaymentSlot(context);
    super.initState();
  }

  @override
  void dispose() {
    invoiceBloc.requestGetHistoryPaymentSlot(context);
    super.dispose();
  }

  statusCreater(status) {
    if (status == 1) {
      return 'SUKSES';
    } else {
      return 'GAGAL';
    }
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
          'Riwayat Pembelian',
          style: TextStyle(
            color: Colors.black,
            fontSize: ScreenUtil().setSp(16),
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
      body: Container(
        margin: EdgeInsets.only(
            left: ScreenUtil().setWidth(20),
            right: ScreenUtil().setWidth(20),
            bottom: ScreenUtil().setWidth(10)),
        padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
        child: StreamBuilder<HistoryPaymentSlotState>(
            stream: invoiceBloc.getHistoryPaymentSlot,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.isLoading) {
                  return Container(
                      height: ScreenUtil().setHeight(85),
                      child: CardSlotPriceLoading());
                } else if (snapshot.data.hasError) {
                  onWidgetDidBuild(() {
                    if (snapshot.data.standby) {
                      showDialogMessage(context, snapshot.data.message,
                          "Terjadi Kesalahan, silahkan coba lagi.");
                      invoiceBloc.unStandBy();
                    }
                  });
                } else if (snapshot.data.isSuccess) {
                  histories = snapshot.data.data.payload.rows;
                }
              }
              return ListView.builder(
                  itemCount: histories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                      padding: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setHeight(15),
                          horizontal: ScreenUtil().setHeight(20)),
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFF0F0F0)),
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setHeight(10)))),
                      child: Row(
                        children: <Widget>[
                          BlueCircle(
                              size: ScreenUtil().setHeight(39),
                              content: histories[index].slot.toString(),
                              isIcon: false,
                              fontSize: 12),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(
                                            bottom: ScreenUtil().setHeight(5)),
                                        child: Text(
                                          '${histories[index].slot.toString()} Slot Invoice',
                                          style: TextStyle(
                                              color: Color(0xFF2D5ADF),
                                              fontWeight: FontWeight.w800,
                                              fontSize:
                                                  ScreenUtil().setSp(12.5)),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          'Rp ${formatCurrency.format(histories[index].price)}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: ScreenUtil().setSp(13)),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          dateFormat(date: histories[index].createdAt),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: ScreenUtil().setSp(10)),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          statusCreater(
                                              histories[index].status),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: ScreenUtil().setSp(11)),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
