
import 'package:soedja_freelance/revamp/modules/wallet/models/bank_model.dart';
import 'package:soedja_freelance/revamp/modules/wallet/models/wallet_model.dart';
import 'package:soedja_freelance/revamp/modules/wallet/models/withdraw_model.dart';

class GetWalletState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  GetWalletResponse data;

  GetWalletState(
      {this.data,
        this.hasError,
        this.isSuccess,
        this.message,
        this.standby,
        this.isInit,
        this.isLoading});

  factory GetWalletState.onSuccess(GetWalletResponse data) {
    return GetWalletState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory GetWalletState.onError(String message) {
    return GetWalletState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory GetWalletState.unStanby() {
    return GetWalletState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory GetWalletState.onLoading(String message) {
    return GetWalletState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory GetWalletState.setInit() {
    return GetWalletState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}

class CreateWithdrawState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  CreateWithdrawResponse data;

  CreateWithdrawState(
      {this.data,
        this.hasError,
        this.isSuccess,
        this.message,
        this.standby,
        this.isInit,
        this.isLoading});

  factory CreateWithdrawState.onSuccess(CreateWithdrawResponse data) {
    return CreateWithdrawState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory CreateWithdrawState.onError(String message) {
    return CreateWithdrawState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory CreateWithdrawState.unStanby() {
    return CreateWithdrawState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory CreateWithdrawState.onLoading(String message) {
    return CreateWithdrawState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory CreateWithdrawState.setInit() {
    return CreateWithdrawState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}

class HistoryWalletState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  WalletHistoryResponse data;

  HistoryWalletState(
      {this.data,
        this.hasError,
        this.isSuccess,
        this.message,
        this.standby,
        this.isInit,
        this.isLoading});

  factory HistoryWalletState.onSuccess(WalletHistoryResponse data) {
    return HistoryWalletState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory HistoryWalletState.onError(String message) {
    return HistoryWalletState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory HistoryWalletState.unStanby() {
    return HistoryWalletState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory HistoryWalletState.onLoading(String message) {
    return HistoryWalletState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory HistoryWalletState.setInit() {
    return HistoryWalletState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}


class WithdrawHistoryState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  WithdrawHistoryResponse data;

  WithdrawHistoryState(
      {this.data,
        this.hasError,
        this.isSuccess,
        this.message,
        this.standby,
        this.isInit,
        this.isLoading});

  factory WithdrawHistoryState.onSuccess(WithdrawHistoryResponse data) {
    return WithdrawHistoryState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory WithdrawHistoryState.onError(String message) {
    return WithdrawHistoryState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory WithdrawHistoryState.unStanby() {
    return WithdrawHistoryState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory WithdrawHistoryState.onLoading(String message) {
    return WithdrawHistoryState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory WithdrawHistoryState.setInit() {
    return WithdrawHistoryState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}


class BankListState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  BankListResponse data;

  BankListState(
      {this.data,
        this.hasError,
        this.isSuccess,
        this.message,
        this.standby,
        this.isInit,
        this.isLoading});

  factory BankListState.onSuccess(BankListResponse data) {
    return BankListState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory BankListState.onError(String message) {
    return BankListState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory BankListState.unStanby() {
    return BankListState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory BankListState.onLoading(String message) {
    return BankListState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory BankListState.setInit() {
    return BankListState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}


class BankHistoryState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  BankHistoryResponse data;

  BankHistoryState(
      {this.data,
        this.hasError,
        this.isSuccess,
        this.message,
        this.standby,
        this.isInit,
        this.isLoading});

  factory BankHistoryState.onSuccess(BankHistoryResponse data) {
    return BankHistoryState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory BankHistoryState.onError(String message) {
    return BankHistoryState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory BankHistoryState.unStanby() {
    return BankHistoryState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory BankHistoryState.onLoading(String message) {
    return BankHistoryState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory BankHistoryState.setInit() {
    return BankHistoryState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}