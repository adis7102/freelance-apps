
import 'package:soedja_freelance/revamp/modules/payment/models/payment_models.dart';

class PaymentState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  PaymentResponse data;

  PaymentState(
      {this.data,
        this.hasError,
        this.isSuccess,
        this.message,
        this.standby,
        this.isInit,
        this.isLoading});

  factory PaymentState.onSuccess(PaymentResponse data) {
    return PaymentState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory PaymentState.onError(String message) {
    return PaymentState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory PaymentState.unStanby() {
    return PaymentState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory PaymentState.onLoading(String message) {
    return PaymentState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory PaymentState.setInit() {
    return PaymentState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}


class PaymentStateXendit<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  PaymentXenditResponse data;

  PaymentStateXendit(
      {this.data,
        this.hasError,
        this.isSuccess,
        this.message,
        this.standby,
        this.isInit,
        this.isLoading});

  factory PaymentStateXendit.onSuccess(PaymentXenditResponse data) {
    return PaymentStateXendit(
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory PaymentStateXendit.onError(String message) {
    return PaymentStateXendit(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory PaymentStateXendit.unStanby() {
    return PaymentStateXendit(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory PaymentStateXendit.onLoading(String message) {
    return PaymentStateXendit(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory PaymentStateXendit.setInit() {
    return PaymentStateXendit(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}

