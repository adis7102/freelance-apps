import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:soedja_freelance/revamp/modules/auth/models/auth_models.dart';
import 'package:soedja_freelance/revamp/modules/payment/bloc/payment_state.dart';
import 'package:soedja_freelance/revamp/modules/payment/models/payment_models.dart';
import 'package:soedja_freelance/revamp/modules/payment/services/payment_service.dart';

import '../models/payment_models.dart';
import 'payment_state.dart';

class PaymentBloc {
  BehaviorSubject<PaymentState> _subjectPayment =
      BehaviorSubject<PaymentState>();
  BehaviorSubject<PaymentStateXendit> _subjectPaymentXendit =
      BehaviorSubject<PaymentStateXendit>();

  Stream<PaymentState> get getPaymentStatus => _subjectPayment.stream;

  Stream<PaymentStateXendit> get getPaymentXendit => _subjectPaymentXendit.stream;

  BehaviorSubject<bool> _stanby = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get getStanby => _stanby.stream;

  requestGiveSupport(
      BuildContext context, String id, int amount, String comment,) {
    GiveSupportPayload payload =
        GiveSupportPayload(parentId: id, comment: comment, amount: amount);
    try {
      _subjectPayment.sink.add(PaymentState.onLoading("Loading Payment ..."));
      PaymentService().giveSupport(context, payload).then((response) {
        if (response.code == "success") {
          _subjectPayment.sink.add(PaymentState.onSuccess(response));
        } else {
          _subjectPayment.sink.add(PaymentState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectPayment.sink.add(PaymentState.onError(e.toString()));
    }
  }

  requestPaymentXendit(
      BuildContext context, String id, String paymentMethod) {
    PaymentXenditPayload payload =
        PaymentXenditPayload(paymentId: id, paymentMethod: paymentMethod.toUpperCase());
    print(payload.toString());
    try {
      _subjectPaymentXendit.sink.add(PaymentStateXendit.onLoading("Loading Payment ..."));
      PaymentService().paymentXendit(context, payload).then((response) {
        if (response.code == "success") {
          _subjectPaymentXendit.sink.add(PaymentStateXendit.onSuccess(response));
        } else {
          _subjectPaymentXendit.sink.add(PaymentStateXendit.onError(response.message));
        }
      });
    } catch (e) {
      _subjectPaymentXendit.sink.add(PaymentStateXendit.onError(e.toString()));
    }
  }

  unStandBy() async {
    _stanby.sink.add(false);
    _subjectPayment.sink.add(PaymentState.unStanby());
    _subjectPaymentXendit.sink.add(PaymentStateXendit.unStanby());
  }

  void dispose() {
    _subjectPayment?.close();
    _subjectPaymentXendit?.close();
    _stanby?.drain(false);
  }
}
