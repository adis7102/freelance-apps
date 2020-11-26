import 'package:flutter/material.dart';
import 'package:soedja_freelance/old_ver/constants/urls.dart';
import 'package:soedja_freelance/old_ver/models/category.dart';
import 'package:soedja_freelance/old_ver/models/subcategory.dart';
import 'package:soedja_freelance/old_ver/models/typecategory.dart';
import 'package:soedja_freelance/old_ver/utils/http_request.dart';

class CategoryService {
  Future<List<Category>> getCategory(BuildContext context) async {
    try {
      List<Category> list = new List<Category>();

      final response = await HttpRequest.get(
          context: context, url: Url.categoryList, useAuth: true);

      response['payload']['rows'].forEach((data) {
        list.add(Category.fromJson(data));
      });

      return list;
    } catch (err) {
      return [];
    }
  }

  Future<List<SubCategory>> getSubCategory(
      BuildContext context, SubCategoryPayload payload) async {
    try {
      List<SubCategory> list = new List<SubCategory>();

      String params = '?type=${payload.type ?? ''}'
          '&category=${Uri.encodeComponent(payload.category)}';

      final response = await HttpRequest.get(
          context: context, url: Url.subCategoryList + params, useAuth: true);

      response['payload']['rows'].forEach((data) {
        list.add(SubCategory.fromJson(data));
      });

      return list;
    } catch (err) {
      return [];
    }
  }

  Future<List<TypeCategory>> getTypeCategory(
      BuildContext context, TypeCategoryPayload payload) async {
    try {
      List<TypeCategory> list = new List<TypeCategory>();

      String params = '?type=${payload.type ?? ''}'
          '&category=${Uri.encodeComponent(payload.category)}&sub_category=${payload.subCategory == 'Semua' ? '' : Uri.encodeComponent(payload.subCategory)}';

      final response = await HttpRequest.get(
          url: Url.typeCategoryList + params, useAuth: true);

      response['payload']['rows'].forEach((data) {
        list.add(TypeCategory.fromJson(data));
      });

      return list;
    } catch (err) {
      return [];
    }
  }
}
