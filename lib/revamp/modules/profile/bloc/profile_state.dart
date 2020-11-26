import 'package:soedja_freelance/revamp/modules/area/models/area_models.dart';
import 'package:soedja_freelance/revamp/modules/auth/models/auth_models.dart';
import 'package:soedja_freelance/revamp/modules/auth/models/register_models.dart';
import 'package:soedja_freelance/revamp/modules/profile/models/profile_models.dart';

class SearchProfileListState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  ProfileListResponse data;

  SearchProfileListState(
      {this.data,
      this.hasError,
      this.isSuccess,
      this.message,
      this.standby,
      this.isInit,
      this.isLoading});

  factory SearchProfileListState.onSuccess(ProfileListResponse data) {
    return SearchProfileListState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory SearchProfileListState.onError(String message) {
    return SearchProfileListState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory SearchProfileListState.unStanby() {
    return SearchProfileListState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory SearchProfileListState.onLoading(String message) {
    return SearchProfileListState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory SearchProfileListState.setInit() {
    return SearchProfileListState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}

class GetFollowingState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  FollowingListResponse data;

  GetFollowingState(
      {this.data,
      this.hasError,
      this.isSuccess,
      this.message,
      this.standby,
      this.isInit,
      this.isLoading});

  factory GetFollowingState.onSuccess(FollowingListResponse data) {
    return GetFollowingState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory GetFollowingState.onError(String message) {
    return GetFollowingState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory GetFollowingState.unStanby() {
    return GetFollowingState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory GetFollowingState.onLoading(String message) {
    return GetFollowingState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory GetFollowingState.setInit() {
    return GetFollowingState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}

class GetFollowerState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  FollowerListResponse data;

  GetFollowerState(
      {this.data,
      this.hasError,
      this.isSuccess,
      this.message,
      this.standby,
      this.isInit,
      this.isLoading});

  factory GetFollowerState.onSuccess(FollowerListResponse data) {
    return GetFollowerState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory GetFollowerState.onError(String message) {
    return GetFollowerState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory GetFollowerState.unStanby() {
    return GetFollowerState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory GetFollowerState.onLoading(String message) {
    return GetFollowerState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory GetFollowerState.setInit() {
    return GetFollowerState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}

class ProfileFollowState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  ProfileFollowResponse data;

  ProfileFollowState(
      {this.data,
      this.hasError,
      this.isSuccess,
      this.message,
      this.standby,
      this.isInit,
      this.isLoading});

  factory ProfileFollowState.onSuccess(ProfileFollowResponse data) {
    return ProfileFollowState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory ProfileFollowState.onError(String message) {
    return ProfileFollowState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory ProfileFollowState.unStanby() {
    return ProfileFollowState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory ProfileFollowState.onLoading(String message) {
    return ProfileFollowState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory ProfileFollowState.setInit() {
    return ProfileFollowState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}

class ProfileDetailState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  ProfileDetailResponse data;

  ProfileDetailState(
      {this.data,
      this.hasError,
      this.isSuccess,
      this.message,
      this.standby,
      this.isInit,
      this.isLoading});

  factory ProfileDetailState.onSuccess(ProfileDetailResponse data) {
    return ProfileDetailState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory ProfileDetailState.onError(String message) {
    return ProfileDetailState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory ProfileDetailState.unStanby() {
    return ProfileDetailState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory ProfileDetailState.onLoading(String message) {
    return ProfileDetailState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory ProfileDetailState.setInit() {
    return ProfileDetailState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}

class ProfessionListState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  ProfessionListResponse data;

  ProfessionListState(
      {this.data,
      this.hasError,
      this.isSuccess,
      this.message,
      this.standby,
      this.isInit,
      this.isLoading});

  factory ProfessionListState.onSuccess(ProfessionListResponse data) {
    return ProfessionListState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory ProfessionListState.onError(String message) {
    return ProfessionListState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory ProfessionListState.unStanby() {
    return ProfessionListState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory ProfessionListState.onLoading(String message) {
    return ProfessionListState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory ProfessionListState.setInit() {
    return ProfessionListState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}

class UpdateProfileState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  UpdateProfileResponse data;

  UpdateProfileState(
      {this.data,
      this.hasError,
      this.isSuccess,
      this.message,
      this.standby,
      this.isInit,
      this.isLoading});

  factory UpdateProfileState.onSuccess(UpdateProfileResponse data) {
    return UpdateProfileState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory UpdateProfileState.onError(String message) {
    return UpdateProfileState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory UpdateProfileState.unStanby() {
    return UpdateProfileState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory UpdateProfileState.onLoading(String message) {
    return UpdateProfileState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory UpdateProfileState.setInit() {
    return UpdateProfileState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}
