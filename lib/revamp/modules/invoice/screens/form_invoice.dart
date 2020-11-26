import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/modules/contact/bloc/contact_bloc.dart';
import 'package:soedja_freelance/revamp/modules/contact/bloc/contact_state.dart';
import 'package:soedja_freelance/revamp/modules/contact/components/contact_components.dart';
import 'package:soedja_freelance/revamp/modules/contact/models/contact_models.dart';
import 'package:soedja_freelance/revamp/modules/invoice/bloc/invoice_bloc.dart';
import 'package:soedja_freelance/revamp/modules/invoice/bloc/invoice_state.dart';
import 'package:soedja_freelance/revamp/modules/invoice/components/invoice_widget.dart';
import 'package:soedja_freelance/revamp/modules/invoice/models/invoice_model.dart';
import 'package:soedja_freelance/revamp/modules/payment/components/payment_success.dart';
import 'package:soedja_freelance/revamp/modules/wallet/components/blueCircle.dart';

import '../../../../old_ver/components/dialog.dart';
import '../../../../old_ver/components/dialog.dart';
import '../../../../old_ver/utils/helpers.dart';
import '../../../helpers/navigation_helper.dart';

class FormInvoice extends StatefulWidget {
  final ListKontakResponse listKontak;
  final ClientData clientData;
  FormInvoice({Key key, this.listKontak, this.clientData}) : super(key: key);

  @override
  _FormInvoiceState createState() => _FormInvoiceState();
}

class _FormInvoiceState extends State<FormInvoice> {
  InvoiceBloc invoiceBloc = new InvoiceBloc();
  KontakBloc kontakBloc = new KontakBloc();
  bool _switchNomorInvoice = false;
  bool _switchDp = false;
  ClientData _selectedUser = new ClientData();
  ListKontakResponse _listKontakResponse = new ListKontakResponse();
  String _sendInvTo = '';
  String selectedDateInvoice = '';
  String selectedTimeInvoice = '';
  String selectedDateJatuhTempo = '';
  String selectedTimeJatuhTempo = '';
  String selectedDateJatuhTempoForDate = '';
  String selectedTimeJatuhTempoForDate = '';
  TextEditingController _judulPenawaran = TextEditingController();
  TextEditingController _nomorInvoice = TextEditingController();
  List<InvoiceDetail> _listOrderanDetail = new List<InvoiceDetail>();
  List<PaymentStage> _listPembayaran = new List<PaymentStage>();
  int _subTotalTagihan = 0;
  double _pajak = 0;
  int _totalPajak = 0;
  int _totalTagihan = 0;
  int _sisaPembayaran = 0;
  int _increPembayaran = 1;

  Future<void> _selectDate(BuildContext context, type) async {
    DateTime picked = await showRoundedDatePicker(
        context: context,
        theme: ThemeData(
          primaryColor: Color(0xFF2D5ADF),
          buttonColor: Color(0xFF2D5ADF),
          accentColor: Color(0xFF2D5ADF),
        ),
        styleDatePicker: MaterialRoundedDatePickerStyle(
            textStyleButtonPositive: TextStyle(color: Color(0xFF2D5ADF)),
            textStyleButtonNegative: TextStyle(color: Color(0xFF2D5ADF))));
    final timePicked = await showRoundedTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      theme: ThemeData(
        primaryColor: Color(0xFF2D5ADF),
        buttonColor: Color(0xFF2D5ADF),
        accentColor: Color(0xFF2D5ADF),
        textTheme: TextTheme(
          caption: TextStyle(color: Color(0xFF2D5ADF)),
        ),
      ),
    );

