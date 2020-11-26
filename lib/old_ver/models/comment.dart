import 'feeds.dart';

class Comment {
  String commentId;
  String parentId;
  String userId;
  String comment;
  int createdAt;
  int updatedAt;
  UserData userData;
  String error;

  Comment({
    this.commentId,
    this.parentId,
    this.userId,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.userData,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    commentId: json["comment_id"],
    parentId: json["parent_id"],
    userId: json["user_id"],
    comment: json["comment"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    userData: UserData.fromJson(json["user_data"]),
  );

  Map<String, dynamic> toJson() => {
    "comment_id": commentId,
    "parent_id": parentId,
    "user_id": userId,
    "comment": comment,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "user_data": userData.toJson(),
  };

  Comment.withError(this.error);
}

class CommentPayload {
  int limit;
  int page;

  CommentPayload({this.limit, this.page,});

  Map<String, dynamic> toJson() {
    return {
      "limit": limit,
      "page": page,
    };
  }
}

class GiveCommentPayload {
  String parentId;
  String comment;

  GiveCommentPayload({this.parentId, this.comment});

  Map<String, dynamic> toJson() {
    return {
      "parent_id": parentId,
      "comment": comment,
    };
  }
}