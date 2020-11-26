import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/modules/contact/models/contact_models.dart';
import 'package:soedja_freelance/revamp/modules/invoice/bloc/invoice_bloc.dart';
import 'package:soedja_freelance/revamp/modules/invoice/models/invoice_model.dart';
import 'package:soedja_freelance/revamp/modules/payment/bloc/payment_bloc.dart';
import 'package:soedja_freelance/revamp/modules/payment/components/PaymentDialogs.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/components/portfolio_components.dart';
import 'package:soedja_freelance/revamp/modules/wallet/components/blueCircle.dart';

import '../../../../old_ver/components/button.dart';
import '../../../../old_ver/themes/color.dart';

Widget InvoiceStruk(
    {BuildContext context,
    InvoiceDetail orderDetail,
    int index,
    Function deleteItem,
    Function editItem}) {
  return Column(
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(
            left: ScreenUtil().setWidth(20),
            right: ScreenUtil().setWidth(20),
            bottom: ScreenUtil().setHeight(20)),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(
                          width: ScreenUtil().setWidth(3),
                          color: Color(0xFF2D5ADF)))),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          flex: 4,
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(10)),
                                  child: BlueCircle(
                                      size: ScreenUtil().setWidth(45),
                                      isIcon: false,
                                      fontSize: ScreenUtil().setSp(17),
                                      content: orderDetail.title[0]
                                              .toUpperCase() +
                                          orderDetail.title[1].toUpperCase()),
                                ),
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      orderDetail.title,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: ScreenUtil().setSp(12)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    deleteItem(index);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        right: ScreenUtil().setWidth(5)),
                                    child: Icon(
                                      Icons.delete,
                                      // size
                                    ),
                                  ),
                                ),
                                OutlineButton(
                                    child: Text(
                                      "Edit",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: ScreenUtil().setSp(10)),
                                    ),
                                    onPressed: () {
                                      editItem(context, index, orderDetail);
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(15)),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Text(
                              orderDetail.description,
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(11),
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(20),
                        vertical: ScreenUtil().setHeight(10)),
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFD6D6D6)),
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenUtil().setHeight(10)))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: ScreenUtil().setHeight(15)),
                              child: Text(
                                'HARGA',
                                style: TextStyle(
                                    color: Color(0xFF707070),
                                    fontSize: ScreenUtil().setSp(9),
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: ScreenUtil().setWidth(2)),
                                    child: Text(
                                      'Rp',
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(9),
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                  Text(
                                    formatCurrency.format(orderDetail.price),
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(16),
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: ScreenUtil().setHeight(15)),
                              child: Text(
                                'KUANTITAS',
                                style: TextStyle(
                                    color: Color(0xFF707070),
                                    fontSize: ScreenUtil().setSp(9),
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            Text(
                              orderDetail.quantity.toString(),
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(16),
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: ScreenUtil().setHeight(15)),
                              child: Text(
                                'TOTAL',
                                style: TextStyle(
                                    color: Color(0xFF707070),
                                    fontSize: ScreenUtil().setSp(9),
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: ScreenUtil().setWidth(2)),
                                    child: Text(
                                      'Rp',
                                      style: TextStyle(
                                          color: Color(0xFF3B8812),
                                          fontSize: ScreenUtil().setSp(9),
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                  Text(
                                    formatCurrency.format(orderDetail.amount),
                                    style: TextStyle(
                                        color: Color(0xFF3B8812),
                                        fontSize: ScreenUtil().setSp(16),
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ),
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
      ),
      Container(
        margin: EdgeInsets.only(
            left: ScreenUtil().setWidth(20),
            right: ScreenUtil().setWidth(20),
            bottom: ScreenUtil().setHeight(20)),
        child: Divider(
          color: Color(0xFFDADADA),
        ),
      ),
    ],
  );
}

Widget CardTimelineInvoice(
    {BuildContext context,
    bool withBack,
    bool withDelete,
    bool isTotal,
    String pembayaranNo,
    String percentage,
    int amount,
    int index,
    Function deleteItem}) {
  return Container(
    padding: EdgeInsets.symmetric(
        vertical: ScreenUtil().setWidth(15),
        horizontal: ScreenUtil().setWidth(18)),
    margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
    decoration: BoxDecoration(
      color: withBack ? Color(0xFFF4F4F7) : Colors.transparent,
      borderRadius: BorderRadius.circular(ScreenUtil().setHeight(10)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(right: ScreenUtil().setWidth(8)),
                child: Image.asset(
                  'assets/icons/moneystackblack.png',
                  width: ScreenUtil().setWidth(21),
                )),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
                    child: Text(
                      isTotal
                          ? 'SISA PELUNASAN'
                          : 'PEMBAYARAN NO ${pembayaranNo}',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(10),
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
                    child: Text(
                      isTotal ? 'DARI DP - TOTAL INVOICE' : percentage,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(10),
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: ScreenUtil().setWidth(3)),
                    child: Text(
                      'Rp',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(8),
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  Container(
                    child: Text(
                      formatCurrency.format(amount),
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(16),
                          fontWeight: FontWeight.w800),
                    ),
                  )
                ],
              ),
            ),
            withDelete
                ? GestureDetector(
                    onTap: () {
                      deleteItem(index, amount);
                    },
                    child: Container(
                      child: Icon(
                        Icons.delete,
                        size: ScreenUtil().setSp(20),
                      ),
                    ),
                  )
                : Container(
                    width: ScreenUtil().setSp(20),
                  )
          ],
        )
      ],
    ),
  );
}

