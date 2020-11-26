import 'dart:convert';

GiveSupportPayload giveSupportPayloadFromJson(String str) => GiveSupportPayload.fromJson(json.decode(str));

String giveSupportPayloadToJson(GiveSupportPayload data) => json.encode(data.toJson());

class GiveSupportPayload {
  GiveSupportPayload({
    this.parentId,
    this.comment,
    this.amount,
  });

  String parentId;
  String comment;
  int amount;

  factory GiveSupportPayload.fromJson(Map<String, dynamic> json) => GiveSupportPayload(
    parentId: json["parent_id"] == null ? null : json["parent_id"],
    comment: json["comment"] == null ? null : json["comment"],
    amount: json["amount"] == null ? null : json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "parent_id": parentId == null ? null : parentId,
    "comment": comment == null ? null : comment,
    "amount": amount == null ? null : amount,
  };
}


PaymentXenditPayload paymentXenditPayloadFromJson(String str) => PaymentXenditPayload.fromJson(json.decode(str));

String paymentXenditPayloadToJson(PaymentXenditPayload data) => json.encode(data.toJson());

class PaymentXenditPayload {
    PaymentXenditPayload({
        this.paymentId,
        this.paymentMethod,
    });

    String paymentId;
    String paymentMethod;

    factory PaymentXenditPayload.fromJson(Map<String, dynamic> json) => PaymentXenditPayload(
        paymentId: json["payment_id"] == null ? null : json["payment_id"],
        paymentMethod: json["payment_method"] == null ? null : json["payment_method"],
    );

    Map<String, dynamic> toJson() => {
        "payment_id": paymentId == null ? null : paymentId,
        "payment_method": paymentMethod == null ? null : paymentMethod,
    };
}

PaymentResponse paymentResponseFromJson(String str) => PaymentResponse.fromJson(json.decode(str));

String paymentResponseToJson(PaymentResponse data) => json.encode(data.toJson());

class PaymentResponse {
  PaymentResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  PaymentPayload payload;

  factory PaymentResponse.fromJson(Map<String, dynamic> json) => PaymentResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : PaymentPayload.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}

class PaymentPayload {
  PaymentPayload({
    this.paymentId,
    this.price,
    this.quantity,
    this.name,
  });

  String paymentId;
  int price;
  int quantity;
  String name;

  factory PaymentPayload.fromJson(Map<String, dynamic> json) => PaymentPayload(
    paymentId: json["payment_id"] == null ? null : json["payment_id"],
    price: json["price"] == null ? null : json["price"],
    quantity: json["quantity"] == null ? null : json["quantity"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "payment_id": paymentId == null ? null : paymentId,
    "price": price == null ? null : price,
    "quantity": quantity == null ? null : quantity,
    "name": name == null ? null : name,
  };
}

PaymentXenditResponse paymentXenditResponseFromJson(String str) => PaymentXenditResponse.fromJson(json.decode(str));

String paymentXenditResponseToJson(PaymentXenditResponse data) => json.encode(data.toJson());

class PaymentXenditResponse {
    PaymentXenditResponse({
        this.code,
        this.message,
    });

    String code;
    String message;

    factory PaymentXenditResponse.fromJson(Map<String, dynamic> json) => PaymentXenditResponse(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
    );

    Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
    };
}