class Province {
  int id;
  String province;

  Province({
    this.id,
    this.province,
  });

  Province.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        province = json['province'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'province': province,
  };
}

class Regency {
  int id;
  int provinceId;
  String regency;

  Regency({
    this.id,
    this.provinceId,
    this.regency,
  });

  Regency.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        provinceId = json['province_id'],
        regency = json['regency'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'province_id': provinceId,
    'regency': regency,
  };
}

class District {
  int id;
  int provinceId;
  int regencyId;
  String district;

  District({
    this.id,
    this.provinceId,
    this.regencyId,
    this.district,
  });

  District.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        provinceId = json['province_id'],
        regencyId = json['regency_id'],
        district = json['district'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'province_id': provinceId,
    'regency_id': regencyId,
    'district': district,
  };
}

class Village {
  int id;
  int provinceId;
  int regencyId;
  int districtId;
  String village;
  String postalCode;

  Village({
    this.id,
    this.provinceId,
    this.regencyId,
    this.districtId,
    this.village,
    this.postalCode,
  });

  Village.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        provinceId = json['province_id'],
        regencyId = json['regency_id'],
        districtId = json['district_id'],
        village = json['village'],
        postalCode = json['postal_code'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'province_id': provinceId,
    'regency_id': regencyId,
    'district_id': districtId,
    'village': village,
    'postal_code': postalCode,
  };
}