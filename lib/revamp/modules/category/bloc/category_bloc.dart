import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:soedja_freelance/revamp/modules/category/bloc/category_state.dart';
import 'package:soedja_freelance/revamp/modules/category/models/category_model.dart';
import 'package:soedja_freelance/revamp/modules/category/services/category_service.dart';

class CategoryBloc extends CategoryService {
  BehaviorSubject<CategoryListState> _subjectGetCategory =
      BehaviorSubject<CategoryListState>();
  BehaviorSubject<SubCategoryListState> _subjectGetSubCategory =
      BehaviorSubject<SubCategoryListState>();
  BehaviorSubject<TypeCategoryListState> _subjectGetTypeCategory =
      BehaviorSubject<TypeCategoryListState>();

  Stream<CategoryListState> get getCategory => _subjectGetCategory.stream;

  Stream<SubCategoryListState> get getSubCategory =>
      _subjectGetSubCategory.stream;

  Stream<TypeCategoryListState> get getTypeCategory =>
      _subjectGetTypeCategory.stream;

  BehaviorSubject<bool> _stanby = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get getStanby => _stanby.stream;

  requestGetCategory(BuildContext context, String type) {
    CategoryPayload payload = new CategoryPayload(type: type);

    try {
      _subjectGetCategory.sink
          .add(CategoryListState.onLoading("Loading get category ..."));
      CategoryService().getCategories(context, payload).then((response) {
        if (response.code == 'success') {
          _subjectGetCategory.sink.add(CategoryListState.onSuccess(response));
        } else {
          _subjectGetCategory.sink
              .add(CategoryListState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectGetCategory.sink.add(CategoryListState.onError(e.toString()));
    }
  }

  requestGetSubCategory(BuildContext context, String type, String category) {
    CategoryPayload payload =
        new CategoryPayload(type: type, category: category);

    try {
      _subjectGetSubCategory.sink
          .add(SubCategoryListState.onLoading("Loading get category ..."));
      CategoryService().getSubCategories(context, payload).then((response) {
        if (response.code == 'success') {
          _subjectGetSubCategory.sink
              .add(SubCategoryListState.onSuccess(response));
        } else {
          _subjectGetSubCategory.sink
              .add(SubCategoryListState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectGetSubCategory.sink
          .add(SubCategoryListState.onError(e.toString()));
    }
  }

  requestGetTypeCategory(BuildContext context, String type, String category,
      String subCategory, String limit, String package) {
    CategoryPayload payload = new CategoryPayload(
      type: type,
      category: category,
      subCategory: subCategory,
      limit: limit,
      isPackage: package,
    );

    try {
      _subjectGetTypeCategory.sink
          .add(TypeCategoryListState.onLoading("Loading get category ..."));
      CategoryService().getTypeCategories(context, payload).then((response) {
        if (response.code == 'success') {
          _subjectGetTypeCategory.sink
              .add(TypeCategoryListState.onSuccess(response));
        } else {
          _subjectGetTypeCategory.sink
              .add(TypeCategoryListState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectGetTypeCategory.sink
          .add(TypeCategoryListState.onError(e.toString()));
    }
  }

  unStandBy() async {
    _stanby.sink.add(false);
    _subjectGetCategory.sink.add(CategoryListState.unStanby());
    _subjectGetSubCategory.sink.add(SubCategoryListState.unStanby());
    _subjectGetTypeCategory.sink.add(TypeCategoryListState.unStanby());
  }

  void dispose() {
    _subjectGetCategory?.close();
    _subjectGetSubCategory?.close();
    _subjectGetTypeCategory?.close();
    _stanby?.drain(false);
  }
}
