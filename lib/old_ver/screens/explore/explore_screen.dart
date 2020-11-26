import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:soedja_freelance/old_ver/components/button.dart';
import 'package:soedja_freelance/old_ver/constants/assets.dart';
import 'package:soedja_freelance/old_ver/constants/strings.dart';
import 'package:soedja_freelance/old_ver/constants/urls.dart';
import 'package:soedja_freelance/old_ver/models/category.dart';
import 'package:soedja_freelance/old_ver/models/feeds.dart';
import 'package:soedja_freelance/old_ver/models/subcategory.dart';
import 'package:soedja_freelance/old_ver/models/typecategory.dart';
import 'package:soedja_freelance/old_ver/screens/feeds/detail_screen.dart';
import 'package:soedja_freelance/old_ver/screens/feeds/feeds_screen.dart';
import 'package:soedja_freelance/old_ver/screens/search/search_home_screen.dart';
import 'package:soedja_freelance/old_ver/services/category.dart';
import 'package:soedja_freelance/old_ver/services/feeds.dart';
import 'package:soedja_freelance/old_ver/services/user.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';
import 'package:soedja_freelance/old_ver/utils/helpers.dart';
import 'package:soedja_freelance/old_ver/utils/navigation.dart';

class ExploreScreen extends StatefulWidget {
  final Category category;
  final SubCategory subCategory;
  final TypeCategory typeCategory;

  ExploreScreen({
    this.category,
    this.subCategory,
    this.typeCategory,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ExploreScreen();
  }
}

class _ExploreScreen extends State<ExploreScreen> {
  ScrollController controller = new ScrollController();

  int page = 1;
  int limit = 10;
  String title = '';

  List<Feeds> feedList;
  bool isEmpty = false;
  bool isLoading = true;
  bool disableLoad = false;
  bool isLoadMore = false;

  bool isRefresh = false;
  Category category = new Category(category: 'Jasa Desain', type: 'creative');
  SubCategory subCategory = new SubCategory(
      category: 'Jasa Desain', type: 'creative', subCategory: 'Semua');
  TypeCategory typeCategory =
      new TypeCategory(typeCategory: 'Semua', type: 'per_hour');

  ScrollController categoryController = new ScrollController();

  List<Category> categoryList = new List<Category>();
  List<SubCategory> subCategoryList = new List<SubCategory>();
  List<TypeCategory> typeCategoryList = new List<TypeCategory>();

  void scrollListener() {
    if (controller.position.pixels >
        controller.position.maxScrollExtent -
            MediaQuery.of(context).size.width) {
      if (isLoadMore && !isLoading && !disableLoad) {
        setState(() {
          disableLoad = true;
          page++;
          feedList.add(Feeds());
        });

        Future.delayed(Duration(seconds: 1), () => fetchFeeds());
      }
    }
  }

  void fetchCategory() async {
    CategoryService().getCategory(context).then((response) {
      if (response.length > 0) {
        setState(() {
          categoryList = response;
        });
      }
      Future.delayed(Duration(seconds: 1), () => fetchSubCategory());
    });
  }

  void fetchSubCategory() {
    SubCategoryPayload payload = new SubCategoryPayload();
    setState(() {
      payload = new SubCategoryPayload(category: category.category);
    });

    CategoryService().getSubCategory(context, payload).then((response) {
      if (response.length > 0) {
        setState(() {
          subCategoryList = response;
          subCategoryList.insert(
              0, SubCategory(subCategory: 'Semua', type: 'creative'));
          isRefresh = true;
          page = 1;
          isLoading = true;
        });
        Future.delayed(Duration(seconds: 1), ()=> fetchFeeds());
      }
    });
  }

