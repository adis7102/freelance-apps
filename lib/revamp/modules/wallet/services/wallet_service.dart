import 'dart:async';

import 'package:flutter/material.dart';
import 'package:soedja_freelance/revamp/assets/urls.dart';
import 'package:soedja_freelance/revamp/helpers/http_helper.dart';
import 'package:soedja_freelance/revamp/modules/wallet/models/bank_model.dart';
import 'package:soedja_freelance/revamp/modules/wallet/models/wallet_model.dart';
import 'package:soedja_freelance/revamp/modules/wallet/models/withdraw_model.dart';

abstract class WalletAPI {
  Future<GetWalletResponse> getWallet(BuildContext context);

  Future<CreateWithdrawResponse> postCreateWithdraw(BuildContext context, WithdrawPayload payload);
  Future<WalletHistoryResponse> getWalletHistory(
      BuildContext context, int page, int limit);

  Future<WithdrawHistoryResponse> getWithdrawHistory(
      BuildContext context, int page, int limit);

  Future<BankListResponse> getBankList(BuildContext context);
  Future<BankHistoryResponse> getBankHistory(BuildContext context);
}

class WalletServices extends WalletAPI {
  @override
  Future<GetWalletResponse> getWallet(BuildContext context) async {
    String url = Urls.wallet;

    try {
      var response =
          await HttpRequest.get(context: context, url: url, useAuth: true);

      if (response['code'] == "success") {
        return GetWalletResponse.fromJson(response);
      } else {
        return GetWalletResponse(code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return GetWalletResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<CreateWithdrawResponse> postCreateWithdraw(BuildContext context, WithdrawPayload payload) async {
    String url = Urls.withdraw;

    try {
      var response =
          await HttpRequest.post(context: context, url: url, useAuth: true, bodyJson: payload.toJson());

      if (response['code'] == "success") {
        return CreateWithdrawResponse.fromJson(response);
      } else {
        return CreateWithdrawResponse(code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return CreateWithdrawResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<WalletHistoryResponse> getWalletHistory(
      BuildContext context, int page, int limit) async {
    String url = Urls.walletHistory + "?page=$page&limit=$limit";

    try {
      var response =
          await HttpRequest.get(context: context, url: url, useAuth: true);

      if (response['code'] == "success") {
        return WalletHistoryResponse.fromJson(response);
      } else {
        return WalletHistoryResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return WalletHistoryResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<BankListResponse> getBankList(BuildContext context) async {
    String url = Urls.bank;

    try {
      var response =
          await HttpRequest.get(context: context, url: url, useAuth: true);

      if (response['code'] == "success") {
        return BankListResponse.fromJson(response);
      } else {
        return BankListResponse(code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return BankListResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<WithdrawHistoryResponse> getWithdrawHistory(BuildContext context, int page, int limit) async {
    String url = Urls.withdrawHistory + "?page=$page&limit=$limit";

    try {
      var response =
      await HttpRequest.get(context: context, url: url, useAuth: true);

      if (response['code'] == "success") {
        return WithdrawHistoryResponse.fromJson(response);
      } else {
        return WithdrawHistoryResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return WithdrawHistoryResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<BankHistoryResponse> getBankHistory(BuildContext context) async {
    String url = Urls.bankHistory;

    try {
      var response =
      await HttpRequest.get(context: context, url: url, useAuth: true);

      if (response['code'] == "success") {
        return BankHistoryResponse.fromJson(response);
      } else {
        return BankHistoryResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return BankHistoryResponse(code: "failed", message: e.toString());
    }
  }
}
