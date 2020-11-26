import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:soedja_freelance/revamp/modules/wallet/bloc/wallet_state.dart';
import 'package:soedja_freelance/revamp/modules/wallet/models/withdraw_model.dart';
import 'package:soedja_freelance/revamp/modules/wallet/services/wallet_service.dart';

class WalletBloc {
  BehaviorSubject<GetWalletState> _subjectGetWallet =
      BehaviorSubject<GetWalletState>();
  BehaviorSubject<CreateWithdrawState> _subjectCreateWithdraw =
      BehaviorSubject<CreateWithdrawState>();
  BehaviorSubject<HistoryWalletState> _subjectWalletHistory =
      BehaviorSubject<HistoryWalletState>();
  BehaviorSubject<BankListState> _subjectBankList =
      BehaviorSubject<BankListState>();
  BehaviorSubject<BankHistoryState> _subjectBankHistory =
      BehaviorSubject<BankHistoryState>();
  BehaviorSubject<WithdrawHistoryState> _subjectWithdrawHistory =
      BehaviorSubject<WithdrawHistoryState>();

  Stream<GetWalletState> get getWalletStatus => _subjectGetWallet.stream;

  Stream<CreateWithdrawState> get getWithdrawStatus =>
      _subjectCreateWithdraw.stream;

  Stream<HistoryWalletState> get getWalletHistory =>
      _subjectWalletHistory.stream;

  Stream<BankListState> get getBankList => _subjectBankList.stream;

  Stream<BankHistoryState> get getBankHistory => _subjectBankHistory.stream;

  Stream<WithdrawHistoryState> get getWithdrawHistory =>
      _subjectWithdrawHistory.stream;

  BehaviorSubject<bool> _stanby = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get getStanby => _stanby.stream;

  requestGetWallet(BuildContext context) {
    try {
      _subjectGetWallet.sink
          .add(GetWalletState.onLoading("Loading get Wallet ..."));
      WalletServices().getWallet(context).then((response) {
        if (response.code == "success") {
          _subjectGetWallet.sink.add(GetWalletState.onSuccess(response));
        } else {
          _subjectGetWallet.sink.add(GetWalletState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectGetWallet.sink.add(GetWalletState.onError(e.toString()));
    }
  }

  requestCreateWithdraw(
    BuildContext context,
    String bank,
    String accountNumber,
    String accountName,
    int amount,
    String pin,
  ) {
    WithdrawPayload payload = new WithdrawPayload(
      bank: bank,
      accountNumber: accountNumber,
      accountName: accountName,
      amount: amount,
      pin: pin,
    );

    try {
      _subjectCreateWithdraw.sink
          .add(CreateWithdrawState.onLoading("Loading get Wallet ..."));
      WalletServices().postCreateWithdraw(context, payload).then((response) {
        if (response.code == "success") {
          _subjectCreateWithdraw.sink
              .add(CreateWithdrawState.onSuccess(response));
        } else {
          _subjectCreateWithdraw.sink
              .add(CreateWithdrawState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectCreateWithdraw.sink
          .add(CreateWithdrawState.onError(e.toString()));
    }
  }

  requestWalletHistory(BuildContext context, int page, int limit) {
    try {
      _subjectWalletHistory.sink
          .add(HistoryWalletState.onLoading("Loading get Wallet ..."));
      WalletServices().getWalletHistory(context, page, limit).then((response) {
        if (response.code == "success") {
          _subjectWalletHistory.sink
              .add(HistoryWalletState.onSuccess(response));
        } else {
          _subjectWalletHistory.sink
              .add(HistoryWalletState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectWalletHistory.sink.add(HistoryWalletState.onError(e.toString()));
    }
  }

  requestBankList(BuildContext context) {
    try {
      _subjectBankList.sink
          .add(BankListState.onLoading("Loading get Wallet ..."));
      WalletServices().getBankList(context).then((response) {
        if (response.code == "success") {
          _subjectBankList.sink.add(BankListState.onSuccess(response));
        } else {
          _subjectBankList.sink.add(BankListState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectBankList.sink.add(BankListState.onError(e.toString()));
    }
  }

  requestBankHistory(BuildContext context) {
    try {
      _subjectBankHistory.sink
          .add(BankHistoryState.onLoading("Loading get Wallet ..."));
      WalletServices().getBankHistory(context).then((response) {
        if (response.code == "success") {
          _subjectBankHistory.sink.add(BankHistoryState.onSuccess(response));
        } else {
          _subjectBankHistory.sink
              .add(BankHistoryState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectBankHistory.sink.add(BankHistoryState.onError(e.toString()));
    }
  }

  requestWithdrawHistory(BuildContext context, int page, int limit) {
    try {
      _subjectWithdrawHistory.sink
          .add(WithdrawHistoryState.onLoading("Loading get Wallet ..."));
      WalletServices()
          .getWithdrawHistory(context, page, limit)
          .then((response) {
        if (response.code == "success") {
          _subjectWithdrawHistory.sink
              .add(WithdrawHistoryState.onSuccess(response));
        } else {
          _subjectWithdrawHistory.sink
              .add(WithdrawHistoryState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectWithdrawHistory.sink
          .add(WithdrawHistoryState.onError(e.toString()));
    }
  }

  unStandBy() async {
    _stanby.sink.add(false);
    _subjectGetWallet.sink.add(GetWalletState.unStanby());
    _subjectCreateWithdraw.sink.add(CreateWithdrawState.unStanby());
    _subjectBankList.sink.add(BankListState.unStanby());
    _subjectWalletHistory.sink.add(HistoryWalletState.unStanby());
    _subjectWithdrawHistory.sink.add(WithdrawHistoryState.unStanby());
    _subjectBankHistory.sink.add(BankHistoryState.unStanby());
  }

  void dispose() {
    _subjectGetWallet?.close();
    _subjectCreateWithdraw?.close();
    _subjectBankList?.close();
    _subjectWalletHistory?.close();
    _subjectWithdrawHistory?.close();
    _subjectBankHistory?.close();
    _stanby?.drain(false);
  }
}
