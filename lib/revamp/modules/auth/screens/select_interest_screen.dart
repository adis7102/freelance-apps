import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/assets/urls.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/category/bloc/category_bloc.dart';
import 'package:soedja_freelance/revamp/modules/category/bloc/category_state.dart';
import 'package:soedja_freelance/revamp/modules/category/models/category_model.dart';
import 'package:soedja_freelance/revamp/modules/dashboard/screens/dashboard_screen.dart';
import 'package:soedja_freelance/revamp/modules/feeds/bloc/feed_bloc.dart';
import 'package:soedja_freelance/revamp/modules/feeds/bloc/feed_state.dart';
import 'package:soedja_freelance/revamp/modules/feeds/components/feeds_component.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

class SelectInterestScreen extends StatefulWidget {
  final AuthBloc authBloc;
  final FeedBloc feedBloc;
  final String before;

  const SelectInterestScreen(
      {Key key, this.authBloc, this.before, this.feedBloc})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SelectInterestScreen();
  }
}

class _SelectInterestScreen extends State<SelectInterestScreen> {
  CategoryBloc categoryBloc = new CategoryBloc();
  int selected = 0;
  List<Category> categoryList = new List<Category>();
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    getCategory();
    super.initState();
  }

  getCategory() async {
    await categoryBloc
        .getCategories(context, CategoryPayload(type: ""))
        .then((response) {
      if (response.code == "success") {
        setState(() {
          categoryList = response.payload.rows;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          hasError = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        if (widget.before != "new_user") {
          Navigation().navigateBack(context);
        }
        return null;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: <Widget>[
            Visibility(
              visible: widget.before != "new_user",
              child: PreferredSize(
                preferredSize: AppBar().preferredSize,
                child: Container(
                  width: AppBar().preferredSize.height,
                  height: AppBar().preferredSize.height,
                  child: Container(
                    margin: EdgeInsets.all(ScreenUtil().setWidth(5)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.2),
                          blurRadius: 3,
                        )
                      ],
                      borderRadius: BorderRadius.circular(
                          AppBar().preferredSize.height / 2),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                      onPressed: () => Navigation().navigateBack(context),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            getCategory();
            return null;
          },
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  Texts.chooseInterest + " ($selected/3)",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(30),
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                Text(
                  Texts.descInterest,
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(14),
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                showCategory(context, size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showCategory(BuildContext context, Size size) {
    if (isLoading) {
      return Wrap(
        spacing: ScreenUtil().setWidth(15),
        runSpacing: ScreenUtil().setHeight(15),
        children: List.generate(12, (index) {
          return Container(
            decoration: BoxDecoration(
                color: ColorApps.light,
                borderRadius: BorderRadius.circular(ScreenUtil().setHeight(5))),
            height: ScreenUtil().setHeight(64),
            width: (size.width - ScreenUtil().setWidth(55)) * 1 / 2,
          );
        }),
      );
    } else {
      if (categoryList.length > 0) {
        return Wrap(
          spacing: ScreenUtil().setWidth(15),
          runSpacing: ScreenUtil().setHeight(15),
          children: List.generate(12, (index) {
            if (index != 11) {
              return Container(
                height: ScreenUtil().setHeight(64),
                width: (size.width - ScreenUtil().setWidth(55)) * 1 / 2,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().setHeight(5)),
                  child: GestureDetector(
                    onTap: () {
                      if (categoryList[index].selected) {
                        categoryList[index].selected = false;
                        selected--;
                      } else {
                        if (selected < 3) {
                          categoryList[index].selected = true;
                          selected++;
                        }
                      }
                      print(selected);
                      setState(() {});
                    },
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: FadeInImage.assetNetwork(
                            placeholder: Images.imgPlaceholder,
                            image: categoryList[index].pictureCover != null
                                ? BaseUrl.SoedjaAPI +
                                    '/' +
                                    categoryList[index].pictureCover
                                : '',
                            height: ScreenUtil().setHeight(64),
                            width: (size.width - ScreenUtil().setWidth(55)) *
                                1 /
                                2,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.3),
                            ),
                          ),
                        ),
                        Positioned(
                          left: ScreenUtil().setWidth(20),
                          top: 0,
                          bottom: 0,
                          right: ScreenUtil().setWidth(20),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: ScreenUtil().setHeight(18),
                                decoration: BoxDecoration(
                                  color: categoryList[index].selected
                                      ? ColorApps.green
                                      : ColorApps.lighter,
                                  borderRadius: BorderRadius.circular(
                                      ScreenUtil().setWidth(20)),
                                  border: Border.all(
                                      color: ColorApps.white, width: 2.0),
                                ),
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                ),
                              ),
                              SizedBox(width: 16.0),
                              Expanded(
                                child: Text(
                                  categoryList[index]
                                      .category
                                      .replaceAll('Jasa ', ''),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: ColorApps.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container(
                height: ScreenUtil().setHeight(64),
                width: (size.width - ScreenUtil().setWidth(55)) * 1 / 2,
                child: StreamBuilder<UpdateInterestState>(
                    stream: widget.feedBloc.getInterest,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.isLoading) {
                          return FlatButtonLoading(
                              context: context,
                              side: BorderSide(color: Colors.black, width: .5),
                              size: size,
                              color: Colors.white,
                              indicatorColor: Colors.black,
                              margin: EdgeInsets.zero);
                        } else if (snapshot.data.hasError) {
                          if (snapshot.data.standby) {
                            onWidgetDidBuild(() {
                              showDialogMessage(context, snapshot.data.message,
                                  "Terjadi kesalahan, silahkan coba lagi.");
                              widget.feedBloc.unStandBy();
                            });
                          }
                        } else if (snapshot.data.isSuccess) {
                          if (snapshot.data.standby) {
                            onWidgetDidBuild((){
                              Navigation().navigateReplacement(
                                  context,
                                  DashboardScreen(
                                    before: "home",
                                  ));
                            });
                            widget.feedBloc.unStandBy();
                          }
                        }
                      }
                      return FlatButtonText(
                          context: context,
                          side: BorderSide(color: Colors.black, width: .5),
                          text: Texts.done.toUpperCase(),
                          color: Colors.white,
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: ScreenUtil().setSp(15),
                            fontWeight: FontWeight.bold,
                          ),
                          onPressed: () {
                            if (selected == 0) {
                              showDialogMessage(
                                  context,
                                  "Belum Pilih Ketertarikan",
                                  "Silahkan pilih ketertarikanmu minimal 1 dan maksimal 3");

                              return null;
                            }
                            widget.feedBloc
                                .requestUpdateInterest(context, categoryList);
                          });
                    }),
              );
            }
          }),
        );
      } else {
        return Expanded(
          child: EmptyFeeds(),
        );
      }
    }
  }
}

//Widget Category(BuildContext context){
//  return StreamBuilder<CategoryListState>(
//      stream: categoryBloc.getCategory,
//      builder: (context, snapshot) {
//        if (snapshot.hasData) {
//          if (snapshot.data.isLoading) {
//            return Wrap(
//              spacing: ScreenUtil().setWidth(15),
//              runSpacing: ScreenUtil().setHeight(15),
//              children: List.generate(12, (index) {
//                return Container(
//                  decoration: BoxDecoration(
//                      color: ColorApps.light,
//                      borderRadius: BorderRadius.circular(
//                          ScreenUtil().setHeight(5))),
//                  height: ScreenUtil().setHeight(64),
//                  width: (size.width - ScreenUtil().setWidth(55)) *
//                      1 /
//                      2,
//                );
//              }),
//            );
//          }
//          if (snapshot.data.hasError) {
//            if (snapshot.data.standby) {
//              onWidgetDidBuild(() {
//                showDialogMessage(context, snapshot.data.message,
//                    "Terjadi Kesalahan, silahkan coba lagi");
//                categoryBloc.unStandBy();
//              });
//            }
//          } else if (snapshot.data.isSuccess) {
//            if (snapshot.data.standby) {
//              onWidgetDidBuild(() {
//                categoryList = snapshot.data.data.payload.rows;
//
//                List<String> select = [];
////                            for(Category category in categoryList){
////                              if(category.selected){
////                                select.add(category.category);
////                              }
////                            }
//
////                            print(select);
//              });
//            }
//          }
//        }
//        return Wrap(
//          spacing: ScreenUtil().setWidth(15),
//          runSpacing: ScreenUtil().setHeight(15),
//          children: List.generate(12, (index) {
//            if (index != 11) {
//              return Container(
//                height: ScreenUtil().setHeight(64),
//                width: (size.width - ScreenUtil().setWidth(55)) *
//                    1 /
//                    2,
//                child: ClipRRect(
//                  borderRadius: BorderRadius.circular(
//                      ScreenUtil().setHeight(5)),
//                  child: GestureDetector(
//                    onTap: () {
//                      if (categoryList[index].selected) {
//                        categoryList[index].selected = false;
//                        selected--;
//                      } else {
//                        if (selected < 3) {
//                          categoryList[index].selected = true;
//                          selected++;
//                        }
//                      }
//                      List<String> select = [];
//                      for (Category category in categoryList) {
//                        if (category.selected) {
//                          select.add(category.category);
//                        }
//                      }
//
//                      print(select);
//                      print(selected);
//                    },
//                    child: Stack(
//                      children: <Widget>[
//                        Positioned.fill(
//                          child: FadeInImage.assetNetwork(
//                            placeholder: Images.imgPlaceholder,
//                            image: categoryList[index]
//                                .pictureCover !=
//                                null
//                                ? BaseUrl.SoedjaAPI +
//                                '/' +
//                                categoryList[index].pictureCover
//                                : '',
//                            height: ScreenUtil().setHeight(64),
//                            width: (size.width -
//                                ScreenUtil().setWidth(55)) *
//                                1 /
//                                2,
//                            fit: BoxFit.fitWidth,
//                          ),
//                        ),
//                        Positioned.fill(
//                          child: Container(
//                            decoration: BoxDecoration(
//                              color: Colors.black.withOpacity(.3),
//                            ),
//                          ),
//                        ),
//                        Positioned(
//                          left: ScreenUtil().setWidth(20),
//                          top: 0,
//                          bottom: 0,
//                          right: ScreenUtil().setWidth(20),
//                          child: Row(
//                            children: <Widget>[
//                              Container(
//                                width: ScreenUtil().setHeight(18),
//                                decoration: BoxDecoration(
//                                  color:
//                                  categoryList[index].selected
//                                      ? ColorApps.green
//                                      : ColorApps.lighter,
//                                  borderRadius:
//                                  BorderRadius.circular(
//                                      ScreenUtil()
//                                          .setWidth(20)),
//                                  border: Border.all(
//                                      color: ColorApps.white,
//                                      width: 2.0),
//                                ),
//                                child: AspectRatio(
//                                  aspectRatio: 1 / 1,
//                                ),
//                              ),
//                              SizedBox(width: 16.0),
//                              Expanded(
//                                child: Text(
//                                  categoryList[index]
//                                      .category
//                                      .replaceAll('Jasa ', ''),
//                                  textAlign: TextAlign.left,
//                                  style: TextStyle(
//                                    color: ColorApps.white,
//                                    fontSize: 15.0,
//                                    fontWeight: FontWeight.bold,
//                                  ),
//                                ),
//                              ),
//                            ],
//                          ),
//                        )
//                      ],
//                    ),
//                  ),
//                ),
//              );
//            } else {
//              return Container(
//                height: ScreenUtil().setHeight(64),
//                width: (size.width - ScreenUtil().setWidth(55)) *
//                    1 /
//                    2,
//                child: StreamBuilder<UpdateInterestState>(
//                    stream: widget.feedBloc.getInterest,
//                    builder: (context, snapshot) {
//                      if (snapshot.hasData) {
//                        if (snapshot.data.isLoading) {
//                          return FlatButtonLoading(
//                              context: context,
//                              side: BorderSide(
//                                  color: Colors.black, width: .5),
//                              size: size,
//                              color: Colors.white,
//                              indicatorColor: Colors.black,
//                              margin: EdgeInsets.zero);
//                        } else if (snapshot.data.hasError) {
//                          if (snapshot.data.standby) {
//                            onWidgetDidBuild(() {
//                              showDialogMessage(
//                                  context,
//                                  snapshot.data.message,
//                                  "Terjadi kesalahan, silahkan coba lagi.");
////                                              feedBloc.unStandBy();
//                            });
//                          }
//                        } else if (snapshot.data.isSuccess) {
//                          if (snapshot.data.standby) {
////                                            Navigation()
////                                                .navigateBack(context);
////                                            feedBloc.requestGetList(
////                                                context, 10, 1, "");
////                                            feedBloc.unStandBy();
//                          }
//                        }
//                      }
//                      return FlatButtonText(
//                          context: context,
//                          side: BorderSide(
//                              color: Colors.black, width: .5),
//                          text: Texts.done.toUpperCase(),
//                          color: Colors.white,
//                          textStyle: TextStyle(
//                            color: Colors.black,
//                            fontSize: ScreenUtil().setSp(15),
//                            fontWeight: FontWeight.bold,
//                          ),
//                          onPressed: () {
//                            widget.feedBloc.requestUpdateInterest(
//                                context, categoryList);
//                          });
//                    }),
//              );
//            }
//          }),
//        );
//      });
//}
