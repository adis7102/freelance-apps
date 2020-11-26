import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/contact/bloc/contact_bloc.dart';
import 'package:soedja_freelance/revamp/modules/contact/bloc/contact_state.dart';
import 'package:soedja_freelance/revamp/modules/contact/models/contact_models.dart';
import 'package:soedja_freelance/revamp/modules/invoice/screens/form_invoice.dart';
import 'package:soedja_freelance/revamp/modules/wallet/components/blueCircle.dart';
import 'package:flutter/src/material/bottom_sheet.dart';

Widget ContactRow(
    {BuildContext context,
    ClientData clientData,
    KontakBloc kontakBloc,
    ListKontakResponse listKontak,
    Function getListClient}) {
  ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
  return Container(
    margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(25)),
    child: Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            ContactDetail(
                context: context,
                detailClient: clientData,
                kontakBloc: kontakBloc,
                listKontak: listKontak);
          },
          child: Container(
            margin: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
            child: BlueCircle(
                size: ScreenUtil().setHeight(40),
                isIcon: false,
                content: clientData.name[0].toUpperCase() +
                    clientData.name[1].toUpperCase(),
                fontSize: 15),
          ),
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () async {
              String _action = await ContactDetail(
                  context: context,
                  detailClient: clientData,
                  kontakBloc: kontakBloc,
                  getListClient: getListClient);
              print('[action] $_action');
              // if (_action == 'delete') {
              //   print('[WAKAKAK] $_action');
              //   kontakBloc.unStandBy();
              //   getListClient('');
              // }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(5)),
                  child: Text(
                    clientData.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: ScreenUtil().setSp(14),
                    ),
                  ),
                ),
                Text(
                  clientData.representativeName,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: ScreenUtil().setSp(11),
                      color: Color(0xFF707070)),
                ),
              ],
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Container(
                height: ScreenUtil().setHeight(40),
                width: ScreenUtil().setWidth(40),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black, width: ScreenUtil().setWidth(.5)),
                    shape: BoxShape.circle),
                child: Center(
                  child: Image.asset(
                    'assets/icons/gmail.png',
                    width: ScreenUtil().setWidth(23),
                  ),
                )),
            Container(
                margin:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
                height: ScreenUtil().setHeight(40),
                width: ScreenUtil().setWidth(40),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black, width: ScreenUtil().setWidth(.5)),
                    shape: BoxShape.circle),
                child: Center(
                  child: Image.asset(
                    'assets/icons/whatsapp.png',
                    width: ScreenUtil().setWidth(23),
                  ),
                )),
            Container(
                height: ScreenUtil().setHeight(40),
                width: ScreenUtil().setWidth(40),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black, width: ScreenUtil().setWidth(.5)),
                    shape: BoxShape.circle),
                child: Center(
                  child: Icon(
                    Icons.markunread_mailbox,
                    color: Color(0xFF2551C7),
                    size: ScreenUtil().setWidth(20),
                  ),
                ))
          ],
        )
      ],
    ),
  );
}

Widget ContactRowLoading({BuildContext context}) {
  ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
  return Container(
    margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(25)),
    child: Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
          height: ScreenUtil().setHeight(40),
          width: ScreenUtil().setHeight(40),
          decoration: BoxDecoration(
            color: Color(0xFFF0F0F0),
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(5)),
                width: ScreenUtil().setWidth(60),
                height: ScreenUtil().setHeight(15),
                decoration: BoxDecoration(
                    color: Color(0xFFF0F0F0),
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setHeight(5))),
              ),
              Container(
                margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(5)),
                width: ScreenUtil().setWidth(80),
                height: ScreenUtil().setHeight(15),
                decoration: BoxDecoration(
                    color: Color(0xFFF0F0F0),
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setHeight(5))),
              ),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Container(
              height: ScreenUtil().setHeight(40),
              width: ScreenUtil().setWidth(40),
              decoration: BoxDecoration(
                  color: Color(0xFFF0F0F0), shape: BoxShape.circle),
            ),
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
              height: ScreenUtil().setHeight(40),
              width: ScreenUtil().setWidth(40),
              decoration: BoxDecoration(
                  color: Color(0xFFF0F0F0), shape: BoxShape.circle),
            ),
            Container(
              height: ScreenUtil().setHeight(40),
              width: ScreenUtil().setWidth(40),
              decoration: BoxDecoration(
                  color: Color(0xFFF0F0F0), shape: BoxShape.circle),
            )
          ],
        )
      ],
    ),
  );
}