CardListkontak(
    {BuildContext context,
    String title,
    String subtitle,
    String labelPrimary,
    String labelGhost,
    String image,
    Function onPrimary,
    Function onGhost,
    ListKontakResponse listKontak}) {
  List<ClientData> listKontakRow = listKontak.payload.rows;
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(top: ScreenUtil().setHeight(60)),
          child: ListView(children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: ScreenUtil().setHeight(8),
                        width: ScreenUtil().setWidth(45),
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: Color(0xFF707070),
                                    width: ScreenUtil().setWidth(2)),
                                bottom: BorderSide(
                                    color: Color(0xFF707070),
                                    width: ScreenUtil().setWidth(2)))),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: ScreenUtil().setWidth(20),
                      bottom: ScreenUtil().setHeight(20)),
                  child: Text(
                    'Kirim Invoice Ke ..',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: ScreenUtil().setSp(18)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
                  height: ScreenUtil().setHeight(28),
                  decoration: BoxDecoration(color: Color(0xFFF4F4F7)),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: ScreenUtil().setWidth(20),
                      bottom: ScreenUtil().setHeight(25)),
                  child: Text(
                    'Semua klien (${listKontak.payload.total})',
                    style: TextStyle(
                        color: Color(0xFF707070),
                        fontWeight: FontWeight.w800,
                        fontSize: ScreenUtil().setSp(12)),
                  ),
                ),
                Container(
                  // height: ScreenUtil().setHeight(520),
                  margin:
                      EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: listKontakRow.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(
                                  bottom: ScreenUtil().setHeight(25)),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: ScreenUtil().setWidth(10)),
                                    child: BlueCircle(
                                        size: ScreenUtil().setHeight(40),
                                        isIcon: false,
                                        content: listKontakRow[index]
                                                .name[0]
                                                .toUpperCase() +
                                            listKontakRow[index]
                                                .name[1]
                                                .toUpperCase(),
                                        fontSize: 15),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              bottom: ScreenUtil().setHeight(5)),
                                          child: Text(
                                            listKontakRow[index].name,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: ScreenUtil().setSp(14),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          listKontakRow[index].representativeName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: ScreenUtil().setSp(11),
                                              color: Color(0xFF707070)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: OutlineButton(
                                      onPressed: () {
                                        Navigator.pop(
                                            context, listKontakRow[index]);
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              ScreenUtil().setHeight(25))),
                                      child: Text(
                                        'Pilih',
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(13),
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    ],
                  ),
                )
              ],
            ),
          ]),
        ),
      );
    },
  );
}

