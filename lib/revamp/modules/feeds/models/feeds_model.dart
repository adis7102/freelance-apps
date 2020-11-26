// To parse this JSON data, do
//
//     final feedsListResponse = feedsListResponseFromJson(jsonString);

import 'dart:convert';

import 'package:soedja_freelance/revamp/modules/profile/models/profile_models.dart';

FeedsListResponse feedsListResponseFromJson(String str) =>
    FeedsListResponse.fromJson(json.decode(str));

String feedsListResponseToJson(FeedsListResponse data) =>
    json.encode(data.toJson());

class FeedsListResponse {
  FeedsListResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  Payload payload;

  factory FeedsListResponse.fromJson(Map<String, dynamic> json) =>
      FeedsListResponse(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        payload:
            json["payload"] == null ? null : Payload.fromJson(json["payload"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "payload": payload == null ? null : payload.toJson(),
      };
}

class Payload {
  Payload({
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

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        total: json["total"] == null ? null : json["total"],
        totalPage: json["totalPage"] == null ? null : json["totalPage"],
        rowPerPage: json["rowPerPage"] == null ? null : json["rowPerPage"],
        previousPage:
            json["previousPage"] == null ? null : json["previousPage"],
        nextPage: json["nextPage"] == null ? null : json["nextPage"],
        currentPage: json["currentPage"] == null ? null : json["currentPage"],
        info: json["info"] == null ? null : json["info"],
        rows: json["rows"] == null
            ? null
            : List<Feed>.from(json["rows"].map((x) => Feed.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total == null ? null : total,
        "totalPage": totalPage == null ? null : totalPage,
        "rowPerPage": rowPerPage == null ? null : rowPerPage,
        "previousPage": previousPage == null ? null : previousPage,
        "nextPage": nextPage == null ? null : nextPage,
        "currentPage": currentPage == null ? null : currentPage,
        "info": info == null ? null : info,
        "rows": rows == null
            ? null
            : List<dynamic>.from(rows.map((x) => x.toJson())),
      };
}

class Feed {
  Feed({
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
    this.duration,
    this.viewer,
    this.commentCount,
    this.likeCount,
    this.hasLike,
    this.hasComment,
    this.hasBookmark,
    this.bookmarkId,
    this.createdAt,
    this.updatedAt,
    this.userData,
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
  int duration;
  int viewer;
  int commentCount;
  int likeCount;
  int hasLike;
  int hasComment;
  int hasBookmark;
  String bookmarkId;
  int createdAt;
  int updatedAt;
  ProfileDetail userData;

  factory Feed.fromJson(Map<String, dynamic> json) => Feed(
        portfolioId: json["portfolio_id"] == null ? null : json["portfolio_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        category: json["category"] == null ? null : json["category"],
        subCategory: json["sub_category"] == null ? null : json["sub_category"],
        typeCategory:
            json["type_category"] == null ? null : json["type_category"],
        amount: json["amount"] == null ? null : json["amount"],
        pictures: json["pictures"] == null
            ? null
            : List<Picture>.from(
                json["pictures"].map((x) => Picture.fromJson(x))),
        youtubeUrl: json["youtube_url"] == null ? null : json["youtube_url"],
        duration: json["duration"] == null ? null : json["duration"],
        viewer: json["viewer"] == null ? null : json["viewer"],
        commentCount:
            json["comment_count"] == null ? null : json["comment_count"],
        likeCount: json["like_count"] == null ? null : json["like_count"],
        hasLike: json["has_like"] == null ? null : json["has_like"],
        hasComment: json["has_comment"] == null ? null : json["has_comment"],
        hasBookmark: json["has_bookmark"] == null ? null : json["has_bookmark"],
        bookmarkId: json["bookmark_id"] == null ? null : json["bookmark_id"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        userData: json["user_data"] == null
            ? null
            : ProfileDetail.fromJson(json["user_data"]),
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
        "pictures": pictures == null
            ? null
            : List<dynamic>.from(pictures.map((x) => x.toJson())),
        "youtube_url": youtubeUrl == null ? null : youtubeUrl,
        "duration": duration == null ? null : duration,
        "viewer": viewer == null ? null : viewer,
        "comment_count": commentCount == null ? null : commentCount,
        "like_count": likeCount == null ? null : likeCount,
        "has_like": hasLike == null ? null : hasLike,
        "has_comment": hasComment == null ? null : hasComment,
        "has_bookmark": hasBookmark == null ? null : hasBookmark,
        "bookmark_id": bookmarkId == null ? null : bookmarkId,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "user_data": userData == null ? null : userData.toJson(),
      };
}

class Picture {
  Picture({
    this.id,
    this.path,
  });

  String id;
  String path;

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
        id: json["id"] == null ? null : json["id"],
        path: json["path"] == null ? null : json["path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "path": path == null ? null : path,
      };
}
//
//class UserData {
//  UserData({
//    this.userId,
//    this.email,
//    this.phone,
//    this.type,
//    this.name,
//    this.address,
//    this.province,
//    this.regency,
//    this.district,
//    this.village,
//    this.profession,
//    this.about,
//    this.skills,
//    this.picture,
//    this.rating,
//    this.autoBid,
//    this.autoBidConfig,
//    this.interests,
//    this.createdAt,
//    this.updatedAt,
//  });
//
//  String userId;
//  String email;
//  String phone;
//  String type;
//  String name;
//  String address;
//  String province;
//  String regency;
//  String district;
//  String village;
//  String profession;
//  String about;
//  String skills;
//  String picture;
//  int rating;
//  int autoBid;
//  dynamic autoBidConfig;
//  List<String> interests;
//  int createdAt;
//  int updatedAt;
//
//  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
//    userId: json["user_id"] == null ? null : json["user_id"],
//    email: json["email"] == null ? null : json["email"],
//    phone: json["phone"] == null ? null : json["phone"],
//    type: json["type"] == null ? null : json["type"],
//    name: json["name"] == null ? null : json["name"],
//    address: json["address"] == null ? null : json["address"],
//    province: json["province"] == null ? null :json["province"],
//    regency: json["regency"] == null ? null : json["regency"],
//    district: json["district"] == null ? null : json["district"],
//    village: json["village"] == null ? null : json["village"],
//    profession: json["profession"] == null ? null : json["profession"],
//    about: json["about"] == null ? null : json["about"],
//    skills: json["skills"] == null ? null : json["skills"],
//    picture: json["picture"] == null ? null : json["picture"],
//    rating: json["rating"] == null ? null : json["rating"],
//    autoBid: json["auto_bid"] == null ? null : json["auto_bid"],
//    autoBidConfig: json["auto_bid_config"],
//    interests: json["interests"] == null ? null : List<String>.from(json["interests"].map((x) => x)),
//    createdAt: json["created_at"] == null ? null : json["created_at"],
//    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
//  );
//
//  Map<String, dynamic> toJson() => {
//    "user_id": userId == null ? null : userId,
//    "email": email == null ? null : email,
//    "phone": phone == null ? null : phone,
//    "type": type == null ? null : type,
//    "name": name == null ? null : name,
//    "address": address == null ? null : address,
//    "province": province == null ? null : province,
//    "regency": regency == null ? null : regency,
//    "district": district == null ? null : district,
//    "village": village == null ? null : village,
//    "profession": profession == null ? null : profession,
//    "about": about == null ? null : about,
//    "skills": skills == null ? null : skills,
//    "picture": picture == null ? null : picture,
//    "rating": rating == null ? null : rating,
//    "auto_bid": autoBid == null ? null : autoBid,
//    "auto_bid_config": autoBidConfig,
//    "interests": interests == null ? null : List<dynamic>.from(interests.map((x) => x)),
//    "created_at": createdAt == null ? null : createdAt,
//    "updated_at": updatedAt == null ? null : updatedAt,
//  };
//}

FeedListPayload feedListPayloadFromJson(String str) =>
    FeedListPayload.fromJson(json.decode(str));

String feedListPayloadToJson(FeedListPayload data) =>
    json.encode(data.toJson());

class FeedListPayload {
  FeedListPayload({
    this.title,
    this.limit,
    this.page,
    this.isVideo,
  });

  String title;
  String limit;
  String page;
  int isVideo;

  factory FeedListPayload.fromJson(Map<String, dynamic> json) =>
      FeedListPayload(
        title: json["title"] == null ? null : json["title"],
        limit: json["limit"] == null ? null : json["limit"],
        page: json["page"] == null ? null : json["page"],
        isVideo: json["is_video"] == null ? null : json["is_video"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "limit": limit == null ? null : limit,
        "page": page == null ? null : page,
        "is_video": isVideo == null ? null : isVideo,
      };
}

UpdateInterestResponse updateInterestResponseFromJson(String str) =>
    UpdateInterestResponse.fromJson(json.decode(str));

String updateInterestResponseToJson(UpdateInterestResponse data) =>
    json.encode(data.toJson());

class UpdateInterestResponse {
  UpdateInterestResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  PayloadInterest payload;

  factory UpdateInterestResponse.fromJson(Map<String, dynamic> json) =>
      UpdateInterestResponse(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        payload: json["payload"] == null
            ? null
            : PayloadInterest.fromJson(json["payload"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "payload": payload == null ? null : payload.toJson(),
      };
}

class PayloadInterest {
  PayloadInterest({
    this.userId,
    this.email,
    this.phone,
    this.type,
    this.name,
    this.address,
    this.province,
    this.regency,
    this.district,
    this.village,
    this.profession,
    this.about,
    this.skills,
    this.picture,
    this.rating,
    this.autoBid,
    this.autoBidConfig,
    this.interests,
    this.createdAt,
    this.updatedAt,
  });

  String userId;
  String email;
  String phone;
  String type;
  String name;
  String address;
  String province;
  String regency;
  String district;
  String village;
  String profession;
  String about;
  String skills;
  String picture;
  int rating;
  int autoBid;
  dynamic autoBidConfig;
  List<String> interests;
  int createdAt;
  int updatedAt;

  factory PayloadInterest.fromJson(Map<String, dynamic> json) =>
      PayloadInterest(
        userId: json["user_id"] == null ? null : json["user_id"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        type: json["type"] == null ? null : json["type"],
        name: json["name"] == null ? null : json["name"],
        address: json["address"] == null ? null : json["address"],
        province: json["province"] == null ? null : json["province"],
        regency: json["regency"] == null ? null : json["regency"],
        district: json["district"] == null ? null : json["district"],
        village: json["village"] == null ? null : json["village"],
        profession: json["profession"] == null ? null : json["profession"],
        about: json["about"] == null ? null : json["about"],
        skills: json["skills"] == null ? null : json["skills"],
        picture: json["picture"] == null ? null : json["picture"],
        rating: json["rating"] == null ? null : json["rating"],
        autoBid: json["auto_bid"] == null ? null : json["auto_bid"],
        autoBidConfig: json["auto_bid_config"],
        interests: json["interests"] == null
            ? null
            : List<String>.from(json["interests"].map((x) => x)),
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "type": type == null ? null : type,
        "name": name == null ? null : name,
        "address": address == null ? null : address,
        "province": province == null ? null : province,
        "regency": regency == null ? null : regency,
        "district": district == null ? null : district,
        "village": village == null ? null : village,
        "profession": profession == null ? null : profession,
        "about": about == null ? null : about,
        "skills": skills == null ? null : skills,
        "picture": picture == null ? null : picture,
        "rating": rating == null ? null : rating,
        "auto_bid": autoBid == null ? null : autoBid,
        "auto_bid_config": autoBidConfig,
        "interests": interests == null
            ? null
            : List<dynamic>.from(interests.map((x) => x)),
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
      };
}
