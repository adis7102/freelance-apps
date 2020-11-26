import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/modules/feeds/components/feeds_component.dart';
import 'package:soedja_freelance/revamp/modules/wallet/bloc/wallet_bloc.dart';
import 'package:soedja_freelance/revamp/modules/wallet/bloc/wallet_state.dart';
import 'package:soedja_freelance/revamp/modules/wallet/components/history_components.dart';
import 'package:soedja_freelance/revamp/modules/wallet/models/wallet_model.dart';

class WalletHistoryIncome extends StatefulWidget {
  final WalletBloc walletBloc;
  final Function onRefreshWallet;

  WalletHistoryIncome({Key key, this.walletBloc, this.onRefreshWallet})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WalletHistoryIncome();
  }
}

class _WalletHistoryIncome extends State<WalletHistoryIncome> {
  ScrollController listController = new ScrollController();
  int limit = 20;
  int page = 1;
  String title = "";
  List<WalletData> historyList = new List<WalletData>();
  bool isLoadMore = false;
  bool isEmpty = false;

  @override
  void initState() {
    getWallet();
    getHistory();
    listController.addListener(scrollListener);
    super.initState();
  }

  getWallet() {
    widget.walletBloc.requestGetWallet(context);
  }

  getHistory() {
    widget.walletBloc.requestWalletHistory(context, page, limit);
  }

  void scrollListener() {
    if (listController.position.pixels >
        listController.position.maxScrollExtent -
            MediaQuery.of(context).size.width) {
      if (isLoadMore) {
        historyList.add(WalletData());
        page++;
        getHistory();
        isLoadMore = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () async {
        page = 1;
        widget.onRefreshWallet();
        getHistory();
        return;
      },
      child: StreamBuilder<HistoryWalletState>(
          stream: widget.walletBloc.getWalletHistory,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isLoading) {
                if (page == 1) {
                  return ListView.separated(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20),
                          vertical: ScreenUtil().setHeight(70)),
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return CardWalletHistoryLoader(context);
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(
                            height: ScreenUtil().setHeight(10),
                          ),
                      itemCount: 10);
                }
              } else if (snapshot.data.hasError) {
                if (snapshot.data.standby) {
                  onWidgetDidBuild(() {
                    showDialogMessage(context, snapshot.data.message,
                        "Terjadi kesalahan. Silahkan coba lagi.");
                    widget.walletBloc.unStandBy();
                  });
                  return Center(child: ShowErrorState());
                }
              } else if (snapshot.data.isSuccess) {
                if (snapshot.data.standby) {
                  if (page < snapshot.data.data.payload.totalPage) {
                    isLoadMore = true;
                  } else {
                    isLoadMore = false;
                  }
                  if (page == 1) {
                    historyList = snapshot.data.data.payload.rows;
//
                    if (snapshot.data.data.payload.rows.length == 0) {
                      isEmpty = true;
                    } else {
                      isEmpty = false;
                    }
                  } else {
                    historyList.removeLast();
                    historyList.addAll(snapshot.data.data.payload.rows);
                  }
                }

                widget.walletBloc.unStandBy();
              }
            }
            if (!isEmpty) {
              return ListView.separated(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(20),
                      vertical: ScreenUtil().setHeight(70)),
                  controller: listController,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    if (historyList[index].logId != null) {
                      return CardWalletHistoryItem(context, historyList[index]);
                    } else {
                      return CardWalletHistoryLoader(context);
                    }
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(
                        height: ScreenUtil().setHeight(10),
                      ),
                  itemCount: historyList.length);
            } else {
              return Container(height: size.height,child: EmptyFeeds());
            }
          }),
    );
  }
}
