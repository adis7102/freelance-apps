import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/urls.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/components/portfolio_components.dart';
import 'package:soedja_freelance/revamp/modules/wallet/bloc/wallet_bloc.dart';
import 'package:soedja_freelance/revamp/modules/wallet/models/withdraw_model.dart';
import 'package:soedja_freelance/revamp/modules/wallet/screens/withdraw_detail_screen.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

Future<dynamic> DialogWithdrawMethod({
  BuildContext context,
  Function(String) onChooseMethod,
}) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
          Size size = MediaQuery.of(context).size;

          return Container(
            padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(30)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(ScreenUtil().setSp(20))),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(30)),
                  child: Text(
                    "Pilih Metode Transfer",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(15),
                    ),
                  ),
                ),
                Container(
                  color: ColorApps.light,
                  height: ScreenUtil().setHeight(16),
                  margin: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(20)),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(30)),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setHeight(10)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Visibility(
                            visible: index == 1,
                            child: Container(
                              child: Text(
                                "Bank Lain",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(12)),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () =>
                                onChooseMethod(index == 0 ? "bca" : "other"),
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  vertical: ScreenUtil().setHeight(10)),
                              child: Row(
                                children: <Widget>[
                                  index == 0
                                      ? Container(
                                          height: ScreenUtil().setHeight(20),
                                          width: ScreenUtil().setWidth(54),
                                          child: Image.asset(Images.imgLogoBCA),
                                        )
                                      : Wrap(
                                          spacing: ScreenUtil().setWidth(10),
                                          children: <Widget>[
                                            Container(
                                              height:
                                                  ScreenUtil().setHeight(20),
                                              child: Image.asset(
                                                  Images.imgLogoAlto),
                                            ),
                                            Container(
                                              height:
                                                  ScreenUtil().setHeight(20),
                                              child: Image.asset(
                                                  Images.imgLogoPrima),
                                            ),
                                            Container(
                                              height:
                                                  ScreenUtil().setHeight(20),
                                              child: Image.asset(
                                                  Images.imgLogoAtmBersama),
                                            ),
                                          ],
                                        ),
                                  Expanded(
                                    child: Container(),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: ScreenUtil().setWidth(15),
                                    color: Colors.black.withOpacity(.5),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            "Fee Transaksi: ${index == 0 ? "Gratis" : "Rp ${formatCurrency.format(6500)}"}",
                            style: TextStyle(
                              color: Colors.black.withOpacity(.8),
                              fontSize: ScreenUtil().setSp(8),
                              fontWeight: FontWeight.normal,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                    height: ScreenUtil().setHeight(30),
                  ),
                  itemCount: 2,
                ),
              ],
            ),
          );
        });
      });
}

Future<dynamic> DialogWithdrawConfirm({
  BuildContext context,
  Function onWithdraw,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      Size size = MediaQuery.of(context).size;
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(ScreenUtil().setSp(10))),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(20),
            vertical: ScreenUtil().setHeight(30)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: ScreenUtil().setHeight(20)),
            Text(
              "Sudah Bener Banknya?",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtil().setSp(20),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(20)),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(40)),
              child: Text(
                "Pastikan nama rekening, nomor rekening dan nama bank sudah benar ya sebelum di proses.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black.withOpacity(.5),
                  fontWeight: FontWeight.normal,
                  height: 1.5,
                  fontSize: ScreenUtil().setSp(12),
                ),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(50)),
            Container(
              height: ScreenUtil().setHeight(56),
              width: size.width,
              child: FlatButtonText(
                  context: context,
                  borderRadius: BorderRadius.zero,
                  color: Colors.black,
                  text: "Withdraw Sekarang".toUpperCase(),
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(15)),
                  onPressed: () => onWithdraw()),
            ),
            SizedBox(height: ScreenUtil().setHeight(10)),
            Container(
              height: ScreenUtil().setHeight(56),
              width: size.width,
              child: FlatButtonText(
                  context: context,
                  borderRadius: BorderRadius.zero,
                  color: Colors.white,
                  text: "Eh Gak Jadi".toUpperCase(),
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(15)),
                  onPressed: () {
                    Navigation().navigateBack(context);
                  }),
            ),
          ],
        ),
      );
    },
  );
}

