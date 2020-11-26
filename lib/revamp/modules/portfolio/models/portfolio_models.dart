// To parse this JSON data, do
//
//     final createPortfolioResponse = createPortfolioResponseFromJson(jsonString);

import 'dart:convert';

import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';

PortfolioPayload portfolioPayloadFromJson(String str) =>
    PortfolioPayload.fromJson(json.decode(str));

String portfolioPayloadToJson(PortfolioPayload data) =>
    json.encode(data.toJson());

class PortfolioPayload {
  PortfolioPayload({
    this.title,
    this.description,
    this.category,
    this.subCategory,
    this.typeCategory,
    this.amount,
    this.duration,
    this.youtubeUrl,
  });

  String title;
  String description;
  String category;
  String subCategory;
  String typeCategory;
  int amount;
  int duration;
  String youtubeUrl;

  factory PortfolioPayload.fromJson(Map<String, dynamic> json) =>
      PortfolioPayload(
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        category: json["category"] == null ? null : json["category"],
        subCategory: json["sub_category"] == null ? null : json["sub_category"],
        typeCategory:
            json["type_category"] == null ? null : json["type_category"],
        amount: json["amount"] == null ? null : json["amount"],
        duration: json["duration"] == null ? null : json["duration"],
        youtubeUrl: json["youtube_url"] == null ? null : json["youtube_url"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "category": category == null ? null : category,
        "sub_category": subCategory == null ? null : subCategory,
        "type_category": typeCategory == null ? null : typeCategory,
        "amount": amount == null ? null : amount,
        "duration": duration == null ? null : duration,
        "youtube_url": youtubeUrl == null ? null : youtubeUrl,
      };
}

CreatePortfolioResponse createPortfolioResponseFromJson(String str) =>
    CreatePortfolioResponse.fromJson(json.decode(str));

String createPortfolioResponseToJson(CreatePortfolioResponse data) =>
    json.encode(data.toJson());

class CreatePortfolioResponse {
  CreatePortfolioResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  Portfolio payload;

  factory CreatePortfolioResponse.fromJson(Map<String, dynamic> json) =>
      CreatePortfolioResponse(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        payload: json["payload"] == null
            ? null
            : Portfolio.fromJson(json["payload"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "payload": payload == null ? null : payload.toJson(),
      };
}

class Portfolio {
  Portfolio({
    this.portfolioId,
    this.userId,
    this.title,
    this.description,
    this.category,
    this.subCategory,
    this.typeCategory,
    this.amount,
    this.pictures,
    this.youtubeUrl,
    this.createdAt,
    this.updatedAt,
  });

  String portfolioId;
  String userId;
  String title;
  String description;
  String category;
  String subCategory;
  String typeCategory;
  int amount;
  List<Picture> pictures;
  String youtubeUrl;
  int createdAt;
  int updatedAt;

  factory Portfolio.fromJson(Map<String, dynamic> json) => Portfolio(
    portfolioId: json["portfolio_id"] == null ? null : json["portfolio_id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    category: json["category"] == null ? null : json["category"],
    subCategory: json["sub_category"] == null ? null : json["sub_category"],
    typeCategory: json["type_category"] == null ? null : json["type_category"],
    amount: json["amount"] == null ? null : json["amount"],
    pictures: json["pictures"] == null ? null : List<Picture>.from(json["pictures"].map((x) => Picture.fromJson(x))),
    youtubeUrl: json["youtube_url"] == null ? null : json["youtube_url"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "portfolio_id": portfolioId == null ? null : portfolioId,
    "user_id": userId == null ? null : userId,
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "category": category == null ? null : category,
    "sub_category": subCategory == null ? null : subCategory,
    "type_category": typeCategory == null ? null : typeCategory,
    "amount": amount == null ? null : amount,
    "pictures": pictures == null ? null : List<dynamic>.from(pictures.map((x) => x.toJson())),
    "youtube_url": youtubeUrl == null ? null : youtubeUrl,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
  };
}


UploadPortfolioResponse uploadPortfolioResponseFromJson(String str) => UploadPortfolioResponse.fromJson(json.decode(str));

String uploadPortfolioResponseToJson(UploadPortfolioResponse data) => json.encode(data.toJson());

class UploadPortfolioResponse {
  UploadPortfolioResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  Portfolio payload;

  factory UploadPortfolioResponse.fromJson(Map<String, dynamic> json) => UploadPortfolioResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : Portfolio.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}
