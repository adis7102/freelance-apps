import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/lists.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/assets/urls.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/keyboard_helper.dart';
import 'package:soedja_freelance/revamp/helpers/masked_text.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/wallet/bloc/wallet_bloc.dart';
import 'package:soedja_freelance/revamp/modules/wallet/bloc/wallet_state.dart';
import 'package:soedja_freelance/revamp/modules/wallet/components/wallet_components.dart';
import 'package:soedja_freelance/revamp/modules/wallet/models/bank_model.dart';
import 'package:soedja_freelance/revamp/modules/wallet/screens/bank_history_screen.dart';
import 'package:soedja_freelance/revamp/modules/wallet/screens/bank_list_screen.dart';
import 'package:soedja_freelance/revamp/modules/wallet/screens/withdraw_confirm_screen.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

class WithdrawScreen extends StatefulWidget {
  final String type;
  final WalletBloc walletBloc;

  const WithdrawScreen({Key key, this.type, this.walletBloc}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WithdrawScreen();
  }
}

class _WithdrawScreen extends State<WithdrawScreen> {
  TextEditingController bankNameController = new TextEditingController();
  TextEditingController accountNumberController = new TextEditingController();
  TextEditingController accountNameController = new TextEditingController();
  MoneyMaskedTextController amountController = MoneyMaskedTextController(
    thousandSeparator: '.',
    decimalSeparator: '',
    precision: 0,
  );

  FocusNode bankNameFocus = new FocusNode();
  FocusNode accountNumberFocus = new FocusNode();
  FocusNode accountNameFocus = new FocusNode();
  FocusNode amountFocus = new FocusNode();

  int walletAmount = 0;

  BankDetail bankDetail = new BankDetail();

  @override
  void initState() {
    setBCA();
    widget.walletBloc.requestGetWallet(context);
    widget.walletBloc.requestBankList(context);
    widget.walletBloc.requestBankHistory(context);
    super.initState();
  }