DialogTambahOrderan({BuildContext context, InvoiceDetail invoiceDetail}) {
  ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
  TextEditingController _judulOrderan = TextEditingController();
  TextEditingController _hargaSatuan = TextEditingController();
  TextEditingController _deskripsi = TextEditingController();
  int _kuantitas = 1;
  int _total = 0;
  bool _isEdit = false;

  if (invoiceDetail != null) {
    _isEdit = true;
    _judulOrderan.text = invoiceDetail.title;
    _hargaSatuan.text = invoiceDetail.price.toString();
    _deskripsi.text = invoiceDetail.description;
    _kuantitas = invoiceDetail.quantity;
    _total = invoiceDetail.amount;
  }

  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
        Size size = MediaQuery.of(context).size;
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: Container(
            margin: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
            height: size.height,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(250)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.only(bottom: ScreenUtil().setWidth(30)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(40)),
                              height: ScreenUtil().setHeight(8),
                              width: ScreenUtil().setWidth(45),
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          color: Color(0xFF707070),
                                          width: ScreenUtil().setWidth(2)),
                                      bottom: BorderSide(
                                          color: Color(0xFF707070),
                                          width: ScreenUtil().setWidth(2)))),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(20),
                            right: ScreenUtil().setWidth(20),
                            bottom: ScreenUtil().setHeight(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Orderan Klien ..',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: ScreenUtil().setSp(10)),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(8)),
                                  child: Icon(
                                    Icons.next_week,
                                    size: ScreenUtil().setHeight(18),
                                    color: Color(0xFF2D5ADF),
                                  ),
                                ),
                                Text(
                                  'RIWAYAT JASA',
                                  style: TextStyle(
                                      color: Color(0xFF2D5ADF),
                                      fontWeight: FontWeight.w800,
                                      fontSize: ScreenUtil().setSp(10)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
                        height: ScreenUtil().setHeight(28),
                        decoration: BoxDecoration(color: Color(0xFFF4F4F7)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(20),
                            vertical: ScreenUtil().setHeight(10)),
                        child: Column(
                          children: <Widget>[
                            TextField(
                              keyboardType: TextInputType.multiline,
                              controller: _judulOrderan,
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: ScreenUtil().setSp(12)),
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                    color: Colors.black,
                                    size: ScreenUtil().setHeight(28),
                                  ),
                                  hintStyle: TextStyle(
                                      color: Color(0xFF8E8F9C),
                                      fontWeight: FontWeight.w800,
                                      fontSize: ScreenUtil().setSp(12)),
                                  hintText:
                                      "Klien Order apa ? .. ex : Ilustrasi dll",
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(20))),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(20)),
                        child: Divider(
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(20),
                          bottom: ScreenUtil().setHeight(15),
                          top: ScreenUtil().setHeight(20),
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 4,
                              child: Container(
                                child: Text(
                                  'HARGA SATUAN',
                                  style: TextStyle(
                                      color: Color(0xFF666666),
                                      fontWeight: FontWeight.w800,
                                      fontSize: ScreenUtil().setSp(9)),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Text(
                                  'KUANTITAS',
                                  style: TextStyle(
                                      color: Color(0xFF666666),
                                      fontWeight: FontWeight.w800,
                                      fontSize: ScreenUtil().setSp(9)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(15)),
                              padding: EdgeInsets.only(
                                left: ScreenUtil().setWidth(20),
                                right: ScreenUtil().setWidth(20),
                                top: ScreenUtil().setHeight(15),
                                bottom: ScreenUtil().setHeight(10),
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xFF707070),
                                      width: ScreenUtil().setWidth(1)),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(
                                          ScreenUtil().setHeight(10)))),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                        height: ScreenUtil().setHeight(25),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right:
                                                      ScreenUtil().setWidth(5)),
                                              child: Text('Rp',
                                                  style: TextStyle(
                                                      fontSize: ScreenUtil()
                                                          .setSp(10),
                                                      fontWeight:
                                                          FontWeight.w800)),
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: TextField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller: _hargaSatuan,
                                                  onChanged: (value) {
                                                    _total = int.parse(value);
                                                    setModalState(() {
                                                      if (_kuantitas != 0 &&
                                                          _hargaSatuan.text !=
                                                              '') {
                                                        _total = _kuantitas *
                                                            int.parse(value);
                                                      }
                                                    });
                                                  },
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: ScreenUtil()
                                                          .setSp(16)),
                                                  decoration: InputDecoration(
                                                    hintStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontSize: ScreenUtil()
                                                            .setSp(16)),
                                                    hintText: "0",
                                                    border: InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    errorBorder:
                                                        InputBorder.none,
                                                    disabledBorder:
                                                        InputBorder.none,
                                                    /* contentPadding: EdgeInsets.only(
                                                          top: ScreenUtil().setHeight(20)) */
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () {
                                              if (_kuantitas > 0) {
                                                setModalState(() {
                                                  _kuantitas = _kuantitas - 1;
                                                  if (_kuantitas != 0 &&
                                                      _hargaSatuan.text != '') {
                                                    _total = _kuantitas *
                                                        int.parse(
                                                            _hargaSatuan.text);
                                                  }
                                                });
                                              }
                                            },
                                            child: Container(
                                              height:
                                                  ScreenUtil().setHeight(35),
                                              width: ScreenUtil().setWidth(35),
                                              decoration: BoxDecoration(
                                                color: Color(0xFF2D5ADF),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                child: Icon(Icons.remove,
                                                    color: Colors.white,
                                                    size: ScreenUtil()
                                                        .setHeight(15)),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '$_kuantitas',
                                            style: TextStyle(
                                                fontSize:
                                                    ScreenUtil().setSp(16),
                                                fontWeight: FontWeight.w800),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              print(_kuantitas);
                                              setModalState(() {
                                                _kuantitas = _kuantitas + 1;
                                                if (_kuantitas != 0 &&
                                                    _hargaSatuan.text != '') {
                                                  _total = _kuantitas *
                                                      int.parse(
                                                          _hargaSatuan.text);
                                                }
                                              });
                                            },
                                            child: Container(
                                              height:
                                                  ScreenUtil().setHeight(35),
                                              width: ScreenUtil().setWidth(35),
                                              decoration: BoxDecoration(
                                                color: Color(0xFF2D5ADF),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                child: Icon(Icons.add,
                                                    color: Colors.white,
                                                    size: ScreenUtil()
                                                        .setHeight(15)),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(15)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(30),
                                  vertical: ScreenUtil().setHeight(20)),
                              decoration: BoxDecoration(
                                  color: Color(0xFF2D5ADF),
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(
                                          ScreenUtil().setHeight(10)))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                            margin: EdgeInsets.only(
                                                right:
                                                    ScreenUtil().setWidth(8)),
                                            child: Image.asset(
                                              'assets/icons/moneystack.png',
                                              width: ScreenUtil().setWidth(19),
                                            )),
                                        Text(
                                          'TOTAL',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: ScreenUtil().setSp(11),
                                              fontWeight: FontWeight.w800),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: ScreenUtil().setWidth(5)),
                                        child: Text(
                                          'Rp',
                                          style: TextStyle(
                                              color: Color(0xFFFDC72B),
                                              fontWeight: FontWeight.w800,
                                              fontSize: ScreenUtil().setSp(9)),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          '${formatCurrency.format(_total)}',
                                          style: TextStyle(
                                              color: Color(0xFFFDC72B),
                                              fontWeight: FontWeight.w800,
                                              fontSize: ScreenUtil().setSp(16)),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(20)),
                        decoration: BoxDecoration(
                            color: Color(0xFFF4F4F7),
                            borderRadius: BorderRadius.circular(
                                ScreenUtil().setHeight(10))),
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(20),
                            vertical: ScreenUtil().setHeight(10)),
                        child: TextField(
                          controller: _deskripsi,
                          maxLines: 8,
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: ScreenUtil().setSp(12)),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                color: Color(0xFF7A7A7B),
                                fontWeight: FontWeight.w800,
                                fontSize: ScreenUtil().setSp(12)),
                            hintText: "Deskripsi Jasa ..",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            /* contentPadding: EdgeInsets.only(
                                                          top: ScreenUtil().setHeight(20)) */
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        margin:
                            EdgeInsets.only(top: ScreenUtil().setHeight(40)),
                        padding: EdgeInsets.symmetric(
                            vertical: ScreenUtil().setHeight(30),
                            horizontal: ScreenUtil().setWidth(15)),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: SizedBox(
                                height: 56,
                                child: FlatButton(
                                    disabledColor: Color(0xFFF0F0F0),
                                    onPressed: _judulOrderan.text != '' &&
                                            _deskripsi.text != '' &&
                                            _hargaSatuan.text != '' &&
                                            _kuantitas != 0 &&
                                            _total != 0
                                        ? () {
                                            Navigator.pop(
                                                context,
                                                InvoiceDetail(
                                                  title: _judulOrderan.text,
                                                  description: _deskripsi.text,
                                                  price: int.parse(
                                                      _hargaSatuan.text),
                                                  quantity: _kuantitas,
                                                  amount: _total,
                                                ));
                                          }
                                        : null,
                                    color: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      'SIMPAN',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 17),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
    },
  );
}