    print(picked);
    print(timePicked);
    if (type == 'tanggalinvoice') {
      if (picked != null) {
        setState(() {
          selectedDateInvoice = DateFormat("dd/MM/yyyy").format(picked);
        });
      }
      if (timePicked != null) {
        setState(() {
          selectedTimeInvoice = '${timePicked.format(context)}';
        });
      }
    } else if (type == 'tanggaljatuhtempo') {
      if (picked != null) {
        setState(() {
          selectedDateJatuhTempo = DateFormat("dd/MM/yyyy").format(picked);
          selectedDateJatuhTempoForDate =
              DateFormat("yyyy-MM-dd").format(picked);
        });
      }
      if (timePicked != null) {
        var hour =
            timePicked.hour <= 9 ? '0${timePicked.hour}' : timePicked.hour;
        var minute = timePicked.minute <= 9
            ? '0${timePicked.minute}'
            : timePicked.minute;
        setState(() {
          selectedTimeJatuhTempo = '${timePicked.format(context)}';
          selectedTimeJatuhTempoForDate = '${hour}:${minute}:00';
        });
      }
    }
  }

  createUser() {
    paymentLunasMaker();
    invoiceBloc.requestPostCreateInvoice(
        context,
        CreateInvoicePayload(
            clientId: _selectedUser.clientId,
            title: _judulPenawaran.text,
            invoiceNumber: _switchNomorInvoice ? _nomorInvoice.text : "",
            dueDate:
                "$selectedDateJatuhTempoForDate $selectedTimeJatuhTempoForDate",
            tax: _pajak,
            paymentStages: _listPembayaran,
            invoiceDetails: _listOrderanDetail));
  }

  paymentLunasMaker() {
    PaymentStage _sisaPembayaranAkhir = new PaymentStage();
    int _allPercentage = 0;

    if (_listPembayaran.length > 0) {
      for (var item in _listPembayaran) {
        print(item.percentage);
        _allPercentage = _allPercentage + item.percentage;
      }

      _sisaPembayaranAkhir = PaymentStage(
          amount: _sisaPembayaran,
          title: "Pembayaran Lunas",
          percentage: 100 - _allPercentage);
      _listPembayaran.add(_sisaPembayaranAkhir);
    } else {
      _sisaPembayaranAkhir = PaymentStage(
          amount: _sisaPembayaran, title: "Pembayaran Lunas", percentage: 100);
    }
    print(_sisaPembayaranAkhir.toJson().toString());
  }

  ghosting() {
    Navigation().navigateBack(context);
  }

  deleteInvoice(int index) {
    setState(() {
      _listOrderanDetail.removeAt(index);
    });
  }

  deletePaymentStages(int index, int amount) {
    setState(() {
      _listPembayaran.removeAt(index);
      _sisaPembayaran = _sisaPembayaran + amount;
    });
  }

  editInvoice(
      BuildContext context, int index, InvoiceDetail invoiceDetail) async {
    setState(() {
      _totalTagihan = _totalTagihan - _subTotalTagihan;
      _subTotalTagihan = _subTotalTagihan - invoiceDetail.amount;
      _sisaPembayaran = _sisaPembayaran - invoiceDetail.amount;
    });

    InvoiceDetail _updatedOrderDetail = await DialogTambahOrderan(
        context: context, invoiceDetail: invoiceDetail);

    print('[LOG UPDATE ORDER] $_updatedOrderDetail');
    if (_updatedOrderDetail != null) {
      setState(() {
        _listOrderanDetail.removeAt(index);
        _listOrderanDetail.insert(index, _updatedOrderDetail);
        _subTotalTagihan = _subTotalTagihan + _updatedOrderDetail.amount;
        _sisaPembayaran = _sisaPembayaran + _updatedOrderDetail.amount;
        _totalTagihan = _totalTagihan + _subTotalTagihan;
      });
    } else {
      setState(() {
        _subTotalTagihan = _subTotalTagihan + invoiceDetail.amount;
        _sisaPembayaran = _sisaPembayaran + invoiceDetail.amount;
        _totalTagihan = _totalTagihan + _subTotalTagihan;
      });
    }
  }

  getListClient() {
    kontakBloc.requestGetListKontak(context, '');
  }

  @override
  void initState() {
    setState(() {
      _listKontakResponse = widget.listKontak;
    });
    if (widget.clientData != null) {
      setState(() {
        _selectedUser = widget.clientData;
        _sendInvTo = widget.clientData.name;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F7),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
            child: Stack(children: <Widget>[
              Container(
                height: ScreenUtil().setHeight(242),
                decoration: BoxDecoration(
                  color: Color(0xFF2D5ADF),
                ),
              ),
              Container(
                  alignment: Alignment.topRight,
                  child: Image.asset('assets/illustrations/mailbox.png',
                      width: ScreenUtil().setWidth(145)),
                  margin: EdgeInsets.only(
                      top: ScreenUtil().setHeight(70),
                      right: ScreenUtil().setWidth(25))),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        left: ScreenUtil().setWidth(10),
                        bottom: ScreenUtil().setHeight(35),
                        top: ScreenUtil().setHeight(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                right: ScreenUtil().setWidth(10)),
                            child: Icon(Icons.chevron_left,
                                size: ScreenUtil().setSp(35),
                                color: Colors.white),
                          ),
                        ),
                        Text(
                          'Kirim Invoice',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(17),
                              fontWeight: FontWeight.w800),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: ScreenUtil().setWidth(15),
                        bottom: ScreenUtil().setHeight(15)),
                    child: Text(
                      'JUDUL PENAWARAN',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(10),
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        bottom: ScreenUtil().setHeight(10),
                        right: ScreenUtil().setWidth(160)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(20),
                            right: ScreenUtil().setWidth(10),
                          ),
                          child: Icon(
                            Icons.markunread_mailbox,
                            size: ScreenUtil().setSp(20),
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 2,
                            controller: _judulPenawaran,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: ScreenUtil().setSp(15)),
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: Color(0xFF6C8BE8),
                                  fontWeight: FontWeight.w800,
                                  fontSize: ScreenUtil().setSp(15)),
                              hintText: "Tuliskan Disini …",
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: ScreenUtil().setWidth(15),
                        bottom: ScreenUtil().setHeight(21)),
                    child: Text(
                      'NAMA KLIEN',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(10),
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  StreamBuilder<ListKontakState>(
                      stream: kontakBloc.getKontak,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.isLoading) {
                            return Container(
                              margin: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(15),
                                  right: ScreenUtil().setWidth(15)),
                              padding: EdgeInsets.symmetric(
                                  vertical: ScreenUtil().setHeight(13),
                                  horizontal: ScreenUtil().setWidth(15)),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          ScreenUtil().setHeight(8)))),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                      height: ScreenUtil().setHeight(18),
                                      width: ScreenUtil().setWidth(18),
                                      margin: EdgeInsets.only(
                                          right: ScreenUtil().setWidth(15)),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                              ScreenUtil().setHeight(5)))),
                                  Expanded(
                                    child: Container(
                                      height: ScreenUtil().setHeight(15),
                                      width: ScreenUtil().setWidth(65),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                              ScreenUtil().setHeight(5))),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: ScreenUtil().setWidth(12)),
                                    height: ScreenUtil().setHeight(5),
                                    width: ScreenUtil().setWidth(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            ScreenUtil().setHeight(5))),
                                  ),
                                  Container(
                                    height: ScreenUtil().setHeight(40),
                                    width: ScreenUtil().setWidth(40),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Center(
                                      child: Icon(Icons.person_add,
                                          color: Colors.white,
                                          size: ScreenUtil().setSp(21)),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else if (snapshot.data.hasError) {
                            onWidgetDidBuild(() {
                              if (snapshot.data.standby) {
                                showDialogMessage(
                                    context,
                                    snapshot.data.message,
                                    "Terjadi Kesalahan, silahkan coba lagi.");
                                invoiceBloc.unStandBy();
                              }
                            });
                          } else if (snapshot.data.isSuccess) {
                            setState(() {
                              _listKontakResponse = snapshot.data.data;
                            });
                          }
                        }
                        return Container(
                          margin: EdgeInsets.only(
                              left: ScreenUtil().setWidth(15),
                              right: ScreenUtil().setWidth(15)),
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setHeight(13),
                              horizontal: ScreenUtil().setWidth(15)),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenUtil().setHeight(8)))),
                          child: Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () async {
                                  ClientData _clientData = await CardListkontak(
                                      context: context,
                                      listKontak: _listKontakResponse);
                                  if (_clientData != null) {
                                    setState(() {
                                      _selectedUser = _clientData;
                                      _sendInvTo = _clientData.name;
                                    });
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(15)),
                                  child: Icon(
                                    Icons.contacts,
                                    size: ScreenUtil().setSp(18),
                                    color: Color(0xFF7E7E7E),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    ClientData _clientData =
                                        await CardListkontak(
                                            context: context,
                                            listKontak: _listKontakResponse);
                                    if (_clientData != null) {
                                      setState(() {
                                        _selectedUser = _clientData;
                                        _sendInvTo = _clientData.name;
                                      });
                                    }
                                  },
                                  child: Container(
                                      child: Text(
                                    _sendInvTo != ''
                                        ? _sendInvTo
                                        : 'Mau kirim Invoice ke siapa?',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setHeight(13),
                                        fontWeight: FontWeight.w800),
                                  )),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  ClientData _clientData = await CardListkontak(
                                      context: context,
                                      listKontak: _listKontakResponse);
                                  if (_clientData != null) {
                                    setState(() {
                                      _selectedUser = _clientData;
                                      _sendInvTo = _clientData.name;
                                    });
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(12)),
                                  child: Icon(
                                    Icons.expand_more,
                                    size: ScreenUtil().setSp(20),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  String _statusCreate = await CreateContactModal(
                                      context: context,
                                      kontakBloc: kontakBloc,
                                      from: "formInvoice",
                                      getListClient: getListClient);
                                  if(_statusCreate != null) {
                                    getListClient();
                                  }
                                },
                                child: Container(
                                  height: ScreenUtil().setHeight(40),
                                  width: ScreenUtil().setWidth(40),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black),
                                  child: Center(
                                    child: Icon(Icons.person_add,
                                        color: Colors.white,
                                        size: ScreenUtil().setSp(21)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                ],
              )
            ]),
          ),
          Container(
            margin: EdgeInsets.only(
                left: ScreenUtil().setWidth(20),
                bottom: ScreenUtil().setHeight(15)),
            child: Text(
              'Info Penawaran',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(13),
                  fontWeight: FontWeight.w800),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(10),
                vertical: ScreenUtil().setHeight(15)),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      left: ScreenUtil().setWidth(18),
                      right: ScreenUtil().setWidth(18),
                      bottom: ScreenUtil().setHeight(10)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: ScreenUtil().setHeight(10)),
                              child: Text(
                                'TANGGAL INVOICE',
                                style: TextStyle(
                                    color: Color(0xFF707070),
                                    fontSize: ScreenUtil().setSp(8.5),
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _selectDate(context, 'tanggalinvoice');
                              },
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: ScreenUtil().setWidth(5)),
                                    child: Icon(
                                      Icons.access_time,
                                      size: ScreenUtil().setSp(22),
                                      color: Color(0xFF707070),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        selectedDateInvoice != '' &&
                                                selectedTimeInvoice != ''
                                            ? '${selectedDateInvoice}   ${selectedTimeInvoice}'
                                            : 'Pilih Tanggal & Waktu',
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(11),
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: ScreenUtil().setWidth(25)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: ScreenUtil().setHeight(10)),
                              child: Text(
                                'TANGGAL JATUH TEMPO',
                                style: TextStyle(
                                    color: Color(0xFF707070),
                                    fontSize: ScreenUtil().setSp(8.5),
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _selectDate(context, 'tanggaljatuhtempo');
                              },
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: ScreenUtil().setWidth(5)),
                                    child: Icon(
                                      Icons.access_time,
                                      size: ScreenUtil().setSp(22),
                                      color: Color(0xFF707070),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        selectedDateJatuhTempo != '' &&
                                                selectedTimeJatuhTempo != ''
                                            ? '${selectedDateJatuhTempo}   ${selectedTimeJatuhTempo}'
                                            : 'Pilih Tanggal & Waktu',
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(11),
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: ScreenUtil().setWidth(10),
                      right: ScreenUtil().setWidth(10),
                      bottom: ScreenUtil().setHeight(15)),
                  child: Divider(
                    color: Color(0xFFDADADA),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                left: ScreenUtil().setWidth(10),
                                bottom: ScreenUtil().setHeight(15)),
                            child: Text(
                              'NOMOR INVOICE',
                              style: TextStyle(
                                  color: Color(0xFF707070),
                                  fontSize: ScreenUtil().setSp(9),
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: ScreenUtil().setWidth(20)),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(10)),
                                  child: Icon(
                                    Icons.confirmation_number,
                                    size: ScreenUtil().setSp(30),
                                    color: Color(0xFF707070),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: TextField(
                                      maxLines: 1,
                                      controller: _nomorInvoice,
                                      enabled: _switchNomorInvoice,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: ScreenUtil().setSp(15)),
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            color: Color(0xFF8E8F9C),
                                            fontWeight: FontWeight.w800,
                                            fontSize: ScreenUtil().setSp(15)),
                                        hintText: "Nomor Invoice …",
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin:
                            EdgeInsets.only(right: ScreenUtil().setWidth(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: ScreenUtil().setHeight(10)),
                              child: Text(
                                'TIDAK ADA/ADA',
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(9),
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            Transform.scale(
                              scale: 1.1,
                              child: CupertinoSwitch(
                                trackColor: Color(0xFFC6F7BB),
                                value: _switchNomorInvoice,
                                onChanged: (value) {
                                  setState(() {
                                    _switchNomorInvoice = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: ScreenUtil().setWidth(20),
                bottom: ScreenUtil().setHeight(15)),
            child: Text(
              'Orderan Klien',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(13),
                  fontWeight: FontWeight.w800),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(20),
                bottom: ScreenUtil().setHeight(20)),
            margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      left: ScreenUtil().setWidth(20),
                      right: ScreenUtil().setWidth(20),
                      bottom: ScreenUtil().setHeight(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'JASA YANG KAMU TAWARKAN',
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(9),
                            fontWeight: FontWeight.w800),
                      ),
                      GestureDetector(
                        onTap: () async {
                          InvoiceDetail _orderDetail =
                              await DialogTambahOrderan(context: context);
                          if (_orderDetail != null) {
                            print(_orderDetail.toJson().toString());
                            setState(() {
                              _listOrderanDetail.add(_orderDetail);
                              _subTotalTagihan =
                                  _subTotalTagihan + _orderDetail.amount;
                              _sisaPembayaran =
                                  _sisaPembayaran + _orderDetail.amount;
                              _totalTagihan = _totalTagihan + _subTotalTagihan;
                            });
                          }
                        },
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(5)),
                                child: Icon(Icons.add_circle_outline,
                                    color: Color(0xFF2955D3)),
                              ),
                              Text(
                                'TAMBAHKAN',
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(11),
                                    color: Color(0xFF2955D3),
                                    fontWeight: FontWeight.w800),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(15)),
                  child: Divider(
                    color: Color(0xFFDADADA),
                  ),
                ),
                Visibility(
                  visible: _listOrderanDetail.length > 0,
                  child: Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _listOrderanDetail.length,
                        itemBuilder: (context, index) {
                          return InvoiceStruk(
                              context: context,
                              orderDetail: _listOrderanDetail[index],
                              index: index,
                              deleteItem: deleteInvoice,
                              editItem: editInvoice);
                        }),
                  ),
                ),
                Visibility(
                  visible: _listOrderanDetail.length == 0,
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(25)),
                    child: Column(
                      children: <Widget>[
                        Center(
                            child: Image.asset(
                          'assets/illustrations/icons.png',
                          width: ScreenUtil().setWidth(125),
                        )),
                        Container(
                          margin: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(20),
                              top: ScreenUtil().setHeight(20)),
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  'Yuk Mulai Tambahkan',
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(15),
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              Text(
                                'List Orderan',
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(15),
                                    fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(15)),
                          child: Divider(
                            color: Color(0xFFDADADA),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(15)),
                        padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(30),
                          right: ScreenUtil().setWidth(30),
                          top: ScreenUtil().setHeight(15),
                          bottom: ScreenUtil().setHeight(10),
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xFFF4F4F7),
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(
                                    ScreenUtil().setHeight(10)))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      'SUB-TOTAL',
                                      style: TextStyle(
                                          color: Color(0xFF707070),
                                          fontWeight: FontWeight.w800,
                                          fontSize: ScreenUtil().setSp(11)),
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: ScreenUtil().setWidth(5)),
                                          child: Text(
                                            'Rp',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize:
                                                    ScreenUtil().setSp(9)),
                                          ),
                                        ),
                                        Text(
                                          '${formatCurrency.format(_subTotalTagihan)}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: ScreenUtil().setSp(16)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(10)),
                              child: Divider(
                                color: Color(0xFF707070),
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: ScreenUtil().setWidth(5)),
                                          child: Text(
                                            'PAJAK',
                                            style: TextStyle(
                                                color: Color(0xFF707070),
                                                fontWeight: FontWeight.w800,
                                                fontSize:
                                                    ScreenUtil().setSp(11)),
                                          ),
                                        ),
                                        _pajak == 0
                                            ? IconButton(
                                                icon: Icon(
                                                  Icons.add_circle_outline,
                                                  size: ScreenUtil().setSp(22),
                                                  color: Color(0xFF2D5ADF),
                                                ),
                                                onPressed: () async {
                                                  PajakObj _jumlahPajak =
                                                      await DialogTambahPajak(
                                                          context: context,
                                                          subTotal:
                                                              _subTotalTagihan);
                                                  if (_jumlahPajak != null) {
                                                    setState(() {
                                                      _pajak =
                                                          _jumlahPajak.pajak;
                                                      _totalPajak =
                                                          _jumlahPajak.total;
                                                      _totalTagihan =
                                                          _totalTagihan +
                                                              _jumlahPajak
                                                                  .total;
                                                    });
                                                  }
                                                },
                                              )
                                            : IconButton(
                                                icon: Icon(
                                                  Icons.create,
                                                  size: ScreenUtil().setSp(22),
                                                  color: Color(0xFF2D5ADF),
                                                ),
                                                onPressed: () {
                                                  DialogTambahPajak(
                                                      context: context);
                                                },
                                              )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: ScreenUtil().setWidth(5)),
                                          child: Text(
                                            'Rp',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize:
                                                    ScreenUtil().setSp(9)),
                                          ),
                                        ),
                                        Text(
                                          '${formatCurrency.format(_totalPajak)}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: ScreenUtil().setSp(16)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(15)),
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(30),
                            vertical: ScreenUtil().setHeight(20)),
                        decoration: BoxDecoration(
                            color: Color(0xFF2D5ADF),
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(
                                    ScreenUtil().setHeight(10)))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                      margin: EdgeInsets.only(
                                          right: ScreenUtil().setWidth(8)),
                                      child: Image.asset(
                                        'assets/icons/moneystack.png',
                                        width: ScreenUtil().setWidth(19),
                                      )),
                                  Text(
                                    'TOTAL TAGIHAN INVOICE',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenUtil().setSp(11),
                                        fontWeight: FontWeight.w800),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(5)),
                                  child: Text(
                                    'Rp',
                                    style: TextStyle(
                                        color: Color(0xFFFDC72B),
                                        fontWeight: FontWeight.w800,
                                        fontSize: ScreenUtil().setSp(9)),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    '${formatCurrency.format(_totalTagihan)}',
                                    style: TextStyle(
                                        color: Color(0xFFFDC72B),
                                        fontWeight: FontWeight.w800,
                                        fontSize: ScreenUtil().setSp(16)),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: ScreenUtil().setWidth(15),
                      bottom: ScreenUtil().setHeight(20)),
                  child: Text(
                    'METODE PEMBAYARAN TERSEDIA UNTUK KLIEN',
                    style: TextStyle(
                        color: Color(0xFF707070),
                        fontSize: ScreenUtil().setSp(9),
                        fontWeight: FontWeight.w800),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setHeight(10)),
                    border: Border.all(color: Color(0xFFD5D5D5)),
                  ),
                  margin: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(15)),
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            bottom: ScreenUtil().setHeight(10),
                            left: ScreenUtil().setWidth(30),
                            right: ScreenUtil().setWidth(30)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                                child: Image.asset(
                              'assets/bank/gopay2.png',
                              width: ScreenUtil().setWidth(70),
                            )),
                            Container(
                                child: Image.asset(
                              'assets/bank/ovo.png',
                              width: ScreenUtil().setWidth(45),
                            )),
                            Container(
                                child: Image.asset(
                              'assets/bank/dana.png',
                              width: ScreenUtil().setWidth(55),
                            )),
                            Container(
                                child: Image.asset(
                              'assets/bank/linkaja.png',
                              width: ScreenUtil().setWidth(25),
                            )),
                          ],
                        ),
                      ),
                      Container(
                        child: Divider(
                          color: Color(0xFF707070),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(30),
                            right: ScreenUtil().setWidth(30),
                            top: ScreenUtil().setHeight(10),
                            bottom: ScreenUtil().setHeight(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'assets/bank/BNI.png',
                                width: ScreenUtil().setWidth(50),
                              ),
                            ),
                            Container(
                              child: Image.asset(
                                'assets/bank/mandiri.png',
                                width: ScreenUtil().setWidth(50),
                              ),
                            ),
                            Container(
                              child: Image.asset(
                                'assets/bank/img_logo_bca.png',
                                width: ScreenUtil().setWidth(50),
                              ),
                            ),
                            Container(
                              child: Image.asset(
                                'assets/bank/permata.png',
                                width: ScreenUtil().setWidth(55),
                              ),
                            ),
                            Container(
                              child: Image.asset(
                                'assets/bank/BRI.png',
                                width: ScreenUtil().setWidth(65),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Divider(
                          color: Color(0xFF707070),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(30),
                            right: ScreenUtil().setWidth(80),
                            top: ScreenUtil().setHeight(10),
                            bottom: ScreenUtil().setHeight(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'assets/bank/visa.png',
                                width: ScreenUtil().setWidth(50),
                              ),
                            ),
                            Container(
                              child: Image.asset(
                                'assets/bank/img_logo_alto.png',
                                width: ScreenUtil().setWidth(35),
                              ),
                            ),
                            Container(
                              child: Image.asset(
                                'assets/bank/mastercard.png',
                                width: ScreenUtil().setWidth(95),
                              ),
                            ),
                            Container(
                              child: Image.asset(
                                'assets/bank/img_logo_atm_bersama.png',
                                width: ScreenUtil().setWidth(40),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setHeight(15),
                vertical: ScreenUtil().setHeight(15)),
            child: Text(
              'Sistem Pembayaran',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(13),
                  fontWeight: FontWeight.w800),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(60)),
            padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(20),
              bottom: ScreenUtil().setHeight(8),
              left: ScreenUtil().setWidth(15),
              right: ScreenUtil().setHeight(20),
            ),
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'TAGIH PEMBAYARAN BERKALA',
                        style: TextStyle(
                            color: Color(0xFF707070),
                            fontSize: ScreenUtil().setSp(9),
                            fontWeight: FontWeight.w800),
                      ),
                      Text(
                        'TIDAK/YA',
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(9),
                            fontWeight: FontWeight.w800),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Apakah invoice ini menggunakan',
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(13),
                                fontWeight: FontWeight.w800),
                          ),
                          Text(
                            'sistem Down Payment (DP)?',
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(13),
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                      Transform.scale(
                        scale: 1.1,
                        child: CupertinoSwitch(
                          trackColor: Color(0xFFC6F7BB),
                          value: _switchDp,
                          onChanged: (value) {
                            setState(() {
                              _switchDp = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
                  child: Text(
                    'Kami akan membagi pembayaran berdasarkan skema DP ditentukan.',
                    style: TextStyle(
                        color: Color(0xFF707070),
                        fontSize: ScreenUtil().setSp(9),
                        fontWeight: FontWeight.w800),
                  ),
                ),
                Visibility(
                  visible: _switchDp,
                  child: Container(
                    margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
                    child: Divider(
                      thickness: 1.5,
                      color: Color(0xFFF0F0F0),
                    ),
                  ),
                ),
                Visibility(
                  visible: _switchDp,
                  child: Container(
                    margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'TIMELINE PEMBAYARAN',
                          style: TextStyle(
                              color: Color(0xFF707070),
                              fontSize: ScreenUtil().setSp(9),
                              fontWeight: FontWeight.w800),
                        ),
                        GestureDetector(
                          onTap: () async {
                            PaymentStage _pembayaranDetail = await DialogDp(
                              context: context,
                              totalTagihan: _sisaPembayaran,
                              pembayaranKe: _increPembayaran,
                            );
                            if (_pembayaranDetail != null) {
                              setState(() {
                                _increPembayaran = _increPembayaran + 1;
                                _sisaPembayaran =
                                    _sisaPembayaran - _pembayaranDetail.amount;
                                _listPembayaran.add(_pembayaranDetail);
                              });
                            }
                          },
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(5)),
                                child: Icon(Icons.add_circle_outline,
                                    color: Color(0xFF2955D3)),
                              ),
                              Text(
                                'TAMBAHKAN',
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(10),
                                    color: Color(0xFF2955D3),
                                    fontWeight: FontWeight.w800),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: _switchDp,
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          fit: FlexFit.loose,
                          child: Container(
                            margin: EdgeInsets.only(
                                right: ScreenUtil().setWidth(10)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    child: Image.asset(
                                  'assets/icons/ic_wave_yellow.png',
                                  width: ScreenUtil().setWidth(20),
                                )),
                                Visibility(
                                  visible: _listPembayaran.length > 0,
                                  child: Flexible(
                                    fit: FlexFit.loose,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        primary: false,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: _listPembayaran.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Visibility(
                                                visible:
                                                    _listPembayaran.length > 0,
                                                child: Container(
                                                  child: Dash(
                                                      direction: Axis.vertical,
                                                      length: ScreenUtil()
                                                          .setHeight(68),
                                                      dashLength: 5,
                                                      dashColor:
                                                          Color(0xFF8E8E93)),
                                                ),
                                              ),
                                              Container(
                                                  child: Image.asset(
                                                'assets/icons/ic_wave_yellow.png',
                                                width:
                                                    ScreenUtil().setWidth(20),
                                              )),
                                            ],
                                          );
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Visibility(
                                visible: _listPembayaran.length > 0,
                                child: Flexible(
                                  fit: FlexFit.loose,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      primary: false,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: _listPembayaran.length,
                                      itemBuilder: (context, index) {
                                        return CardTimelineInvoice(
                                            context: context,
                                            withBack: true,
                                            withDelete: true,
                                            isTotal: false,
                                            amount:
                                                _listPembayaran[index].amount,
                                            pembayaranNo:
                                                (index + 1).toString(),
                                            percentage:
                                                '${_listPembayaran[index].percentage} %',
                                            deleteItem: deletePaymentStages,
                                            index: index);
                                      }),
                                ),
                              ),
                              CardTimelineInvoice(
                                  context: context,
                                  withBack: false,
                                  withDelete: false,
                                  isTotal: true,
                                  amount: _sisaPembayaran)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(30),
                horizontal: ScreenUtil().setWidth(15)),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    height: 56,
                    child: FlatButton(
                        onPressed: _judulPenawaran.text == '' &&
                                _sendInvTo == '' &&
                                selectedDateInvoice == '' &&
                                selectedTimeInvoice == '' &&
                                selectedDateJatuhTempo == '' &&
                                selectedTimeJatuhTempo == '' &&
                                _listOrderanDetail.length == 0
                            ? null
                            : () {
                                ShowConfirmNew(
                                    context: context,
                                    title: 'Oke, Invoice Segera Dibuat.',
                                    subtitle:
                                        'Pastikan informasi sudah benar, klik tombol dibawah ini jika sudah yakin.',
                                    labelPrimary: 'BUAT INVOICE SEKARANG',
                                    labelGhost: 'EH GAK JADI',
                                    onPrimary: createUser,
                                    onGhost: ghosting,
                                    bloc: invoiceBloc);
                              },
                        color: Colors.black,
                        disabledColor: Color(0xFFF0F0F0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'KIRIM INVOICE',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 17),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
