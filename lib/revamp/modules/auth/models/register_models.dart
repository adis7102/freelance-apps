import 'dart:convert';

import 'package:soedja_freelance/revamp/modules/auth/models/login_models.dart';

RegisterPayload registerPayloadFromJson(String str) => RegisterPayload.fromJson(json.decode(str));

String registerPayloadToJson(RegisterPayload data) => json.encode(data.toJson());

class RegisterPayload {
  RegisterPayload({
    this.email,
    this.phone,
    this.name,
    this.type,
  });

  String email;
  String phone;
  String name;
  String type;

  factory RegisterPayload.fromJson(Map<String, dynamic> json) => RegisterPayload(
    email: json["email"] == null ? null : json["email"],
    phone: json["phone"] == null ? null : json["phone"],
    name: json["name"] == null ? null : json["name"],
    type: json["type"] == null ? null : json["type"],
  );

  Map<String, dynamic> toJson() => {
    "email": email == null ? null : email,
    "phone": phone == null ? null : phone,
    "name": name == null ? null : name,
    "type": type == null ? null : type,
  };
}

DefaultResponse defaultResponseFromJson(String str) => DefaultResponse.fromJson(json.decode(str));

String defaultResponseToJson(DefaultResponse data) => json.encode(data.toJson());

class DefaultResponse {
  DefaultResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  Payload payload;

  factory DefaultResponse.fromJson(Map<String, dynamic> json) => DefaultResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : Payload.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}

class Payload {
  Payload();

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
  );

  Map<String, dynamic> toJson() => {
  };
}

class DefaultJwtResponse {
  DefaultJwtResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  PayloadJwt payload;

  factory DefaultJwtResponse.fromJson(Map<String, dynamic> json) => DefaultJwtResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : PayloadJwt.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}
