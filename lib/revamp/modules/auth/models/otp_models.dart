// To parse this JSON data, do
//
//     final validateOtpPayload = validateOtpPayloadFromJson(jsonString);

import 'dart:convert';

ValidateOtpPayload validateOtpPayloadFromJson(String str) => ValidateOtpPayload.fromJson(json.decode(str));

String validateOtpPayloadToJson(ValidateOtpPayload data) => json.encode(data.toJson());

class ValidateOtpPayload {
  ValidateOtpPayload({
    this.email,
    this.otp,
  });

  String email;
  String otp;

  factory ValidateOtpPayload.fromJson(Map<String, dynamic> json) => ValidateOtpPayload(
    email: json["email"] == null ? null : json["email"],
    otp: json["otp"] == null ? null : json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "email": email == null ? null : email,
    "otp": otp == null ? null : otp,
  };
}

ResendOtpPayload resendOtpPayloadFromJson(String str) => ResendOtpPayload.fromJson(json.decode(str));

String resendOtpPayloadToJson(ResendOtpPayload data) => json.encode(data.toJson());

class ResendOtpPayload {
  ResendOtpPayload({
    this.email,
  });

  String email;

  factory ResendOtpPayload.fromJson(Map<String, dynamic> json) => ResendOtpPayload(
    email: json["email"] == null ? null : json["email"],
  );

  Map<String, dynamic> toJson() => {
    "email": email == null ? null : email,
  };
}
