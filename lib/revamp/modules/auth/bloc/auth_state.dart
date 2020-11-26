import 'package:soedja_freelance/revamp/modules/auth/models/auth_models.dart';
import 'package:soedja_freelance/revamp/modules/auth/models/register_models.dart';

class GetProfileState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  GetProfileResponse data;

  GetProfileState(
      {this.data,
      this.hasError,
      this.isSuccess,
      this.message,
      this.standby,
      this.isInit,
      this.isLoading});

  factory GetProfileState.onSuccess(GetProfileResponse data) {
    return GetProfileState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory GetProfileState.onError(String message) {
    return GetProfileState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory GetProfileState.unStanby() {
    return GetProfileState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory GetProfileState.onLoading(String message) {
    return GetProfileState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory GetProfileState.setInit() {
    return GetProfileState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}

class RegisterStatusState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  DefaultResponse data;

  RegisterStatusState(
      {this.data,
      this.hasError,
      this.isSuccess,
      this.message,
      this.standby,
      this.isInit,
      this.isLoading});

  factory RegisterStatusState.onSuccess(DefaultResponse data) {
    return RegisterStatusState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory RegisterStatusState.onError(String message) {
    return RegisterStatusState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory RegisterStatusState.unStanby() {
    return RegisterStatusState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory RegisterStatusState.onLoading(String message) {
    return RegisterStatusState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory RegisterStatusState.setInit() {
    return RegisterStatusState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}

class ValidateOtpState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  DefaultJwtResponse data;

  ValidateOtpState(
      {this.data,
      this.hasError,
      this.isSuccess,
      this.message,
      this.standby,
      this.isInit,
      this.isLoading});

  factory ValidateOtpState.onSuccess(DefaultJwtResponse data) {
    return ValidateOtpState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory ValidateOtpState.onError(String message) {
    return ValidateOtpState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory ValidateOtpState.unStanby() {
    return ValidateOtpState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory ValidateOtpState.onLoading(String message) {
    return ValidateOtpState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory ValidateOtpState.setInit() {
    return ValidateOtpState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}

class ResendOtpState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  DefaultResponse data;

  ResendOtpState(
      {this.data,
      this.hasError,
      this.isSuccess,
      this.message,
      this.standby,
      this.isInit,
      this.isLoading});

  factory ResendOtpState.onSuccess(DefaultResponse data) {
    return ResendOtpState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory ResendOtpState.onError(String message) {
    return ResendOtpState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory ResendOtpState.unStanby() {
    return ResendOtpState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory ResendOtpState.onLoading(String message) {
    return ResendOtpState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory ResendOtpState.setInit() {
    return ResendOtpState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}

class ResetPinState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  DefaultResponse data;

  ResetPinState(
      {this.data,
      this.hasError,
      this.isSuccess,
      this.message,
      this.standby,
      this.isInit,
      this.isLoading});

  factory ResetPinState.onSuccess(DefaultResponse data) {
    return ResetPinState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory ResetPinState.onError(String message) {
    return ResetPinState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory ResetPinState.unStanby() {
    return ResetPinState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory ResetPinState.onLoading(String message) {
    return ResetPinState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory ResetPinState.setInit() {
    return ResetPinState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}
