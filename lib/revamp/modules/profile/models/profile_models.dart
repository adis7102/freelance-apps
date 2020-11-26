
import 'dart:convert';

import 'package:soedja_freelance/revamp/modules/auth/models/auth_models.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';

ProfileListResponse profileListResponseFromJson(String str) => ProfileListResponse.fromJson(json.decode(str));

String profileListResponseToJson(ProfileListResponse data) => json.encode(data.toJson());

class ProfileListResponse {
  ProfileListResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  ProfileData payload;

  factory ProfileListResponse.fromJson(Map<String, dynamic> json) => ProfileListResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : ProfileData.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}

class ProfileData {
  ProfileData({
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
  List<ProfileDetail> rows;

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
    total: json["total"] == null ? null : json["total"],
    totalPage: json["totalPage"] == null ? null : json["totalPage"],
    rowPerPage: json["rowPerPage"] == null ? null : json["rowPerPage"],
    previousPage: json["previousPage"] == null ? null : json["previousPage"],
    nextPage: json["nextPage"] == null ? null : json["nextPage"],
    currentPage: json["currentPage"] == null ? null : json["currentPage"],
    info: json["info"] == null ? null : json["info"],
    rows: json["rows"] == null ? null : List<ProfileDetail>.from(json["rows"].map((x) => ProfileDetail.fromJson(x))),
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

class ProfileDetailResponse {
  ProfileDetailResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  ProfileDetail payload;

  factory ProfileDetailResponse.fromJson(Map<String, dynamic> json) => ProfileDetailResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : ProfileDetail.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}

class ProfileDetail {
  ProfileDetail({
    this.userId,
    this.name,
    this.email,
    this.phone,
    this.type,
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
    this.hasFollow,
    this.createdAt,
    this.updatedAt,
    this.portpolios,
    this.experiences,
  });

  String userId;
  String name;
  String email;
  String phone;
  String type;
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
  List<String> interests;
  int hasFollow;
  int createdAt;
  int updatedAt;
  List<Feed> portpolios;
  List<dynamic> experiences;

  factory ProfileDetail.fromJson(Map<String, dynamic> json) => ProfileDetail(
    userId: json["user_id"] == null ? null : json["user_id"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    phone: json["phone"] == null ? null : json["phone"],
    type: json["type"] == null ? null : json["type"],
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
    interests: json["interests"] == null ? null : List<String>.from(json["interests"].map((x) => x)),
    hasFollow: json["has_follow"] == null ? null : json["has_follow"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    portpolios: json["portpolios"] == null ? null : List<Feed>.from(json["portpolios"].map((x) => Feed.fromJson(x))),
    experiences: json["experiences"] == null ? null : List<dynamic>.from(json["experiences"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId == null ? null : userId,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "phone": phone == null ? null : phone,
    "type": type == null ? null : type,
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
    "interests": interests == null ? null : List<dynamic>.from(interests.map((x) => x)),
    "has_follow": hasFollow == null ? null : hasFollow,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "portpolios": portpolios == null ? null : List<dynamic>.from(portpolios.map((x) => x.toJson())),
    "experiences": experiences == null ? null : List<dynamic>.from(experiences.map((x) => x)),
  };
}

FollowingListResponse followingListResponseFromJson(String str) => FollowingListResponse.fromJson(json.decode(str));

String followingListResponseToJson(FollowingListResponse data) => json.encode(data.toJson());

class FollowingListResponse {
  FollowingListResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  FollowingPayload payload;

  factory FollowingListResponse.fromJson(Map<String, dynamic> json) => FollowingListResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : FollowingPayload.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}

class FollowingPayload {
  FollowingPayload({
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
  List<FollowingDetail> rows;

  factory FollowingPayload.fromJson(Map<String, dynamic> json) => FollowingPayload(
    total: json["total"] == null ? null : json["total"],
    totalPage: json["totalPage"] == null ? null : json["totalPage"],
    rowPerPage: json["rowPerPage"] == null ? null : json["rowPerPage"],
    previousPage: json["previousPage"] == null ? null : json["previousPage"],
    nextPage: json["nextPage"] == null ? null : json["nextPage"],
    currentPage: json["currentPage"] == null ? null : json["currentPage"],
    info: json["info"] == null ? null : json["info"],
    rows: json["rows"] == null ? null : List<FollowingDetail>.from(json["rows"].map((x) => FollowingDetail.fromJson(x))),
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


FollowerListResponse followerListResponseFromJson(String str) => FollowerListResponse.fromJson(json.decode(str));

String followerListResponseToJson(FollowerListResponse data) => json.encode(data.toJson());

class FollowerListResponse {
  FollowerListResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  FollowerPayload payload;

  factory FollowerListResponse.fromJson(Map<String, dynamic> json) => FollowerListResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : FollowerPayload.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}

class FollowerPayload {
  FollowerPayload({
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
  List<FollowerDetail> rows;

  factory FollowerPayload.fromJson(Map<String, dynamic> json) => FollowerPayload(
    total: json["total"] == null ? null : json["total"],
    totalPage: json["totalPage"] == null ? null : json["totalPage"],
    rowPerPage: json["rowPerPage"] == null ? null : json["rowPerPage"],
    previousPage: json["previousPage"] == null ? null : json["previousPage"],
    nextPage: json["nextPage"] == null ? null : json["nextPage"],
    currentPage: json["currentPage"] == null ? null : json["currentPage"],
    info: json["info"] == null ? null : json["info"],
    rows: json["rows"] == null ? null : List<FollowerDetail>.from(json["rows"].map((x) => FollowerDetail.fromJson(x))),
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

class FollowerDetail {
  FollowerDetail({
    this.id,
    this.followerId,
    this.followingId,
    this.createdAt,
    this.updatedAt,
    this.hasFollow,
    this.followerDetail,
  });

  int id;
  String followerId;
  String followingId;
  int createdAt;
  int updatedAt;
  int hasFollow;
  ProfileDetail followerDetail;

  factory FollowerDetail.fromJson(Map<String, dynamic> json) => FollowerDetail(
    id: json["id"] == null ? null : json["id"],
    followerId: json["follower_id"] == null ? null : json["follower_id"],
    followingId: json["following_id"] == null ? null : json["following_id"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    hasFollow: json["has_follow"] == null ? null : json["has_follow"],
    followerDetail: json["follower_detail"] == null ? null : ProfileDetail.fromJson(json["follower_detail"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "follower_id": followerId == null ? null : followerId,
    "following_id": followingId == null ? null : followingId,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "has_follow": hasFollow == null ? null : hasFollow,
    "follower_detail": followerDetail == null ? null : followerDetail.toJson(),
  };
}


class FollowingDetail {
  FollowingDetail({
    this.id,
    this.followerId,
    this.followingId,
    this.createdAt,
    this.updatedAt,
    this.hasFollow,
    this.followingDetail,
  });

  int id;
  String followerId;
  String followingId;
  int createdAt;
  int updatedAt;
  int hasFollow;
  ProfileDetail followingDetail;

  factory FollowingDetail.fromJson(Map<String, dynamic> json) => FollowingDetail(
    id: json["id"] == null ? null : json["id"],
    followerId: json["follower_id"] == null ? null : json["follower_id"],
    followingId: json["following_id"] == null ? null : json["following_id"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    hasFollow: json["has_follow"] == null ? null : json["has_follow"],
    followingDetail: json["following_detail"] == null ? null : ProfileDetail.fromJson(json["following_detail"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "follower_id": followerId == null ? null : followerId,
    "following_id": followingId == null ? null : followingId,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "has_follow": hasFollow == null ? null : hasFollow,
    "following_detail": followingDetail == null ? null : followingDetail.toJson(),
  };
}


CreateFollowResponse createFollowResponseFromJson(String str) => CreateFollowResponse.fromJson(json.decode(str));

String createFollowResponseToJson(CreateFollowResponse data) => json.encode(data.toJson());

class CreateFollowResponse {
  CreateFollowResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  FollowingDetail payload;

  factory CreateFollowResponse.fromJson(Map<String, dynamic> json) => CreateFollowResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : FollowingDetail.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}

class ProfileFollowResponse {
  ProfileFollowResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  ProfileFollow payload;

  factory ProfileFollowResponse.fromJson(Map<String, dynamic> json) => ProfileFollowResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : ProfileFollow.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}

class ProfileFollow {
  ProfileFollow({
    this.follower,
    this.following,
  });

  int follower;
  int following;

  factory ProfileFollow.fromJson(Map<String, dynamic> json) => ProfileFollow(
    follower: json["follower"] == null ? null : json["follower"],
    following: json["following"] == null ? null : json["following"],
  );

  Map<String, dynamic> toJson() => {
    "follower": follower == null ? null : follower,
    "following": following == null ? null : following,
  };
}

ProfessionListResponse professionListResponseFromJson(String str) => ProfessionListResponse.fromJson(json.decode(str));

String professionListResponseToJson(ProfessionListResponse data) => json.encode(data.toJson());

class ProfessionListResponse {
  ProfessionListResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  ProfessionPayload payload;

  factory ProfessionListResponse.fromJson(Map<String, dynamic> json) => ProfessionListResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : ProfessionPayload.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}

class ProfessionPayload {
  ProfessionPayload({
    this.total,
    this.rows,
  });

  int total;
  List<Profession> rows;

  factory ProfessionPayload.fromJson(Map<String, dynamic> json) => ProfessionPayload(
    total: json["total"] == null ? null : json["total"],
    rows: json["rows"] == null ? null : List<Profession>.from(json["rows"].map((x) => Profession.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total == null ? null : total,
    "rows": rows == null ? null : List<dynamic>.from(rows.map((x) => x.toJson())),
  };
}

class Profession {
  Profession({
    this.id,
    this.profession,
  });

  int id;
  String profession;

  factory Profession.fromJson(Map<String, dynamic> json) => Profession(
    id: json["id"] == null ? null : json["id"],
    profession: json["profession"] == null ? null : json["profession"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "profession": profession == null ? null : profession,
  };
}