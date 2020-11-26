
import 'dart:convert';

BannerStudioResponse bannerStudioResponseFromJson(String str) => BannerStudioResponse.fromJson(json.decode(str));

String bannerStudioResponseToJson(BannerStudioResponse data) => json.encode(data.toJson());

class BannerStudioResponse {
  BannerStudioResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  BannerPayload payload;

  factory BannerStudioResponse.fromJson(Map<String, dynamic> json) => BannerStudioResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : BannerPayload.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}

class BannerPayload {
  BannerPayload({
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
  List<BannerDetail> rows;

  factory BannerPayload.fromJson(Map<String, dynamic> json) => BannerPayload(
    total: json["total"] == null ? null : json["total"],
    totalPage: json["totalPage"] == null ? null : json["totalPage"],
    rowPerPage: json["rowPerPage"] == null ? null : json["rowPerPage"],
    previousPage: json["previousPage"] == null ? null : json["previousPage"],
    nextPage: json["nextPage"] == null ? null : json["nextPage"],
    currentPage: json["currentPage"] == null ? null : json["currentPage"],
    info: json["info"] == null ? null : json["info"],
    rows: json["rows"] == null ? null : List<BannerDetail>.from(json["rows"].map((x) => BannerDetail.fromJson(x))),
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

class BannerDetail {
  BannerDetail({
    this.id,
    this.title,
    this.description,
    this.picture,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String title;
  String description;
  String picture;
  int status;
  int createdAt;
  int updatedAt;

  factory BannerDetail.fromJson(Map<String, dynamic> json) => BannerDetail(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    picture: json["picture"] == null ? null : json["picture"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "picture": picture == null ? null : picture,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
  };
}