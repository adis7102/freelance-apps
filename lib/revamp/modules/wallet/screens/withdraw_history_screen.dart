import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/feeds/components/feeds_component.dart';
import 'package:soedja_freelance/revamp/modules/wallet/bloc/wallet_bloc.dart';
import 'package:soedja_freelance/revamp/modules/wallet/bloc/wallet_state.dart';
import 'package:soedja_freelance/revamp/modules/wallet/components/withdraw_components.dart';
import 'package:soedja_freelance/revamp/modules/wallet/models/withdraw_model.dart';

class WithdrawHistoryScreen extends StatefulWidget {
  final WalletBloc walletBloc;

  const WithdrawHistoryScreen({Key key, this.walletBloc}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WithdrawHistoryScreen();
  }
}

class _WithdrawHistoryScreen extends State<WithdrawHistoryScreen> {
  ScrollController listController = new ScrollController();
  int limit = 10;
  int page = 1;
  List<WithdrawHistory> list = new List<WithdrawHistory>();
  bool isLoadMore = false;
  bool isEmpty = false;

  @override
  void initState() {
    getHistory();
    listController.addListener(scrollListener);
    super.initState();
  }

  getHistory() {
    widget.walletBloc.requestWithdrawHistory(context, page, limit);
  }

  void scrollListener() {
    if (listController.position.pixels >
        listController.position.maxScrollExtent -
            MediaQuery.of(context).size.width) {
      if (isLoadMore) {
        list.add(WithdrawHistory());
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        titleSpacing: ScreenUtil().setWidth(5),
        title: Text(
          "Withdraw History",
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
      body: RefreshIndicator(
        onRefresh: () async {
          page = 1;
          getHistory();
          return;
        },
        child: StreamBuilder<WithdrawHistoryState>(
            stream: widget.walletBloc.getWithdrawHistory,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.isLoading) {
                  if (page == 1) {
                    return ListView.separated(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(20),
                            vertical: ScreenUtil().setHeight(20)),
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return CardWithdrawHistoryLoader(context);
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(
                              height: ScreenUtil().setHeight(20),
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
                      list = snapshot.data.data.payload.rows;

                      if (snapshot.data.data.payload.rows.length == 0) {
                        isEmpty = true;
                      } else {
                        isEmpty = false;
                      }
                    } else {
                      list.removeLast();
                      list.addAll(snapshot.data.data.payload.rows);
                    }
                  }

                  widget.walletBloc.unStandBy();
                }
              }
              if (!isEmpty) {
                return ListView.separated(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(20),
                        vertical: ScreenUtil().setHeight(20)),
                    controller: listController,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      if (list[index].withdrawId != null) {
                        return CardWithdrawHistoryItem(context, list[index]);
                      } else {
                        return CardWithdrawHistoryLoader(context);
                      }
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                    itemCount: list.length);
              } else {
                return EmptyFeeds();
              }
            }),
      ),
    );
  }
}
