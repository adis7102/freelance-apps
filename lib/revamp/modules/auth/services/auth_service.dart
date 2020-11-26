import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:soedja_freelance/revamp/assets/urls.dart';
import 'package:soedja_freelance/revamp/helpers/http_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/models/auth_models.dart';
import 'package:soedja_freelance/revamp/modules/auth/models/login_models.dart';
import 'package:soedja_freelance/revamp/modules/auth/models/otp_models.dart';
import 'package:soedja_freelance/revamp/modules/auth/models/pin_models.dart';
import 'package:soedja_freelance/revamp/modules/auth/models/register_models.dart';
import 'package:soedja_freelance/revamp/modules/notification/models/notification_models.dart';

abstract class AuthAPI {
  Future<LoginResponse> postLogin(
    BuildContext context,
    LoginPayload payload,
  );

  Future<DefaultResponse> postRegister(
    BuildContext context,
    RegisterPayload payload,
  );

  Future<DefaultJwtResponse> postValidate(
    BuildContext context,
    ValidateOtpPayload payload,
  );

  Future<DefaultResponse> resendOtp(
      BuildContext context, ResendOtpPayload payload, String type);

  Future<DefaultResponse> resetPin(
      BuildContext context, ResetPinPayload payload, String token);

  Future<GetProfileResponse> getProfileAuth(BuildContext context);

  Future<GetProfileResponse> updateProfile(
      BuildContext context, UpdateProfilePayload payload);

  Future<GetProfileResponse> uploadAvatar(BuildContext context, File file);

  Future<DefaultResponse> requestFCM(
    BuildContext context,
    String token,
    String userId,
    String version,
  );
}

class AuthServices extends AuthAPI {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  Location location = new Location();

  @override
  Future<LoginResponse> postLogin(
      BuildContext context, LoginPayload payload) async {
    try {
      String url = Urls.login;
      var response = await HttpRequest.post(
          context: context,
          url: url,
          useAuth: false,
          bodyJson: payload.toJson());
      if (response['code'] == "success") {
        return LoginResponse.fromJson(response);
      } else {
        return LoginResponse(code: "failed", message: response["message"]);
      }
    } catch (e) {
      print("Error " + e.toString());
      return LoginResponse(message: e.toString());
    }
  }

  @override
  Future<GetProfileResponse> getProfileAuth(BuildContext context) async {
    try {
      String url = Urls.getProfile;

      var response = await HttpRequest.get(
        context: context,
        url: url,
        useAuth: true,
      );

      return GetProfileResponse.fromJson(response);
    } catch (e) {
      print(e.toString());
      return GetProfileResponse(code: 'failed', message: e.toString());
    }
  }

  @override
  Future<DefaultResponse> postRegister(
      BuildContext context, RegisterPayload payload) async {
    try {
      String url = Urls.registerFreelance;

      var response = await HttpRequest.post(
        context: context,
        url: url,
        bodyJson: payload.toJson(),
        useAuth: false,
      );

      return DefaultResponse.fromJson(response);
    } catch (e) {
      print(e.toString());
      return DefaultResponse(code: 'failed', message: e.toString());
    }
  }

  @override
  Future<DefaultJwtResponse> postValidate(
      BuildContext context, ValidateOtpPayload payload) async {
    try {
      String url = Urls.validateOtp;

      var response = await HttpRequest.post(
        context: context,
        url: url,
        bodyJson: payload.toJson(),
        useAuth: false,
      );

      return DefaultJwtResponse.fromJson(response);
    } catch (e) {
      print(e.toString());
      return DefaultJwtResponse(code: 'failed', message: e.toString());
    }
  }

  @override
  Future<DefaultResponse> resendOtp(
      BuildContext context, ResendOtpPayload payload, String type) async {
    try {
      String url =
          type == 'activate' ? Urls.requestActivate : Urls.requestResetPin;

      var response = await HttpRequest.post(
        context: context,
        url: url,
        bodyJson: payload.toJson(),
        useAuth: false,
      );

      return DefaultResponse.fromJson(response);
    } catch (e) {
      print(e.toString());
      return DefaultResponse(code: 'failed', message: e.toString());
    }
  }

  @override
  Future<DefaultResponse> resetPin(
      BuildContext context, ResetPinPayload payload, String token) async {
    try {
      String url = Urls.sendResetPin;

      var response = await HttpRequest.postToken(
        context: context,
        url: url,
        bodyJson: payload.toJson(),
        token: token,
      );

      return DefaultResponse.fromJson(response);
    } catch (e) {
      print(e.toString());
      return DefaultResponse(code: 'failed', message: e.toString());
    }
  }

  @override
  Future<GetProfileResponse> updateProfile(
      BuildContext context, UpdateProfilePayload payload) async {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

  @override
  Future<GetProfileResponse> uploadAvatar(
      BuildContext context, File file) async {
    String url = Urls.updateAvatar;
    try {
      var response = await HttpRequest.putFile(
        context: context,
        url: url,
        files: [file],
        useAuth: false,
      );
      if (response['code'] == "success") {
        return GetProfileResponse.fromJson(response);
      } else {
        return GetProfileResponse(code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return GetProfileResponse(code: 'failed', message: e.toString());
    }
  }

  @override
  Future<DefaultResponse> requestFCM(
      BuildContext context, String token, String userId, String version) async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.model}');

    UpdateTokenPayload payload = new UpdateTokenPayload(
        userId: userId,
        device: Platform.isIOS ? 'ios' : 'android',
        os: androidInfo.type,
        osVersion: androidInfo.version.toString(),
        appVersion: version,
        brand: androidInfo.brand,
        brandType: androidInfo.device,
        token: token);

    print(payload.toJson());
    try {
      var response = await HttpRequest.put(
        context: context,
        url: Urls.updateToken,
        bodyJson: payload.toJson(),
      );

      if (response['code'] == "success") {
        return DefaultResponse.fromJson(response);
      }

      return DefaultResponse(code: "failed", message: response['message']);
    } catch (e) {
      print(e);
      return DefaultResponse(code: "failed", message: e.toString());
    }
  }
}
