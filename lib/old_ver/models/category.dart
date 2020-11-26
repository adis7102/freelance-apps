class Category {
  String categoryId;
  String type;
  String category;
  String description;
  String picture;
  String pictureCover;
  int createdAt;
  int updatedAt;
  int totalSubCategory;

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
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["category_id"],
        type: json["type"],
        category: json["category"],
        description: json["description"],
        picture: json["picture"],
        pictureCover: json["picture_cover"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        totalSubCategory: json["total_sub_category"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "type": type,
        "category": category,
        "description": description,
        "picture": picture,
        "picture_cover": pictureCover,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "total_sub_category": totalSubCategory,
      };
}

class CategoryInterest {
  Category category;
  bool selected;

  CategoryInterest({
    this.category,
    this.selected,
  });

  factory CategoryInterest.fromJson(Map<String, dynamic> json) => CategoryInterest(
    category: Category.fromJson(json["category"]),
    selected: json["selected"],
  );

  Map<String, dynamic> toJson() => {
    "category": category.toJson(),
    "selected": selected,
  };
}
