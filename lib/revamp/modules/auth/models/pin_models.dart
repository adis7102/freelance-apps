// To parse this JSON data, do
//
//     final requestResetPayload = requestResetPayloadFromJson(jsonString);

import 'dart:convert';

RequestResetPayload requestResetPayloadFromJson(String str) => RequestResetPayload.fromJson(json.decode(str));

String requestResetPayloadToJson(RequestResetPayload data) => json.encode(data.toJson());

class RequestResetPayload {
  RequestResetPayload({
    this.email,
  });

  String email;

  factory RequestResetPayload.fromJson(Map<String, dynamic> json) => RequestResetPayload(
    email: json["email"] == null ? null : json["email"],
  );

  Map<String, dynamic> toJson() => {
    "email": email == null ? null : email,
  };
}

ResetPinPayload resetPinPayloadFromJson(String str) => ResetPinPayload.fromJson(json.decode(str));

String resetPinPayloadToJson(ResetPinPayload data) => json.encode(data.toJson());

class ResetPinPayload {
  ResetPinPayload({
    this.email,
    this.pin,
  });

  String email;
  String pin;

  factory ResetPinPayload.fromJson(Map<String, dynamic> json) => ResetPinPayload(
    email: json["email"] == null ? null : json["email"],
    pin: json["pin"] == null ? null : json["pin"],
  );

  Map<String, dynamic> toJson() => {
    "email": email == null ? null : email,
    "pin": pin == null ? null : pin,
  };
}
