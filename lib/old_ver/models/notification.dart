import 'dart:convert';

class Notifications {
  Notifications({
    this.id,
    this.messageId,
    this.userId,
    this.isAck,
    this.type,
    this.isRead,
    this.createdAt,
    this.updatedAt,
    this.detail,
  });

  int id;
  String messageId;
  String userId;
  bool isAck;
  String type;
  bool isRead;
  int createdAt;
  int updatedAt;
  Detail detail;

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        id: json["id"] == null ? null : json["id"],
        messageId: json["message_id"] == null ? null : json["message_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        isAck: json["is_ack"] == null ? null : json["is_ack"],
        type: json["type"] == null ? null : json["type"],
        isRead: json["is_read"] == null ? null : json["is_read"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        detail: json["detail"] == null ? null : Detail.fromJson(json["detail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "message_id": messageId == null ? null : messageId,
        "user_id": userId == null ? null : userId,
        "is_ack": isAck == null ? null : isAck,
        "type": type == null ? null : type,
        "is_read": isRead == null ? null : isRead,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "detail": detail == null ? null : detail.toJson(),
      };
}

class Detail {
  Detail({
    this.type,
    this.message,
    this.name,
    this.picture,
  });

  String type;
  Message message;
  String name;
  String picture;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        type: json["type"] == null ? null : json["type"],
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
        name: json["name"] == null ? null : json["name"],
        picture: json["picture"] == null ? null : json["picture"],
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "message": message == null ? null : message.toJson(),
        "name": name == null ? null : name,
        "picture": picture == null ? null : picture,
      };
}

class Message {
  Message({
    this.type,
    this.title,
    this.message,
    this.contentId,
    this.givenById,
  });

  String type;
  String title;
  String message;
  String contentId;
  String givenById;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        type: json["type"] == null ? null : json["type"],
        title: json["title"] == null ? null : json["title"],
        message: json["message"] == null ? null : json["message"],
        contentId: json["content_id"] == null ? null : json["content_id"],
        givenById: json["given_by_id"] == null ? null : json["given_by_id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "title": title == null ? null : title,
        "message": message == null ? null : message,
        "content_id": contentId == null ? null : contentId,
        "given_by_id": givenById == null ? null : givenById,
      };
}

class NotificationPayload {
  int limit;
  int page;

  NotificationPayload({
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

class UpdateTokenPayload {
  UpdateTokenPayload({
    this.userId,
    this.device,
    this.os,
    this.osVersion,
    this.appVersion,
    this.brand,
    this.brandType,
    this.token,
  });

  String userId;
  String device;
  String os;
  String osVersion;
  String appVersion;
  String brand;
  String brandType;
  String token;

  factory UpdateTokenPayload.fromJson(Map<String, dynamic> json) =>
      UpdateTokenPayload(
        userId: json["user_id"],
        device: json["device"],
        os: json["os"],
        osVersion: json["os_version"],
        appVersion: json["app_version"],
        brand: json["brand"],
        brandType: json["brand_type"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "device": device,
        "os": os,
        "os_version": osVersion,
        "app_version": appVersion,
        "brand": brand,
        "brand_type": brandType,
        "token": token,
      };
}