ContactDetail(
    {BuildContext context,
    ClientData detailClient,
    KontakBloc kontakBloc,
    Function getListClient,
    ListKontakResponse listKontak}) {
  ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);

  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
        ClientData clientData = detailClient;
        return GestureDetector(
          onVerticalDragStart: (_) {},
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            padding: EdgeInsets.only(top: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 28, right: 28),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.clear,
                          size: 24,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
                  child: BlueCircle(
                      size: ScreenUtil().setHeight(64),
                      content: clientData.name[0].toUpperCase() +
                          clientData.name[1].toUpperCase(),
                      isIcon: false,
                      fontSize: ScreenUtil().setSp(27)),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(5)),
                        child: Text(
                          clientData.name,
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(5)),
                        child: Text(
                          clientData.representativeName,
                          style: TextStyle(
                              color: Color(0xFF666666),
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.w800),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: 28, right: 28, bottom: ScreenUtil().setHeight(20)),
                  child: Divider(
                    color: Color(0xFFECECEC),
                    thickness: ScreenUtil().setSp(2),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: 28, right: 28, bottom: ScreenUtil().setHeight(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin:
                              EdgeInsets.only(right: ScreenUtil().setWidth(10)),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(5)),
                                child: Image.asset(
                                    'assets/images/indonesia2.png',
                                    width: ScreenUtil().setWidth(26)),
                              ),
                              Text(
                                clientData.phone,
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(10),
                                    fontWeight: FontWeight.w800),
                              )
                            ],
                          )),
                      Container(
                          margin:
                              EdgeInsets.only(right: ScreenUtil().setWidth(10)),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(5)),
                                child: Image.asset('assets/icons/gmail.png',
                                    width: ScreenUtil().setWidth(26)),
                              ),
                              Text(
                                clientData.email,
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(10),
                                    fontWeight: FontWeight.w800),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    ClientData _editedClientData = await CreateContactModal(
                      context: context,
                      kontakBloc: kontakBloc,
                      getListClient: getListClient,
                      clientData: clientData,
                      listKontak: listKontak,
                    );

                    if (_editedClientData != null) {
                      setModalState(() {
                        detailClient = _editedClientData;
                      });
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 28,
                        right: 28,
                        bottom: ScreenUtil().setHeight(10)),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Color(0xFFE2E2E2),
                          width: ScreenUtil().setWidth(1.2),
                        ),
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setHeight(5))),
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(20),
                        horizontal: ScreenUtil().setWidth(20)),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin:
                              EdgeInsets.only(right: ScreenUtil().setWidth(10)),
                          child: Icon(Icons.edit, size: ScreenUtil().setSp(25)),
                        ),
                        Expanded(
                            child: Container(
                          child: Text(
                            'Ubah',
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(12),
                                fontWeight: FontWeight.w800),
                          ),
                        )),
                        Container(
                          child: Icon(Icons.chevron_right,
                              size: ScreenUtil().setSp(25)),
                        ),
                      ],
                    ),
                  ),
                ),
                StreamBuilder<DeleteContactState>(
                    stream: kontakBloc.deleteContactStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.isLoading) {
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Color(0xFFE2E2E2),
                                  width: ScreenUtil().setWidth(1.2),
                                ),
                                borderRadius: BorderRadius.circular(
                                    ScreenUtil().setHeight(5))),
                            margin: EdgeInsets.only(
                                left: 28,
                                right: 28,
                                bottom: ScreenUtil().setHeight(30)),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: ScreenUtil().setHeight(56),
                              margin: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(20)),
                              child: LoadingIndicator(
                                indicatorType: Indicator.ballPulse,
                                color: Color(0xFFF0F0F0),
                              ),
                            ),
                          );
                        } else if (snapshot.data.hasError) {
                          onWidgetDidBuild(() {
                            showDialogMessage(context, snapshot.data.message,
                                "Terjadi kesalahan. Silahkan coba lagi.");
                          });
                          return Container(
                              child: Center(child: ShowErrorState()));
                        } else if (snapshot.data.isSuccess) {
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            kontakBloc.unStandByDelete();
                            getListClient('');
                            Navigator.pop(context, 'delete');
                          });
                        }
                      }
                      return GestureDetector(
                        onTap: () {
                          kontakBloc.requestDeleteContact(
                              context, clientData.clientId);
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 28,
                              right: 28,
                              bottom: ScreenUtil().setHeight(30)),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Color(0xFFE2E2E2),
                                width: ScreenUtil().setWidth(1.2),
                              ),
                              borderRadius: BorderRadius.circular(
                                  ScreenUtil().setHeight(5))),
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setHeight(20),
                              horizontal: ScreenUtil().setWidth(20)),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(10)),
                                child: Icon(Icons.delete,
                                    size: ScreenUtil().setSp(25)),
                              ),
                              Expanded(
                                  child: Container(
                                child: Text(
                                  'Hapus Kontak',
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(12),
                                      fontWeight: FontWeight.w800),
                                ),
                              )),
                              Container(
                                child: Icon(Icons.chevron_right,
                                    size: ScreenUtil().setSp(25)),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
              ],
            ),
          ),
        );
      });
    },
  );
}

