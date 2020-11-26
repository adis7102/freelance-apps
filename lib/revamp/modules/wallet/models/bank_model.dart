// To parse this JSON data, do
//
//     final bankListResponse = bankListResponseFromJson(jsonString);

import 'dart:convert';

BankListResponse bankListResponseFromJson(String str) => BankListResponse.fromJson(json.decode(str));

String bankListResponseToJson(BankListResponse data) => json.encode(data.toJson());

class BankListResponse {
  BankListResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  List<BankDetail> payload;

  factory BankListResponse.fromJson(Map<String, dynamic> json) => BankListResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : List<BankDetail>.from(json["payload"].map((x) => BankDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : List<dynamic>.from(payload.map((x) => x.toJson())),
  };
}

class BankDetail {
  BankDetail({
    this.code,
    this.title,
    this.logo,
    this.createdAt,
    this.updatedAt,
  });

  String code;
  String title;
  String logo;
  int createdAt;
  int updatedAt;

  factory BankDetail.fromJson(Map<String, dynamic> json) => BankDetail(
    code: json["code"] == null ? null : json["code"],
    title: json["title"] == null ? null : json["title"],
    logo: json["logo"] == null ? null : json["logo"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "title": title == null ? null : title,
    "logo": logo == null ? null : logo,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
  };
}


BankHistoryResponse bankHistoryResponseFromJson(String str) => BankHistoryResponse.fromJson(json.decode(str));

String bankHistoryResponseToJson(BankHistoryResponse data) => json.encode(data.toJson());

class BankHistoryResponse {
  BankHistoryResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  List<BankHistory> payload;

  factory BankHistoryResponse.fromJson(Map<String, dynamic> json) => BankHistoryResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : List<BankHistory>.from(json["payload"].map((x) => BankHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : List<dynamic>.from(payload.map((x) => x.toJson())),
  };
}

class BankHistory {
  BankHistory({
    this.id,
    this.userId,
    this.bank,
    this.accountNumber,
    this.accountName,
    this.createdAt,
    this.updatedAt,
    this.bankDetail,
  });

  String id;
  String userId;
  String bank;
  String accountNumber;
  String accountName;
  int createdAt;
  int updatedAt;
  BankDetail bankDetail;

  factory BankHistory.fromJson(Map<String, dynamic> json) => BankHistory(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    bank: json["bank"] == null ? null : json["bank"],
    accountNumber: json["account_number"] == null ? null : json["account_number"],
    accountName: json["account_name"] == null ? null : json["account_name"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    bankDetail: json["bank_detail"] == null ? null : BankDetail.fromJson(json["bank_detail"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "bank": bank == null ? null : bank,
    "account_number": accountNumber == null ? null : accountNumber,
    "account_name": accountName == null ? null : accountName,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "bank_detail": bankDetail == null ? null : bankDetail.toJson(),
  };
}
