
import 'package:soedja_freelance/revamp/modules/portfolio/models/comment_model.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/models/portfolio_models.dart';

class CreatePortfolioState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  CreatePortfolioResponse data;

  CreatePortfolioState(
      {this.data,
        this.hasError,
        this.isSuccess,
        this.message,
        this.standby,
        this.isInit,
        this.isLoading});

  factory CreatePortfolioState.onSuccess(CreatePortfolioResponse data) {
    return CreatePortfolioState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory CreatePortfolioState.onError(String message) {
    return CreatePortfolioState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory CreatePortfolioState.unStanby() {
    return CreatePortfolioState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory CreatePortfolioState.onLoading(String message) {
    return CreatePortfolioState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory CreatePortfolioState.setInit() {
    return CreatePortfolioState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}
class UpdatePortfolioState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  CreatePortfolioResponse data;

  UpdatePortfolioState(
      {this.data,
        this.hasError,
        this.isSuccess,
        this.message,
        this.standby,
        this.isInit,
        this.isLoading});

  factory UpdatePortfolioState.onSuccess(CreatePortfolioResponse data) {
    return UpdatePortfolioState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory UpdatePortfolioState.onError(String message) {
    return UpdatePortfolioState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory UpdatePortfolioState.unStanby() {
    return UpdatePortfolioState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory UpdatePortfolioState.onLoading(String message) {
    return UpdatePortfolioState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory UpdatePortfolioState.setInit() {
    return UpdatePortfolioState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}
class DeletePortfolioState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  CreatePortfolioResponse data;

  DeletePortfolioState(
      {this.data,
        this.hasError,
        this.isSuccess,
        this.message,
        this.standby,
        this.isInit,
        this.isLoading});

  factory DeletePortfolioState.onSuccess(CreatePortfolioResponse data) {
    return DeletePortfolioState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory DeletePortfolioState.onError(String message) {
    return DeletePortfolioState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory DeletePortfolioState.unStanby() {
    return DeletePortfolioState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory DeletePortfolioState.onLoading(String message) {
    return DeletePortfolioState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory DeletePortfolioState.setInit() {
    return DeletePortfolioState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}

class UploadPortfolioState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  UploadPortfolioResponse data;

  UploadPortfolioState(
      {this.data,
        this.hasError,
        this.isSuccess,
        this.message,
        this.standby,
        this.isInit,
        this.isLoading});

  factory UploadPortfolioState.onSuccess(UploadPortfolioResponse data) {
    return UploadPortfolioState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory UploadPortfolioState.onError(String message) {
    return UploadPortfolioState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory UploadPortfolioState.unStanby() {
    return UploadPortfolioState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory UploadPortfolioState.onLoading(String message) {
    return UploadPortfolioState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory UploadPortfolioState.setInit() {
    return UploadPortfolioState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}


class CommentListState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  PortfolioCommentResponse data;

  CommentListState(
      {this.data,
        this.hasError,
        this.isSuccess,
        this.message,
        this.standby,
        this.isInit,
        this.isLoading});

  factory CommentListState.onSuccess(PortfolioCommentResponse data) {
    return CommentListState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory CommentListState.onError(String message) {
    return CommentListState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory CommentListState.unStanby() {
    return CommentListState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory CommentListState.onLoading(String message) {
    return CommentListState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory CommentListState.setInit() {
    return CommentListState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}


class GiveCommentState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  GiveCommentResponse data;

  GiveCommentState(
      {this.data,
        this.hasError,
        this.isSuccess,
        this.message,
        this.standby,
        this.isInit,
        this.isLoading});

  factory GiveCommentState.onSuccess(GiveCommentResponse data) {
    return GiveCommentState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory GiveCommentState.onError(String message) {
    return GiveCommentState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory GiveCommentState.unStanby() {
    return GiveCommentState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory GiveCommentState.onLoading(String message) {
    return GiveCommentState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory GiveCommentState.setInit() {
    return GiveCommentState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}