  void fetchTypeCategory() {
    TypeCategoryPayload payload = new TypeCategoryPayload();
    setState(() {
      payload = new TypeCategoryPayload(
          category: category.category, subCategory: subCategory.subCategory);
    });

    CategoryService().getTypeCategory(context, payload).then((response) {
      if (response.length > 0) {
        setState(() {
          typeCategoryList = response;
          typeCategoryList.insert(
              0, TypeCategory(typeCategory: 'Semua', type: 'per_hour'));
          isRefresh = true;
          page = 1;
          isLoading = true;
        });
        Future.delayed(Duration(seconds: 1), ()=> fetchFeeds());
      }
    });
  }

  void fetchFeeds() {
    ExplorePayload payload = new ExplorePayload();
    payload = new ExplorePayload(
      limit: limit,
      page: page,
      title: title,
      category: category.category,
      subCategory: subCategory.subCategory,
      typeCategory: typeCategory.typeCategory,
    );

    getFeeds(context: context, payload: payload);
  }

  void getFeeds({BuildContext context, ExplorePayload payload}) async {
    FeedsService().getExplore(context, payload).then((response) {
      if (page > 1) {
        setState(() {
          feedList.removeLast();
        });
        if (response.length > 0) {
          setState(() {
            if (response.length < 10) {
              isLoadMore = false;
              disableLoad = true;
            }
            feedList.addAll(response);
          });
        } else {
          setState(() {
            isLoadMore = false;
            disableLoad = true;
          });
        }
      } else {
        if (response.length > 0) {
          setState(() {
            isLoading = false;
            isEmpty = false;
            isLoadMore = true;
            disableLoad = false;
            feedList = response;
          });
        } else {
          setState(() {
            isLoading = false;
            disableLoad = true;
            isEmpty = true;
          });
        }
      }
    });
  }

  @override
  void initState() {
    feedList = new List<Feeds>();
    controller.addListener(scrollListener);
//    fetchFeeds();
    fetchCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBarSection(
        context: context,
        controller: categoryController,
        size: size,
        category: category,
        subCategory: subCategory,
        typeCategory: typeCategory,
        categoryList: categoryList,
        subCategoryList: subCategoryList,
        typeCategoryList: typeCategoryList,
        onChangedCategory: (val) {
          if (category != val) {
            setState(() {
              category = val;
              subCategory =
                  new SubCategory(type: 'creative', subCategory: 'Semua');
              typeCategory =
                  new TypeCategory(typeCategory: 'Semua', type: 'per_hour');
            });

            if (val.type == 'creative') {
              fetchSubCategory();
            } else {
              fetchTypeCategory();
            }
          }
        },
        onChangedSubCategory: (val) {
          if (subCategory != val) {
            setState(() {
              subCategory = val;
              page = 1;
              isLoading = true;
            });
            Future.delayed(Duration(seconds: 1), ()=> fetchFeeds());
          }
        },
        onChangedTypeCategory: (val) {
          if (typeCategory != val) {
            setState(() {
              typeCategory = val;
              page = 1;
              isLoading = true;
            });
            Future.delayed(Duration(seconds: 1), ()=> fetchFeeds());
          }
        },
      ),
      body: RefreshIndicator(
        onRefresh: () async  {
          setState(() {
            page = 1;
            isLoading = true;
          });
          fetchFeeds();

          return;
        },
        child: contentSection(
          context: context,
          isEmpty: isEmpty,
          isLoading: isLoading,
          size: size,
          controller: controller,
          list: feedList,
          isLoadMode: isLoadMore,
          disableLoad: disableLoad,
        ),
      ),
    );
  }
}

