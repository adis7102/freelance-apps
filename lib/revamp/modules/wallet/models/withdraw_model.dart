// To parse this JSON data, do
//
//     final withdrawHistoryResponse = withdrawHistoryResponseFromJson(jsonString);

import 'dart:convert';

import 'package:soedja_freelance/revamp/modules/wallet/models/bank_model.dart';

CreateWithdrawResponse createWithdrawResponseFromJson(String str) => CreateWithdrawResponse.fromJson(json.decode(str));

String createWithdrawResponseToJson(CreateWithdrawResponse data) => json.encode(data.toJson());

class CreateWithdrawResponse {
  CreateWithdrawResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  CreateWithdrawPayload payload;

  factory CreateWithdrawResponse.fromJson(Map<String, dynamic> json) => CreateWithdrawResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : CreateWithdrawPayload.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}

class CreateWithdrawPayload {
  CreateWithdrawPayload({
    this.proof,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.withdrawId,
    this.bank,
    this.accountNumber,
    this.accountName,
    this.amount,
    this.userId,
    this.remark,
    this.adminFee,
  });

  String proof;
  int status;
  int createdAt;
  int updatedAt;
  String withdrawId;
  String bank;
  String accountNumber;
  String accountName;
  int amount;
  String userId;
  String remark;
  int adminFee;

  factory CreateWithdrawPayload.fromJson(Map<String, dynamic> json) => CreateWithdrawPayload(
    proof: json["proof"] == null ? null : json["proof"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    withdrawId: json["withdraw_id"] == null ? null : json["withdraw_id"],
    bank: json["bank"] == null ? null : json["bank"],
    accountNumber: json["account_number"] == null ? null : json["account_number"],
    accountName: json["account_name"] == null ? null : json["account_name"],
    amount: json["amount"] == null ? null : json["amount"],
    userId: json["user_id"] == null ? null : json["user_id"],
    remark: json["remark"] == null ? null : json["remark"],
    adminFee: json["admin_fee"] == null ? null : json["admin_fee"],
  );

  Map<String, dynamic> toJson() => {
    "proof": proof == null ? null : proof,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "withdraw_id": withdrawId == null ? null : withdrawId,
    "bank": bank == null ? null : bank,
    "account_number": accountNumber == null ? null : accountNumber,
    "account_name": accountName == null ? null : accountName,
    "amount": amount == null ? null : amount,
    "user_id": userId == null ? null : userId,
    "remark": remark == null ? null : remark,
    "admin_fee": adminFee == null ? null : adminFee,
  };
}


WithdrawPayload withdrawPayloadFromJson(String str) => WithdrawPayload.fromJson(json.decode(str));

String withdrawPayloadToJson(WithdrawPayload data) => json.encode(data.toJson());

class WithdrawPayload {
  WithdrawPayload({
    this.bank,
    this.accountNumber,
    this.accountName,
    this.amount,
    this.pin,
  });

  String bank;
  String accountNumber;
  String accountName;
  int amount;
  String pin;

  factory WithdrawPayload.fromJson(Map<String, dynamic> json) => WithdrawPayload(
    bank: json["bank"] == null ? null : json["bank"],
    accountNumber: json["account_number"] == null ? null : json["account_number"],
    accountName: json["account_name"] == null ? null : json["account_name"],
    amount: json["amount"] == null ? null : json["amount"],
    pin: json["pin"] == null ? null : json["pin"],
  );

  Map<String, dynamic> toJson() => {
    "bank": bank == null ? null : bank,
    "account_number": accountNumber == null ? null : accountNumber,
    "account_name": accountName == null ? null : accountName,
    "amount": amount == null ? null : amount,
    "pin": pin == null ? null : pin,
  };
}


WithdrawHistoryResponse withdrawHistoryResponseFromJson(String str) => WithdrawHistoryResponse.fromJson(json.decode(str));

String withdrawHistoryResponseToJson(WithdrawHistoryResponse data) => json.encode(data.toJson());

class WithdrawHistoryResponse {
  WithdrawHistoryResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  WithdrawHistoryPayload payload;

  factory WithdrawHistoryResponse.fromJson(Map<String, dynamic> json) => WithdrawHistoryResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : WithdrawHistoryPayload.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}

class WithdrawHistoryPayload {
  WithdrawHistoryPayload({
    this.total,
    this.totalPage,
    this.rowPerPage,
    this.previousPage,
    this.nextPage,
    this.currentPage,
    this.info,
    this.rows,
  });

  int total;
  int totalPage;
  int rowPerPage;
  int previousPage;
  int nextPage;
  int currentPage;
  String info;
  List<WithdrawHistory> rows;

  factory WithdrawHistoryPayload.fromJson(Map<String, dynamic> json) => WithdrawHistoryPayload(
    total: json["total"] == null ? null : json["total"],
    totalPage: json["totalPage"] == null ? null : json["totalPage"],
    rowPerPage: json["rowPerPage"] == null ? null : json["rowPerPage"],
    previousPage: json["previousPage"] == null ? null : json["previousPage"],
    nextPage: json["nextPage"] == null ? null : json["nextPage"],
    currentPage: json["currentPage"] == null ? null : json["currentPage"],
    info: json["info"] == null ? null : json["info"],
    rows: json["rows"] == null ? null : List<WithdrawHistory>.from(json["rows"].map((x) => WithdrawHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total == null ? null : total,
    "totalPage": totalPage == null ? null : totalPage,
    "rowPerPage": rowPerPage == null ? null : rowPerPage,
    "previousPage": previousPage == null ? null : previousPage,
    "nextPage": nextPage == null ? null : nextPage,
    "currentPage": currentPage == null ? null : currentPage,
    "info": info == null ? null : info,
    "rows": rows == null ? null : List<dynamic>.from(rows.map((x) => x.toJson())),
  };
}

class WithdrawHistory {
  WithdrawHistory({
    this.withdrawId,
    this.userId,
    this.bank,
    this.accountNumber,
    this.accountName,
    this.adminFee,
    this.remark,
    this.amount,
    this.proof,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.bankDetail,
  });

  String withdrawId;
  String userId;
  String bank;
  String accountNumber;
  String accountName;
  int adminFee;
  String remark;
  int amount;
  String proof;
  int status;
  int createdAt;
  int updatedAt;
  BankDetail bankDetail;

  factory WithdrawHistory.fromJson(Map<String, dynamic> json) => WithdrawHistory(
    withdrawId: json["withdraw_id"] == null ? null : json["withdraw_id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    bank: json["bank"] == null ? null : json["bank"],
    accountNumber: json["account_number"] == null ? null : json["account_number"],
    accountName: json["account_name"] == null ? null : json["account_name"],
    adminFee: json["admin_fee"] == null ? null : json["admin_fee"],
    remark: json["remark"] == null ? null : json["remark"],
    amount: json["amount"] == null ? null : json["amount"],
    proof: json["proof"] == null ? null : json["proof"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    bankDetail: json["bank_detail"] == null ? null : BankDetail.fromJson(json["bank_detail"]),
  );

  Map<String, dynamic> toJson() => {
    "withdraw_id": withdrawId == null ? null : withdrawId,
    "user_id": userId == null ? null : userId,
    "bank": bank == null ? null : bank,
    "account_number": accountNumber == null ? null : accountNumber,
    "account_name": accountName == null ? null : accountName,
    "admin_fee": adminFee == null ? null : adminFee,
    "remark": remark == null ? null : remark,
    "amount": amount == null ? null : amount,
    "proof": proof == null ? null : proof,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "bank_detail": bankDetail == null ? null : bankDetail.toJson(),
  };
}
