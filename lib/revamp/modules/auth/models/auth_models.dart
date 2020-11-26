// To parse this JSON data, do
//
//     final getProfileResponse = getProfileResponseFromJson(jsonString);

import 'dart:convert';

import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';
import 'package:soedja_freelance/revamp/modules/profile/models/profile_models.dart';

GetProfileResponse getProfileResponseFromJson(String str) => GetProfileResponse.fromJson(json.decode(str));

String getProfileResponseToJson(GetProfileResponse data) => json.encode(data.toJson());

class GetProfileResponse {
  GetProfileResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  ProfileDetail payload;

  factory GetProfileResponse.fromJson(Map<String, dynamic> json) => GetProfileResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : ProfileDetail.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}



UpdateProfilePayload updateProfilePayloadFromJson(String str) => UpdateProfilePayload.fromJson(json.decode(str));

String updateProfilePayloadToJson(UpdateProfilePayload data) => json.encode(data.toJson());

class UpdateProfilePayload {
  UpdateProfilePayload({
    this.email,
    this.phone,
    this.name,
    this.address,
    this.province,
    this.regency,
    this.district,
    this.village,
    this.profession,
    this.about,
    this.skills,
  });

  String email;
  String phone;
  String name;
  String address;
  String province;
  String regency;
  String district;
  String village;
  String profession;
  String about;
  String skills;

  factory UpdateProfilePayload.fromJson(Map<String, dynamic> json) => UpdateProfilePayload(
    email: json["email"] == null ? null : json["email"],
    phone: json["phone"] == null ? null : json["phone"],
    name: json["name"] == null ? null : json["name"],
    address: json["address"] == null ? null : json["address"],
    province: json["province"] == null ? null : json["province"],
    regency: json["regency"] == null ? null : json["regency"],
    district: json["district"] == null ? null : json["district"],
    village: json["village"] == null ? null : json["village"],
    profession: json["profession"] == null ? null : json["profession"],
    about: json["about"] == null ? null : json["about"],
    skills: json["skills"] == null ? null : json["skills"],
  );

  Map<String, dynamic> toJson() => {
    "email": email == null ? null : email,
    "phone": phone == null ? null : phone,
    "name": name == null ? null : name,
    "address": address == null ? null : address,
    "province": province == null ? null : province,
    "regency": regency == null ? null : regency,
    "district": district == null ? null : district,
    "village": village == null ? null : village,
    "profession": profession == null ? null : profession,
    "about": about == null ? null : about,
    "skills": skills == null ? null : skills,
  };
}
UpdateProfileResponse updateProfileResponseFromJson(String str) => UpdateProfileResponse.fromJson(json.decode(str));

String updateProfileResponseToJson(UpdateProfileResponse data) => json.encode(data.toJson());

class UpdateProfileResponse {
  UpdateProfileResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  ProfileDetail payload;

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) => UpdateProfileResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : ProfileDetail.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}


class JwtData {
  String userId;
  String email;

  JwtData({this.userId, this.email});

  factory JwtData.fromJson(Map<String, dynamic> json) => JwtData(
    userId: json["user_id"],
    email: json["email"],
  );

  // object to json
  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "email": email,
    };
  }
}
