import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/urls.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/wallet/bloc/wallet_bloc.dart';
import 'package:soedja_freelance/revamp/modules/wallet/bloc/wallet_state.dart';
import 'package:soedja_freelance/revamp/modules/wallet/models/bank_model.dart';

class BankListScreen extends StatefulWidget {
  final WalletBloc walletBloc;
  final Function(BankDetail) onSelectBank;

  const BankListScreen({
    Key key,
    @required this.walletBloc,
    @required this.onSelectBank,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BankListScreen();
  }
}

class _BankListScreen extends State<BankListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1.0,
          centerTitle: true,
          titleSpacing: ScreenUtil().setWidth(5),
          title: Text(
            "Pilih Bank Tujuan",
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
          ]),
      body: StreamBuilder<BankListState>(
          stream: widget.walletBloc.getBankList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isLoading) {
                return Center(child: SmallLayoutLoading(context, Colors.black));
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
                return ListView.separated(
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(5)),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          widget
                              .onSelectBank(snapshot.data.data.payload[index]);
                        },
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setHeight(10),
                              horizontal: ScreenUtil().setWidth(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "${snapshot.data.data.payload[index].title}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ScreenUtil().setSp(15),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Container(
                                width: ScreenUtil().setWidth(40),
                                color: Colors.white,
                                child: FadeInImage.assetNetwork(
                                  placeholder: "",
                                  width: ScreenUtil().setWidth(30),
                                  height: ScreenUtil().setHeight(30),
                                  fit: BoxFit.fitWidth,
                                  image: snapshot.data.data.payload[index].logo
                                              .length >
                                          0
                                      ? BaseUrl.SoedjaAPI +
                                          "/" +
                                          snapshot.data.data.payload[index].logo
                                      : "",
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                          height: ScreenUtil().setHeight(10),
                        ),
                    itemCount: snapshot.data.data.payload.length);
              }
            }
            return Container();
          }),
    );
  }
}
