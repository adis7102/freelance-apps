
import 'dart:convert';

import 'package:soedja_freelance/revamp/modules/profile/models/profile_models.dart';

FeedLikeListResponse feedLikeListResponseFromJson(String str) => FeedLikeListResponse.fromJson(json.decode(str));

String feedLikeListResponseToJson(FeedLikeListResponse data) => json.encode(data.toJson());

class FeedLikeListResponse {
  FeedLikeListResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  LikePayload payload;

  factory FeedLikeListResponse.fromJson(Map<String, dynamic> json) => FeedLikeListResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : LikePayload.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}

class LikePayload {
  LikePayload({
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
  List<LikeDetail> rows;

  factory LikePayload.fromJson(Map<String, dynamic> json) => LikePayload(
    total: json["total"] == null ? null : json["total"],
    totalPage: json["totalPage"] == null ? null : json["totalPage"],
    rowPerPage: json["rowPerPage"] == null ? null : json["rowPerPage"],
    previousPage: json["previousPage"] == null ? null : json["previousPage"],
    nextPage: json["nextPage"] == null ? null : json["nextPage"],
    currentPage: json["currentPage"] == null ? null : json["currentPage"],
    info: json["info"] == null ? null : json["info"],
    rows: json["rows"] == null ? null : List<LikeDetail>.from(json["rows"].map((x) => LikeDetail.fromJson(x))),
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

class LikeDetail {
  LikeDetail({
    this.likeId,
    this.contentId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.userData,
  });

  String likeId;
  String contentId;
  String userId;
  int createdAt;
  int updatedAt;
  ProfileDetail userData;

  factory LikeDetail.fromJson(Map<String, dynamic> json) => LikeDetail(
    likeId: json["like_id"] == null ? null : json["like_id"],
    contentId: json["content_id"] == null ? null : json["content_id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    userData: json["user_data"] == null ? null : ProfileDetail.fromJson(json["user_data"]),
  );

  Map<String, dynamic> toJson() => {
    "like_id": likeId == null ? null : likeId,
    "content_id": contentId == null ? null : contentId,
    "user_id": userId == null ? null : userId,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "user_data": userData == null ? null : userData.toJson(),
  };
}


class CreateLikeResponse {
  CreateLikeResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  LikeDetail payload;

  factory CreateLikeResponse.fromJson(Map<String, dynamic> json) => CreateLikeResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : LikeDetail.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}