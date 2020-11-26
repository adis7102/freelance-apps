import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/urls.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/components/portfolio_components.dart';
import 'package:soedja_freelance/revamp/modules/wallet/bloc/wallet_bloc.dart';
import 'package:soedja_freelance/revamp/modules/wallet/bloc/wallet_state.dart';
import 'package:soedja_freelance/revamp/modules/wallet/models/bank_model.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

class BankHistoryScreen extends StatefulWidget {
  final WalletBloc walletBloc;
  final Function(BankHistory) onSelectBank;

  BankHistoryScreen({
    Key key,
    @required this.walletBloc,
    @required this.onSelectBank,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BankHistoryScreen();
  }
}

class _BankHistoryScreen extends State<BankHistoryScreen> {
  @override
  void initState() {
    super.initState();
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
            "Daftar Bank",
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
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: YellowBanner(
                message:
                    "List bank yang pernah digunakan sebelumnya untuk transaksi withdraw."),
          ),
          Container(
            padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.symmetric(
                    vertical: BorderSide(
                        color: Colors.black, width: .2))),
            width: size.width,
            child: Text(
              "Rekening",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(12)),
            ),
          ),
          Container(
            height: ScreenUtil().setHeight(10),
            color: Colors.white,
          ),
          Expanded(
            child: StreamBuilder<BankHistoryState>(
              stream: widget.walletBloc.getBankHistory,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.isLoading) {
                    return Center(
                        child: SmallLayoutLoading(context, Colors.black));
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
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              widget.onSelectBank(
                                  snapshot.data.data.payload[index]);
                            },
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  vertical: ScreenUtil().setHeight(10),
                                  horizontal: ScreenUtil().setWidth(20)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  FadeInImage.assetNetwork(
                                    placeholder: "",
                                    width: ScreenUtil().setWidth(40),
                                    height: ScreenUtil().setHeight(20),
                                    fit: BoxFit.fitWidth,
                                    image: snapshot.data.data.payload[index]
                                                .bankDetail.logo.length >
                                            0
                                        ? BaseUrl.SoedjaAPI +
                                            "/" +
                                            snapshot.data.data.payload[index]
                                                .bankDetail.logo
                                        : "",
                                  ),
                                  SizedBox(width: ScreenUtil().setWidth(20)),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          snapshot.data.data.payload[index]
                                              .accountName,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize:
                                                  ScreenUtil().setSp(12)),
                                        ),
                                        SizedBox(
                                            height:
                                                ScreenUtil().setHeight(10)),
                                        Text(
                                          snapshot.data.data.payload[index]
                                              .bankDetail.title,
                                          style: TextStyle(
                                              color: Colors.black
                                                  .withOpacity(.5),
                                              fontWeight: FontWeight.normal,
                                              fontSize:
                                                  ScreenUtil().setSp(12)),
                                        ),
                                        SizedBox(
                                            height:
                                                ScreenUtil().setHeight(10)),
                                        Text(
                                          snapshot.data.data.payload[index]
                                              .accountNumber,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize:
                                                  ScreenUtil().setSp(12)),
                                        ),
                                        SizedBox(
                                            height:
                                                ScreenUtil().setHeight(10)),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "Gunakan",
                                    style: TextStyle(
                                      color: ColorApps.primary,
                                      fontSize: ScreenUtil().setSp(12),
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                              height: ScreenUtil().setHeight(10),
                              indent: ScreenUtil().setWidth(10),
                              endIndent: ScreenUtil().setWidth(10),
                            ),
                        itemCount: snapshot.data.data.payload.length);
                  }
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
