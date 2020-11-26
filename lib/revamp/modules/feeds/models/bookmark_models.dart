
import 'dart:convert';

import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';
import 'package:soedja_freelance/revamp/modules/profile/models/profile_models.dart';

CreateBookmarkResponse createBookmarkResponseFromJson(String str) => CreateBookmarkResponse.fromJson(json.decode(str));

String createBookmarkResponseToJson(CreateBookmarkResponse data) => json.encode(data.toJson());

class CreateBookmarkResponse {
  CreateBookmarkResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  Bookmark payload;

  factory CreateBookmarkResponse.fromJson(Map<String, dynamic> json) => CreateBookmarkResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : Bookmark.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}

BookmarkListResponse bookmarkListResponseFromJson(String str) => BookmarkListResponse.fromJson(json.decode(str));

String bookmarkListResponseToJson(BookmarkListResponse data) => json.encode(data.toJson());

class BookmarkListResponse {
  BookmarkListResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  BookmarkPayload payload;

  factory BookmarkListResponse.fromJson(Map<String, dynamic> json) => BookmarkListResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : BookmarkPayload.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}

class BookmarkPayload {
  BookmarkPayload({
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
  List<Bookmark> rows;

  factory BookmarkPayload.fromJson(Map<String, dynamic> json) => BookmarkPayload(
    total: json["total"] == null ? null : json["total"],
    totalPage: json["totalPage"] == null ? null : json["totalPage"],
    rowPerPage: json["rowPerPage"] == null ? null : json["rowPerPage"],
    previousPage: json["previousPage"] == null ? null : json["previousPage"],
    nextPage: json["nextPage"] == null ? null : json["nextPage"],
    currentPage: json["currentPage"] == null ? null : json["currentPage"],
    info: json["info"] == null ? null : json["info"],
    rows: json["rows"] == null ? null : List<Bookmark>.from(json["rows"].map((x) => Bookmark.fromJson(x))),
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

class Bookmark {
  Bookmark({
    this.bookmarkId,
    this.userId,
    this.portfolioId,
    this.createdAt,
    this.updatedAt,
    this.userDetail,
    this.portfolioDetail,
  });

  String bookmarkId;
  String userId;
  String portfolioId;
  int createdAt;
  int updatedAt;
  ProfileDetail userDetail;
  Feed portfolioDetail;

  factory Bookmark.fromJson(Map<String, dynamic> json) => Bookmark(
    bookmarkId: json["bookmark_id"] == null ? null : json["bookmark_id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    portfolioId: json["portfolio_id"] == null ? null : json["portfolio_id"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    userDetail: json["user_detail"] == null ? null : ProfileDetail.fromJson(json["user_detail"]),
    portfolioDetail: json["portfolio_detail"] == null ? null : Feed.fromJson(json["portfolio_detail"]),
  );

  Map<String, dynamic> toJson() => {
    "bookmark_id": bookmarkId == null ? null : bookmarkId,
    "user_id": userId == null ? null : userId,
    "portfolio_id": portfolioId == null ? null : portfolioId,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "user_detail": userDetail == null ? null : userDetail.toJson(),
    "portfolio_detail": portfolioDetail == null ? null : portfolioDetail.toJson(),
  };
}
