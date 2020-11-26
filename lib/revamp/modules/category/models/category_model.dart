import 'dart:convert';

CategoryPayload categoryPayloadFromJson(String str) =>
    CategoryPayload.fromJson(json.decode(str));

String categoryPayloadToJson(CategoryPayload data) =>
    json.encode(data.toJson());

class CategoryPayload {
  CategoryPayload({
    this.type,
    this.category,
    this.subCategory,
    this.typeCategory,
    this.isPackage,
    this.limit,
  });

  String type;
  String category;
  String subCategory;
  String typeCategory;
  String isPackage;
  String limit;

  factory CategoryPayload.fromJson(Map<String, dynamic> json) =>
      CategoryPayload(
        type: json["type"] == null ? null : json["type"],
        category: json["category"] == null ? null : json["category"],
        subCategory: json["sub_category"] == null ? null : json["sub_category"],
        typeCategory:
            json["type_category"] == null ? null : json["type_category"],
        isPackage: json["is_package"] == null ? null : json["is_package"],
        limit: json["limit"] == null ? null : json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "category": category == null ? null : category,
        "sub_category": subCategory == null ? null : subCategory,
        "type_category": typeCategory == null ? null : typeCategory,
        "is_package": isPackage == null ? null : isPackage,
        "limit": limit == null ? null : limit,
      };
}

CategoryListResponse categoryListResponseFromJson(String str) =>
    CategoryListResponse.fromJson(json.decode(str));

String categoryListResponseToJson(CategoryListResponse data) =>
    json.encode(data.toJson());

class CategoryListResponse {
  CategoryListResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  PayloadCategory payload;

