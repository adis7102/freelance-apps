import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:soedja_freelance/old_ver/components/dialog.dart';
import 'package:soedja_freelance/old_ver/constants/strings.dart';
import 'package:soedja_freelance/old_ver/constants/urls.dart';
import 'package:soedja_freelance/old_ver/models/login.dart';
import 'package:soedja_freelance/old_ver/models/otp.dart';
import 'package:soedja_freelance/old_ver/models/pin.dart';
import 'package:soedja_freelance/old_ver/models/register.dart';
import 'package:soedja_freelance/old_ver/models/user.dart';
import 'package:soedja_freelance/old_ver/utils/http_request.dart';

class UserService {
  Future<Login> login(LoginPayload payload) async {
    try {
      final response = await HttpRequest.post(
          url: Url.loginFreelance, bodyJson: payload.toJson(), useAuth: false);
      if (response['code'] == 'success') {
        return Login(
            message: response['code'], jwt: response['payload']['jwt']);
      } else if (response['message'] == 'Email / PIN anda salah') {
        print(response['message']);
        return Login(message: 'wrong_pin');
      } else if (response['message'] == 'PIN anda belum diaktifkan') {
        return Login(message: 'deactive_pin');
      } else if (response['message']
          .contains('silahkan melakukan aktifasi account')) {
        return Login(message: 'deactive_account');
      } else {
        return Login(message: response['code']);
      }
    } catch (err) {
      return Login.withError(err.toString());
    }
  }

  Future<String> register(RegisterPayload payload) async {
    try {
      final response = await HttpRequest.post(
          url: Url.registerFreelance,
          bodyJson: payload.toJson(),
          useAuth: false);
      if (response['code'] == 'success') {
        return 'success';
      } else {
        if (response['message'] == 'Email anda sudah terdaftar') {
          return 'registered';
        }
        return response['message'];
      }
    } catch (err) {
      return 'failed';
    }
  }

  Future<bool> postOtp(OtpPayload payload, String type) async {
    try {
      final response = await HttpRequest.post(
          url: type == Strings.registerKey
              ? Url.requestActivate
              : Url.requestResetPin,
          bodyJson: payload.toJson(),
          useAuth: false);
      if (response['code'] == 'success') {
        return true;
      }
      return false;
    } catch (err) {
      return false;
    }
  }

  Future<PinToken> postValidateOtp(OtpValidatePayload payload) async {
    try {
      final response = await HttpRequest.post(
          url: Url.validateOtp, bodyJson: payload.toJson(), useAuth: false);
      if (response['code'] == 'success') {
        return PinToken(jwt: response['payload']['jwt']);
      } else if (response['message'] == 'otp tidak valid') {
        return PinToken(message: 'wrong_otp');
      } else {
        return PinToken(message: 'err_general');
      }
    } catch (err) {
      return PinToken(message: 'err_general');
    }
  }

  Future<bool> postResetPin(PinCreatePayload payload) async {
    try {
      final response = await HttpRequest.post(
          url: Url.sendResetPin, bodyJson: payload.toJson(), useAuth: true);
      if (response['code'] == 'success') {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }

  Future<Profile> getProfile(BuildContext context) async {
    try {
      final response = await HttpRequest.get(
          context: context, url: Url.getProfile, useAuth: true);
      return Profile.fromJson(response['payload']);
    } catch (err) {
      return Profile.withError(err.toString());
    }
  }

  Future<Profile> getFeedsProfile(BuildContext context, String userId) async {
    try {
      final response = await HttpRequest.get(
          context: context, url: Url.getFeedsProfile+userId, useAuth: true);


      print("Profile payload: "+response['payload'].toString());
//      Profile prof = new Profile.fromJson(response['payload']);
//
//      print("Profile: "+prof.name);
      return Profile.fromJson(response['payload']);
    } catch (err) {
      return Profile.withError(err.toString());
    }
  }

  Future<List<Profession>> getProfession(BuildContext context) async {
    try {
      List<Profession> list = new List<Profession>();
      final response = await HttpRequest.get(
          context: context, url: Url.professionList, useAuth: true);

      response['payload']['rows'].forEach((data) {
        list.add(Profession.fromJson(data));
      });

      return list;
    } catch (err) {
      return [];
    }
  }

  Future<Profile> updateProfile(BuildContext context, UpdateProfilePayload payload) async {
    try {
      Profile profile = new Profile();

      final response = await HttpRequest.put(
          context: context, url: Url.updateProfileFreelance, bodyJson: payload.toJson(), useAuth: true);

      if(response['code'] =='success'){
        profile = new Profile(userId: response['payload']['user_id']);
        return profile;
      }

      return profile;
    } catch (err) {
      return Profile();
    }
  }

  Future<bool> updateAvatar(BuildContext context, List<File> files) async {
    try {

      final response = await HttpRequest.putFile(context: context,
          url: Url.updateAvatar, files: files, useAuth: true);

      if(response['code'] =='success'){
        return true;
      }

      return false;
    } catch (err) {
      return false;
    }
  }

  Future<FollowData> getFollows(BuildContext context, String userId) async {
    try {

      final response = await HttpRequest.get(
          context: context, url: Url.getFollows+userId, useAuth: true);

      return FollowData.fromJson(response['payload']);
    } catch (err) {
      return FollowData();
    }
  }
}
