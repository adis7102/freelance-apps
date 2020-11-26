class RegisterPayload {
  String email;
  String phone;
  String name;
  String type;

  RegisterPayload({
    this.email,
    this.phone,
    this.name,
    this.type,
  });

  // object to json
  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "phone": phone,
      "name": name,
      "type": type,
    };
  }
}
