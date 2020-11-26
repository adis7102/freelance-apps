import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/assets/lists.dart';
import 'package:soedja_freelance/revamp/assets/urls.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/wallet/bloc/wallet_bloc.dart';
import 'package:soedja_freelance/revamp/modules/wallet/components/withdraw_components.dart';
import 'package:soedja_freelance/revamp/modules/wallet/models/bank_model.dart';
import 'package:soedja_freelance/revamp/modules/wallet/screens/withdraw_pin_screen.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

class WithdrawConfirmScreen extends StatefulWidget {
  final WalletBloc walletBloc;
  final DateTime date;
  final BankDetail bankDetail;
  final String accountNumber;
  final String accountName;
  final int amount;

  WithdrawConfirmScreen({
    this.walletBloc,
    this.date,
    this.bankDetail,
    this.accountNumber,
    this.accountName,
    this.amount,
  });

  @override
  State<StatefulWidget> createState() {
    return _WithdrawConfirmScreen();
  }
}

class _WithdrawConfirmScreen extends State<WithdrawConfirmScreen> {
  DateTime dateFrom;
  DateTime dateTo;

  @override
  void initState() {
    setDate();
    super.initState();
  }

  setDate() {
    var date = widget.date;
    dateFrom = new DateTime(date.year, date.month, date.day);
    dateTo = new DateTime(date.year, date.month, date.day + 2);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        titleSpacing: ScreenUtil().setWidth(5),
        title: Text(
          "Withdraw ${widget.bankDetail.title}".toUpperCase(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil().setSp(15),
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigation().navigateBack(context)),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          dateFormat(dateTime: widget.date),
                          style: TextStyle(
                              color: Colors.black.withOpacity(.5),
                              fontWeight: FontWeight.normal,
                              fontSize: ScreenUtil().setSp(12)),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Text(
                          "Sedang Verifikasi".toUpperCase(),
                          style: TextStyle(
                              color: Colors.black,
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
                          height: ScreenUtil().setHeight(20),
                          fit: BoxFit.fitWidth,
                          image: widget.bankDetail.logo.length > 0
                              ? BaseUrl.SoedjaAPI + "/" + widget.bankDetail.logo
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
                              widget.accountNumber,
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
                      "Proses Verifikasi & Pengiriman".toUpperCase(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: ScreenUtil().setSp(12)),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(15)),
                    Container(
                      decoration: BoxDecoration(
                          color: ColorApps.light,
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().setHeight(5))),
                      padding: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setHeight(20),
                          horizontal: ScreenUtil().setWidth(20)),
                      child: Row(
                        children: <Widget>[
                          Text(
                            dateFormat(
                                    dateTime: dateFrom,
                                    formatDate: "dd/MM/yyyy") +
                                " - " +
                                dateFormat(
                                    dateTime: dateTo, formatDate: "dd/MM/yyyy"),
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
                      ),
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
                          "Rp ${formatCurrency.format(widget.amount)}",
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
                          widget.bankDetail.code == "BCA"
                              ? "Gratis"
                              : "Rp ${formatCurrency.format(6500)}",
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
                          "Rp ${formatCurrency.format(widget.amount - (widget.bankDetail.code == "BCA" ? 0 : 6500))}",
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
              DividerWidget(
                child: Text(
                  "Catatan Umum :".toUpperCase(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(10),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                children: List.generate(withdrawDetailsNotes.length, (index) {
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
                            color: isOdd(withdrawDetailsNotes[index]['index'])
                                ? ColorApps.light
                                : Colors.white,
                            borderRadius: BorderRadius.circular(
                                ScreenUtil().setHeight(18)),
                          ),
                          padding: EdgeInsets.all(ScreenUtil().setHeight(5)),
                          margin:
                              EdgeInsets.only(right: ScreenUtil().setWidth(10)),
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
              SizedBox(height: ScreenUtil().setHeight(100)),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 1)]),
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(20),
                  vertical: ScreenUtil().setHeight(10)),
              child: Container(
                height: ScreenUtil().setHeight(56),
                child: FlatButtonText(
                    context: context,
                    text: "Withdraw Sekarang".toUpperCase(),
                    onPressed: () => DialogWithdrawConfirm(
                        context: context,
                        onWithdraw: () {
                          Navigation().navigateScreen(
                              context,
                              WithdrawPinScreen(
                                walletBloc: widget.walletBloc,
                                bank: widget.bankDetail.code,
                                accountNumber: widget.accountNumber,
                                accountName: widget.accountName,
                                amount: widget.amount,
                              ));
                        })),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
