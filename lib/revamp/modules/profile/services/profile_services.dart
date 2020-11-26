import 'package:flutter/material.dart';
import 'package:soedja_freelance/revamp/assets/urls.dart';
import 'package:soedja_freelance/revamp/helpers/http_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/models/auth_models.dart';
import 'package:soedja_freelance/revamp/modules/auth/models/register_models.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';
import 'package:soedja_freelance/revamp/modules/profile/models/profile_models.dart';

abstract class ProfileAPI {
  Future<ProfileDetailResponse> getProfileDetail(
      BuildContext context, String userId);

  Future<ProfileListResponse> getProfileList(
      BuildContext context, FeedListPayload payload);

  Future<ProfileFollowResponse> getProfileFollow(
      BuildContext context, String userId);

  Future<FollowingListResponse> getFollowing(
      BuildContext context, String userId, FeedListPayload payload);

  Future<FollowerListResponse> getFollower(
      BuildContext context, String userId, FeedListPayload payload);

  Future<CreateFollowResponse> createFollow(
      BuildContext context, String userId);

  Future<DefaultResponse> deleteFollow(BuildContext context, String userId);

  Future<ProfessionListResponse> getProfession(BuildContext context);

  Future<UpdateProfileResponse> updateProfile(
      BuildContext context, UpdateProfilePayload payload);
}

class ProfileService extends ProfileAPI {
  @override
  Future<ProfileDetailResponse> getProfileDetail(
      BuildContext context, String userId) async {
    String url = Urls.getProfileDetail + userId;
    try {
      var response =
          await HttpRequest.get(context: context, useAuth: true, url: url);
      if (response['code'] == "success") {
        return ProfileDetailResponse.fromJson(response);
      } else {
        return ProfileDetailResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return ProfileDetailResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<ProfileListResponse> getProfileList(
      BuildContext context, FeedListPayload payload) async {
    String url = Urls.profilesList +
        "?name=${payload.title}"
            "&limit=${payload.limit}"
            "&page=${payload.page}";

    try {
      var response =
          await HttpRequest.get(context: context, useAuth: true, url: url);
      if (response['code'] == "success") {
        return ProfileListResponse.fromJson(response);
      } else {
        return ProfileListResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return ProfileListResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<CreateFollowResponse> createFollow(
      BuildContext context, String userId) async {
    String url = Urls.createFollow;

    var body = {
      "following_id": userId,
    };

    try {
      var response = await HttpRequest.post(
          context: context, useAuth: true, url: url, bodyJson: body);
      if (response['code'] == "success") {
        return CreateFollowResponse.fromJson(response);
      } else {
        return CreateFollowResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return CreateFollowResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<DefaultResponse> deleteFollow(
      BuildContext context, String userId) async {
    String url = Urls.removeFollow + userId;

    try {
      var response =
          await HttpRequest.delete(context: context, useAuth: true, url: url);
      if (response['code'] == "success") {
        return DefaultResponse.fromJson(response);
      } else {
        return DefaultResponse(code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return DefaultResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<FollowerListResponse> getFollower(
      BuildContext context, String userId, FeedListPayload payload) async {
    String url = Urls.getFollower +
        userId +
        "?limit=${payload.limit}"
            "&page=${payload.page}";

    try {
      var response =
          await HttpRequest.get(context: context, useAuth: true, url: url);
      if (response['code'] == "success") {
        return FollowerListResponse.fromJson(response);
      } else {
        return FollowerListResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return FollowerListResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<FollowingListResponse> getFollowing(
      BuildContext context, String userId, FeedListPayload payload) async {
    String url = Urls.getFollowing +
        userId +
        "?limit=${payload.limit}"
            "&page=${payload.page}";

    try {
      var response =
          await HttpRequest.get(context: context, useAuth: true, url: url);
      if (response['code'] == "success") {
        return FollowingListResponse.fromJson(response);
      } else {
        return FollowingListResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return FollowingListResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<ProfileFollowResponse> getProfileFollow(
      BuildContext context, String userId) async {
    String url = Urls.getProfileFollow + userId;

    try {
      var response =
          await HttpRequest.get(context: context, useAuth: true, url: url);
      if (response['code'] == "success") {
        return ProfileFollowResponse.fromJson(response);
      } else {
        return ProfileFollowResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return ProfileFollowResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<ProfessionListResponse> getProfession(BuildContext context) async {
    String url = Urls.getProfession;

    try {
      var response =
          await HttpRequest.get(context: context, useAuth: true, url: url);
      if (response['code'] == "success") {
        return ProfessionListResponse.fromJson(response);
      } else {
        return ProfessionListResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return ProfessionListResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<UpdateProfileResponse> updateProfile(
      BuildContext context, UpdateProfilePayload payload) async {
    String url = Urls.updateProfile;

    try {
      var response = await HttpRequest.put(
          context: context,
          useAuth: true,
          url: url,
          bodyJson: payload.toJson());
      if (response['code'] == "success") {
        return UpdateProfileResponse.fromJson(response);
      } else {
        return UpdateProfileResponse(code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return UpdateProfileResponse(code: "failed", message: e.toString());
    }
  }
}
