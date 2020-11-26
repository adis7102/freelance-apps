import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/urls.dart';
import 'package:soedja_freelance/revamp/helpers/keyboard_helper.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/components/portfolio_components.dart';
import 'package:soedja_freelance/revamp/modules/wallet/components/withdraw_components.dart';
import 'package:soedja_freelance/revamp/modules/wallet/models/withdraw_model.dart';
import 'package:soedja_freelance/revamp/assets/lists.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

class WithdrawDetailScreen extends StatefulWidget {
  final WithdrawHistory withdrawHistory;

  WithdrawDetailScreen({Key key, this.withdrawHistory}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WithdrawDetailScreen();
  }
}

class _WithdrawDetailScreen extends State<WithdrawDetailScreen> {
  DateTime dateFrom;
  DateTime dateTo;

  @override
  void initState() {
    setDate();
    super.initState();
  }

  setDate() {
    var date = DateTime.fromMillisecondsSinceEpoch(
        widget.withdrawHistory.createdAt * 1000);
    dateFrom = new DateTime(date.year, date.month, date.day);
    dateTo = new DateTime(date.year, date.month, date.day + 2);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorApps.light,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        automaticallyImplyLeading: false,
        title: Text(
          "Withdraw".toUpperCase(),
          style: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil().setSp(15),
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ),
              onPressed: () => Navigation().navigateBack(context)),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            dateFormat(date: widget.withdrawHistory.createdAt),
                            style: TextStyle(
                                color: Colors.black.withOpacity(.5),
                                fontWeight: FontWeight.w300,
                                fontSize: ScreenUtil().setSp(12)),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Text(
                            ketStatus(widget.withdrawHistory.status)
                                .toUpperCase(),
                            style: TextStyle(
                                color:
                                    colorStatus(widget.withdrawHistory.status),
                                fontWeight: FontWeight.normal,
                                fontSize: ScreenUtil().setSp(12)),
                          ),
                        ],
                      ),
                      Divider(height: ScreenUtil().setHeight(40)),
                      Row(
                        children: <Widget>[
                          Text(
                            "Bank Tujuan".toUpperCase(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: ScreenUtil().setSp(12)),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          FadeInImage.assetNetwork(
                            placeholder: "",
                            width: ScreenUtil().setWidth(50),
                            height: ScreenUtil().setHeight(30),
                            fit: BoxFit.fitWidth,
                            image:
                                widget.withdrawHistory.bankDetail.logo.length >
                                        0
                                    ? BaseUrl.SoedjaAPI +
                                        "/" +
                                        widget.withdrawHistory.bankDetail.logo
                                    : "",
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      Container(
                          decoration: BoxDecoration(
                              color: ColorApps.yellowLight,
                              borderRadius: BorderRadius.circular(
                                  ScreenUtil().setHeight(5))),
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setHeight(20),
                              horizontal: ScreenUtil().setWidth(20)),
                          child: Row(
                            children: <Widget>[
                              Text(
                                widget.withdrawHistory.accountNumber,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ScreenUtil().setSp(15),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(child: Container()),
                              Icon(
                                Icons.credit_card,
                                color: Colors.black,
                                size: ScreenUtil().setHeight(24),
                              ),
                            ],
                          )),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      Text(
                        widget.withdrawHistory.status == 2
                            ? "Bukti Transaksi Bank".toUpperCase()
                            : widget.withdrawHistory.status == 9
                                ? "Catatan Verifikasi".toUpperCase()
                                : "Proses Verifikasi & Pengiriman"
                                    .toUpperCase(),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: ScreenUtil().setSp(12)),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(15)),
                      widget.withdrawHistory.status != 2
                          ? Container(
                              width: size.width,
                              decoration: BoxDecoration(
                                  color: ColorApps.light,
                                  borderRadius: BorderRadius.circular(
                                      ScreenUtil().setHeight(5))),
                              padding: EdgeInsets.symmetric(
                                  vertical: ScreenUtil().setHeight(20),
                                  horizontal: ScreenUtil().setWidth(20)),
                              child: widget.withdrawHistory.status != 9
                                  ? Row(
                                      children: <Widget>[
                                        Text(
                                          dateFormat(
                                                  dateTime: dateFrom,
                                                  formatDate: "dd/MM/yyyy") +
                                              " - " +
                                              dateFormat(
                                                  dateTime: dateTo,
                                                  formatDate: "dd/MM/yyyy"),
                                          style: TextStyle(
                                            color: Colors.black.withOpacity(.8),
                                            fontSize: ScreenUtil().setSp(15),
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Expanded(child: Container()),
                                        Text(
                                          "Dua Hari",
                                          style: TextStyle(
                                            color: Colors.black.withOpacity(.5),
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      widget.withdrawHistory.remark,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: ScreenUtil().setSp(12),
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ))
                          : Container(
                              height: ScreenUtil().setHeight(56),
                              child: FlatButtonWidget(
                                  context: context,
                                  color: Colors.black,
                                  onPressed: () => ShowImagePreview(
                                        context: context,
                                        index: 0,
                                        pictures: [
                                          Picture(
                                              path:
                                                  widget.withdrawHistory.proof)
                                        ],
                                      ),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.receipt,
                                        color: Colors.white,
                                        size: ScreenUtil().setHeight(16),
                                      ),
                                      SizedBox(
                                          width: ScreenUtil().setWidth(10)),
                                      Text(
                                        "Bukti Transfer",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(15),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Icon(
                                        Icons.file_download,
                                        color: Colors.white,
                                        size: ScreenUtil().setHeight(16),
                                      ),
                                    ],
                                  )),
                            ),
                      Divider(height: ScreenUtil().setHeight(40)),
                      Row(
                        children: <Widget>[
                          Text(
                            "Nominal Penarikan",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: ScreenUtil().setSp(12)),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Text(
                            "Rp ${formatCurrency.format(widget.withdrawHistory.amount)}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: ScreenUtil().setSp(15)),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenUtil().setHeight(15)),
                      Row(
                        children: <Widget>[
                          Text(
                            "Biaya Transfer",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: ScreenUtil().setSp(12)),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Text(
                            widget.withdrawHistory.adminFee == 0
                                ? "Gratis"
                                : "Rp ${formatCurrency.format(widget.withdrawHistory.adminFee)}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: ScreenUtil().setSp(15)),
                          ),
                        ],
                      ),
                      Divider(height: ScreenUtil().setHeight(40)),
                      Row(
                        children: <Widget>[
                          Text(
                            "Total Penarikan",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: ScreenUtil().setSp(12)),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Text(
                            "Rp ${formatCurrency.format(widget.withdrawHistory.amount - widget.withdrawHistory.adminFee)}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(15)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                widget.withdrawHistory.status == 2
                    ? DividerWidget(
                        child: Row(
                          children: <Widget>[
                            SvgPicture.asset(
                              Images.iconHelpSvg,
                              semanticsLabel: "icon_help",
                            ),
                            Expanded(
                              child: Text(
                                "Jika terjadi kesalahan dapat menghubungi kami via email finance@soedja.com",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: ScreenUtil().setSp(10),
                                    fontWeight: FontWeight.normal,
                                    height: 1.5),
                              ),
                            ),
                          ],
                        ),
                      )
                    : widget.withdrawHistory.status == 9
                        ? Container()
                        : DividerWidget(
                            child: Text(
                              "Catatan Umum :".toUpperCase(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenUtil().setSp(10),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                Visibility(
                  visible: widget.withdrawHistory.status != 2 &&
                      widget.withdrawHistory.status != 9,
                  child: Column(
                    children:
                        List.generate(withdrawDetailsNotes.length, (index) {
                      return DividerWidget(
                        color: isOdd(withdrawDetailsNotes[index]['index'])
                            ? Colors.white
                            : null,
                        padding: EdgeInsets.symmetric(
                            vertical: ScreenUtil().setHeight(10),
                            horizontal: ScreenUtil().setWidth(20)),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: ScreenUtil().setHeight(32),
                              decoration: BoxDecoration(
                                color:
                                    isOdd(withdrawDetailsNotes[index]['index'])
                                        ? ColorApps.light
                                        : Colors.white,
                                borderRadius: BorderRadius.circular(
                                    ScreenUtil().setHeight(18)),
                              ),
                              padding:
                                  EdgeInsets.all(ScreenUtil().setHeight(5)),
                              margin: EdgeInsets.only(
                                  right: ScreenUtil().setWidth(10)),
                              child: AspectRatio(
                                aspectRatio: 1 / 1,
                                child: Container(
                                  height: ScreenUtil().setHeight(32),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${withdrawDetailsNotes[index]['index']}.",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: ScreenUtil().setSp(10),
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                withdrawDetailsNotes[index]['notes'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ScreenUtil().setSp(10),
                                  fontWeight: FontWeight.normal,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(100)),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Visibility(
              visible: !Keyboard().isKeyboardOpen(context),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 1)
                ]),
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(20),
                    vertical: ScreenUtil().setHeight(10)),
                child: Container(
                  height: ScreenUtil().setHeight(56),
                  child: FlatButtonText(
                      context: context,
                      text: "Tutup".toUpperCase(),
                      onPressed: () {
                        Navigation().navigateBack(context);
                      }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