CreateContactModal(
    {BuildContext context,
    KontakBloc kontakBloc,
    Function getListClient,
    ClientData clientData,
    ListKontakResponse listKontak,
    String from}) {
  TextEditingController _namaKlien = new TextEditingController();
  TextEditingController _namaPerwakilan = new TextEditingController();
  TextEditingController _nomorTelepon = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  String _typeAction = '';

  if (clientData != null) {
    _namaKlien.text = clientData.name;
    _namaPerwakilan.text = clientData.representativeName;
    _nomorTelepon.text = clientData.phone;
    _email.text = clientData.email;
  }

  afterSuccessCreate(type, dataSnapshot) {
    if (from == "formInvoice") {
      if (type == 'buatinvoice') {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.pop(context, 'success');
        });
      } else {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.pop(context, 'success');
        });
      }
    } else {
      if (type == 'buatinvoice') {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          kontakBloc.unStandBy();
          getListClient('');
          Navigator.pop(context);
          Navigation().navigateScreen(
              context,
              FormInvoice(
                listKontak: listKontak,
                clientData: ClientData(
                    clientId: dataSnapshot.data.data.payload.clientId,
                    name: dataSnapshot.data.data.payload.name,
                    representativeName:
                        dataSnapshot.data.data.payload.representativeName,
                    email: dataSnapshot.data.data.payload.email,
                    phone: dataSnapshot.data.data.payload.phone,
                    createdAt: dataSnapshot.data.data.payload.createdAt,
                    updatedAt: dataSnapshot.data.data.payload.updatedAt),
              ));
        });
      } else {
        kontakBloc.unStandBy();
        getListClient('');
        Navigator.pop(context);
      }
    }
  }

  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
        return GestureDetector(
          onVerticalDragStart: (_) {},
          child: Container(
            height: MediaQuery.of(context).size.height / 1.10,
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            padding: EdgeInsets.only(top: 32),
            child: ListView(children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin:
                        EdgeInsets.only(bottom: ScreenUtil().setHeight(120)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin:
                              EdgeInsets.only(left: 28, right: 28, bottom: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  'Buat Kontak Baru',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 15),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.clear,
                                  size: 24,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          color: Color(0xFFF4F4F7),
                          height: 19,
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(left: 28, right: 28, bottom: 10),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 67,
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFCFCFCF)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: TextFormField(
                              controller: _namaKlien,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.account_circle,
                                  size: 28,
                                  color: Colors.black,
                                ),
                                hintText: 'Nama Klien …',
                                hintStyle: TextStyle(
                                  color: Color(0xFFC3C3C3),
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(left: 28, right: 28, bottom: 10),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 67,
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFCFCFCF)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: TextFormField(
                              controller: _namaPerwakilan,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.account_circle,
                                  size: 28,
                                  color: Colors.black,
                                ),
                                hintText: 'Nama Perwakilan Klien …',
                                hintStyle: TextStyle(
                                  color: Color(0xFFC3C3C3),
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                left: 28, right: 28, bottom: 10, top: 10),
                            child: Text(
                              'NOMOR TELEPON / WHATSAPP',
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(8),
                                  color: Color(0xFF666666),
                                  fontWeight: FontWeight.w800),
                            )),
                        Container(
                          margin:
                              EdgeInsets.only(left: 28, right: 28, bottom: 10),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 67,
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFCFCFCF)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              color: Color(0xFFCFCFCF)))),
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                          margin: EdgeInsets.only(right: 8),
                                          child: Image.asset(
                                            'assets/images/indonesia2.png',
                                            width: ScreenUtil().setWidth(35),
                                          )),
                                      Text(
                                        '+62',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 17),
                                      )
                                    ],
                                  )),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  margin: EdgeInsets.only(left: 15),
                                  child: TextFormField(
                                    controller: _nomorTelepon,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '8xxx',
                                      hintStyle: TextStyle(
                                        color: Color(0xFFC3C3C3),
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                left: 28, right: 28, bottom: 10),
                            child: Text(
                              'EMAIL',
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(8),
                                  color: Color(0xFF666666),
                                  fontWeight: FontWeight.w800),
                            )),
                        Container(
                          margin:
                              EdgeInsets.only(left: 28, right: 28, bottom: 10),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 67,
                          decoration: BoxDecoration(
                            color: Color(0xFFF4F4F7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                flex: 1,
                                child: Container(
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                          child: Image.asset(
                                        'assets/icons/gmail.png',
                                        width: ScreenUtil().setWidth(35),
                                      )),
                                    ],
                                  )),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: TextFormField(
                                    controller: _email,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Alamat Email Klien …',
                                      hintStyle: TextStyle(
                                        color: Color(0xFFC3C3C3),
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  clientData == null
                      ? StreamBuilder<CreateContactState>(
                          stream: kontakBloc.postContact,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              print(snapshot.data.isLoading.toString());
                              if (snapshot.data.isLoading) {
                                return FlatButtonLoading(
                                    context: context,
                                    size: MediaQuery.of(context).size,
                                    color: Colors.black,
                                    margin: EdgeInsets.zero);
                              } else if (snapshot.data.hasError) {
                                onWidgetDidBuild(() {
                                  showDialogMessage(
                                      context,
                                      snapshot.data.message,
                                      "Terjadi kesalahan. Silahkan coba lagi.");
                                  kontakBloc.unStandBy();
                                });
                              } else if (snapshot.data.isSuccess) {
                                if (_typeAction == 'cumabuat') {
                                  afterSuccessCreate('cumabuat', snapshot);
                                }
                              }
                            }
                            return Container(
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: SizedBox(
                                      height: 56,
                                      child: FlatButton(
                                          onPressed: _namaKlien.text == '' &&
                                                  _namaPerwakilan.text == '' &&
                                                  _nomorTelepon.text == '' &&
                                                  _email.text == ''
                                              ? null
                                              : () {
                                                  setModalState(() {
                                                    _typeAction = 'cumabuat';
                                                  });
                                                  kontakBloc.requestCreateContact(
                                                      context,
                                                      CreateContactPayload(
                                                          name: _namaKlien.text,
                                                          representativeName:
                                                              _namaPerwakilan
                                                                  .text,
                                                          phone: '+62' +
                                                              _nomorTelepon
                                                                  .text,
                                                          email: _email.text));
                                                },
                                          disabledColor: Color(0xFFF0F0F0),
                                          color: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Text(
                                            'SIMPAN',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 15),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          })
                      : StreamBuilder<EditContactState>(
                          stream: kontakBloc.editContactStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              print(snapshot.data.isLoading.toString());
                              if (snapshot.data.isLoading) {
                                return FlatButtonLoading(
                                    context: context,
                                    size: MediaQuery.of(context).size,
                                    color: Colors.black,
                                    margin: EdgeInsets.zero);
                              } else if (snapshot.data.hasError) {
                                onWidgetDidBuild(() {
                                  showDialogMessage(
                                      context,
                                      snapshot.data.message,
                                      "Terjadi kesalahan. Silahkan coba lagi.");
                                  kontakBloc.unStandBy();
                                });
                              } else if (snapshot.data.isSuccess) {
                                if (_typeAction == 'cumabuat') {
                                  kontakBloc.unStandByEdit();
                                  getListClient('');
                                  Navigator.pop(
                                      context,
                                      ClientData(
                                          clientId: snapshot
                                              .data.data.payload.clientId,
                                          name: snapshot.data.data.payload.name,
                                          representativeName: snapshot.data.data
                                              .payload.representativeName,
                                          email:
                                              snapshot.data.data.payload.email,
                                          phone:
                                              snapshot.data.data.payload.phone,
                                          createdAt: snapshot
                                              .data.data.payload.createdAt,
                                          updatedAt: snapshot
                                              .data.data.payload.updatedAt));
                                }
                              }
                            }
                            return Container(
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: SizedBox(
                                      height: 56,
                                      child: FlatButton(
                                          onPressed: _namaKlien.text == '' &&
                                                  _namaPerwakilan.text == '' &&
                                                  _nomorTelepon.text == '' &&
                                                  _email.text == ''
                                              ? null
                                              : () {
                                                  setModalState(() {
                                                    _typeAction = 'cumabuat';
                                                  });
                                                  kontakBloc.requestEditContact(
                                                    context,
                                                    CreateContactPayload(
                                                        name: _namaKlien.text,
                                                        representativeName:
                                                            _namaPerwakilan
                                                                .text,
                                                        phone: (_nomorTelepon
                                                                            .text[
                                                                        0] +
                                                                    _nomorTelepon
                                                                            .text[
                                                                        1] +
                                                                    _nomorTelepon
                                                                            .text[
                                                                        2]) ==
                                                                '+62'
                                                            ? _nomorTelepon.text
                                                            : '+62' +
                                                                _nomorTelepon
                                                                    .text,
                                                        email: _email.text),
                                                    clientData.clientId,
                                                  );
                                                },
                                          disabledColor: Color(0xFFF0F0F0),
                                          color: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Text(
                                            'SIMPAN',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 15),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                  clientData == null
                      ? StreamBuilder<CreateContactState>(
                          stream: kontakBloc.postContact,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              print(snapshot.data.isLoading.toString());
                              if (snapshot.data.isLoading) {
                                return FlatButtonLoading(
                                    context: context,
                                    size: MediaQuery.of(context).size,
                                    color: Color(0xFFF0F0F0),
                                    margin: EdgeInsets.zero);
                              } else if (snapshot.data.hasError) {
                                onWidgetDidBuild(() {
                                  showDialogMessage(
                                      context,
                                      snapshot.data.message,
                                      "Terjadi kesalahan. Silahkan coba lagi.");
                                  kontakBloc.unStandBy();
                                });
                              } else if (snapshot.data.isSuccess) {
                                if (_typeAction == 'buatinvoice') {
                                  afterSuccessCreate('buatinvoice', snapshot);
                                }
                              }
                            }
                            return Container(
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: SizedBox(
                                      height: 56,
                                      child: FlatButton(
                                          onPressed: _namaKlien.text == '' &&
                                                  _namaPerwakilan.text == '' &&
                                                  _nomorTelepon.text == '' &&
                                                  _email.text == ''
                                              ? null
                                              : () {
                                                  setModalState(() {
                                                    _typeAction = 'buatinvoice';
                                                  });
                                                  kontakBloc.requestCreateContact(
                                                      context,
                                                      CreateContactPayload(
                                                          name: _namaKlien.text,
                                                          representativeName:
                                                              _namaPerwakilan
                                                                  .text,
                                                          phone: '+62' +
                                                              _nomorTelepon
                                                                  .text,
                                                          email: _email.text));
                                                },
                                          color: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Text(
                                            'SIMPAN & BUAT INVOICE',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 15),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          })
                      : StreamBuilder<EditContactState>(
                          stream: kontakBloc.editContactStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              print(snapshot.data.isLoading.toString());
                              if (snapshot.data.isLoading) {
                                return FlatButtonLoading(
                                    context: context,
                                    size: MediaQuery.of(context).size,
                                    color: Color(0xFFF0F0F0),
                                    margin: EdgeInsets.zero);
                              } else if (snapshot.data.hasError) {
                                onWidgetDidBuild(() {
                                  showDialogMessage(
                                      context,
                                      snapshot.data.message,
                                      "Terjadi kesalahan. Silahkan coba lagi.");
                                  kontakBloc.unStandBy();
                                });
                              } else if (snapshot.data.isSuccess) {
                                if (_typeAction == 'buatinvoice') {
                                  SchedulerBinding.instance
                                      .addPostFrameCallback((_) {
                                    kontakBloc.unStandByEdit();
                                    getListClient('');
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigation().navigateScreen(
                                        context,
                                        FormInvoice(
                                          listKontak: listKontak,
                                          clientData: ClientData(
                                              clientId: snapshot
                                                  .data.data.payload.clientId,
                                              name: snapshot
                                                  .data.data.payload.name,
                                              representativeName: snapshot
                                                  .data
                                                  .data
                                                  .payload
                                                  .representativeName,
                                              email: snapshot
                                                  .data.data.payload.email,
                                              phone: snapshot
                                                  .data.data.payload.phone,
                                              createdAt: snapshot
                                                  .data.data.payload.createdAt,
                                              updatedAt: snapshot
                                                  .data.data.payload.updatedAt),
                                        ));
                                  });
                                  // getListClient('');
                                  // Navigator.pop(
                                  //     context,
                                  //     ClientData(
                                  //         clientId: snapshot
                                  //             .data.data.payload.clientId,
                                  //         name: snapshot.data.data.payload.name,
                                  //         representativeName: snapshot.data.data
                                  //             .payload.representativeName,
                                  //         email:
                                  //             snapshot.data.data.payload.email,
                                  //         phone:
                                  //             snapshot.data.data.payload.phone,
                                  //         createdAt: snapshot
                                  //             .data.data.payload.createdAt,
                                  //         updatedAt: snapshot
                                  //             .data.data.payload.updatedAt));
                                }
                              }
                            }
                            return Container(
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: SizedBox(
                                      height: 56,
                                      child: FlatButton(
                                          onPressed: _namaKlien.text == '' &&
                                                  _namaPerwakilan.text == '' &&
                                                  _nomorTelepon.text == '' &&
                                                  _email.text == ''
                                              ? null
                                              : () {
                                                  setModalState(() {
                                                    _typeAction = 'buatinvoice';
                                                  });
                                                  kontakBloc.requestEditContact(
                                                    context,
                                                    CreateContactPayload(
                                                        name: _namaKlien.text,
                                                        representativeName:
                                                            _namaPerwakilan
                                                                .text,
                                                        phone: (_nomorTelepon
                                                                            .text[
                                                                        0] +
                                                                    _nomorTelepon
                                                                            .text[
                                                                        1] +
                                                                    _nomorTelepon
                                                                            .text[
                                                                        2]) ==
                                                                '+62'
                                                            ? _nomorTelepon.text
                                                            : '+62' +
                                                                _nomorTelepon
                                                                    .text,
                                                        email: _email.text),
                                                    clientData.clientId,
                                                  );
                                                },
                                          color: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Text(
                                            'SIMPAN & BUAT INVOICE',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 15),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                  Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom))
                ],
              ),
            ]),
          ),
        );
      });
    },
  );
}
