import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RedeemInvoice extends StatefulWidget {
  RedeemInvoice({Key key}) : super(key: key);

  @override
  _RedeemInvoiceState createState() => _RedeemInvoiceState();
}

class _RedeemInvoiceState extends State<RedeemInvoice> {
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
          'Redeem Slot',
          style: TextStyle(
            color: Colors.black,
            fontSize: ScreenUtil().setSp(17),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.all(0),
          child: Icon(Icons.chevron_left, size: ScreenUtil().setSp(40)),
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
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFFCBCBCB),
                      ),
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setHeight(8)),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(15)),
                        child: Text(
                          'KODE PROMO',
                          style: TextStyle(
                              color: Color(0xFF666666),
                              fontWeight: FontWeight.w800,
                              fontSize: ScreenUtil().setSp(12)),
                        ),
                      ),
                      Container(
                        height: ScreenUtil().setHeight(65),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                ScreenUtil().setHeight(8)),
                            color: Color(0xFFF4F4F7)),
                        child: Center(
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: ScreenUtil().setSp(16)),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: 'Masukan Kode Disini ..',
                                suffixIcon: Icon(
                                  Icons.content_paste,
                                  size: ScreenUtil().setSp(25),
                                  color: Colors.black,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(30),
                                    vertical: ScreenUtil().setHeight(15))),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            bottom: ScreenUtil().setHeight(15),
                            top: ScreenUtil().setHeight(10)),
                        child: Text(
                          'STATUS:',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: ScreenUtil().setSp(12)),
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'assets/images/img_soedja_logo.png',
                                width: ScreenUtil().setWidth(100),
                              ),
                            ),
                            FlatButton(
                                onPressed: () {},
                                color: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        ScreenUtil().setHeight(25))),
                                child: Text(
                                  'REDEEM',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(13),
                                      fontWeight: FontWeight.w800),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: ScreenUtil().setHeight(15),
                      left: ScreenUtil().setWidth(40)),
                  child: Text(
                    'Slot Yang Didapatkan :',
                    style: TextStyle(
                        color: Color(0xFF666666),
                        fontWeight: FontWeight.w800,
                        fontSize: ScreenUtil().setSp(11)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(40)),
                  child: Text(
                    '0',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: ScreenUtil().setSp(22)),
                  ),
                ),
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
                    child: FlatButton(
                        disabledColor: Color(0xFFF4F4F7),
                        disabledTextColor: Color(0xFF707070),
                        onPressed: () {},
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'GUNAKAN',
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
    );
  }
}
