import 'package:soedja_freelance/revamp/modules/category/models/category_model.dart';

class CategoryListState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  CategoryListResponse data;

  CategoryListState(
      {this.data,
      this.hasError,
      this.isSuccess,
      this.message,
      this.standby,
      this.isInit,
      this.isLoading});

  factory CategoryListState.onSuccess(CategoryListResponse data) {
    return CategoryListState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory CategoryListState.onError(String message) {
    return CategoryListState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory CategoryListState.unStanby() {
    return CategoryListState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory CategoryListState.onLoading(String message) {
    return CategoryListState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory CategoryListState.setInit() {
    return CategoryListState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}

class SubCategoryListState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  SubCategoryListResponse data;

  SubCategoryListState(
      {this.data,
      this.hasError,
      this.isSuccess,
      this.message,
      this.standby,
      this.isInit,
      this.isLoading});

  factory SubCategoryListState.onSuccess(SubCategoryListResponse data) {
    return SubCategoryListState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory SubCategoryListState.onError(String message) {
    return SubCategoryListState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory SubCategoryListState.unStanby() {
    return SubCategoryListState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory SubCategoryListState.onLoading(String message) {
    return SubCategoryListState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory SubCategoryListState.setInit() {
    return SubCategoryListState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}

class TypeCategoryListState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  TypeCategoryListResponse data;

  TypeCategoryListState(
      {this.data,
      this.hasError,
      this.isSuccess,
      this.message,
      this.standby,
      this.isInit,
      this.isLoading});

  factory TypeCategoryListState.onSuccess(TypeCategoryListResponse data) {
    return TypeCategoryListState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory TypeCategoryListState.onError(String message) {
    return TypeCategoryListState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory TypeCategoryListState.unStanby() {
    return TypeCategoryListState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory TypeCategoryListState.onLoading(String message) {
    return TypeCategoryListState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory TypeCategoryListState.setInit() {
    return TypeCategoryListState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}
