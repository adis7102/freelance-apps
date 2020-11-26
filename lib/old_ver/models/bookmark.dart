import 'package:soedja_freelance/old_ver/models/feeds.dart';

class Bookmarks {
  String bookmarkId;
  String userId;
  String portfolioId;
  int createdAt;
  int updatedAt;
  UserDetail userDetail;
  PortfolioDetail portfolioDetail;

  Bookmarks({
    this.bookmarkId,
    this.userId,
    this.portfolioId,
    this.createdAt,
    this.updatedAt,
    this.userDetail,
    this.portfolioDetail,
  });

  factory Bookmarks.fromJson(Map<String, dynamic> json) => Bookmarks(
        bookmarkId: json["bookmark_id"],
        userId: json["user_id"],
        portfolioId: json["portfolio_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        userDetail: UserDetail.fromJson(json["user_detail"]),
        portfolioDetail: PortfolioDetail.fromJson(json["portfolio_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "bookmark_id": bookmarkId,
        "user_id": userId,
        "portfolio_id": portfolioId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "user_detail": userDetail.toJson(),
        "portfolio_detail": portfolioDetail.toJson(),
      };
}

class PortfolioDetail {
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

  PortfolioDetail({
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

  factory PortfolioDetail.fromJson(Map<String, dynamic> json) =>
      PortfolioDetail(
        portfolioId: json["portfolio_id"],
        userId: json["user_id"],
        title: json["title"],
        description: json["description"],
        category: json["category"],
        subCategory: json["sub_category"],
        typeCategory: json["type_category"],
        amount: json["amount"],
        pictures: List<Picture>.from(
            json["pictures"].map((x) => Picture.fromJson(x))),
        youtubeUrl: json["youtube_url"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "portfolio_id": portfolioId,
        "user_id": userId,
        "title": title,
        "description": description,
        "category": category,
        "sub_category": subCategory,
        "type_category": typeCategory,
        "amount": amount,
        "pictures": List<dynamic>.from(pictures.map((x) => x.toJson())),
        "youtube_url": youtubeUrl,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class UserDetail {
  UserDetail({
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
  dynamic interests;
  int createdAt;
  int updatedAt;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        userId: json["user_id"],
        email: json["email"],
        phone: json["phone"],
        type: json["type"],
        name: json["name"],
        address: json["address"],
        province: json["province"],
        regency: json["regency"],
        district: json["district"],
        village: json["village"],
        profession: json["profession"],
        about: json["about"],
        skills: json["skills"],
        picture: json["picture"],
        rating: json["rating"],
        autoBid: json["auto_bid"],
        interests: json["interests"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "email": email,
        "phone": phone,
        "type": type,
        "name": name,
        "address": address,
        "province": province,
        "regency": regency,
        "district": district,
        "village": village,
        "profession": profession,
        "about": about,
        "skills": skills,
        "picture": picture,
        "rating": rating,
        "auto_bid": autoBid,
        "interests": interests,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class BookmarksPayload {
  int limit;
  int page;

  BookmarksPayload({
    this.limit,
    this.page,
  });

  // object to json
  Map<String, dynamic> toJson() {
    return {
      "limit": limit,
      "page": page,
    };
  }
}
