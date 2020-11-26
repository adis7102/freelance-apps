import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:soedja_freelance/revamp/assets/fonts.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/lists.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_state.dart';
import 'package:soedja_freelance/revamp/modules/auth/screens/confirm_otp_screen.dart';
import 'package:soedja_freelance/revamp/modules/auth/screens/create_pin_screen.dart';
import 'package:soedja_freelance/revamp/modules/dashboard/screens/dashboard_screen.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/components/portfolio_components.dart';
import 'package:soedja_freelance/revamp/modules/wallet/bloc/wallet_bloc.dart';
import 'package:soedja_freelance/revamp/modules/wallet/bloc/wallet_state.dart';
import 'package:soedja_freelance/revamp/modules/wallet/components/success_create_withdraw.dart';
import 'package:soedja_freelance/revamp/modules/wallet/models/withdraw_model.dart';
import 'package:soedja_freelance/revamp/modules/wallet/screens/withdraw_history_screen.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

class WithdrawPinScreen extends StatefulWidget {
  final WalletBloc walletBloc;
  final String bank;
  final String accountNumber;
  final String accountName;
  final int amount;

  WithdrawPinScreen({
    Key key,
    this.walletBloc,
    this.bank,
    this.accountNumber,
    this.accountName,
    this.amount,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WithdrawPinScreen();
  }
}

class _WithdrawPinScreen extends State<WithdrawPinScreen> {
  String pin = '';

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        titleSpacing: ScreenUtil().setWidth(5),
        title: Text(
          "Masukan Pin".toUpperCase(),
          style: TextStyle(
              color: Colors.white,
              fontSize: ScreenUtil().setSp(15),
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () => Navigation().navigateBack(context)),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(20),
                  vertical: ScreenUtil().setHeight(10)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().setWidth(5))),
              child: YellowBanner(
                message:
                    "Masukan PIN untuk melanjutkan transaksi withdraw ke rekening kamu.",
                margin: EdgeInsets.zero,
              ),
            ),
            Expanded(child: SizedBox(height: ScreenUtil().setHeight(30))),
            Image.asset(Images.imgLogoOnly,
                height: ScreenUtil().setHeight(51), fit: BoxFit.fitHeight),
            SizedBox(height: ScreenUtil().setHeight(30)),
            StreamBuilder<CreateWithdrawState>(
                stream: widget.walletBloc.getWithdrawStatus,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.isLoading) {
                      return SmallLayoutLoading(context, Colors.white);
                    } else if (snapshot.data.hasError) {
                      if (snapshot.data.standby) {
                        onWidgetDidBuild(() {
                          showDialogMessage(context, snapshot.data.message,
                              "Terjadi kesalahan, silahkan coba lagi.");
                        });
                        widget.walletBloc.unStandBy();
                      }
                    } else if (snapshot.data.isSuccess) {
                      onWidgetDidBuild(() {
                        Navigation().navigateBack(context);
                        Navigation().navigateBack(context);
                        Navigation().navigateBack(context);
                        Navigation().navigateBack(context);
                        SuccessCreateWithdraw(
                            widget.walletBloc, context, snapshot.data.data);
                      });
                      widget.walletBloc.unStandBy();
                    }
                  }
                  return Column(
                    children: <Widget>[
                      DotsPin(
                        total: 6,
                        index: pin.length,
                        size: 14.0,
                        color: ColorApps.white,
                      ),
                    ],
                  );
                }),
            SizedBox(height: ScreenUtil().setHeight(40)),
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(70)),
              child: Wrap(
                spacing: ScreenUtil().setSp(40),
                runSpacing: ScreenUtil().setSp(20),
                children: List.generate(listPhonebutton.length, (index) {
                  if (index != 11) {
                    return ClipRRect(
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setSp(72)),
                      child: Material(
                        color: index != 9 && pin.length != 6
                            ? Colors.white.withOpacity(.1)
                            : Colors.transparent,
                        child: Container(
                          width:
                              (size.width - ScreenUtil().setWidth(220)) * 1 / 3,
                          child: AspectRatio(
                            aspectRatio: 1 / 1,
                            child: InkWell(
                              onTap: index == 9 || pin.length == 6
                                  ? null
                                  : () {
                                      if (pin.length != 6) {
                                        setState(() {
                                          pin = pin +
                                              listPhonebutton[index]['value'];
                                        });
                                        print(pin);
                                        if (pin.length == 6) {
                                          widget.walletBloc
                                              .requestCreateWithdraw(
                                            context,
                                            widget.bank,
                                            widget.accountNumber,
                                            widget.accountName,
                                            widget.amount,
                                            pin,
                                          );
                                        }
                                      }
                                    },
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  listPhonebutton[index]['text'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenUtil().setSp(34)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (index == 11) {
                    return ClipRRect(
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setSp(72)),
                      child: Material(
                        color: index != 9 && pin.length != 6
                            ? Colors.white.withOpacity(.1)
                            : Colors.transparent,
                        child: Container(
                          width:
                              (size.width - ScreenUtil().setWidth(220)) * 1 / 3,
                          child: AspectRatio(
                            aspectRatio: 1 / 1,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  if (pin.length > 0) {
                                    pin = pin.substring(0, pin.length - 1);
                                  }
                                });
                              },
                              child: Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(ScreenUtil().setSp(72)),
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        height: ScreenUtil().setHeight(72),
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(50)),
          ],
        ),
      ),
    );
  }
}
