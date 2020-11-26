
import 'dart:convert';

ProvinceListResponse provinceListResponseFromJson(String str) => ProvinceListResponse.fromJson(json.decode(str));

String provinceListResponseToJson(ProvinceListResponse data) => json.encode(data.toJson());

class ProvinceListResponse {
  ProvinceListResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  ProvincePayload payload;

  factory ProvinceListResponse.fromJson(Map<String, dynamic> json) => ProvinceListResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : ProvincePayload.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}

class ProvincePayload {
  ProvincePayload({
    this.total,
    this.rows,
  });

  int total;
  List<AreaData> rows;

  factory ProvincePayload.fromJson(Map<String, dynamic> json) => ProvincePayload(
    total: json["total"] == null ? null : json["total"],
    rows: json["rows"] == null ? null : List<AreaData>.from(json["rows"].map((x) => AreaData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total == null ? null : total,
    "rows": rows == null ? null : List<dynamic>.from(rows.map((x) => x.toJson())),
  };
}

RegencyListResponse regencyListResponseFromJson(String str) => RegencyListResponse.fromJson(json.decode(str));

String regencyListResponseToJson(RegencyListResponse data) => json.encode(data.toJson());

class RegencyListResponse {
  RegencyListResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  RegencyPayload payload;

  factory RegencyListResponse.fromJson(Map<String, dynamic> json) => RegencyListResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : RegencyPayload.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}

class RegencyPayload {
  RegencyPayload({
    this.total,
    this.rows,
  });

  int total;
  List<AreaData> rows;

  factory RegencyPayload.fromJson(Map<String, dynamic> json) => RegencyPayload(
    total: json["total"] == null ? null : json["total"],
    rows: json["rows"] == null ? null : List<AreaData>.from(json["rows"].map((x) => AreaData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total == null ? null : total,
    "rows": rows == null ? null : List<dynamic>.from(rows.map((x) => x.toJson())),
  };
}

DistrictListResponse districtListResponseFromJson(String str) => DistrictListResponse.fromJson(json.decode(str));

String districtListResponseToJson(DistrictListResponse data) => json.encode(data.toJson());

class DistrictListResponse {
  DistrictListResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  DistrictPayload payload;

  factory DistrictListResponse.fromJson(Map<String, dynamic> json) => DistrictListResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : DistrictPayload.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}

class DistrictPayload {
  DistrictPayload({
    this.total,
    this.rows,
  });

  int total;
  List<AreaData> rows;

  factory DistrictPayload.fromJson(Map<String, dynamic> json) => DistrictPayload(
    total: json["total"] == null ? null : json["total"],
    rows: json["rows"] == null ? null : List<AreaData>.from(json["rows"].map((x) => AreaData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total == null ? null : total,
    "rows": rows == null ? null : List<dynamic>.from(rows.map((x) => x.toJson())),
  };
}

VillageListResponse villageListResponseFromJson(String str) => VillageListResponse.fromJson(json.decode(str));

String villageListResponseToJson(VillageListResponse data) => json.encode(data.toJson());

class VillageListResponse {
  VillageListResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  VillagePayload payload;

  factory VillageListResponse.fromJson(Map<String, dynamic> json) => VillageListResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    payload: json["payload"] == null ? null : VillagePayload.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "payload": payload == null ? null : payload.toJson(),
  };
}

class VillagePayload {
  VillagePayload({
    this.total,
    this.rows,
  });

  int total;
  List<AreaData> rows;

  factory VillagePayload.fromJson(Map<String, dynamic> json) => VillagePayload(
    total: json["total"] == null ? null : json["total"],
    rows: json["rows"] == null ? null : List<AreaData>.from(json["rows"].map((x) => AreaData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total == null ? null : total,
    "rows": rows == null ? null : List<dynamic>.from(rows.map((x) => x.toJson())),
  };
}

class AreaData {
  AreaData({
    this.id,
    this.provinceId,
    this.province,
    this.regencyId,
    this.regency,
    this.districtId,
    this.district,
    this.village,
    this.postalCode,
  });

  int id;
  int provinceId;
  String province;
  int regencyId;
  String regency;
  int districtId;
  String district;
  String village;
  String postalCode;

  factory AreaData.fromJson(Map<String, dynamic> json) => AreaData(
    id: json["id"] == null ? null : json["id"],
    provinceId: json["province_id"] == null ? null : json["province_id"],
    province: json["province"] == null ? null : json["province"],
    regencyId: json["regency_id"] == null ? null : json["regency_id"],
    regency: json["regency"] == null ? null : json["regency"],
    districtId: json["district_id"] == null ? null : json["district_id"],
    district: json["district"] == null ? null : json["district"],
    village: json["village"] == null ? null : json["village"],
    postalCode: json["postal_code"] == null ? null : json["postal_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "province_id": provinceId == null ? null : provinceId,
    "province": province == null ? null : province,
    "regency_id": regencyId == null ? null : regencyId,
    "regency": regency == null ? null : regency,
    "district_id": districtId == null ? null : districtId,
    "district": district == null ? null : district,
    "village": village == null ? null : village,
    "postal_code": postalCode == null ? null : postalCode,
  };
}

