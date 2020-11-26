import 'dart:convert';

import 'package:soedja_freelance/old_ver/models/feeds.dart';

Portfolio portfolioFromJson(String str) => Portfolio.fromJson(json.decode(str));

String portfolioToJson(Portfolio data) => json.encode(data.toJson());

class Portfolio {
  List<Picture> pictures;
  int createdAt;
  int updatedAt;
  String portfolioId;
  String title;
  String description;
  String category;
  String subCategory;
  String typeCategory;
  int amount;
  String youtubeUrl;
  String userId;
  String error;

  Portfolio({
    this.pictures,
    this.createdAt,
    this.updatedAt,
    this.portfolioId,
    this.title,
    this.description,
    this.category,
    this.subCategory,
    this.typeCategory,
    this.amount,
    this.youtubeUrl,
    this.userId,
  });

  factory Portfolio.fromJson(Map<String, dynamic> json) => Portfolio(
        pictures: List<Picture>.from(
            json["pictures"].map((x) => Picture.fromJson(x))),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        portfolioId: json["portfolio_id"],
        title: json["title"],
        description: json["description"],
        category: json["category"],
        subCategory: json["sub_category"],
        typeCategory: json["type_category"],
        amount: json["amount"],
        youtubeUrl: json["youtube_url"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "pictures": List<dynamic>.from(pictures.map((x) => x.toJson())),
        "created_at": createdAt,
        "updated_at": updatedAt,
        "portfolio_id": portfolioId,
        "title": title,
        "description": description,
        "category": category,
        "sub_category": subCategory,
        "type_category": typeCategory,
        "amount": amount,
        "youtube_url": youtubeUrl,
        "user_id": userId,
      };

  Portfolio.withError(this.error);
}

class PortfolioPayload {
  String title;
  String description;
  String category;
  String subCategory;
  String typeCategory;
  int amount;
  String youtubeUrl;

  PortfolioPayload({
    this.title,
    this.description,
    this.category,
    this.subCategory,
    this.typeCategory,
    this.amount,
    this.youtubeUrl,
  });

  factory PortfolioPayload.fromJson(Map<String, dynamic> json) =>
      PortfolioPayload(
        title: json["title"],
        description: json["description"],
        category: json["category"],
        subCategory: json["sub_category"],
        typeCategory: json["type_category"],
        amount: json["amount"],
        youtubeUrl: json["youtube_url"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "category": category,
        "sub_category": subCategory,
        "type_category": typeCategory,
        "amount": amount,
        "youtube_url": youtubeUrl,
      };
}

class PortfolioListPayload {
  int limit;
  int page;
  String title;

  PortfolioListPayload({
    this.limit,
    this.page,
    this.title,
  });

  // object to json
  Map<String, dynamic> toJson() {
    return {
      "limit": limit,
      "page": page,
      "title": title,
    };
  }
}
