import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/lists.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/category/bloc/category_bloc.dart';
import 'package:soedja_freelance/revamp/modules/category/bloc/category_state.dart';
import 'package:soedja_freelance/revamp/modules/category/models/category_model.dart';
import 'package:soedja_freelance/revamp/modules/feeds/bloc/feed_bloc.dart';
import 'package:soedja_freelance/revamp/modules/feeds/bloc/feed_state.dart';
import 'package:soedja_freelance/revamp/modules/feeds/components/feeds_component.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';
import 'package:soedja_freelance/revamp/modules/feeds/screens/search_screen.dart';
import 'package:soedja_freelance/revamp/modules/home/components/appbar_component.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/screens/detail_portfolio_screen.dart';
import 'package:soedja_freelance/revamp/modules/profile/models/profile_models.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

class ExploreScreen extends StatefulWidget {
  final AuthBloc authBloc;
  final ProfileDetail authUser;

  const ExploreScreen({Key key, this.authBloc, this.authUser})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ExploreScreen();
  }
}

class _ExploreScreen extends State<ExploreScreen> {
  FeedBloc feedBloc = new FeedBloc();
  CategoryBloc categoryBloc = new CategoryBloc();

  Category category = new Category(category: "Jasa Desain", type: "creative");
  SubCategory subCategory = new SubCategory(
      category: "Jasa Desain", subCategory: "Semua", type: "creative");
  TypeCategory typeCategory = new TypeCategory(
      category: "", subCategory: "", typeCategory: "Semua", type: "");

  List<Category> categoryList = new List<Category>();
  List<SubCategory> subCategoryList = new List<SubCategory>();
  List<TypeCategory> typeCategoryList = new List<TypeCategory>();

  bool allSubCategory = true;
  bool allTypeCategory = true;

  ScrollController listController = new ScrollController();

  int limit = 10;
  int page = 1;
  String title = "";
  List<Feed> feedList = new List<Feed>();
  bool isLoadMore = true;
  bool isEmpty = false;

  int tabIndex = 0;

  @override
  void initState() {
    getCategory();
    getSubCategory();
    getFeeds();
    listController.addListener(scrollListener);
    super.initState();
  }

  void getCategory() {
    categoryBloc.requestGetCategory(
      context,
      "",
    );
  }

  void getSubCategory() {
    categoryBloc.requestGetSubCategory(
      context,
      category.type,
      category.category,
    );
  }

  void getTypeCategory() {
    categoryBloc.requestGetTypeCategory(
        context, category.type, category.category, "", "50", "0,1");
  }

  void getFeeds() {
    feedBloc.requestGetExplore(
      context: context,
      limit: limit,
      page: page,
      category: category,
      subCategory: subCategory.subCategory,
      typeCategory: typeCategory.typeCategory,
    );
  }

