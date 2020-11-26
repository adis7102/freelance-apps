import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:soedja_freelance/revamp/assets/lotties.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/dashboard/screens/dashboard_screen.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/models/portfolio_models.dart';
import 'package:soedja_freelance/revamp/modules/wallet/bloc/wallet_bloc.dart';
import 'package:soedja_freelance/revamp/modules/wallet/models/withdraw_model.dart';
import 'package:soedja_freelance/revamp/modules/wallet/screens/withdraw_history_screen.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

Future<dynamic> SuccessCreateWithdraw(
  WalletBloc walletBloc,
  BuildContext context,
  CreateWithdrawResponse response,
) {
  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.black,
    context: context,
    enableDrag: false,
    builder: (BuildContext context) {
      Size size = MediaQuery.of(context).size;
      var date = new DateTime.fromMillisecondsSinceEpoch(
          response.payload.createdAt * 1000);
      DateTime dateFrom = new DateTime(date.year, date.month, date.day + 2);
      DateTime dateTo = new DateTime(date.year, date.month, date.day + 4);

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: ScreenUtil().setHeight(20)),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
                icon: Icon(
                  Icons.cancel,
                  color: Colors.white,
                ),
                onPressed: () => Navigation().navigateBack(context)),
          ),
          Expanded(
            child: Container(),
          ),
          LottieBuilder.asset(
            Lotties.successIcon,
            height: ScreenUtil().setHeight(150),
            repeat: false,
          ),
          Text(
            "Withdraw".toUpperCase(),
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtil().setSp(24)),
          ),
          SizedBox(height: ScreenUtil().setHeight(20)),
          Text(
            "Berhasil Dilakukan!",
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Divider(
                  height: ScreenUtil().setHeight(20),
                  color: Colors.white,
                ),
                Text(
                  "Proses Verifikasi & Pengiriman".toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: ScreenUtil().setSp(12)),
                ),
                SizedBox(height: ScreenUtil().setHeight(10)),
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
                                dateTime: dateFrom, formatDate: "dd/MM/yyyy") +
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
                SizedBox(height: ScreenUtil().setHeight(20)),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Nominal Penarikan',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: ScreenUtil().setSp(12)),
                      ),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    Expanded(
                      child: Text(
                        "Rp ${formatCurrency.format(response.payload.amount)}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(15),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtil().setHeight(10)),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Biaya Transfer',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: ScreenUtil().setSp(12)),
                      ),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    Expanded(
                      child: Text(
                        response.payload.adminFee == 0
                            ? "Gratis"
                            : "Rp ${formatCurrency.format(response.payload.adminFee)}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(15),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: ScreenUtil().setHeight(40),
                  color: Colors.white,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Uang Yang Dikirim (Nett)',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: ScreenUtil().setSp(12)),
                      ),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    Expanded(
                      child: Text(
                        "Rp ${formatCurrency.format(response.payload.amount - response.payload.adminFee)}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(15),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: ScreenUtil().setHeight(40),
                  color: Colors.white,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        Texts.timeCreate + ' :',
                        style: TextStyle(
                            color: Colors.white.withOpacity(.5),
                            fontWeight: FontWeight.normal,
                            fontSize: ScreenUtil().setSp(10)),
                      ),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    Expanded(
                      child: Text(
                        dateFormat(date: response.payload.createdAt),
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Colors.white.withOpacity(.5),
                            fontSize: ScreenUtil().setSp(10),
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                Container(
                  height: ScreenUtil().setHeight(56),
                  width: size.width,
                  child: FlatButtonText(
                    context: context,
                    color: Colors.black,
                    side: BorderSide(color: Colors.white, width: .5),
                    text: "Info Withdraw".toUpperCase(),
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(15)),
                    onPressed: () {
                      Navigation().navigateBack(context);
                      Navigation().navigateScreen(
                          context,
                          WithdrawHistoryScreen(
                            walletBloc: walletBloc,
                          ));
                    },
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(10)),
                Container(
                  height: ScreenUtil().setHeight(56),
                  width: size.width,
                  child: FlatButtonText(
                    context: context,
                    color: Colors.black,
                    text: "Tutup".toUpperCase(),
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(15)),
                    onPressed: () => Navigation().navigateBack(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