  void setBCA() {
    if (widget.type == "bca") {
      bankDetail = new BankDetail(
          code: "BCA", title: "Bank BCA", logo: "images/banks/BCA.png");
      setState(() {
        bankNameController.text = bankDetail.title;
      });
    } else {
      bankDetail = new BankDetail(logo: "");
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
          "WITHDRAW SOEDJA Bills",
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
          Positioned.fill(
            child: GestureDetector(
              onTap: () => Keyboard().closeKeyboard(context),
              child: ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Nama Bank".toUpperCase(),
                          style: TextStyle(
                            color: Colors.black.withOpacity(.8),
                            fontSize: ScreenUtil().setSp(10),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(15)),
                        Container(
                          width: size.width,
                          height: AppBar().preferredSize.height - 10,
                          child: Stack(
                            children: <Widget>[
                              TextFormFieldOutline(
                                controller: bankNameController,
                                focusNode: bankNameFocus,
                                hint: "Pilih Tujuan Bank",
                                enabled: false,
                                suffixIcon: Container(
                                  padding: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(10)),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: "",
                                    width: ScreenUtil().setWidth(40),
                                    height: ScreenUtil().setHeight(20),
                                    fit: BoxFit.fitWidth,
                                    image: bankDetail.logo.length > 0
                                        ? BaseUrl.SoedjaAPI +
                                            "/" +
                                            bankDetail.logo
                                        : "",
                                  ),
                                ),
                                onFieldSubmitted: (val) => onFieldSubmitted(
                                    context, bankNameFocus, accountNumberFocus),
                                textInputAction: TextInputAction.next,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigation().navigateScreen(
                                      context,
                                      BankListScreen(
                                        walletBloc: widget.walletBloc,
                                        onSelectBank: (val) {
                                          Navigation().navigateBack(context);
                                          setState(() {
                                            bankDetail = val;
                                            bankNameController.text =
                                                bankDetail.title;
                                          });
                                        },
                                      ));
                                },
                                child: Container(
                                  width: size.width,
                                  height: AppBar().preferredSize.height,
                                  color: Colors.transparent,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(20)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Nomor Rekening".toUpperCase(),
                              style: TextStyle(
                                color: Colors.black.withOpacity(.8),
                                fontSize: ScreenUtil().setSp(10),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigation().navigateScreen(
                                  context,
                                  BankHistoryScreen(
                                    walletBloc: widget.walletBloc,
                                    onSelectBank: (bank) {
                                      Navigation().navigateBack(context);
                                      setState(() {
                                        bankDetail = bank.bankDetail;
                                        bankNameController.text =
                                            bankDetail.title;
                                        accountNumberController.text =
                                            bank.accountNumber;
                                        accountNameController.text =
                                            bank.accountName;
                                      });
                                    },
                                  )),
                              child: Container(
                                padding:
                                    EdgeInsets.all(ScreenUtil().setHeight(5)),
                                color: Colors.white,
                                child: Text(
                                  "Daftar Rek".toUpperCase(),
                                  style: TextStyle(
                                    color: ColorApps.primary,
                                    fontSize: ScreenUtil().setSp(10),
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: ScreenUtil().setHeight(10)),
                        TextFormFieldOutline(
                          focusNode: accountNumberFocus,
                          controller: accountNumberController,
                          hint: "Masukan Nomor Rekening",
                          keyboardType: TextInputType.number,
                          suffixIcon: Icon(
                            Icons.credit_card,
                            color: Colors.black,
                          ),
                          onFieldSubmitted: (val) => onFieldSubmitted(
                              context, accountNumberFocus, accountNameFocus),
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(height: ScreenUtil().setHeight(20)),
                        Text(
                          "Nama Pemilik Rekening".toUpperCase(),
                          style: TextStyle(
                            color: Colors.black.withOpacity(.8),
                            fontSize: ScreenUtil().setSp(10),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(15)),
                        TextFormFieldOutline(
                          controller: accountNameController,
                          focusNode: accountNameFocus,
                          hint: "Nama Pemilik Rekening",
                          suffixIcon: widget.type == "bca"
                              ? Container(
                                  width: 20,
                                )
                              : Container(width: 20),
                          onFieldSubmitted: (val) => onFieldSubmitted(
                              context, accountNameFocus, amountFocus),
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(height: ScreenUtil().setHeight(20)),
                        Text(
                          "Saldo Saat Ini".toUpperCase(),
                          style: TextStyle(
                            color: Colors.black.withOpacity(.8),
                            fontSize: ScreenUtil().setSp(10),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(15)),
                        StreamBuilder<GetWalletState>(
                            stream: widget.walletBloc.getWalletStatus,
                            builder: (context, snapshot) {
                              if (snapshot.data.isSuccess) {
                                if (snapshot.data.standby) {
                                  walletAmount =
                                      snapshot.data.data.payload.amount;
                                }
                              }
                              return Container(
                                  decoration: BoxDecoration(
                                      color: ColorApps.yellowLight,
                                      borderRadius: BorderRadius.circular(
                                          ScreenUtil().setHeight(5))),
                                  padding: EdgeInsets.symmetric(
                                      vertical: ScreenUtil().setHeight(10),
                                      horizontal: ScreenUtil().setWidth(20)),
                                  child: WalletAmount(
                                      context, walletAmount, false));
                            }),
                        SizedBox(height: ScreenUtil().setHeight(20)),
                        Text(
                          "${widget.type == "bca" ? "NOMINAL PENARIKAN" : "NOMINAL PENARIKAN + 6,500 (Biaya Transfer Bank)"}"
                              .toUpperCase(),
                          style: TextStyle(
                            color: Colors.black.withOpacity(.8),
                            fontSize: ScreenUtil().setSp(10),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(15)),
                        Row(
                          children: <Widget>[
                            Container(
                              width: ScreenUtil().setWidth(60),
                              child: TextFormFieldAreaOutline(
                                enabled: false,
                                hint: "Rp",
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(
                                        ScreenUtil().setHeight(5))),
                              ),
                            ),
                            Expanded(
                              child: TextFormFieldOutline(
                                focusNode: amountFocus,
                                controller: amountController,
                                keyboardType: TextInputType.number,
                                hint: "Nominal Tarik Uang",
                                borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(
                                        ScreenUtil().setHeight(5))),
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (val) =>
                                    Keyboard().closeKeyboard(context),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: ScreenUtil().setHeight(20)),
                      ],
                    ),
                  ),
                  DividerWidget(
                    child: Text(
                      "Catatan Umum:".toUpperCase(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(12),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Column(
                    children: List.generate(withdrawNotes.length, (index) {
                      return DividerWidget(
                        color: index == 0 ? Colors.white : null,
                        padding: EdgeInsets.symmetric(
                            vertical: ScreenUtil().setHeight(10),
                            horizontal: ScreenUtil().setWidth(20)),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: ScreenUtil().setHeight(32),
                              decoration: BoxDecoration(
                                color:
                                    index == 0 ? ColorApps.light : Colors.white,
                                borderRadius: BorderRadius.circular(
                                    ScreenUtil().setHeight(18)),
                              ),
                              padding:
                                  EdgeInsets.all(ScreenUtil().setHeight(5)),
                              margin: EdgeInsets.only(
                                  right: ScreenUtil().setWidth(10)),
                              child: AspectRatio(
                                aspectRatio: 1 / 1,
                                child: Container(
                                  height: ScreenUtil().setHeight(32),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${withdrawNotes[index]['index']}.",
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
                                withdrawNotes[index]['notes'],
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
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Visibility(
              visible: !Keyboard().isKeyboardOpen(context),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 3)
                ]),
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(20),
                    vertical: ScreenUtil().setHeight(10)),
                child: Container(
                  height: ScreenUtil().setHeight(56),
                  child: FlatButtonText(
                      context: context,
                      text: "Lanjut".toUpperCase(),
                      onPressed: () {
                        validateField(context);
                      }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void validateField(BuildContext context) {
    if (bankNameController.text.length < 3) {
      showDialogMessage(context, "Nama Bank Belum Benar",
          "Silahkan isi nama bank yang jelas dan benar");
      return null;
    }
    if (accountNumberController.text.length < 3) {
      showDialogMessage(context, "Nomor Rekening Bank Belum Benar",
          "Silahkan isi nomor rekening tujuan bank yang benar");
      return null;
    }
    if (accountNameController.text.length < 3) {
      showDialogMessage(context, "Nama Pemilik Rekening Belum Benar",
          "Silahkan isi nama rekening yang jelas dan benar");
      return null;
    }
    if (int.parse(amountController.text.replaceAll(".", "")) < 10000) {
      showDialogMessage(context, "Jumlah Nominal Minimal Rp 10.000",
          "Nominal Penarikan minimal sebesar Rp 10.000");
      return null;
    }
    if (int.parse(amountController.text.replaceAll(".", "")) > walletAmount) {
      showDialogMessage(context, "Jumlah Nominal Melebihi Saldo",
          "Nominal Penarikan maksimal sebesar Rp ${formatCurrency.format(walletAmount)}");
      return null;
    }

    Navigation().navigateScreen(
        context,
        WithdrawConfirmScreen(
          walletBloc: widget.walletBloc,
            date: DateTime.now(),
            bankDetail: bankDetail,
            accountNumber: accountNumberController.text,
            accountName: accountNameController.text,
            amount: int.parse(amountController.text.replaceAll(".", ""))));
  }
}