  factory CategoryListResponse.fromJson(Map<String, dynamic> json) =>
      CategoryListResponse(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        payload: json["payload"] == null
            ? null
            : PayloadCategory.fromJson(json["payload"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "payload": payload == null ? null : payload.toJson(),
      };
}

class PayloadCategory {
  PayloadCategory({
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
  List<Category> rows;

  factory PayloadCategory.fromJson(Map<String, dynamic> json) =>
      PayloadCategory(
        total: json["total"] == null ? null : json["total"],
        totalPage: json["totalPage"] == null ? null : json["totalPage"],
        rowPerPage: json["rowPerPage"] == null ? null : json["rowPerPage"],
        previousPage:
            json["previousPage"] == null ? null : json["previousPage"],
        nextPage: json["nextPage"] == null ? null : json["nextPage"],
        currentPage: json["currentPage"] == null ? null : json["currentPage"],
        info: json["info"] == null ? null : json["info"],
        rows: json["rows"] == null
            ? null
            : List<Category>.from(
                json["rows"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total == null ? null : total,
        "totalPage": totalPage == null ? null : totalPage,
        "rowPerPage": rowPerPage == null ? null : rowPerPage,
        "previousPage": previousPage == null ? null : previousPage,
        "nextPage": nextPage == null ? null : nextPage,
        "currentPage": currentPage == null ? null : currentPage,
        "info": info == null ? null : info,
        "rows": rows == null
            ? null
            : List<dynamic>.from(rows.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    this.categoryId,
    this.type,
    this.category,
    this.description,
    this.picture,
    this.pictureCover,
    this.createdAt,
    this.updatedAt,
    this.totalSubCategory,
    this.selected = false,
  });

  String categoryId;
  String type;
  String category;
  String description;
  String picture;
  String pictureCover;
  int createdAt;
  int updatedAt;
  int totalSubCategory;
  bool selected;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["category_id"] == null ? null : json["category_id"],
        type: json["type"] == null ? null : json["type"],
        category: json["category"] == null ? null : json["category"],
        description: json["description"] == null ? null : json["description"],
        picture: json["picture"] == null ? null : json["picture"],
        pictureCover:
            json["picture_cover"] == null ? null : json["picture_cover"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        totalSubCategory: json["total_sub_category"] == null
            ? null
            : json["total_sub_category"],
        selected: false,
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId == null ? null : categoryId,
        "type": type == null ? null : type,
        "category": category == null ? null : category,
        "description": description == null ? null : description,
        "picture": picture == null ? null : picture,
        "picture_cover": pictureCover == null ? null : pictureCover,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "total_sub_category":
            totalSubCategory == null ? null : totalSubCategory,
        "selected": selected == null ? null : selected,
      };
}

SubCategoryListResponse subCategoryListResponseFromJson(String str) =>
    SubCategoryListResponse.fromJson(json.decode(str));

String subCategoryListResponseToJson(SubCategoryListResponse data) =>
    json.encode(data.toJson());

class SubCategoryListResponse {
  SubCategoryListResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  PayloadSubCategory payload;

  factory SubCategoryListResponse.fromJson(Map<String, dynamic> json) =>
      SubCategoryListResponse(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        payload: json["payload"] == null
            ? null
            : PayloadSubCategory.fromJson(json["payload"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "payload": payload == null ? null : payload.toJson(),
      };
}

class PayloadSubCategory {
  PayloadSubCategory({
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
  List<SubCategory> rows;

  factory PayloadSubCategory.fromJson(Map<String, dynamic> json) =>
      PayloadSubCategory(
        total: json["total"] == null ? null : json["total"],
        totalPage: json["totalPage"] == null ? null : json["totalPage"],
        rowPerPage: json["rowPerPage"] == null ? null : json["rowPerPage"],
        previousPage:
            json["previousPage"] == null ? null : json["previousPage"],
        nextPage: json["nextPage"] == null ? null : json["nextPage"],
        currentPage: json["currentPage"] == null ? null : json["currentPage"],
        info: json["info"] == null ? null : json["info"],
        rows: json["rows"] == null
            ? null
            : List<SubCategory>.from(
                json["rows"].map((x) => SubCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total == null ? null : total,
        "totalPage": totalPage == null ? null : totalPage,
        "rowPerPage": rowPerPage == null ? null : rowPerPage,
        "previousPage": previousPage == null ? null : previousPage,
        "nextPage": nextPage == null ? null : nextPage,
        "currentPage": currentPage == null ? null : currentPage,
        "info": info == null ? null : info,
        "rows": rows == null
            ? null
            : List<dynamic>.from(rows.map((x) => x.toJson())),
      };
}

class SubCategory {
  SubCategory({
    this.subCategoryId,
    this.type,
    this.category,
    this.subCategory,
    this.picture,
    this.pictureCover,
    this.createdAt,
    this.updatedAt,
  });

  String subCategoryId;
  String type;
  String category;
  String subCategory;
  String picture;
  String pictureCover;
  int createdAt;
  int updatedAt;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        subCategoryId:
            json["sub_category_id"] == null ? null : json["sub_category_id"],
        type: json["type"] == null ? null : json["type"],
        category: json["category"] == null ? null : json["category"],
        subCategory: json["sub_category"] == null ? null : json["sub_category"],
        picture: json["picture"] == null ? null : json["picture"],
        pictureCover:
            json["picture_cover"] == null ? null : json["picture_cover"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "sub_category_id": subCategoryId == null ? null : subCategoryId,
        "type": type == null ? null : type,
        "category": category == null ? null : category,
        "sub_category": subCategory == null ? null : subCategory,
        "picture": picture == null ? null : picture,
        "picture_cover": pictureCover == null ? null : pictureCover,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
      };
}

TypeCategoryListResponse typeCategoryListResponseFromJson(String str) =>
    TypeCategoryListResponse.fromJson(json.decode(str));

String typeCategoryListResponseToJson(TypeCategoryListResponse data) =>
    json.encode(data.toJson());

class TypeCategoryListResponse {
  TypeCategoryListResponse({
    this.code,
    this.message,
    this.payload,
  });

  String code;
  String message;
  PayloadTypeCategory payload;

  factory TypeCategoryListResponse.fromJson(Map<String, dynamic> json) =>
      TypeCategoryListResponse(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        payload: json["payload"] == null
            ? null
            : PayloadTypeCategory.fromJson(json["payload"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "payload": payload == null ? null : payload.toJson(),
      };
}

class PayloadTypeCategory {
  PayloadTypeCategory({
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
  List<TypeCategory> rows;

  factory PayloadTypeCategory.fromJson(Map<String, dynamic> json) =>
      PayloadTypeCategory(
        total: json["total"] == null ? null : json["total"],
        totalPage: json["totalPage"] == null ? null : json["totalPage"],
        rowPerPage: json["rowPerPage"] == null ? null : json["rowPerPage"],
        previousPage:
            json["previousPage"] == null ? null : json["previousPage"],
        nextPage: json["nextPage"] == null ? null : json["nextPage"],
        currentPage: json["currentPage"] == null ? null : json["currentPage"],
        info: json["info"] == null ? null : json["info"],
        rows: json["rows"] == null
            ? null
            : List<TypeCategory>.from(
                json["rows"].map((x) => TypeCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total == null ? null : total,
        "totalPage": totalPage == null ? null : totalPage,
        "rowPerPage": rowPerPage == null ? null : rowPerPage,
        "previousPage": previousPage == null ? null : previousPage,
        "nextPage": nextPage == null ? null : nextPage,
        "currentPage": currentPage == null ? null : currentPage,
        "info": info == null ? null : info,
        "rows": rows == null
            ? null
            : List<dynamic>.from(rows.map((x) => x.toJson())),
      };
}

class TypeCategory {
  TypeCategory({
    this.typeCategoryId,
    this.type,
    this.category,
    this.subCategory,
    this.typeCategory,
    this.isPackage,
    this.description,
    this.picture,
    this.pictureCover,
    this.packageDetail,
    this.createdAt,
    this.updatedAt,
  });

  String typeCategoryId;
  String type;
  String category;
  String subCategory;
  String typeCategory;
  int isPackage;
  String description;
  String picture;
  String pictureCover;
  PackageDetail packageDetail;
  int createdAt;
  int updatedAt;

  factory TypeCategory.fromJson(Map<String, dynamic> json) => TypeCategory(
        typeCategoryId:
            json["type_category_id"] == null ? null : json["type_category_id"],
        type: json["type"] == null ? null : json["type"],
        category: json["category"] == null ? null : json["category"],
        subCategory: json["sub_category"] == null ? null : json["sub_category"],
        typeCategory:
            json["type_category"] == null ? null : json["type_category"],
        isPackage: json["is_package"] == null ? null : json["is_package"],
        description: json["description"] == null ? null : json["description"],
        picture: json["picture"] == null ? null : json["picture"],
        pictureCover:
            json["picture_cover"] == null ? null : json["picture_cover"],
        packageDetail: json["package_detail"] == null
            ? null
            : PackageDetail.fromJson(json["package_detail"]),
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "type_category_id": typeCategoryId == null ? null : typeCategoryId,
        "type": type == null ? null : type,
        "category": category == null ? null : category,
        "sub_category": subCategory == null ? null : subCategory,
        "type_category": typeCategory == null ? null : typeCategory,
        "is_package": isPackage == null ? null : isPackage,
        "description": description == null ? null : description,
        "picture": picture == null ? null : picture,
        "picture_cover": pictureCover == null ? null : pictureCover,
        "package_detail": packageDetail == null ? null : packageDetail.toJson(),
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
      };
}

class PackageDetail {
  PackageDetail({
    this.budget,
    this.duration,
    this.examples,
    this.packageList,
    this.typeCategory,
  });

  int budget;
  String duration;
  List<dynamic> examples;
  List<String> packageList;
  String typeCategory;

  factory PackageDetail.fromJson(Map<String, dynamic> json) => PackageDetail(
        budget: json["budget"] == null ? null : json["budget"],
        duration: json["duration"] == null ? null : json["duration"],
        examples: json["examples"] == null
            ? null
            : List<dynamic>.from(json["examples"].map((x) => x)),
        packageList: json["package_list"] == null
            ? null
            : List<String>.from(json["package_list"].map((x) => x)),
        typeCategory:
            json["type_category"] == null ? null : json["type_category"],
      );

  Map<String, dynamic> toJson() => {
        "budget": budget == null ? null : budget,
        "duration": duration == null ? null : duration,
        "examples": examples == null
            ? null
            : List<dynamic>.from(examples.map((x) => x)),
        "package_list": packageList == null
            ? null
            : List<dynamic>.from(packageList.map((x) => x)),
        "type_category": typeCategory == null ? null : typeCategory,
      };
}
