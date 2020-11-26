class TermCondition {
  List<CategoryItem> category;

  TermCondition({this.category});

  factory TermCondition.fromJson(Map<String, dynamic> json) => TermCondition(
        category: json["kategory_tnc"],
      );

  Map<String, dynamic> toJson() => {
        "kategory_tnc": category,
      };
}

class CategoryItem {
  List<SubCategoryItem> subCategory;

  CategoryItem({this.subCategory});

  factory CategoryItem.fromJson(Map<String, dynamic> json) => CategoryItem(
        subCategory: json["sub_kategory_tnc"],
      );

  Map<String, dynamic> toJson() => {
        "sub_kategory_tnc": subCategory,
      };
}

class SubCategoryItem {
  String title;
  String description;

  SubCategoryItem({this.title, this.description});

  factory SubCategoryItem.fromJson(Map<String, dynamic> json) => SubCategoryItem(
    title: json["title_tnc"],
    description: json["description_tnc"],
  );

  Map<String, dynamic> toJson() => {
    "title_tnc": title,
    "description_tnc": description,
  };
}