DialogTambahPajak({BuildContext context, int subTotal}) {
  TextEditingController _judulPajak = new TextEditingController();
  TextEditingController _jumlahPajak = new TextEditingController();
  int _total = 0;
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
          return GestureDetector(
            onVerticalDragDown: (_) {},
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(ScreenUtil().setSp(10))),
              ),
//            padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(20),
                        left: ScreenUtil().setWidth(20),
                        right: ScreenUtil().setWidth(20),
                        bottom: ScreenUtil().setHeight(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'PAJAK',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: ScreenUtil().setSp(15)),
                        ),
                        IconButton(
                            icon: Icon(Icons.clear,
                                size: ScreenUtil().setHeight(25)),
                            onPressed: () {
                              Navigator.pop(context);
                            })
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
                    height: ScreenUtil().setHeight(28),
                    decoration: BoxDecoration(color: Color(0xFFF4F4F7)),
                  ),
                  YellowBanner(
                      context: context,
                      message:
                          'Pastikan kamu sudah upload items sebelum mengisi kolom pajak ini.',
                      margin: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20))),
                  Container(
                    margin: EdgeInsets.only(
                      left: ScreenUtil().setWidth(20),
                      bottom: ScreenUtil().setHeight(15),
                      top: ScreenUtil().setHeight(20),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: Container(
                            child: Text(
                              'NAMA PAJAK',
                              style: TextStyle(
                                  color: Color(0xFF666666),
                                  fontWeight: FontWeight.w800,
                                  fontSize: ScreenUtil().setSp(9)),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Text(
                              'TAGIHAN PAJAK',
                              style: TextStyle(
                                  color: Color(0xFF666666),
                                  fontWeight: FontWeight.w800,
                                  fontSize: ScreenUtil().setSp(9)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(15)),
                          padding: EdgeInsets.only(
                            left: ScreenUtil().setWidth(20),
                            right: ScreenUtil().setWidth(20),
                            top: ScreenUtil().setHeight(15),
                            bottom: ScreenUtil().setHeight(10),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xFF707070),
                                  width: ScreenUtil().setWidth(1)),
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(
                                      ScreenUtil().setHeight(10)))),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 4,
                                child: Container(
                                  child: TextField(
                                    controller: _judulPajak,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: ScreenUtil().setSp(16)),
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          color: Color(0xFF7E7E7E),
                                          fontWeight: FontWeight.w800,
                                          fontSize: ScreenUtil().setSp(16)),
                                      hintText: "Cth : PPh 23, dll …",
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      /* contentPadding: EdgeInsets.only(
                                                      top: ScreenUtil().setHeight(20)) */
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Container(
                                        width: ScreenUtil().setWidth(80),
                                        decoration: BoxDecoration(
                                            color: Color(0xFFF4F4F7),
                                            borderRadius: BorderRadius.circular(
                                                ScreenUtil().setHeight(10))),
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          controller: _jumlahPajak,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: ScreenUtil().setSp(16)),
                                          onChanged: (value) {
                                            print(value);
                                            setModalState(() {
                                              if (value == '') {
                                                _total = 0;
                                              } else {
                                                print(int.parse(value) /
                                                    100 *
                                                    subTotal);
                                                _total = (int.parse(value) /
                                                        100 *
                                                        subTotal)
                                                    .round();
                                              }
                                            });
                                          },
                                          decoration: InputDecoration(
                                              hintStyle: TextStyle(
                                                  color: Color(0xFF7E7E7E),
                                                  fontWeight: FontWeight.w800,
                                                  fontSize:
                                                      ScreenUtil().setSp(16)),
                                              hintText: "0",
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                Radius.circular(
                                                    ScreenUtil().setHeight(10)),
                                              )),
                                              fillColor: Color(0xFFF4F4F7),
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              contentPadding: EdgeInsets.only(
                                                  left:
                                                      ScreenUtil().setWidth(35),
                                                  top:
                                                      ScreenUtil().setHeight(5),
                                                  bottom: ScreenUtil()
                                                      .setHeight(5))),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          '%',
                                          style: TextStyle(
                                              fontSize: ScreenUtil().setSp(16),
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(15)),
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(30),
                              vertical: ScreenUtil().setHeight(20)),
                          decoration: BoxDecoration(
                              color: Color(0xFF2D5ADF),
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(
                                      ScreenUtil().setHeight(10)))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                        margin: EdgeInsets.only(
                                            right: ScreenUtil().setWidth(8)),
                                        child: Image.asset(
                                          'assets/icons/moneystack.png',
                                          width: ScreenUtil().setWidth(19),
                                        )),
                                    Text(
                                      'TOTAL',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(11),
                                          fontWeight: FontWeight.w800),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: ScreenUtil().setWidth(5)),
                                    child: Text(
                                      'Rp',
                                      style: TextStyle(
                                          color: Color(0xFFFDC72B),
                                          fontWeight: FontWeight.w800,
                                          fontSize: ScreenUtil().setSp(9)),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      formatCurrency.format(_total),
                                      style: TextStyle(
                                          color: Color(0xFFFDC72B),
                                          fontWeight: FontWeight.w800,
                                          fontSize: ScreenUtil().setSp(16)),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(30),
                        horizontal: ScreenUtil().setWidth(15)),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(
                            height: 56,
                            child: FlatButton(
                                disabledColor: Color(0xFFF0F0F0),
                                onPressed: _jumlahPajak.text != '' &&
                                        _judulPajak.text != ''
                                    ? () {
                                        Navigator.pop(
                                            context,
                                            PajakObj(
                                                pajak: int.parse(
                                                        _jumlahPajak.text) /
                                                    100,
                                                total: _total));
                                      }
                                    : null,
                                color: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  'SIMPAN',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 17),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      });
}