  void scrollListener() {
    if (listController.position.pixels >
        listController.position.maxScrollExtent -
            MediaQuery.of(context).size.width) {
      if (isLoadMore) {
        page++;
        feedList.add(Feed());
        getFeeds();
        isLoadMore = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        textTheme: TextTheme(),
        automaticallyImplyLeading: false,
        leading: null,
        titleSpacing: 0,
        title: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: Row(
            children: <Widget>[
              SizedBox(width: ScreenUtil().setWidth(15)),
              Text(
                Texts.explore,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(20),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Container(
                child: IconButton(
                  icon: Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.05),
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setSp(25))),
                    height: ScreenUtil().setHeight(40),
                    width: ScreenUtil().setWidth(40),
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () => Navigation().navigateScreen(
                      context,
                      SearchScreen(
                        authBloc: widget.authBloc,
                        authUser: widget.authUser,
                        title: "",
                      )),
                ),
              ),
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: Column(
            children: <Widget>[
              Container(
                height: ScreenUtil().setHeight(45),
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.black.withOpacity(.5), width: .2))),
                child: StreamBuilder<CategoryListState>(
                    stream: categoryBloc.getCategory,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.isSuccess) {
                          categoryList = snapshot.data.data.payload.rows;
                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(15),
                                vertical: ScreenUtil().setHeight(5)),
                            itemCount: categoryList.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    SizedBox(width: ScreenUtil().setWidth(5)),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  if (categoryList[index] != category) {
                                    category = categoryList[index];
                                    if (categoryList[index].type ==
                                        "creative") {
                                      setState(() {
                                        allSubCategory = true;
                                        subCategory = SubCategory(
                                            category: "",
                                            subCategory: "Semua",
                                            type: "creative");
                                        typeCategory = TypeCategory(
                                            category: "",
                                            subCategory: "",
                                            typeCategory: "Semua",
                                            type: category.type);
                                      });
                                      getSubCategory();
                                    } else {
                                      setState(() {
                                        allTypeCategory = true;
                                        subCategory = SubCategory(
                                            category: "",
                                            subCategory: "Semua",
                                            type: category.type);
                                        typeCategory = TypeCategory(
                                            category: "",
                                            subCategory: "",
                                            typeCategory: "Semua",
                                            type: "");
                                      });
                                      getTypeCategory();
                                    }
                                    page = 1;
                                    getFeeds();
                                  }
                                },
                                child: Container(
                                  height: ScreenUtil().setHeight(45),
                                  width: ScreenUtil().setWidth(110),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: category.category ==
                                              categoryList[index].category
                                          ? Colors.black
                                          : Colors.white,
                                      border: Border.all(
                                          color: Colors.black, width: .1),
                                      borderRadius: BorderRadius.circular(
                                          ScreenUtil().setWidth(20))),
                                  child: Text(
                                    categoryList[index]
                                        .category
                                        .replaceAll("Jasa ", ""),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: category.category ==
                                                categoryList[index].category
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: ScreenUtil().setSp(12),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      }
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(15),
                            vertical: ScreenUtil().setHeight(5)),
                        itemCount: 10,
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(width: ScreenUtil().setWidth(5)),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: ScreenUtil().setHeight(35),
                            width: ScreenUtil().setWidth(100),
                            decoration: BoxDecoration(
                                color: ColorApps.light,
                                borderRadius: BorderRadius.circular(
                                    ScreenUtil().setWidth(20))),
                          );
                        },
                      );
                    }),
              ),
              category.type == "creative"
                  ? Container(
                      height: ScreenUtil().setHeight(35),
                      width: size.width,
                      child: StreamBuilder<SubCategoryListState>(
                          stream: categoryBloc.getSubCategory,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.isSuccess) {
                                subCategoryList =
                                    snapshot.data.data.payload.rows;
                                if (allSubCategory) {
                                  subCategoryList.insert(0, subCategory);
                                  allSubCategory = false;
                                }
                                return ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: subCategoryList.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          Container(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (subCategory !=
                                            subCategoryList[index]) {
                                          setState(() {
                                            subCategory =
                                                subCategoryList[index];
                                          });
                                          getFeeds();
                                        }
                                      },
                                      child: Container(
                                        height: ScreenUtil().setHeight(35),
                                        padding: EdgeInsets.symmetric(
                                            vertical: ScreenUtil().setWidth(5),
                                            horizontal:
                                                ScreenUtil().setWidth(10)),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color:
                                                  Colors.black.withOpacity(.5),
                                              width: .1),
                                        ),
                                        child: Text(
                                          subCategoryList[index].subCategory,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: subCategory.subCategory ==
                                                      subCategoryList[index]
                                                          .subCategory
                                                  ? ColorApps.primary
                                                  : Colors.black
                                                      .withOpacity(.5),
                                              fontSize: ScreenUtil().setSp(10),
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            }
                            return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: 10,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      Container(),
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  height: ScreenUtil().setHeight(35),
                                  width: ScreenUtil().setWidth(100),
                                  padding: EdgeInsets.symmetric(
                                      vertical: ScreenUtil().setWidth(5),
                                      horizontal: ScreenUtil().setWidth(10)),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.black.withOpacity(.5),
                                        width: .1),
                                  ),
                                  child: Container(
                                    height: ScreenUtil().setHeight(20),
                                    width: ScreenUtil().setWidth(80),
                                    decoration: BoxDecoration(
                                        color: ColorApps.light,
                                        borderRadius: BorderRadius.circular(
                                            ScreenUtil().setWidth(20))),
                                  ),
                                );
                              },
                            );
                          }),
                    )
                  : Container(
                      height: ScreenUtil().setHeight(35),
                      width: size.width,
                      child: StreamBuilder<TypeCategoryListState>(
                          stream: categoryBloc.getTypeCategory,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.isSuccess) {
                                typeCategoryList =
                                    snapshot.data.data.payload.rows;
                                if (allTypeCategory) {
                                  typeCategoryList.insert(0, typeCategory);
                                  allTypeCategory = false;
                                }
                                return ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: typeCategoryList.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          Container(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (typeCategory !=
                                            typeCategoryList[index]) {
                                          setState(() {
                                            typeCategory =
                                                typeCategoryList[index];
                                          });
                                          getFeeds();
                                        }
                                      },
                                      child: Container(
                                        height: ScreenUtil().setHeight(35),
                                        padding: EdgeInsets.symmetric(
                                            vertical: ScreenUtil().setWidth(5),
                                            horizontal:
                                                ScreenUtil().setWidth(10)),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color:
                                                  Colors.black.withOpacity(.5),
                                              width: .1),
                                        ),
                                        child: Text(
                                          typeCategoryList[index].typeCategory,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: typeCategory
                                                          .typeCategory ==
                                                      typeCategoryList[index]
                                                          .typeCategory
                                                  ? ColorApps.primary
                                                  : Colors.black
                                                      .withOpacity(.5),
                                              fontSize: ScreenUtil().setSp(10),
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            }
                            return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: 10,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      Container(),
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  height: ScreenUtil().setHeight(35),
                                  width: ScreenUtil().setWidth(100),
                                  padding: EdgeInsets.symmetric(
                                      vertical: ScreenUtil().setWidth(5),
                                      horizontal: ScreenUtil().setWidth(10)),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.black.withOpacity(.5),
                                        width: .1),
                                  ),
                                  child: Container(
                                    height: ScreenUtil().setHeight(20),
                                    width: ScreenUtil().setWidth(80),
                                    decoration: BoxDecoration(
                                        color: ColorApps.light,
                                        borderRadius: BorderRadius.circular(
                                            ScreenUtil().setWidth(20))),
                                  ),
                                );
                              },
                            );
                          }),
                    ),
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          page = 1;
          getFeeds();
          return null;
        },
        child: StreamBuilder<GetExploreState>(
            stream: feedBloc.getExplore,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.isLoading) {
                  if (page == 1) {
                    return ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return CardFeedsLoader(
                            context: context,
                            size: size,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(
                              height: ScreenUtil().setHeight(0),
                            ),
                        itemCount: 2);
                  }
                } else if (snapshot.data.hasError) {
                  onWidgetDidBuild(() {
                    if (snapshot.data.standby) {
                      showDialogMessage(context, snapshot.data.message,
                          "Terjadi Kesalahan, silahkan coba lagi");
                      feedBloc.unStandBy();
                    }
                  });
                  return Center(
                    child: Text(
                      snapshot.data.message,
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                } else if (snapshot.data.isSuccess) {
                  if (snapshot.data.standby) {
                    if (page < snapshot.data.data.payload.totalPage) {
                      isLoadMore = true;
                    } else {
                      isLoadMore = false;
                    }
                    if (page == 1) {
                      feedList = snapshot.data.data.payload.rows;
                      feedBloc.unStandBy();

                      if (feedList.length == 0) {
                        isEmpty = true;
                      } else {
                        isEmpty = false;
                      }
                    } else {
                      feedList.removeLast();
                      feedList.addAll(snapshot.data.data.payload.rows);
                      feedBloc.unStandBy();
                    }
                  }
                }
              }
              if (!isEmpty) {
                return ListView.separated(
                    controller: listController,
                    itemBuilder: (BuildContext context, int index) {
                      if (feedList[index].portfolioId != null) {
                        return CardFeedsItem(
                          context: context,
                          index: index,
                          size: size,
                          feed: feedList[index],
                          authBloc: widget.authBloc,
                          authUser: widget.authUser,
                          onPressed: () => Navigation().navigateScreen(
                              context,
                              DetailPortfolioScreen(
                                before: "feeds",
                                portfolioId: feedList[index].portfolioId,
                                profileDetail: feedList[index].userData,
                                authUser: widget.authUser,
//                              feedBloc: feedBloc,
                              )),
                          onLike: () async {
                            if (feedList[index].hasLike == 0) {
                              await feedBloc.feedServices
                                  .createLike(
                                      context, feedList[index].portfolioId)
                                  .then((response) {
                                if (response.code == "success") {
                                  setState(() {
                                    feedList[index].hasLike = 1;
                                    feedList[index].likeCount++;
                                  });
                                } else {
                                  showDialogMessage(context, response.message,
                                      "Terjadi kesalahan, silahkan coba lagi.");
                                }
                              });
                            } else {
                              await feedBloc.feedServices
                                  .deleteLike(
                                      context, feedList[index].portfolioId)
                                  .then((response) {
                                if (response.code == "success") {
                                  setState(() {
                                    feedList[index].hasLike = 0;
                                    feedList[index].likeCount--;
                                  });
                                } else {
                                  showDialogMessage(context, response.message,
                                      "Terjadi kesalahan, silahkan coba lagi.");
                                }
                              });
                            }
                          },
                          onBookmark: () async {
                            if (feedList[index].hasBookmark == 0) {
                              await feedBloc.feedServices
                                  .createBookmark(
                                      context, feedList[index].portfolioId)
                                  .then((response) {
                                if (response.code == "success") {
                                  setState(() {
                                    feedList[index].hasBookmark = 1;
                                  });
                                }
                              });
                            }
//                            else {
//                              await feedBloc.feedServices
//                                  .deleteBookmark(
//                                      context, feedList[index].portfolioId)
//                                  .then((response) {
//                                if (response.code == "success") {
//                                  setState(() {
//                                    feedList[index].hasBookmark = 0;
//                                  });
//                                }
//                              });
//                            }
                          },
                        );
                      } else {
                        return CardFeedsLoader(
                          context: context,
                          size: size,
                        );
                      }
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(
                          height: ScreenUtil().setHeight(0),
                        ),
                    itemCount: feedList.length);
              } else {
                return EmptyFeeds();
              }
            }),
      ),
    );
  }
}