Widget appBarSection({
  BuildContext context,
  Size size,
  Category category,
  SubCategory subCategory,
  TypeCategory typeCategory,
  List<Category> categoryList,
  List<SubCategory> subCategoryList,
  List<TypeCategory> typeCategoryList,
  Function(Category) onChangedCategory,
  Function(SubCategory) onChangedSubCategory,
  Function(TypeCategory) onChangedTypeCategory,
  ScrollController controller,
}) {
  return AppBar(
    backgroundColor: AppColors.white,
    iconTheme: IconThemeData(),
    elevation: 1.0,
    automaticallyImplyLeading: false,
    title: Text(
      Strings.discover,
      style: TextStyle(
          color: AppColors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
    ),
    actions: <Widget>[
      Row(
        children: <Widget>[
          ButtonPrimary(
              context: context,
              height: 40.0,
              width: 40.0,
              onTap: () =>
                  Navigation().navigateScreen(context, SearchHomeScreen()),
              child: Icon(
                Icons.search,
                color: AppColors.black,
              ),
              buttonColor: AppColors.light,
              borderRadius: BorderRadius.circular(20.0),
              padding: EdgeInsets.all(0.0)),
          SizedBox(width: 16.0),
        ],
      )
    ],
    bottom: PreferredSize(
        preferredSize: Size.fromHeight(82.0),
        child: exploreCategorySection(
          context: context,
          size: size,
          category: category,
          subCategory: subCategory,
          typeCategory: typeCategory,
          onChangedCategory: (val) => onChangedCategory(val),
          onChangedSubCategory: (val) => onChangedSubCategory(val),
          onChangedTypeCategory: (val) => onChangedTypeCategory(val),
          categoryList: categoryList,
          subCategoryList: subCategoryList,
          typeCategoryList: typeCategoryList,
        )),
  );
}

Widget exploreCategorySection({
  BuildContext context,
  Category category,
  SubCategory subCategory,
  TypeCategory typeCategory,
  Size size,
  Function(Category) onChangedCategory,
  Function(SubCategory) onChangedSubCategory,
  Function(TypeCategory) onChangedTypeCategory,
  List<Category> categoryList,
  List<SubCategory> subCategoryList,
  List<TypeCategory> typeCategoryList,
}) {
  return Column(
    children: <Widget>[
      Container(
        height: 36.0,
        width: size.width,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
            itemBuilder: (BuildContext context, int index) {
              return ButtonPrimary(
                onTap: () => onChangedCategory(categoryList[index]),
                buttonColor: category.category == categoryList[index].category
                    ? category.type == 'creative' ? AppColors.black : AppColors.primary
                    : AppColors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 0.0),
                borderRadius: BorderRadius.circular(30.0),
                border: Border.all(
                    color:  AppColors.black,
                    width: category == categoryList[index] ? 0.1 : .2),
                child: Text(
                  categoryList[index].category.replaceAll('Jasa ', ''),
                  style: TextStyle(
                      color: category.category == categoryList[index].category
                          ? AppColors.white
                          : AppColors.black,
                      fontSize: 10.0,),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => SizedBox(
                  width: 8.0,
                ),
            itemCount: categoryList.length),
      ),
      SizedBox(height: 8.0),
      Container(
        height: 40.0,
        width: size.width,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              if (category.type == 'creative') {
                return ButtonPrimary(
                  onTap: () => onChangedSubCategory(subCategoryList[index]),
                  buttonColor: AppColors.white,
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.0, vertical: 0.0),
                  borderRadius: BorderRadius.circular(0.0),
                  border: Border.all(color: AppColors.grey707070, width: .2),
                  child: Text(
                    subCategoryList[index].subCategory,
                    style: TextStyle(
                        color: subCategory.subCategory ==
                                subCategoryList[index].subCategory
                            ? AppColors.primary
                            : AppColors.black.withOpacity(.6),
                        fontSize: 10.0,),
                  ),
                );
              } else {
                return ButtonPrimary(
                  onTap: () => onChangedTypeCategory(typeCategoryList[index]),
                  buttonColor: AppColors.white,
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.0, vertical: 0.0),
                  borderRadius: BorderRadius.circular(0.0),
                  border: Border.all(color: AppColors.grey707070, width: .2),
                  child: Text(
                    typeCategoryList[index].typeCategory,
                    style: TextStyle(
                        color: typeCategory.typeCategory ==
                                typeCategoryList[index].typeCategory
                            ? AppColors.primary
                            : AppColors.black.withOpacity(.6),
                        fontSize: 10.0,),
                  ),
                );
              }
            },
            separatorBuilder: (BuildContext context, int index) => Container(),
            itemCount: category.type == 'creative'
                ? subCategoryList.length
                : typeCategoryList.length),
      ),
    ],
  );
}

