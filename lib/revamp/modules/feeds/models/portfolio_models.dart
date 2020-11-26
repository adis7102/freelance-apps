
import 'dart:convert';

import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';
import 'package:soedja_freelance/revamp/modules/profile/models/profile_models.dart';

PortfolioListResponse portfolioListResponseFromJson(String str) => PortfolioListResponse.fromJson(json.decode(str));

String portfolioListResponseToJson(PortfolioListResponse data) => json.encode(data.toJson());

class PortfolioListResponse {
  PortfolioListResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  ListPortfolioPayload payload;

  factory PortfolioListResponse.fromJson(Map<String, dynamic> json) => PortfolioListResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : ListPortfolioPayload.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}

class ListPortfolioPayload {
  ListPortfolioPayload({
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
  List<Feed> rows;

  factory ListPortfolioPayload.fromJson(Map<String, dynamic> json) => ListPortfolioPayload(
    total: json["total"] == null ? null : json["total"],
    totalPage: json["totalPage"] == null ? null : json["totalPage"],
    rowPerPage: json["rowPerPage"] == null ? null : json["rowPerPage"],
    previousPage: json["previousPage"] == null ? null : json["previousPage"],
    nextPage: json["nextPage"] == null ? null : json["nextPage"],
    currentPage: json["currentPage"] == null ? null : json["currentPage"],
    info: json["info"] == null ? null : json["info"],
    rows: json["rows"] == null ? null : List<Feed>.from(json["rows"].map((x) => Feed.fromJson(x))),
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


UpdateViewerResponse updateViewerResponseFromJson(String str) => UpdateViewerResponse.fromJson(json.decode(str));

String updateViewerResponseToJson(UpdateViewerResponse data) => json.encode(data.toJson());

class UpdateViewerResponse {
  UpdateViewerResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  Feed payload;

  factory UpdateViewerResponse.fromJson(Map<String, dynamic> json) => UpdateViewerResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : Feed.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}

class PortfolioDetailResponse {
  PortfolioDetailResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  Feed payload;

  factory PortfolioDetailResponse.fromJson(Map<String, dynamic> json) => PortfolioDetailResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : Feed.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}


DeletePictureResponse deletePictureResponseFromJson(String str) => DeletePictureResponse.fromJson(json.decode(str));

String deletePictureResponseToJson(DeletePictureResponse data) => json.encode(data.toJson());

class DeletePictureResponse {
  DeletePictureResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  Feed payload;

  factory DeletePictureResponse.fromJson(Map<String, dynamic> json) => DeletePictureResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : Feed.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}