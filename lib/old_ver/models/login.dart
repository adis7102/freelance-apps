class Login {
  String jwt;
  String message;
  String error;

  Login({
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
  factory Login.fromJson(Map<String, dynamic> map) {
    return Login(jwt: map['jwt'], message: map['message']);
  }

  Login.withError(this.error);
}

class LoginPayload {
  String email;
  String pin;

  LoginPayload({this.email, this.pin});

  // object to json
  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "pin": pin,
    };
  }
}
