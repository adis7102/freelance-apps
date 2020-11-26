// To parse this JSON data, do
//
//     final notificationListResponse = notificationListResponseFromJson(jsonString);

import 'dart:convert';

NotificationListResponse notificationListResponseFromJson(String str) => NotificationListResponse.fromJson(json.decode(str));

String notificationListResponseToJson(NotificationListResponse data) => json.encode(data.toJson());

class NotificationListResponse {
  NotificationListResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  NotificationPayload payload;

  factory NotificationListResponse.fromJson(Map<String, dynamic> json) => NotificationListResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : NotificationPayload.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}

class NotificationPayload {
  NotificationPayload({
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
  List<MessageData> rows;

  factory NotificationPayload.fromJson(Map<String, dynamic> json) => NotificationPayload(
    total: json["total"] == null ? null : json["total"],
    totalPage: json["totalPage"] == null ? null : json["totalPage"],
    rowPerPage: json["rowPerPage"] == null ? null : json["rowPerPage"],
    previousPage: json["previousPage"] == null ? null : json["previousPage"],
    nextPage: json["nextPage"] == null ? null : json["nextPage"],
    currentPage: json["currentPage"] == null ? null : json["currentPage"],
    info: json["info"] == null ? null : json["info"],
    rows: json["rows"] == null ? null : List<MessageData>.from(json["rows"].map((x) => MessageData.fromJson(x))),
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

class MessageData {
  MessageData({
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
  MessageDetail detail;

  factory MessageData.fromJson(Map<String, dynamic> json) => MessageData(
    id: json["id"] == null ? null : json["id"],
    messageId: json["message_id"] == null ? null : json["message_id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    isAck: json["is_ack"] == null ? null : json["is_ack"],
    type: json["type"] == null ? null : json["type"],
    isRead: json["is_read"] == null ? null : json["is_read"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    detail: json["detail"] == null ? null : MessageDetail.fromJson(json["detail"]),
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

class MessageDetail {
  MessageDetail({
    this.type,
    this.message,
    this.name,
    this.picture,
  });

  String type;
  MessageClass message;
  String name;
  String picture;

  factory MessageDetail.fromJson(Map<String, dynamic> json) => MessageDetail(
    type: json["type"] == null ? null : json["type"],
    message: json["message"] == null ? null : MessageClass.fromJson(json["message"]),
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

class MessageClass {
  MessageClass({
    this.type,
    this.title,
    this.message,
    this.contentId,
    this.givenById,
    this.parentId,
  });

  String type;
  String title;
  String message;
  String contentId;
  String givenById;
  String parentId;

  factory MessageClass.fromJson(Map<String, dynamic> json) => MessageClass(
    type: json["type"] == null ? null : json["type"],
    title: json["title"] == null ? null : json["title"],
    message: json["message"] == null ? null : json["message"],
    contentId: json["content_id"] == null ? null : json["content_id"],
    givenById: json["given_by_id"] == null ? null : json["given_by_id"],
    parentId: json["parent_id"] == null ? null : json["parent_id"],
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "title": title == null ? null : title,
    "message": message == null ? null : message,
    "content_id": contentId == null ? null : contentId,
    "given_by_id": givenById == null ? null : givenById,
    "parent_id": parentId == null ? null : parentId,
  };
}

SaveFcmRequest saveFcmRequestFromJson(String str) =>
    SaveFcmRequest.fromJson(json.decode(str));

String saveFcmRequestToJson(SaveFcmRequest data) => json.encode(data.toJson());

class SaveFcmRequest {
  SaveFcmRequest({
    this.token,
    this.device,
    this.osVersion,
    this.serial,
  });

  String token;
  String device;
  String osVersion;
  String serial;

  factory SaveFcmRequest.fromJson(Map<String, dynamic> json) => SaveFcmRequest(
    token: json["token"],
    device: json["device"],
    osVersion: json["osVersion"],
    serial: json["serial"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "device": device,
    "osVersion": osVersion,
    "serial": serial,
  };
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
