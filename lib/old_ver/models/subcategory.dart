class SubCategory {
  String subCategoryId;
  String type;
  String category;
  String subCategory;
  String picture;
  String pictureCover;
  int createdAt;
  int updatedAt;

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

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    subCategoryId: json["sub_category_id"],
    type: json["type"],
    category: json["category"],
    subCategory: json["sub_category"],
    picture: json["picture"],
    pictureCover: json["picture_cover"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "sub_category_id": subCategoryId,
    "type": type,
    "category": category,
    "sub_category": subCategory,
    "picture": picture,
    "picture_cover": pictureCover,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class SubCategoryPayload {
  String type;
  String category;

  SubCategoryPayload({this.type, this.category});

  // object to json
  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "category": category,
    };
  }
}