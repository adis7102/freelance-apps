import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/modules/feeds/components/feeds_component.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/components/portfolio_components.dart';
import 'package:soedja_freelance/revamp/modules/wallet/bloc/wallet_bloc.dart';
import 'package:soedja_freelance/revamp/modules/wallet/bloc/wallet_state.dart';
import 'package:soedja_freelance/revamp/modules/wallet/models/wallet_model.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

//Widget WalletHistoryIncome(
//    {BuildContext context,
//    WalletBloc walletBloc,
//    ScrollController controller,
//    int page,
//    List<WalletData> list,
//    bool isLoadMore,
//    bool isEmpty,
//    Function(List<WalletData>,bool, bool) payloadData}) {
//  bool load = isLoadMore;
//  bool empty = isEmpty;
//  return StreamBuilder<HistoryWalletState>(
//      stream: walletBloc.getWalletHistory,
//      builder: (context, snapshot) {
//        if (snapshot.hasData) {
//          if (snapshot.data.isLoading) {
//            if (page == 1) {
//              print("page $page");
//              return Center(child: SmallLayoutLoading(context, Colors.black));
//            }
//          } else if (snapshot.data.hasError) {
//            if (snapshot.data.standby) {
//              onWidgetDidBuild(() {
//                showDialogMessage(context, snapshot.data.message,
//                    "Terjadi kesalahan. Silahkan coba lagi.");
//                walletBloc.unStandBy();
//              });
//              return Center(child: ShowErrorState());
//            }
//          } else if (snapshot.data.isSuccess) {
//            if (snapshot.data.standby) {
//              print("page $page");
//              if (page < snapshot.data.data.payload.totalPage) {
//                isLoadMore = true;
//              } else {
//                isLoadMore = false;
//              }
//              if (page == 1) {
//                list = snapshot.data.data.payload.rows;
////
//                if (snapshot.data.data.payload.rows.length == 0) {
//                  isEmpty = true;
//                } else {
//                  isEmpty = false;
//                }
//              } else {
////                list.removeLast();
//                list.addAll(snapshot.data.data.payload.rows);
//              }
//              print("isLoadMore $isLoadMore");
//              print("isEmpty $isEmpty");
//              payloadData(list,isLoadMore, isEmpty);
//              print(list.length);
//            }
//
//            walletBloc.unStandBy();
////            return ListView.separated(
////                padding: EdgeInsets.symmetric(
////                    horizontal: ScreenUtil().setWidth(20),
////                    vertical: ScreenUtil().setHeight(70)),
////                controller: controller,
////                itemBuilder: (BuildContext context, int index) {
////                  return CardWalletHistoryItem(context, list[index]);
////                },
////                separatorBuilder: (BuildContext context, int index) => SizedBox(
////                  height: ScreenUtil().setHeight(10),
////                ),
////                itemCount: list.length);
//          }
//        }
//        return ListView.separated(
//            padding: EdgeInsets.symmetric(
//                horizontal: ScreenUtil().setWidth(20),
//                vertical: ScreenUtil().setHeight(70)),
//            controller: controller,
//            itemBuilder: (BuildContext context, int index) {
//              return CardWalletHistoryItem(context, list[index]);
//            },
//            separatorBuilder: (BuildContext context, int index) => SizedBox(
//                  height: ScreenUtil().setHeight(10),
//                ),
//            itemCount: list.length);
//      });
//}

Widget CardWalletHistoryItem(BuildContext context, WalletData walletData) {
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
        Text(
          walletData.notes ?? "".toUpperCase(),
          style: TextStyle(
            color: Colors.black,
            fontSize: ScreenUtil().setSp(10),
            fontWeight: FontWeight.normal,
          ),
        ),
        Text(
          dateFormat(date: walletData.createdAt ?? 0),
          style: TextStyle(
            color: Colors.black,
            fontSize: ScreenUtil().setSp(10),
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    ),
    SizedBox(height: ScreenUtil().setHeight(5)),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Rp ${formatCurrency.format(walletData.amount ?? 0)}",
          style: TextStyle(
            color: Colors.black,
            fontSize: ScreenUtil().setSp(12),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Rp ${formatCurrency.format(
            walletData.amount != null ? walletData.amount -
                (walletData.deduction != null ? walletData.deduction : 0) : 0)}",
            style: TextStyle(
              color: Colors.green,
              fontSize: ScreenUtil().setSp(12),
              fontWeight: FontWeight.normal,
            ),
          ),
          ],
        ),
      ],
    ),
  );
}


Widget CardWalletHistoryLoader(BuildContext context) {
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
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setSp(20)),
              height: ScreenUtil().setHeight(12),
              width: ScreenUtil().setWidth(50),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.05),
                borderRadius:
                BorderRadius.circular(ScreenUtil().setSp(5)),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setSp(20)),
              height: ScreenUtil().setHeight(12),
              width: ScreenUtil().setWidth(100),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.05),
                borderRadius:
                BorderRadius.circular(ScreenUtil().setSp(5)),
              ),
            ),
          ],
        ),
        SizedBox(height: ScreenUtil().setHeight(5)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setSp(20)),
              height: ScreenUtil().setHeight(15),
              width: ScreenUtil().setWidth(70),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.05),
                borderRadius:
                BorderRadius.circular(ScreenUtil().setSp(5)),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setSp(20)),
              height: ScreenUtil().setHeight(15),
              width: ScreenUtil().setWidth(70),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.05),
                borderRadius:
                BorderRadius.circular(ScreenUtil().setSp(5)),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget WalletHistorySchedule(BuildContext context, WalletBloc walletBloc) {
  Size size = MediaQuery.of(context).size;
  return Container(height: size.height,child: EmptyFeeds());
}