DialogDp({BuildContext context, int totalTagihan, int pembayaranKe}) {
  TextEditingController _percentage = new TextEditingController();
  double _totalAkhir = 0;
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
          return GestureDetector(
            onVerticalDragDown: (_) {},
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(ScreenUtil().setSp(10))),
              ),
//            padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(20),
                        left: ScreenUtil().setWidth(20),
                        right: ScreenUtil().setWidth(20),
                        bottom: ScreenUtil().setHeight(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'SISTEM TAGIHAN BERKALA (DP)',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: ScreenUtil().setSp(15)),
                        ),
                        IconButton(
                            icon: Icon(Icons.clear,
                                size: ScreenUtil().setHeight(25)),
                            onPressed: () {
                              Navigator.pop(context);
                            })
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
                    height: ScreenUtil().setHeight(28),
                    decoration: BoxDecoration(color: Color(0xFFF4F4F7)),
                  ),
                  YellowBanner(
                      context: context,
                      message:
                          'Pastikan kamu sudah upload items sebelum mengisi kolom DP ini.',
                      margin: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20))),
                  Container(
                    margin: EdgeInsets.only(
                      left: ScreenUtil().setWidth(20),
                      bottom: ScreenUtil().setHeight(15),
                      top: ScreenUtil().setHeight(20),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: Container(
                            child: Text(
                              'TOTAL TAGIHAN INVOICE',
                              style: TextStyle(
                                  color: Color(0xFF666666),
                                  fontWeight: FontWeight.w800,
                                  fontSize: ScreenUtil().setSp(9)),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Text(
                              'PERSENTASE DP',
                              style: TextStyle(
                                  color: Color(0xFF666666),
                                  fontWeight: FontWeight.w800,
                                  fontSize: ScreenUtil().setSp(9)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(15)),
                          padding: EdgeInsets.only(
                            left: ScreenUtil().setWidth(20),
                            right: ScreenUtil().setWidth(20),
                            top: ScreenUtil().setHeight(15),
                            bottom: ScreenUtil().setHeight(10),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xFF707070),
                                  width: ScreenUtil().setWidth(1)),
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(
                                      ScreenUtil().setHeight(10)))),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 4,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                          right: ScreenUtil().setWidth(5)),
                                      child: Text(
                                        'Rp',
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(8),
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        formatCurrency.format(totalTagihan),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize:
                                                ScreenUtil().setHeight(15)),
                                      ),
                                    )
                                    // Expanded(
                                    //   flex: 4,
                                    //   child: Container(
                                    //     child: TextField(
                                    //       keyboardType: TextInputType.number,
                                    //       controller: _percentage,
                                    //       style: TextStyle(
                                    //           fontWeight: FontWeight.w800,
                                    //           fontSize: ScreenUtil().setSp(16)),
                                    //       decoration: InputDecoration(
                                    //         hintStyle: TextStyle(
                                    //             color: Color(0xFF7E7E7E),
                                    //             fontWeight: FontWeight.w800,
                                    //             fontSize: ScreenUtil().setSp(16)),
                                    //         hintText: "0",
                                    //         border: InputBorder.none,
                                    //         focusedBorder: InputBorder.none,
                                    //         enabledBorder: InputBorder.none,
                                    //         errorBorder: InputBorder.none,
                                    //         disabledBorder: InputBorder.none,
                                    //         /* contentPadding: EdgeInsets.only(
                                    //                         top: ScreenUtil().setHeight(20)) */
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Container(
                                        width: ScreenUtil().setWidth(80),
                                        decoration: BoxDecoration(
                                            color: Color(0xFFF4F4F7),
                                            borderRadius: BorderRadius.circular(
                                                ScreenUtil().setHeight(10))),
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          controller: _percentage,
                                          onChanged: (value) {
                                            setModalState(() {
                                              if (value == "") {
                                                _totalAkhir = 0;
                                              } else {
                                                _totalAkhir = int.parse(value) /
                                                    100 *
                                                    totalTagihan;
                                                print(_totalAkhir);
                                              }
                                            });
                                          },
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: ScreenUtil().setSp(16)),
                                          decoration: InputDecoration(
                                              hintStyle: TextStyle(
                                                  color: Color(0xFF7E7E7E),
                                                  fontWeight: FontWeight.w800,
                                                  fontSize:
                                                      ScreenUtil().setSp(16)),
                                              hintText: "0",
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                Radius.circular(
                                                    ScreenUtil().setHeight(10)),
                                              )),
                                              fillColor: Color(0xFFF4F4F7),
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              contentPadding: EdgeInsets.only(
                                                  left:
                                                      ScreenUtil().setWidth(35),
                                                  top:
                                                      ScreenUtil().setHeight(5),
                                                  bottom: ScreenUtil()
                                                      .setHeight(5))),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          '%',
                                          style: TextStyle(
                                              fontSize: ScreenUtil().setSp(16),
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(15)),
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(30),
                              vertical: ScreenUtil().setHeight(20)),
                          decoration: BoxDecoration(
                              color: Color(0xFF2D5ADF),
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(
                                      ScreenUtil().setHeight(10)))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                        margin: EdgeInsets.only(
                                            right: ScreenUtil().setWidth(8)),
                                        child: Image.asset(
                                          'assets/icons/moneystack.png',
                                          width: ScreenUtil().setWidth(19),
                                        )),
                                    Text(
                                      'TOTAL',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(11),
                                          fontWeight: FontWeight.w800),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: ScreenUtil().setWidth(5)),
                                    child: Text(
                                      'Rp',
                                      style: TextStyle(
                                          color: Color(0xFFFDC72B),
                                          fontWeight: FontWeight.w800,
                                          fontSize: ScreenUtil().setSp(9)),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      formatCurrency.format(_totalAkhir),
                                      style: TextStyle(
                                          color: Color(0xFFFDC72B),
                                          fontWeight: FontWeight.w800,
                                          fontSize: ScreenUtil().setSp(16)),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(30),
                        horizontal: ScreenUtil().setWidth(15)),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(
                            height: 56,
                            child: FlatButton(
                                onPressed: () {
                                  Navigator.pop(
                                      context,
                                      PaymentStage(
                                          amount: _totalAkhir.round(),
                                          percentage:
                                              int.parse(_percentage.text),
                                          title:
                                              'Pembayaran Tahap ${pembayaranKe.toString()}'));
                                },
                                color: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  'SIMPAN',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 17),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      });
}