Widget contentSection({
  BuildContext context,
  bool isLoading,
  bool isEmpty,
  List<Feeds> list,
  ScrollController controller,
  Size size,
  bool isLoadMode,
  bool disableLoad,
}) {
  if (isLoading) {
    return loaderSection(context: context, size: size, count: 3);
  } else {
    if (isEmpty) {
      return emptySection(context: context, size: size);
    } else {
      return feedListSection(
          context: context,
          size: size,
          controller: controller,
          list: list,
          isLoadMore: isLoadMode,
          isLoading: isLoading,
          disableLoad: disableLoad);
    }
  }
}

Widget loaderSection({BuildContext context, Size size, int count}) {
  return ListView.separated(
    shrinkWrap: true,
    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40.0),
    separatorBuilder: (BuildContext context, int index) =>
        SizedBox(height: 16.0),
    itemCount: count,
    itemBuilder: (BuildContext context, int index) {
      return loaderFeeds(context: context, size: size);
    },
  );
}

Widget loaderFeeds({BuildContext context, Size size}) {
  return Container(
    color: AppColors.light,
    height: size.width,
    width: size.width,
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Shimmer.fromColors(
            child: Container(
                width: size.width, height: size.width, color: AppColors.white),
            baseColor: AppColors.light,
            highlightColor: AppColors.lighter),
        Container(
          height: 115.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                    color: AppColors.black.withOpacity(.2),
                    blurRadius: 5,
                    offset: Offset(0.0, 4.0))
              ]),
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.all(16.0),
          child: Shimmer.fromColors(
            baseColor: AppColors.light,
            highlightColor: AppColors.lighter,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                            width: 36.0, height: 36.0, color: AppColors.white),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                width: 150.0,
                                height: 20.0,
                                color: AppColors.white),
                            SizedBox(height: 4.0),
                            Container(
                                width: 100.0,
                                height: 15.0,
                                color: AppColors.white),
                          ],
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Container(
                          width: 25.0, height: 25.0, color: AppColors.white),
                      SizedBox(width: 4.0),
                      Container(
                          width: 25.0, height: 25.0, color: AppColors.white),
                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: <Widget>[
                    Container(
                        width: 25.0, height: 25.0, color: AppColors.white),
                    SizedBox(width: 16.0),
                    Container(
                        width: 100.0, height: 30.0, color: AppColors.white),
                    Expanded(child: SizedBox(width: 16.0)),
                    Container(
                        width: 25.0, height: 25.0, color: AppColors.white),
                    SizedBox(width: 4.0),
                    Container(
                        width: 30.0, height: 20.0, color: AppColors.white),
                    SizedBox(width: 16.0),
                    Container(
                        width: 25.0, height: 25.0, color: AppColors.white),
                    SizedBox(width: 4.0),
                    Container(
                        width: 30.0, height: 20.0, color: AppColors.white),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget feedListSection({
  BuildContext context,
  Size size,
  ScrollController controller,
  List<Feeds> list,
  bool isLoading,
  bool isLoadMore,
  bool disableLoad,
}) {
  return ListView.separated(
    controller: controller,
    shrinkWrap: true,
    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40.0),
    separatorBuilder: (BuildContext context, int index) => SizedBox(
      height: 16.0,
    ),
    itemCount: list.length,
    itemBuilder: (BuildContext context, int index) {
      return cardFeeds(
          context: context,
          item: list[index],
          size: size,
          isLoading: list[index].category == null);
    },
  );
}

