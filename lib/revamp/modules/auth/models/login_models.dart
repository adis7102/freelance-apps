
import 'dart:convert';

LoginPayload loginPayloadFromJson(String str) => LoginPayload.fromJson(json.decode(str));

String loginPayloadToJson(LoginPayload data) => json.encode(data.toJson());

class LoginPayload {
  LoginPayload({
    this.email,
    this.pin,
  });

  String email;
  String pin;

  factory LoginPayload.fromJson(Map<String, dynamic> json) => LoginPayload(
    email: json["email"] == null ? null : json["email"],
    pin: json["pin"] == null ? null : json["pin"],
  );

  Map<String, dynamic> toJson() => {
    "email": email == null ? null : email,
    "pin": pin == null ? null : pin,
  };
}

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  PayloadJwt payload;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
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

class PayloadJwt {
  PayloadJwt({
    this.jwt,
  });

  String jwt;

  factory PayloadJwt.fromJson(Map<String, dynamic> json) => PayloadJwt(
    jwt: json["jwt"] == null ? null : json["jwt"],
  );

  Map<String, dynamic> toJson() => {
    "jwt": jwt == null ? null : jwt,
  };
}