Widget CardWithdrawHistoryItem(BuildContext context, WithdrawHistory data) {
  return GestureDetector(
    onTap: () => Navigation()
        .navigateScreen(context, WithdrawDetailScreen(withdrawHistory: data)),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black.withOpacity(.5), width: .2),
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(5))),
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(20),
          vertical: ScreenUtil().setHeight(15)),
//    margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(300)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  color: colorStatus(data.status),
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().setHeight(20))),
              padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
              margin: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
              child: Icon(
                Icons.receipt,
                color: Colors.white,
                size: ScreenUtil().setHeight(16),
              )),
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Withdraw".toUpperCase(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(10),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      dateFormat(date: data.createdAt ?? 0),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(10),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtil().setHeight(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Status Tarik Uang",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(10),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      ketStatus(data.status).toUpperCase(),
                      style: TextStyle(
                        color: colorStatus(data.status),
                        fontSize: ScreenUtil().setSp(10),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: ScreenUtil().setHeight(30),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    data.status != 2
                        ? FadeInImage.assetNetwork(
                            placeholder: "",
                            width: ScreenUtil().setWidth(50),
                            height: ScreenUtil().setHeight(30),
                            fit: BoxFit.fitWidth,
                            image: data.bankDetail.logo.length > 0
                                ? BaseUrl.SoedjaAPI + "/" + data.bankDetail.logo
                                : "",
                          )
                        : Text(
                            "Rp ${formatCurrency.format(data.amount ?? 0)}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: ScreenUtil().setSp(15),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    data.status != 2
                        ? Text(
                            "Rp ${formatCurrency.format(data.amount ?? 0)}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: ScreenUtil().setSp(15),
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Container(
                            height: ScreenUtil().setHeight(40),
                            child: FlatButtonWidget(
                                context: context,
                                color: Colors.black,
                                onPressed: () => ShowImagePreview(
                                      context: context,
                                      index: 0,
                                      pictures: [Picture(path: data.proof)],
                                    ),
                                borderRadius: BorderRadius.zero,
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.receipt,
                                      color: Colors.white,
                                      size: ScreenUtil().setHeight(16),
                                    ),
                                    SizedBox(width: ScreenUtil().setWidth(5)),
                                    Text(
                                      "Bukti Transfer",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenUtil().setSp(10),
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )
                                  ],
                                )),
                          ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Color colorStatus(int status) {
  switch (status) {
    case 0:
      return Colors.black;
      break;
    case 1:
      return Colors.black;
      break;
    case 2:
      return Colors.green;
      break;
    case 9:
      return Colors.red;
      break;
    default:
      return Colors.black;
  }
}

String ketStatus(int status) {
  switch (status) {
    case 0:
      return "Sedang Verifikasi";
      break;
    case 1:
      return "Menunggu Transfer";
      break;
    case 2:
      return "Berhasil Dikirim";
      break;
    case 9:
      return "Withdraw Ditolak";
      break;
    default:
      return "Sedang Verifikasi";
  }
}

Widget CardWithdrawHistoryLoader(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black.withOpacity(.5), width: .2),
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(5))),
    padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(20),
        vertical: ScreenUtil().setHeight(15)),
//    margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(300)),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setSp(20)),
              height: ScreenUtil().setHeight(12),
              width: ScreenUtil().setWidth(50),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.05),
                borderRadius: BorderRadius.circular(ScreenUtil().setSp(5)),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setSp(20)),
              height: ScreenUtil().setHeight(12),
              width: ScreenUtil().setWidth(100),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.05),
                borderRadius: BorderRadius.circular(ScreenUtil().setSp(5)),
              ),
            ),
          ],
        ),
        SizedBox(height: ScreenUtil().setHeight(5)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setSp(20)),
              height: ScreenUtil().setHeight(15),
              width: ScreenUtil().setWidth(70),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.05),
                borderRadius: BorderRadius.circular(ScreenUtil().setSp(5)),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setSp(20)),
              height: ScreenUtil().setHeight(15),
              width: ScreenUtil().setWidth(70),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.05),
                borderRadius: BorderRadius.circular(ScreenUtil().setSp(5)),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
