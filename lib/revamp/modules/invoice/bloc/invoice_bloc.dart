import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:soedja_freelance/revamp/modules/invoice/bloc/invoice_state.dart';
import 'package:soedja_freelance/revamp/modules/invoice/models/invoice_model.dart';
import 'package:soedja_freelance/revamp/modules/invoice/services/invoice_services.dart';

class InvoiceBloc extends InvoiceServices {
  InvoiceServices invoiceServices = new InvoiceServices();

  BehaviorSubject<GetSlotState> _subjectGetSlot =
      BehaviorSubject<GetSlotState>();

  BehaviorSubject<GetPriceListSlotState> _subjectGetPriceListSlot =
      BehaviorSubject<GetPriceListSlotState>();
  
  BehaviorSubject<HistoryPaymentSlotState> _subjectGetHistoryPaymentSlot =
      BehaviorSubject<HistoryPaymentSlotState>();

  BehaviorSubject<SlotPaymentState> _subjectPostSlotPayment =
      BehaviorSubject<SlotPaymentState>();
  
  BehaviorSubject<CreateInvoiceState> _subjectPostCreateInvoice =
      BehaviorSubject<CreateInvoiceState>();
  
  BehaviorSubject<GetAllInvoiceState> _subjectGetAllInvoice =
      BehaviorSubject<GetAllInvoiceState>();

  BehaviorSubject<GetStatisticState> _subjectGetStatistic =
      BehaviorSubject<GetStatisticState>();

  Stream<GetSlotState> get getSlot => _subjectGetSlot.stream;
  Stream<GetPriceListSlotState> get getPriceListSlot => _subjectGetPriceListSlot.stream;
  Stream<HistoryPaymentSlotState> get getHistoryPaymentSlot => _subjectGetHistoryPaymentSlot.stream;
  Stream<SlotPaymentState> get postSlotPayment => _subjectPostSlotPayment.stream;
  Stream<CreateInvoiceState> get postCreateInvoice => _subjectPostCreateInvoice.stream;
  Stream<GetAllInvoiceState> get getInvoiceAll => _subjectGetAllInvoice.stream;
  Stream<GetStatisticState> get getStatisticStream => _subjectGetStatistic.stream;

  BehaviorSubject<bool> _stanby = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get getStanby => _stanby.stream;

  requestGetTotalSlot(BuildContext context) {
    
    try {
      _subjectGetSlot.sink
          .add(GetSlotState.onLoading("Loading get total Slot ..."));

      InvoiceServices().getTotalSlot(context).then((response) {
        if (response.code == "success") {
          _subjectGetSlot.sink.add(GetSlotState.onSuccess(response));
        } else {
          _subjectGetSlot.sink.add(GetSlotState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectGetSlot.sink.add(GetSlotState.onError(e.toString()));
    }
  }

  requestGetPriceListSlot(BuildContext context) {
    
    try {
      _subjectGetPriceListSlot.sink
          .add(GetPriceListSlotState.onLoading("Loading get total Slot ..."));

      InvoiceServices().getPriceList(context).then((response) {
        if (response.code == "success") {
          _subjectGetPriceListSlot.sink.add(GetPriceListSlotState.onSuccess(response));
        } else {
          _subjectGetPriceListSlot.sink.add(GetPriceListSlotState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectGetPriceListSlot.sink.add(GetPriceListSlotState.onError(e.toString()));
    }
  }

  requestPostSlotPayment( BuildContext context, String parentId) {
    SlotPaymentPayload payload =
        SlotPaymentPayload(slotId: parentId);
    try {
      _subjectPostSlotPayment.sink
          .add(SlotPaymentState.onLoading("Loading get total Slot ..."));

      InvoiceServices().postPaymentSlot(context, payload).then((response) {
        if (response.code == "success") {
          _subjectPostSlotPayment.sink.add(SlotPaymentState.onSuccess(response));
        } else {
          _subjectPostSlotPayment.sink.add(SlotPaymentState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectPostSlotPayment.sink.add(SlotPaymentState.onError(e.toString()));
    }
  }

  requestGetHistoryPaymentSlot(BuildContext context) {
    
    try {
      _subjectGetHistoryPaymentSlot.sink
          .add(HistoryPaymentSlotState.onLoading("Loading get total Slot ..."));

      InvoiceServices().getHistorySlot(context).then((response) {
        if (response.code == "success") {
          _subjectGetHistoryPaymentSlot.sink.add(HistoryPaymentSlotState.onSuccess(response));
        } else {
          _subjectGetHistoryPaymentSlot.sink.add(HistoryPaymentSlotState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectGetHistoryPaymentSlot.sink.add(HistoryPaymentSlotState.onError(e.toString()));
    }
  }

  requestPostCreateInvoice(BuildContext context, CreateInvoicePayload payload) {
    print(payload.toJson().toString());
    try {
      _subjectPostCreateInvoice.sink
          .add(CreateInvoiceState.onLoading("Loading get total Slot ..."));

      InvoiceServices().createInvoice(context, payload).then((response) {
        if (response.code == "success") {
          _subjectPostCreateInvoice.sink.add(CreateInvoiceState.onSuccess(response));
        } else {
          _subjectPostCreateInvoice.sink.add(CreateInvoiceState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectPostCreateInvoice.sink.add(CreateInvoiceState.onError(e.toString()));
    }
  }

  requestGetAllInvoice(BuildContext context) {
    
    try {
      _subjectGetAllInvoice.sink
          .add(GetAllInvoiceState.onLoading("Loading get total Slot ..."));

      InvoiceServices().getAllInvoice(context).then((response) {
        if (response.code == "success") {
          _subjectGetAllInvoice.sink.add(GetAllInvoiceState.onSuccess(response));
        } else {
          _subjectGetAllInvoice.sink.add(GetAllInvoiceState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectGetAllInvoice.sink.add(GetAllInvoiceState.onError(e.toString()));
    }
  }

  requestGetStatistic(BuildContext context) {
    
    try {
      _subjectGetStatistic.sink
          .add(GetStatisticState.onLoading("Loading get total Slot ..."));

      InvoiceServices().getStatistic(context).then((response) {
        if (response.code == "success") {
          _subjectGetStatistic.sink.add(GetStatisticState.onSuccess(response));
        } else {
          _subjectGetStatistic.sink.add(GetStatisticState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectGetStatistic.sink.add(GetStatisticState.onError(e.toString()));
    }
  }

  

  unStandBy() async {
    _stanby.sink.add(false);
    _subjectGetSlot.sink.add(GetSlotState.unStanby());
    _subjectGetPriceListSlot.sink.add(GetPriceListSlotState.unStanby());
    _subjectGetHistoryPaymentSlot.sink.add(HistoryPaymentSlotState.unStanby());
    _subjectPostSlotPayment.sink.add(SlotPaymentState.unStanby());
    _subjectPostCreateInvoice.sink.add(CreateInvoiceState.unStanby());
    _subjectGetAllInvoice.sink.add(GetAllInvoiceState.unStanby());
    _subjectGetStatistic.sink.add(GetStatisticState.unStanby());
  }

  void dispose() {
    _subjectGetSlot?.close();
    _subjectGetPriceListSlot?.close();
    _subjectPostSlotPayment?.close();
    _subjectGetHistoryPaymentSlot?.close();
    _subjectPostCreateInvoice?.close();
    _subjectGetAllInvoice?.close();
    _subjectGetStatistic?.close();
    _stanby?.drain(false);
  }
}
