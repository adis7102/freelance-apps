
import 'dart:convert';

TypeCategory typeCategoryFromJson(String str) => TypeCategory.fromJson(json.decode(str));

String typeCategoryToJson(TypeCategory data) => json.encode(data.toJson());

class TypeCategory {
  String typeCategoryId;
  String type;
  String category;
  String subCategory;
  String typeCategory;
  int isPackage;
  String description;
  String picture;
  String pictureCover;
  dynamic packageDetail;
  int createdAt;
  int updatedAt;

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

  factory TypeCategory.fromJson(Map<String, dynamic> json) => TypeCategory(
    typeCategoryId: json["type_category_id"],
    type: json["type"],
    category: json["category"],
    subCategory: json["sub_category"],
    typeCategory: json["type_category"],
    isPackage: json["is_package"],
    description: json["description"],
    picture: json["picture"],
    pictureCover: json["picture_cover"],
    packageDetail: json["package_detail"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "type_category_id": typeCategoryId,
    "type": type,
    "category": category,
    "sub_category": subCategory,
    "type_category": typeCategory,
    "is_package": isPackage,
    "description": description,
    "picture": picture,
    "picture_cover": pictureCover,
    "package_detail": packageDetail,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}


class TypeCategoryPayload {
  String type;
  String category;
  String subCategory;

  TypeCategoryPayload({this.type, this.category, this.subCategory});

  // object to json
  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "category": category,
      "sub_category": subCategory,
    };
  }
}