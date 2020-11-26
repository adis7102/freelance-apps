import 'package:flutter/material.dart';
import 'package:soedja_freelance/revamp/modules/invoice/models/invoice_model.dart';

import '../../../assets/urls.dart';
import '../../../helpers/http_helper.dart';

abstract class InvoiceAPI {
  Future<SlotResponse> getTotalSlot(BuildContext context);

  Future<SlotPriceList> getPriceList(BuildContext context);

  Future<SlotPayment> postPaymentSlot(
      BuildContext context, SlotPaymentPayload payload);

  Future<HistorySlotResponse> getHistorySlot(BuildContext context);

  Future<CreateInvoiceResponse> createInvoice(
      BuildContext context, CreateInvoicePayload payload);

  Future<GetAllInvoiceResponse> getAllInvoice(BuildContext context);
  Future<GetStatisticResponse> getStatistic(BuildContext context);
}

class InvoiceServices extends InvoiceAPI {
  @override
  Future<SlotResponse> getTotalSlot(BuildContext context) async {
    String url = Urls.slotInvoice;

    try {
      var response =
          await HttpRequest.get(context: context, useAuth: true, url: url);
      if (response['code'] == "success") {
        return SlotResponse.fromJson(response);
      } else {
        return SlotResponse(code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return SlotResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<SlotPriceList> getPriceList(BuildContext context) async {
    String url = Urls.priceListInvoice;

    try {
      var response =
          await HttpRequest.get(context: context, useAuth: true, url: url);
      if (response['code'] == "success") {
        return SlotPriceList.fromJson(response);
      } else {
        return SlotPriceList(code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return SlotPriceList(code: "failed", message: e.toString());
    }
  }

  @override
  Future<SlotPayment> postPaymentSlot(
      BuildContext context, SlotPaymentPayload payload) async {
    String url = Urls.slotPayment;
    try {
      var response = await HttpRequest.post(
          context: context,
          url: url,
          useAuth: true,
          bodyJson: payload.toJson());
      print('${response.toString()} INIIIII');
      if (response['code'] == "success") {
        return SlotPayment.fromJson(response);
      } else {
        SlotPayment(code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return SlotPayment(code: "failed", message: e.toString());
    }
  }

  @override
  Future<HistorySlotResponse> getHistorySlot(BuildContext context) async {
    String url = Urls.historyPaymentSlot;

    try {
      var response =
          await HttpRequest.get(context: context, useAuth: true, url: url);
      if (response['code'] == "success") {
        return HistorySlotResponse.fromJson(response);
      } else {
        return HistorySlotResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return HistorySlotResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<CreateInvoiceResponse> createInvoice(BuildContext context, CreateInvoicePayload payload) async {
    String url = Urls.createInvoice;

    try {
      var response = await HttpRequest.post(
          context: context, useAuth: true, url: url, bodyJson: payload.toJson());
      if (response['code'] == "success") {
        return CreateInvoiceResponse.fromJson(response);
      } else {
        return CreateInvoiceResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return CreateInvoiceResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<GetAllInvoiceResponse> getAllInvoice(BuildContext context) async {
    String url = Urls.getAllInvoice;

    try {
      var response =
          await HttpRequest.get(context: context, useAuth: true, url: url);
      if (response['code'] == "success") {
        return GetAllInvoiceResponse.fromJson(response);
      } else {
        return GetAllInvoiceResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return GetAllInvoiceResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<GetStatisticResponse> getStatistic(BuildContext context) async {
    String url = Urls.getStatistic;

    try {
      var response =
          await HttpRequest.get(context: context, useAuth: true, url: url);
      if (response['code'] == "success") {
        return GetStatisticResponse.fromJson(response);
      } else {
        return GetStatisticResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return GetStatisticResponse(code: "failed", message: e.toString());
    }
  }

}
