import 'package:soedja_freelance/old_ver/models/user.dart';

class Feeds {
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
  int commentCount;
  int likeCount;
  int hasLike;
  int hasComment;
  int hasBookmark;
  String bookmarkId;
  int createdAt;
  int updatedAt;
  Profile userData;

  Feeds({
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

  factory Feeds.fromJson(Map<String, dynamic> json) => Feeds(
        portfolioId: json["portfolio_id"],
        userId: json["user_id"],
        title: json["title"],
        description: json["description"],
        category: json["category"],
        subCategory: json["sub_category"],
        typeCategory: json["type_category"],
        amount: json["amount"],
        pictures: List<Picture>.from(json["pictures"].map((x) => Picture.fromJson(x))),
        youtubeUrl: json["youtube_url"],
        commentCount: json["comment_count"],
        likeCount: json["like_count"],
        hasLike: json["has_like"],
        hasComment: json["has_comment"],
        hasBookmark: json["has_bookmark"],
        bookmarkId: json["bookmark_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        userData: Profile.fromJson(json["user_data"]),
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
        "comment_count": commentCount,
        "like_count": likeCount,
        "has_like": hasLike,
        "has_comment": hasComment,
        "has_bookmark": hasBookmark,
        "bookmark_id": bookmarkId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "user_data": userData.toJson(),
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


class FeedProfiles {
  String userId;
  String name;
  String province;
  String regency;
  String picture;
  int hasFollow;

  FeedProfiles({
    this.userId,
    this.name,
    this.province,
    this.regency,
    this.picture,
    this.hasFollow,
  });

  factory FeedProfiles.fromJson(Map<String, dynamic> json) => FeedProfiles(
    userId: json["user_id"],
    name: json["name"],
    province: json["province"],
    regency: json["regency"],
    picture: json["picture"],
    hasFollow: json["has_follow"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "name": name,
    "province": province,
    "regency": regency,
    "picture": picture,
    "has_follow": hasFollow,
  };
}

class UserData {
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

  UserData({
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

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
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

class FeedsList {
  List<Feeds> feedList;
  String error;

  FeedsList({this.feedList});

  FeedsList.fromJson(Map<String, dynamic> json) {
    if (json['rows'] != null) {
      feedList = List<Feeds>();
      json['rows'].forEach((value) {
        feedList.add(Feeds.fromJson(value));
      });
    }
  }

  FeedsList.withError(this.error);
}

class FeedsPayload {
  int limit;
  int page;
  String title;

  FeedsPayload({this.limit, this.page, this.title});

  // object to json
  Map<String, dynamic> toJson() {
    return {
      "limit": limit,
      "page": page,
      "title": title,
    };
  }
}

class FeedProfilePayload {
  int limit;
  int page;
  String title;

  FeedProfilePayload({this.limit, this.page, this.title});

  // object to json
  Map<String, dynamic> toJson() {
    return {
      "limit": limit,
      "page": page,
      "title": title,
    };
  }
}

class ExplorePayload {
  int limit;
  int page;
  String title;
  String category;
  String subCategory;
  String typeCategory;

  ExplorePayload({
    this.limit,
    this.page,
    this.title,
    this.category,
    this.subCategory,
    this.typeCategory,
  });

  // object to json
  Map<String, dynamic> toJson() {
    return {
      "limit": limit,
      "page": page,
      "title": title,
      "category": category,
      "sub_category": subCategory,
      "type_category": typeCategory,
    };
  }
}

class Like {
  String likeId;
  String contentId;
  String error;

  Like({
    this.likeId,
    this.contentId,
  });

  // object to json
  Map<String, dynamic> toJson() {
    return {
      "like_id": likeId,
      "content_id": contentId,
    };
  }

  // json response API to object
  factory Like.fromJson(Map<String, dynamic> map) {
    return Like(
      likeId: map['like_id'],
      contentId: map['content_id'],
    );
  }

  Like.withError(this.error);
}

class LikePayload {
  String contentId;

  LikePayload({
    this.contentId,
  });

  Map<String, dynamic> toJson() {
    return {
      "content_id": contentId,
    };
  }
}


class Bookmark {
  String bookmarkId;
  String portfolioId;
  String error;

  Bookmark({
    this.bookmarkId,
    this.portfolioId,
  });

  // object to json
  Map<String, dynamic> toJson() {
    return {
      "bookmark_id": bookmarkId,
      "portfolio_id": portfolioId,
    };
  }

  // json response API to object
  factory Bookmark.fromJson(Map<String, dynamic> map) {
    return Bookmark(
      bookmarkId: map['bookmark_id'],
      portfolioId: map['portfolio_id'],
    );
  }

  Bookmark.withError(this.error);
}

class BookmarkPayload {
  String portfolioId;

  BookmarkPayload({
    this.portfolioId,
  });

  Map<String, dynamic> toJson() {
    return {
      "portfolio_id": portfolioId,
    };
  }
}


class Follow {
  String followingId;
  String followerId;
  String error;

  Follow({
    this.followingId,
    this.followerId,
  });

  // object to json
  Map<String, dynamic> toJson() {
    return {
      "following_id": followingId,
      "follower_id": followerId,
    };
  }

  // json response API to object
  factory Follow.fromJson(Map<String, dynamic> map) {
    return Follow(
      followingId: map['following_id'],
      followerId: map['follower_id'],
    );
  }

  Follow.withError(this.error);
}

class FollowPayload {
  String followingId;

  FollowPayload({
    this.followingId,
  });

  Map<String, dynamic> toJson() {
    return {
      "following_id": followingId,
    };
  }
}