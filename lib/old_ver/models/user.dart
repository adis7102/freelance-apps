import 'dart:convert';

import 'package:soedja_freelance/old_ver/models/feeds.dart';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
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
  List<Portpolio> portpolios;
  List<Experience> experiences;
  String error;

  Profile({
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
    this.portpolios,
    this.experiences,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
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
        interests: json["interests"] == null
            ? null
            : List<String>.from(json["interests"].map((x) => x)),
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        portpolios: json["portpolios"] == null
            ? null
            : List<Portpolio>.from(
                json["portpolios"].map((x) => Portpolio.fromJson(x))),
        experiences: json["experiences"] == null
            ? null
            : List<Experience>.from(
                json["experiences"].map((x) => Experience.fromJson(x))),
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
        "interests": interests == null
            ? null
            : List<dynamic>.from(interests.map((x) => x)),
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "portpolios": portpolios == null
            ? null
            : List<dynamic>.from(portpolios.map((x) => x.toJson())),
        "experiences": experiences == null
            ? null
            : List<dynamic>.from(experiences.map((x) => x.toJson())),
      };

  Profile.withError(this.error);
}

class Experience {
  String experienceId;
  String userId;
  String company;
  String position;
  String startDate;
  String endDate;
  String province;
  String regency;
  int tillNow;
  String picture;
  int createdAt;
  int updatedAt;

  Experience({
    this.experienceId,
    this.userId,
    this.company,
    this.position,
    this.startDate,
    this.endDate,
    this.province,
    this.regency,
    this.tillNow,
    this.picture,
    this.createdAt,
    this.updatedAt,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        experienceId: json["experience_id"],
        userId: json["user_id"],
        company: json["company"],
        position: json["position"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        province: json["province"],
        regency: json["regency"],
        tillNow: json["till_now"],
        picture: json["picture"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "experience_id": experienceId,
        "user_id": userId,
        "company": company,
        "position": position,
        "start_date": startDate,
        "end_date": endDate,
        "province": province,
        "regency": regency,
        "till_now": tillNow,
        "picture": picture,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Portpolio {
  Portpolio({
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

  factory Portpolio.fromJson(Map<String, dynamic> json) => Portpolio(
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
        "pictures": pictures == null
            ? null
            : List<dynamic>.from(pictures.map((x) => x.toJson())),
        "youtube_url": youtubeUrl == null ? null : youtubeUrl,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
      };
}

class JwtData {
  String userId;
  String email;

  JwtData({this.userId, this.email});

  factory JwtData.fromJson(Map<String, dynamic> json) => JwtData(
        userId: json["user_id"],
        email: json["email"],
      );

  // object to json
  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "email": email,
    };
  }
}

class Profession {
  int id;
  String profession;

  Profession({
    this.id,
    this.profession,
  });

  Profession.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        profession = json['profession'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'profession': profession,
      };
}

class UpdateProfilePayload {
  String email;
  String phone;
  String name;
  String address;
  String province;
  String regency;
  String district;
  String village;
  String profession;
  String about;
  String skills;

  UpdateProfilePayload({
    this.email,
    this.phone,
    this.name,
    this.address,
    this.province,
    this.regency,
    this.district,
    this.village,
    this.profession,
    this.about,
    this.skills,
  });

  UpdateProfilePayload.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        phone = json['phone'],
        name = json['name'],
        address = json['address'],
        province = json['province'],
        regency = json['regency'],
        district = json['district'],
        village = json['village'],
        profession = json['profession'],
        about = json['about'],
        skills = json['skills'];

  Map<String, dynamic> toJson() => {
        'email': email,
        'phone': phone,
        'name': name,
        'address': address,
        'province': province,
        'regency': regency,
        'district': district,
        'village': village,
        'profession': profession,
        'about': about,
        'skills': skills,
      };
}

class FollowData {
  int follower;
  int following;

  FollowData({
    this.follower,
    this.following,
  });

  FollowData.fromJson(Map<String, dynamic> json)
      : follower = json['follower'],
        following = json['following'];

  Map<String, dynamic> toJson() => {
        'follower': follower,
        'following': following,
      };
}
