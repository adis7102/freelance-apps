
import 'package:flutter/material.dart';
import 'package:soedja_freelance/revamp/assets/urls.dart';
import 'package:soedja_freelance/revamp/helpers/http_helper.dart';
import 'package:soedja_freelance/revamp/modules/payment/models/payment_models.dart';

abstract class PaymentAPI{
  Future<PaymentResponse> giveSupport(BuildContext context, GiveSupportPayload payload);
  Future<PaymentXenditResponse> paymentXendit(BuildContext context, PaymentXenditPayload payload);
}

class PaymentService extends PaymentAPI{
  @override
  Future<PaymentResponse> giveSupport(BuildContext context, GiveSupportPayload payload) async {
    String url = Urls.giveSupport;
    try {
      var response  = await HttpRequest.post(context: context, url: url, useAuth: true, bodyJson: payload.toJson());

      if(response['code'] == "success"){
        return PaymentResponse.fromJson(response);
      } else {
        PaymentResponse(code: "failed", message: response['message']);
      }
    } catch (e){
      print(e.toString());
      return PaymentResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<PaymentXenditResponse> paymentXendit(BuildContext context, PaymentXenditPayload payload) async {
    String url = Urls.paymentXendit;
    try {
      var response  = await HttpRequest.post(context: context, url: url, useAuth: true, bodyJson: payload.toJson());
      print('${response.toString()} INIIIII');
      if(response['code'] == "success"){
        return PaymentXenditResponse.fromJson(response);
      } else {
        PaymentXenditResponse(code: "failed", message: response['message']);
      }
    } catch (e){
      print(e.toString());
      return PaymentXenditResponse(code: "failed", message: e.toString());
    }
  }

}