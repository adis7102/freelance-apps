
import 'dart:convert';

GetWalletResponse getWalletResponseFromJson(String str) => GetWalletResponse.fromJson(json.decode(str));

String getWalletResponseToJson(GetWalletResponse data) => json.encode(data.toJson());

class GetWalletResponse {
  GetWalletResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  Wallet payload;

  factory GetWalletResponse.fromJson(Map<String, dynamic> json) => GetWalletResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : Wallet.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}

class Wallet {
  Wallet({
    this.userId,
    this.amount,
    this.createdAt,
    this.updatedAt,
  });

  String userId;
  int amount;
  int createdAt;
  int updatedAt;

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
    userId: json["user_id"] == null ? null : json["user_id"],
    amount: json["amount"] == null ? null : json["amount"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId == null ? null : userId,
    "amount": amount == null ? null : amount,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
  };
}


WalletHistoryResponse walletHistoryResponseFromJson(String str) => WalletHistoryResponse.fromJson(json.decode(str));

String walletHistoryResponseToJson(WalletHistoryResponse data) => json.encode(data.toJson());

class WalletHistoryResponse {
  WalletHistoryResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  HistoryWallet payload;

  factory WalletHistoryResponse.fromJson(Map<String, dynamic> json) => WalletHistoryResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : HistoryWallet.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}

class HistoryWallet {
  HistoryWallet({
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
  List<WalletData> rows;

  factory HistoryWallet.fromJson(Map<String, dynamic> json) => HistoryWallet(
    total: json["total"] == null ? null : json["total"],
    totalPage: json["totalPage"] == null ? null : json["totalPage"],
    rowPerPage: json["rowPerPage"] == null ? null : json["rowPerPage"],
    previousPage: json["previousPage"] == null ? null : json["previousPage"],
    nextPage: json["nextPage"] == null ? null : json["nextPage"],
    currentPage: json["currentPage"] == null ? null : json["currentPage"],
    info: json["info"] == null ? null : json["info"],
    rows: json["rows"] == null ? null : List<WalletData>.from(json["rows"].map((x) => WalletData.fromJson(x))),
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

class WalletData {
  WalletData({
    this.logId,
    this.userId,
    this.proofId,
    this.amount,
    this.remark,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.notes,
    this.deduction,
  });

  String logId;
  String userId;
  String proofId;
  int amount;
  String remark;
  String type;
  int createdAt;
  int updatedAt;
  String notes;
  int deduction;

  factory WalletData.fromJson(Map<String, dynamic> json) => WalletData(
    logId: json["log_id"] == null ? null : json["log_id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    proofId: json["proof_id"] == null ? null : json["proof_id"],
    amount: json["amount"] == null ? null : json["amount"],
    remark: json["remark"] == null ? null : json["remark"],
    type: json["type"] == null ? null : json["type"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    notes: json["notes"] == null ? null : json["notes"],
    deduction: json["deduction"] == null ? null : json["deduction"],
  );

  Map<String, dynamic> toJson() => {
    "log_id": logId == null ? null : logId,
    "user_id": userId == null ? null : userId,
    "proof_id": proofId == null ? null : proofId,
    "amount": amount == null ? null : amount,
    "remark": remark == null ? null : remark,
    "type": type == null ? null : type,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "notes": notes == null ? null : notes,
    "deduction": deduction == null ? null : deduction,
  };
}
