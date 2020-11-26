

class Following {
  Following({
    this.id,
    this.followerId,
    this.followingId,
    this.createdAt,
    this.updatedAt,
    this.followingDetail,
  });

  int id;
  String followerId;
  String followingId;
  int createdAt;
  int updatedAt;
  FollowingDetail followingDetail;

  factory Following.fromJson(Map<String, dynamic> json) => Following(
    id: json["id"],
    followerId: json["follower_id"],
    followingId: json["following_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    followingDetail: FollowingDetail.fromJson(json["following_detail"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "follower_id": followerId,
    "following_id": followingId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "following_detail": followingDetail.toJson(),
  };
}

class FollowingDetail {
  FollowingDetail({
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
//    this.interests,
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
//  List<String> interests;
  int createdAt;
  int updatedAt;

  factory FollowingDetail.fromJson(Map<String, dynamic> json) => FollowingDetail(
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
//    interests: List<String>.from(json["interests"].map((x) => x)),
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
//    "interests": List<dynamic>.from(interests.map((x) => x)),
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Follower {
  Follower({
    this.id,
    this.followerId,
    this.followingId,
    this.createdAt,
    this.updatedAt,
    this.followerDetail,
  });

  int id;
  String followerId;
  String followingId;
  int createdAt;
  int updatedAt;
  FollowerDetail followerDetail;

  factory Follower.fromJson(Map<String, dynamic> json) => Follower(
    id: json["id"],
    followerId: json["follower_id"],
    followingId: json["following_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    followerDetail: FollowerDetail.fromJson(json["follower_detail"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "follower_id": followerId,
    "following_id": followingId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "follower_detail": followerDetail.toJson(),
  };
}

class FollowerDetail {
  FollowerDetail({
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
  List<dynamic> interests;
  int createdAt;
  int updatedAt;

  factory FollowerDetail.fromJson(Map<String, dynamic> json) => FollowerDetail(
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
    interests: List<dynamic>.from(json["interests"].map((x) => x)),
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
    "interests": List<dynamic>.from(interests.map((x) => x)),
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}