class PinCreatePayload {
  final String email;
  final String pin;

  PinCreatePayload({
    this.email,
    this.pin,
  });

  PinCreatePayload.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        pin = json['pin'];

  Map<String, dynamic> toJson() => {
    'email': email,
    'pin': pin,
  };
}
