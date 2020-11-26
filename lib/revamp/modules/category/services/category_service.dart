import 'package:flutter/material.dart';
import 'package:soedja_freelance/revamp/assets/urls.dart';
import 'package:soedja_freelance/revamp/helpers/http_helper.dart';
import 'package:soedja_freelance/revamp/modules/category/models/category_model.dart';

abstract class CategoryAPI {
  Future<CategoryListResponse> getCategories(
      BuildContext context, CategoryPayload payload);

  Future<SubCategoryListResponse> getSubCategories(
      BuildContext context, CategoryPayload payload);

  Future<TypeCategoryListResponse> getTypeCategories(
      BuildContext context, CategoryPayload payload);
}

class CategoryService extends CategoryAPI {
  @override
  Future<CategoryListResponse> getCategories(
      BuildContext context, CategoryPayload payload) async {
    String type = "";
    if (payload.type != null) {
      type = "type=${payload.type}";
    }
    String url = Urls.categoryList + "?" + type;

    try {
      var response =
          await HttpRequest.get(context: context, url: url, useAuth: true);

      if (response['code'] == "success") {
        return CategoryListResponse.fromJson(response);
      } else {
        return CategoryListResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return CategoryListResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<SubCategoryListResponse> getSubCategories(
      BuildContext context, CategoryPayload payload) async {
    String url = Urls.subCategoryList +
        "?type=${payload.type}"
            "&category=${payload.category}";

    try {
      var response =
          await HttpRequest.get(context: context, url: url, useAuth: true);

      if (response['code'] == "success") {
        return SubCategoryListResponse.fromJson(response);
      } else {
        return SubCategoryListResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return SubCategoryListResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<TypeCategoryListResponse> getTypeCategories(
      BuildContext context, CategoryPayload payload) async {
    String subCategory = payload.subCategory.length > 0
        ? "&sub_category=${Uri.encodeComponent(payload.subCategory)}"
        : "";

    String url = Urls.typeCategoryList +
        "?type=${payload.type}"
            "&category=${payload.category}"
            "&$subCategory"
            "&limit=${payload.limit}"
            "&is_package=${payload.isPackage}";

    try {
      var response =
          await HttpRequest.get(context: context, url: url, useAuth: true);

      if (response['code'] == "success") {
        return TypeCategoryListResponse.fromJson(response);
      } else {
        return TypeCategoryListResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return TypeCategoryListResponse(code: "failed", message: e.toString());
    }
  }
}
