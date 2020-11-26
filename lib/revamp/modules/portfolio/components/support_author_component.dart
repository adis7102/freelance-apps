import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/masked_text.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/auth/models/auth_models.dart';
import 'package:soedja_freelance/revamp/modules/feeds/components/feeds_component.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';
import 'package:soedja_freelance/revamp/modules/payment/bloc/payment_bloc.dart';
import 'package:soedja_freelance/revamp/modules/payment/bloc/payment_state.dart';
import 'package:soedja_freelance/revamp/modules/payment/components/PaymentDialogs.dart';
import 'package:soedja_freelance/revamp/modules/payment/components/payment_component.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/components/portfolio_components.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/models/portfolio_models.dart';
import 'package:soedja_freelance/revamp/modules/profile/models/profile_models.dart';

import '../../../../old_ver/components/dialog.dart';

DialogSupportAuthor(
    {BuildContext context,
    String portfolioId,
    ProfileDetail profile,
    ProfileDetail profileDetail,
    PaymentBloc paymentBloc,
    ProfileDetail authUser,
    TextEditingController amountController,
    TextEditingController commentController,
    Function(int, String) onGiveSupport}) {
  List amounts = [20000, 50000, 150000, 200000];

  commentController = new TextEditingController();
  amountController = new MoneyMaskedTextController(
    thousandSeparator: '.',
    decimalSeparator: '',
    precision: 0,
  );
  

  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
          Size size = MediaQuery.of(context).size;

          void validateField(BuildContext context) {
            if (int.parse(amountController.text.replaceAll(".", "")) < 10000) {
              showDialogMessage(context, "Nominal Minimum Rp 10.000",
                  "Minimum saweran adalah Rp 10.000 rupiah untuk sekali transaksi.");
              return null;
            }
            if (commentController.text.isEmpty) {
              showDialogMessage(context, "Kolom Komentar Tidak Boleh Kosong",
                  "Silahkan isi kolom komentar untuk memberikan sawer.");
              return null;
            }
            // paymentBloc.requestGiveSupport(
            //     context,
            //     portfolioId,
            //     int.parse(amountController.text.replaceAll(".", "")),
            //     commentController.text);
            showPaymentMethod(
              context: context,
              paymentOf: 'GIFT VIDEO',
              paymentBloc: paymentBloc,
              nominal: int.parse(amountController.text.replaceAll(".", "")),
              type: 'sawer',
              parentId: portfolioId,
              comment: commentController.text,
              profile: profile,
              profileDetail: profileDetail,
            );
            commentController.text = '';
            amountController.text = '';
          }

          return GestureDetector(
            onVerticalDragDown: (_) {},
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(ScreenUtil().setSp(10))),
              ),
//            padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      AvatarTitleSubtitle(
                          context: context,
                          profile: profileDetail,
                          profileAuth: authUser,
                          title: profileDetail.name,
                          subtitle: "Dukung kreator untuk mendapatkan uang.",
                          from: 'support'),
                    ],
                  ),
                  Divider(
                    height: ScreenUtil().setHeight(40),
                  ),
                  Wrap(
                    spacing: ScreenUtil().setWidth(10),
                    runSpacing: ScreenUtil().setHeight(10),
                    children: List.generate(amounts.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          setModalState(() {
                            amountController.text = amounts[index].toString();
                          });
                        },
                        child: Container(
                          width: (size.width - ScreenUtil().setWidth(60)) * 1 / 2,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(.05),
                            borderRadius:
                                BorderRadius.circular(ScreenUtil().setWidth(5)),
                            border: Border.all(
                                color: int.parse(amountController.text
                                            .replaceAll(".", "")) ==
                                        amounts[index]
                                    ? Colors.black
                                    : Colors.transparent,
                                width: 1),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(30),
                              vertical: ScreenUtil().setHeight(20)),
                          child: Row(
                            children: <Widget>[
                              SvgPicture.asset(
                                Images.iconGiveSupportBlack,
                                height: ScreenUtil().setHeight(21),
                                width: ScreenUtil().setWidth(21),
                              ),
                              SizedBox(width: ScreenUtil().setWidth(10)),
                              Text(
                                "Rp ${formatCurrency.format(amounts[index])}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: ScreenUtil().setSp(15)),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  TextFormFieldOutline(
                    hint: Texts.inputAmount,
                    controller: amountController,
                    minLines: 1,
                    maxLines: 5,
                    onPressedSuffix: () {
                      setModalState(() {
                        amountController.clear();
                      });
                    },
                    onChanged: (val) => setModalState(() {}),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: ScreenUtil().setSp(15)),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(10)),
                    prefixIcon: Container(
                      margin: EdgeInsets.fromLTRB(
                          ScreenUtil().setHeight(30),
                          ScreenUtil().setHeight(10),
                          ScreenUtil().setHeight(10),
                          ScreenUtil().setHeight(10)),
                      child: SvgPicture.asset(
                        Images.iconGiveSupportBlack,
                        height: ScreenUtil().setHeight(21),
                        width: ScreenUtil().setWidth(21),
                      ),
                    ),
                  ),
                  YellowBanner(
                      context: context,
                      message:
                          "Minimum saweran adalah Rp 10.000 rupiah untuk sekali transaksi.",
                      margin: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setHeight(20))),
                  Text(
                    Texts.giveComment,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil().setSp(14),
                    ),
                  ),
                  Divider(
                    height: ScreenUtil().setHeight(40),
                  ),
                  TextFormFieldAreaOutline(
                    hint: Texts.comment,
                    controller: commentController,
                    minLines: 3,
                    maxLines: 5,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(14),
                        height: 1.5,
                        fontWeight: FontWeight.normal),
                    contentPadding: EdgeInsets.all(ScreenUtil().setHeight(10)),
                    prefixIcon: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setHeight(20)),
                      child: SvgPicture.asset(
                        Images.iconCommentSvg,
                        height: ScreenUtil().setHeight(17),
                        width: ScreenUtil().setWidth(20),
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  Container(
                    height: ScreenUtil().setHeight(56),
                    width: size.width,
                    child: FlatButtonText(
                        context: context,
                        color: Colors.black,
                        text: "Lanjut Bayar".toUpperCase(),
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(15)),
                        onPressed: () {
                          validateField(context);
                        }),
                  )
                ],
              ),
            ),
          );
        });
      });
}
