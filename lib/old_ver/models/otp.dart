class PinToken {
  String jwt;
  String message;
  String error;

  PinToken({
    this.jwt,
    this.message,
  });

  // object to json
  Map<String, dynamic> toJson() {
    return {
      "jwt": jwt,
      "message": message,
    };
  }

  // json response API to object
  factory PinToken.fromJson(Map<String, dynamic> map) {
    return PinToken(jwt: map['jwt']);
  }

  PinToken.withError(this.error);
}

class OtpPayload {
  final String email;

  OtpPayload({
    this.email,
  });

  OtpPayload.fromJson(Map<String, dynamic> json)
      : email = json['email'];

  Map<String, dynamic> toJson() => {
    'email': email,
  };
}

class OtpTokenPayload {
  final String jwt;

  OtpTokenPayload({
    this.jwt,
  });

  OtpTokenPayload.fromJson(Map<String, dynamic> json)
      : jwt = json['jwt'];

  Map<String, dynamic> toJson() => {
    'jwt': jwt,
  };
}

class OtpValidatePayload {
  final String email;
  final String otp;

  OtpValidatePayload({
    this.email,
    this.otp,
  });

  OtpValidatePayload.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        otp = json['otp'];

  Map<String, dynamic> toJson() => {
    'email': email,
    'otp': otp,
  };
}
