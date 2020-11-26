import 'package:soedja_freelance/revamp/modules/contact/models/contact_models.dart';

class ListKontakState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  ListKontakResponse data;

  ListKontakState(
      {this.data,
      this.hasError,
      this.isSuccess,
      this.message,
      this.standby,
      this.isInit,
      this.isLoading});

  factory ListKontakState.onSuccess(ListKontakResponse data) {
    return ListKontakState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory ListKontakState.onError(String message) {
    return ListKontakState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory ListKontakState.unStanby() {
    return ListKontakState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory ListKontakState.onLoading(String message) {
    return ListKontakState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory ListKontakState.setInit() {
    return ListKontakState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}

class CreateContactState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  CreateContactResponse data;

  CreateContactState(
      {this.data,
      this.hasError,
      this.isSuccess,
      this.message,
      this.standby,
      this.isInit,
      this.isLoading});

  factory CreateContactState.onSuccess(CreateContactResponse data) {
    return CreateContactState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory CreateContactState.onError(String message) {
    return CreateContactState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory CreateContactState.unStanby() {
    return CreateContactState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory CreateContactState.onLoading(String message) {
    return CreateContactState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory CreateContactState.setInit() {
    return CreateContactState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}


class DeleteContactState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  DeleteContactResponse data;

  DeleteContactState(
      {this.data,
      this.hasError,
      this.isSuccess,
      this.message,
      this.standby,
      this.isInit,
      this.isLoading});

  factory DeleteContactState.onSuccess(DeleteContactResponse data) {
    return DeleteContactState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory DeleteContactState.onError(String message) {
    return DeleteContactState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory DeleteContactState.unStanby() {
    return DeleteContactState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory DeleteContactState.onLoading(String message) {
    return DeleteContactState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory DeleteContactState.setInit() {
    return DeleteContactState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}

class EditContactState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  EditContactResponse data;

  EditContactState(
      {this.data,
      this.hasError,
      this.isSuccess,
      this.message,
      this.standby,
      this.isInit,
      this.isLoading});

  factory EditContactState.onSuccess(EditContactResponse data) {
    return EditContactState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory EditContactState.onError(String message) {
    return EditContactState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory EditContactState.unStanby() {
    return EditContactState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory EditContactState.onLoading(String message) {
    return EditContactState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory EditContactState.setInit() {
    return EditContactState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}