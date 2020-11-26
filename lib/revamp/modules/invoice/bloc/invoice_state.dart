
import 'package:soedja_freelance/revamp/modules/invoice/models/invoice_model.dart';

class GetSlotState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  SlotResponse data;

  GetSlotState(
      {this.data,
        this.hasError,
        this.isSuccess,
        this.message,
        this.standby,
        this.isInit,
        this.isLoading});

  factory GetSlotState.onSuccess(SlotResponse data) {
    return GetSlotState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory GetSlotState.onError(String message) {
    return GetSlotState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory GetSlotState.unStanby() {
    return GetSlotState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory GetSlotState.onLoading(String message) {
    return GetSlotState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory GetSlotState.setInit() {
    return GetSlotState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}

class GetPriceListSlotState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  SlotPriceList data;

  GetPriceListSlotState(
      {this.data,
        this.hasError,
        this.isSuccess,
        this.message,
        this.standby,
        this.isInit,
        this.isLoading});

  factory GetPriceListSlotState.onSuccess(SlotPriceList data) {
    return GetPriceListSlotState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory GetPriceListSlotState.onError(String message) {
    return GetPriceListSlotState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory GetPriceListSlotState.unStanby() {
    return GetPriceListSlotState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory GetPriceListSlotState.onLoading(String message) {
    return GetPriceListSlotState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory GetPriceListSlotState.setInit() {
    return GetPriceListSlotState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}


class SlotPaymentState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  SlotPayment data;

  SlotPaymentState(
      {this.data,
        this.hasError,
        this.isSuccess,
        this.message,
        this.standby,
        this.isInit,
        this.isLoading});

  factory SlotPaymentState.onSuccess(SlotPayment data) {
    return SlotPaymentState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory SlotPaymentState.onError(String message) {
    return SlotPaymentState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory SlotPaymentState.unStanby() {
    return SlotPaymentState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory SlotPaymentState.onLoading(String message) {
    return SlotPaymentState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory SlotPaymentState.setInit() {
    return SlotPaymentState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}

class HistoryPaymentSlotState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  HistorySlotResponse data;

  HistoryPaymentSlotState(
      {this.data,
        this.hasError,
        this.isSuccess,
        this.message,
        this.standby,
        this.isInit,
        this.isLoading});

  factory HistoryPaymentSlotState.onSuccess(HistorySlotResponse data) {
    return HistoryPaymentSlotState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory HistoryPaymentSlotState.onError(String message) {
    return HistoryPaymentSlotState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory HistoryPaymentSlotState.unStanby() {
    return HistoryPaymentSlotState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory HistoryPaymentSlotState.onLoading(String message) {
    return HistoryPaymentSlotState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory HistoryPaymentSlotState.setInit() {
    return HistoryPaymentSlotState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}


class CreateInvoiceState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  CreateInvoiceResponse data;

  CreateInvoiceState(
      {this.data,
        this.hasError,
        this.isSuccess,
        this.message,
        this.standby,
        this.isInit,
        this.isLoading});

  factory CreateInvoiceState.onSuccess(CreateInvoiceResponse data) {
    return CreateInvoiceState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory CreateInvoiceState.onError(String message) {
    return CreateInvoiceState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory CreateInvoiceState.unStanby() {
    return CreateInvoiceState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory CreateInvoiceState.onLoading(String message) {
    return CreateInvoiceState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory CreateInvoiceState.setInit() {
    return CreateInvoiceState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}


class GetAllInvoiceState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  GetAllInvoiceResponse data;

  GetAllInvoiceState(
      {this.data,
        this.hasError,
        this.isSuccess,
        this.message,
        this.standby,
        this.isInit,
        this.isLoading});

  factory GetAllInvoiceState.onSuccess(GetAllInvoiceResponse data) {
    return GetAllInvoiceState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory GetAllInvoiceState.onError(String message) {
    return GetAllInvoiceState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory GetAllInvoiceState.unStanby() {
    return GetAllInvoiceState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory GetAllInvoiceState.onLoading(String message) {
    return GetAllInvoiceState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory GetAllInvoiceState.setInit() {
    return GetAllInvoiceState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}


class GetStatisticState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  GetStatisticResponse data;

  GetStatisticState(
      {this.data,
        this.hasError,
        this.isSuccess,
        this.message,
        this.standby,
        this.isInit,
        this.isLoading});

  factory GetStatisticState.onSuccess(GetStatisticResponse data) {
    return GetStatisticState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory GetStatisticState.onError(String message) {
    return GetStatisticState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory GetStatisticState.unStanby() {
    return GetStatisticState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory GetStatisticState.onLoading(String message) {
    return GetStatisticState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory GetStatisticState.setInit() {
    return GetStatisticState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}