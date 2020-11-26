// To parse this JSON data, do
//
//     final portfolioCommentResponse = portfolioCommentResponseFromJson(jsonString);

import 'dart:convert';

import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';
import 'package:soedja_freelance/revamp/modules/profile/models/profile_models.dart';

PortfolioCommentResponse portfolioCommentResponseFromJson(String str) => PortfolioCommentResponse.fromJson(json.decode(str));

String portfolioCommentResponseToJson(PortfolioCommentResponse data) => json.encode(data.toJson());

class PortfolioCommentResponse {
  PortfolioCommentResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  CommentPayload payload;

  factory PortfolioCommentResponse.fromJson(Map<String, dynamic> json) => PortfolioCommentResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : CommentPayload.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}

class CommentPayload {
  CommentPayload({
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
  List<Comment> rows;

  factory CommentPayload.fromJson(Map<String, dynamic> json) => CommentPayload(
    total: json["total"] == null ? null : json["total"],
    totalPage: json["totalPage"] == null ? null : json["totalPage"],
    rowPerPage: json["rowPerPage"] == null ? null : json["rowPerPage"],
    previousPage: json["previousPage"] == null ? null : json["previousPage"],
    nextPage: json["nextPage"] == null ? null : json["nextPage"],
    currentPage: json["currentPage"] == null ? null : json["currentPage"],
    info: json["info"] == null ? null : json["info"],
    rows: json["rows"] == null ? null : List<Comment>.from(json["rows"].map((x) => Comment.fromJson(x))),
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

class Comment {
  Comment({
    this.commentId,
    this.parentId,
    this.userId,
    this.comment,
    this.isSawer,
    this.amount,
    this.createdAt,
    this.updatedAt,
    this.userData,
  });

  String commentId;
  String parentId;
  String userId;
  String comment;
  int isSawer;
  int amount;
  int createdAt;
  int updatedAt;
  ProfileDetail userData;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    commentId: json["comment_id"] == null ? null : json["comment_id"],
    parentId: json["parent_id"] == null ? null : json["parent_id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    comment: json["comment"] == null ? null : json["comment"],
    isSawer: json["is_sawer"] == null ? null : json["is_sawer"],
    amount: json["amount"] == null ? null : json["amount"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    userData: json["user_data"] == null ? null : ProfileDetail.fromJson(json["user_data"]),
  );

  Map<String, dynamic> toJson() => {
    "comment_id": commentId == null ? null : commentId,
    "parent_id": parentId == null ? null : parentId,
    "user_id": userId == null ? null : userId,
    "comment": comment == null ? null : comment,
    "is_sawer": isSawer == null ? null : isSawer,
    "amount": amount == null ? null : amount,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "user_data": userData == null ? null : userData.toJson(),
  };
}


class CommentListPayload {
  CommentListPayload({
    this.title,
    this.isSawer,
    this.limit,
    this.page,
  });

  String title;
  String isSawer;
  String limit;
  String page;

  factory CommentListPayload.fromJson(Map<String, dynamic> json) => CommentListPayload(
    title: json["title"] == null ? null : json["title"],
    isSawer: json["is_sawer"] == null ? null : json["is_sawer"],
    limit: json["limit"] == null ? null : json["limit"],
    page: json["page"] == null ? null : json["page"],
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title,
    "is_sawer": isSawer == null ? null : isSawer,
    "limit": limit == null ? null : limit,
    "page": page == null ? null : page,
  };
}

CommentPayload commentPayloadFromJson(String str) => CommentPayload.fromJson(json.decode(str));

String commentPayloadToJson(CommentPayload data) => json.encode(data.toJson());

class GiveCommentPayload {
  GiveCommentPayload({
    this.parentId,
    this.comment,
  });

  String parentId;
  String comment;

  factory GiveCommentPayload.fromJson(Map<String, dynamic> json) => GiveCommentPayload(
    parentId: json["parent_id"] == null ? null : json["parent_id"],
    comment: json["comment"] == null ? null : json["comment"],
  );

  Map<String, dynamic> toJson() => {
    "parent_id": parentId == null ? null : parentId,
    "comment": comment == null ? null : comment,
  };
}


GiveCommentResponse giveCommentResponseFromJson(String str) => GiveCommentResponse.fromJson(json.decode(str));

String giveCommentResponseToJson(GiveCommentResponse data) => json.encode(data.toJson());

class GiveCommentResponse {
  GiveCommentResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  Comment payload;

  factory GiveCommentResponse.fromJson(Map<String, dynamic> json) => GiveCommentResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : Comment.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}


TotalSawerResponse totalSawerResponseFromJson(String str) => TotalSawerResponse.fromJson(json.decode(str));

String totalSawerResponseToJson(TotalSawerResponse data) => json.encode(data.toJson());

class TotalSawerResponse {
  TotalSawerResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  TotalSawerPayload payload;

  factory TotalSawerResponse.fromJson(Map<String, dynamic> json) => TotalSawerResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : TotalSawerPayload.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}

class TotalSawerPayload {
  TotalSawerPayload({
    this.total,
  });

  int total;

  factory TotalSawerPayload.fromJson(Map<String, dynamic> json) => TotalSawerPayload(
    total: json["total"] == null ? null : json["total"],
  );

  Map<String, dynamic> toJson() => {
    "total": total == null ? null : total,
  };
}
