import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/assets/fonts.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/components/portfolio_components.dart';
import 'package:soedja_freelance/revamp/modules/wallet/bloc/wallet_bloc.dart';
import 'package:soedja_freelance/revamp/modules/wallet/bloc/wallet_state.dart';
import 'package:soedja_freelance/revamp/modules/wallet/components/history_components.dart';
import 'package:soedja_freelance/revamp/modules/wallet/components/wallet_components.dart';
import 'package:soedja_freelance/revamp/modules/wallet/components/withdraw_components.dart';
import 'package:soedja_freelance/revamp/modules/wallet/models/wallet_model.dart';
import 'package:soedja_freelance/revamp/modules/wallet/screens/wallet_history_income.dart';
import 'package:soedja_freelance/revamp/modules/wallet/screens/withdraw_history_screen.dart';
import 'package:soedja_freelance/revamp/modules/wallet/screens/withdraw_screen.dart';

class WalletScreen extends StatefulWidget {
  final WalletBloc walletBloc;

  const WalletScreen({Key key, this.walletBloc}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WalletScreen();
  }
}

class _WalletScreen extends State<WalletScreen>
    with SingleTickerProviderStateMixin {
  int walletAmount = 0;
  TabController tabController;
  int tabIndex = 0;

  @override
  void initState() {
    tabController =
        new TabController(vsync: this, length: 2, initialIndex: tabIndex);
    super.initState();
  }

  @override
  void dispose() {
    widget.walletBloc.requestGetWallet(context);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleSpacing: ScreenUtil().setWidth(5),
        title: Text(
          "SOEDJA Bills",
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
        actions: <Widget>[
          IconButton(
            icon: Container(
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.05),
                  borderRadius: BorderRadius.circular(ScreenUtil().setSp(25))),
              height: ScreenUtil().setHeight(40),
              width: ScreenUtil().setWidth(40),
              child: Icon(
                Icons.eject,
                color: Colors.black,
              ),
            ),
            onPressed: () => Navigation().navigateScreen(
                context,
                WithdrawHistoryScreen(
                  walletBloc: widget.walletBloc,
                )),
          ),
          SizedBox(width: ScreenUtil().setWidth(10)),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(20),
                vertical: ScreenUtil().setHeight(10)),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black.withOpacity(.5), width: .2))),
            child: StreamBuilder<GetWalletState>(
                stream: widget.walletBloc.getWalletStatus,
                builder: (context, snapshot) {
                  if (snapshot.data.isSuccess) {
                    if (snapshot.data.standby) {
                      walletAmount = snapshot.data.data.payload.amount;
                    }
                  }
                  return Row(
                    children: <Widget>[
                      WalletAmount(context, walletAmount, false),
                      Expanded(
                          child: SizedBox(width: ScreenUtil().setWidth(10))),
                      FlatButtonWidget(
                          context: context,
                          color: Colors.black,
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().setSp(30)),
                          onPressed:
//                          walletAmount < 10000 ? null :
                              () {
                            DialogWithdrawMethod(
                                context: context,
                                onChooseMethod: (type) {
                                  Navigation().navigateBack(context);
                                  Navigation().navigateScreen(
                                      context,
                                      WithdrawScreen(
                                        type: type,
                                        walletBloc: widget.walletBloc,
                                      ));
                                });
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.eject,
                                color: Colors.white,
                                size: ScreenUtil().setWidth(20),
                              ),
                              SizedBox(width: ScreenUtil().setWidth(5)),
                              Text(
                                "Withdraw",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(12),
                                  fontWeight: FontWeight.normal,
                                ),
                              )
                            ],
                          )),
                    ],
                  );
                }),
          ),
          Container(
            height: ScreenUtil().setHeight(56),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black.withOpacity(.5), width: .2))),
            child: TabBar(
              controller: tabController,
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(12),
                fontWeight: FontWeight.w500,
                fontFamily: Fonts.ubuntu,
              ),
              unselectedLabelStyle: TextStyle(
                color: Colors.black.withOpacity(.5),
                fontSize: ScreenUtil().setSp(12),
                fontWeight: FontWeight.normal,
                fontFamily: Fonts.ubuntu,
              ),
              tabs: <Widget>[
                Tab(
                  text: "PENDAPATAN",
                ),
                Tab(
                  text: "TERJADWAL",
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                TabBarView(
                  controller: tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    WalletHistoryIncome(
                      walletBloc: widget.walletBloc,
                      onRefreshWallet: () {
                        widget.walletBloc.requestGetWallet(context);
                      },
                    ),
                    WalletHistorySchedule(context, widget.walletBloc),
                  ],
                ),
                YellowBanner(
                    context: context,
                    message:
                        "Pendapatan yang diterima saat transaksi berhasil dibayarkan"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