Widget cardFeeds({
  BuildContext context,
  int index,
  Feeds item,
  Size size,
  bool isLoading = false,
  Function(Feeds) onLike,
  Function(Feeds) onBookmark,
  Function(Feeds) onUpdate,
}) {
  if (!isLoading) {
    return GestureDetector(
      onTap: () => Navigation().navigateScreen(
          context,
          FeedsDetailScreen(
            item: item,
            index: index,
            onUpdate: (item) {
              onUpdate(item);
              Navigation().navigateBack(context);
            },
          )),
      child: Container(
        color: AppColors.light,
        height: size.width,
        width: size.width,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            FadeInImage.assetNetwork(
              placeholder: Assets.imgPlaceholder,
              image: item.pictures.length > 0
                  ? BaseUrl.SoedjaAPI + '/' + item.pictures[0].path
                  : '',
              width: size.width,
              height: size.width,
              fit: BoxFit.cover,
            ),
            Container(
              height: 115.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.black.withOpacity(.2),
                        blurRadius: 5,
                        offset: Offset(0.0, 4.0))
                  ]),
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            color: AppColors.light,
                            child: FadeInImage.assetNetwork(
                              placeholder: avatar(item.userData.name),
                              image: BaseUrl.SoedjaAPI +
                                  '/' +
                                  item.userData.picture,
                              width: 36.0,
                              height: 36.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                item.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                item.userData.name,
                                style: TextStyle(
                                    color: AppColors.black.withOpacity(.6),
                                    fontSize: 10.0),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16.0),
                        ButtonPrimary(
                          onTap: () => onBookmark(item),
                          buttonColor: AppColors.white,
                          padding: EdgeInsets.all(4.0),
                          child: item.hasBookmark == 0
                              ? Icon(
                                  Icons.bookmark_border,
                                  color: AppColors.black,
                                )
                              : Icon(
                                  Icons.bookmark,
                                  color: AppColors.green,
                                ),
                        ),
                        ButtonPrimary(
                            buttonColor: AppColors.white,
                            padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.more_vert,
                              color: AppColors.black,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: <Widget>[
                      ButtonPrimary(
                        onTap: () => onLike(item),
                        height: 25.0,
                        width: 25.0,
                        buttonColor: AppColors.white,
                        padding: EdgeInsets.all(4.0),
                        borderRadius: BorderRadius.circular(20.0),
                        child: item.hasLike == 1
                            ? Image.asset(
                                Assets.iconLike,
                                height: 20.0,
                                width: 20.0,
                              )
                            : Image.asset(
                                Assets.iconDislike,
                                height: 20.0,
                                width: 20.0,
                              ),
                      ),
                      SizedBox(width: 8.0),
                      ButtonPrimary(
                          onTap: () => Navigation().navigateScreen(
                              context,
                              FeedsDetailScreen(item: item,
                                index: index,
                                onUpdate: (item) {
                                  onUpdate(item);
                                  Navigation().navigateBack(context);
                                },)),
                          buttonColor: AppColors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                              color: AppColors.grey707070, width: .2),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 6.0),
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                Assets.iconComment,
                                height: 20.0,
                                width: 20.0,
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                Strings.comment,
                                style: TextStyle(
                                    color: AppColors.black.withOpacity(.6),
                                    fontSize: 10.0),
                              )
                            ],
                          )),
                      Expanded(child: SizedBox(width: 16.0)),
                      Image.asset(
                        Assets.iconLikeCount,
                        height: 25.0,
                        width: 25.0,
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        currency.format(item.likeCount),
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 12.0),
                      ),
                      SizedBox(width: 16.0),
                      Image.asset(
                        Assets.iconCommentCount,
                        height: 25.0,
                        width: 25.0,
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        currency.format(item.commentCount),
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 12.0),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  } else {
    return loaderFeeds(context: context, size: size);
  }
}