Widget CardSlotPrice(
    {BuildContext context,
    String paymentOf,
    int nominal,
    String type,
    String contentInCircle,
    SlotPricePayload pricePayload,
    InvoiceBloc invoiceBloc,
    PaymentBloc paymentBloc,
    parentId}) {
  return GestureDetector(
    onTap: () async {
      String _paymentStatus = await showPaymentMethod(
          context: context,
          paymentOf: paymentOf,
          nominal: nominal,
          type: type,
          invoiceBloc: invoiceBloc,
          paymentBloc: paymentBloc,
          parentId: parentId);

      if (_paymentStatus == 'successpayment') {
        invoiceBloc.requestGetTotalSlot(context);
      }
    },
    child: Container(
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
      padding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setHeight(15),
          horizontal: ScreenUtil().setHeight(20)),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFF0F0F0)),
          borderRadius:
              BorderRadius.all(Radius.circular(ScreenUtil().setHeight(5)))),
      child: Row(
        children: <Widget>[
          BlueCircle(
              size: ScreenUtil().setHeight(38),
              content: contentInCircle,
              isIcon: false,
              fontSize: 12),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(5)),
                        child: Text(
                          paymentOf,
                          style: TextStyle(
                              color: Color(0xFF2D5ADF),
                              fontWeight: FontWeight.w800,
                              fontSize: ScreenUtil().setSp(12)),
                        ),
                      ),
                      Container(
                        child: Text(
                          'Rp ${formatCurrency.format(nominal)}',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: ScreenUtil().setSp(12)),
                        ),
                      )
                    ],
                  ),
                  Container(
                    child: Text(
                      pricePayload.description,
                      style: TextStyle(
                          color: Color(0xFF606060),
                          fontWeight: FontWeight.w800,
                          fontSize: ScreenUtil().setSp(10)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget CardSlotPriceLoading({BuildContext context}) {
  return Container(
    margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
    padding: EdgeInsets.symmetric(
        vertical: ScreenUtil().setHeight(15),
        horizontal: ScreenUtil().setHeight(20)),
    decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFF0F0F0)),
        borderRadius:
            BorderRadius.all(Radius.circular(ScreenUtil().setHeight(5)))),
    child: Row(
      children: <Widget>[
        Container(
          height: ScreenUtil().setHeight(38),
          width: ScreenUtil().setHeight(38),
          decoration: BoxDecoration(
            color: Color(0xFFF0F0F0),
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin:
                          EdgeInsets.only(bottom: ScreenUtil().setHeight(5)),
                      decoration: BoxDecoration(
                          color: Color(0xFFF0F0F0),
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().setWidth(3))),
                      width: ScreenUtil().setWidth(70),
                      height: ScreenUtil().setHeight(15),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFF0F0F0),
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().setWidth(3))),
                      width: ScreenUtil().setWidth(45),
                      height: ScreenUtil().setHeight(15),
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFF0F0F0),
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setWidth(3))),
                  width: ScreenUtil().setWidth(45),
                  height: ScreenUtil().setHeight(10),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
