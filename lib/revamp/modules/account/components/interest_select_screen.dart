import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/lotties.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/assets/urls.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_state.dart';
import 'package:soedja_freelance/revamp/modules/category/bloc/category_bloc.dart';
import 'package:soedja_freelance/revamp/modules/category/bloc/category_state.dart';
import 'package:soedja_freelance/revamp/modules/category/models/category_model.dart';
import 'package:soedja_freelance/revamp/modules/dashboard/screens/dashboard_screen.dart';
import 'package:soedja_freelance/revamp/modules/feeds/bloc/feed_bloc.dart';
import 'package:soedja_freelance/revamp/modules/feeds/bloc/feed_state.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/models/portfolio_models.dart';
import 'package:soedja_freelance/revamp/modules/profile/models/profile_models.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

Future<dynamic> InterestSelectScreen({
  BuildContext context,
  AuthBloc authBloc,
  CategoryBloc categoryBloc,
}) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;
        int selected = 0;
        FeedBloc feedBloc = new FeedBloc();
        List<Category> categoryList = new List<Category>();

        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
          return Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(20),
                vertical: ScreenUtil().setHeight(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: ScreenUtil().setHeight(30)),
                Row(
                  children: <Widget>[
                    Expanded(child: Container()),
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.5),
                              blurRadius: 3,
                            )
                          ],
                          borderRadius: BorderRadius.circular(
                              AppBar().preferredSize.height / 2),
                        ),
                        alignment: Alignment.center,
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.black,
                            size: ScreenUtil().setSp(24),
                          ),
                          onPressed: () => Navigation().navigateBack(context),
                        )),
                  ],
                ),
                Text(
                  Texts.chooseInterest,
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
                StreamBuilder<CategoryListState>(
                    stream: categoryBloc.getCategory,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.isLoading) {
                          return Wrap(
                            spacing: ScreenUtil().setWidth(15),
                            runSpacing: ScreenUtil().setHeight(15),
                            children: List.generate(12, (index) {
                              return Container(
                                decoration: BoxDecoration(
                                    color: ColorApps.light,
                                    borderRadius: BorderRadius.circular(
                                        ScreenUtil().setHeight(5))),
                                height: ScreenUtil().setHeight(64),
                                width:
                                    (size.width - ScreenUtil().setWidth(55)) *
                                        1 /
                                        2,
                              );
                            }),
                          );
                        }
                        if (snapshot.data.hasError) {
                          if (snapshot.data.standby) {
                            onWidgetDidBuild(() {
                              showDialogMessage(context, snapshot.data.message,
                                  "Terjadi Kesalahan, silahkan coba lagi");
                              categoryBloc.unStandBy();
                            });
                          }
                        } else if (snapshot.data.isSuccess) {
                          if (snapshot.data.standby) {
                            categoryList = snapshot.data.data.payload.rows;

//                            categoryBloc.unStandBy();
                            return Wrap(
                              spacing: ScreenUtil().setWidth(15),
                              runSpacing: ScreenUtil().setHeight(15),
                              children: List.generate(12, (index) {
                                if (index != 11) {
                                  return Container(
                                    height: ScreenUtil().setHeight(64),
                                    width: (size.width -
                                            ScreenUtil().setWidth(55)) *
                                        1 /
                                        2,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          ScreenUtil().setHeight(5)),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (categoryList[index].selected) {
                                            categoryList[index].selected =
                                                false;
                                            selected--;
                                          } else {
                                            if (selected < 3) {
                                              categoryList[index].selected =
                                                  true;
                                              selected++;
                                            }
                                          }

                                          print(selected);
                                        },
                                        child: Stack(
                                          children: <Widget>[
                                            Positioned.fill(
                                              child: FadeInImage.assetNetwork(
                                                placeholder:
                                                    Images.imgPlaceholder,
                                                image: categoryList[index]
                                                            .pictureCover !=
                                                        null
                                                    ? BaseUrl.SoedjaAPI +
                                                        '/' +
                                                        categoryList[index]
                                                            .pictureCover
                                                    : '',
                                                height:
                                                    ScreenUtil().setHeight(64),
                                                width: (size.width -
                                                        ScreenUtil()
                                                            .setWidth(55)) *
                                                    1 /
                                                    2,
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                            Positioned.fill(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(.3),
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
                                                    width: ScreenUtil()
                                                        .setHeight(18),
                                                    decoration: BoxDecoration(
                                                      color: categoryList[index]
                                                              .selected
                                                          ? ColorApps.green
                                                          : ColorApps.lighter,
                                                      borderRadius: BorderRadius
                                                          .circular(ScreenUtil()
                                                              .setWidth(20)),
                                                      border: Border.all(
                                                          color:
                                                              ColorApps.white,
                                                          width: 2.0),
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
                                                          .replaceAll(
                                                              'Jasa ', ''),
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        color: ColorApps.white,
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                    width: (size.width -
                                            ScreenUtil().setWidth(55)) *
                                        1 /
                                        2,
                                    child: StreamBuilder<UpdateInterestState>(
                                        stream: feedBloc.getInterest,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            if (snapshot.data.isLoading) {
                                              return FlatButtonLoading(
                                                  context: context,
                                                  side: BorderSide(
                                                      color: Colors.black,
                                                      width: .5),
                                                  size: size,
                                                  color: Colors.white,
                                                  indicatorColor: Colors.black,
                                                  margin: EdgeInsets.zero);
                                            } else if (snapshot.data.hasError) {
                                              if (snapshot.data.standby) {
                                                onWidgetDidBuild(() {
                                                  showDialogMessage(
                                                      context,
                                                      snapshot.data.message,
                                                      "Terjadi kesalahan, silahkan coba lagi.");
                                                  feedBloc.unStandBy();
                                                });
                                              }
                                            } else if (snapshot
                                                .data.isSuccess) {
                                              if (snapshot.data.standby) {
                                                Navigation()
                                                    .navigateBack(context);
                                                feedBloc.requestGetList(
                                                    context, 10, 1, "");
                                                feedBloc.unStandBy();
                                              }
                                            }
                                          }
                                          return FlatButtonText(
                                              context: context,
                                              side: BorderSide(
                                                  color: Colors.black,
                                                  width: .5),
                                              text: Texts.done.toUpperCase(),
                                              color: Colors.white,
                                              textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize:
                                                    ScreenUtil().setSp(15),
                                                fontWeight: FontWeight.bold,
                                              ),
                                              onPressed: () {
                                                feedBloc.requestUpdateInterest(
                                                    context, categoryList);
                                              });
                                        }),
                                  );
                                }
                              }),
                            );
                          }
                        }
                      }
                      return Container();
                    }),
                Expanded(child: SizedBox(height: ScreenUtil().setHeight(20))),
              ],
            ),
          );
        });
      });
}

Widget AvatarProfile({ProfileDetail profile, double size}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(size ?? ScreenUtil().setSp(18)),
    child: Container(
      width: size ?? 24,
      color: Colors.black.withOpacity(.05),
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: FadeInImage.assetNetwork(
            placeholder: avatar(profile != null ? profile.name : "A"),
            fit: BoxFit.cover,
            image: profile.picture.length > 0
                ? BaseUrl.SoedjaAPI + "/" + profile.picture
                : ""),
      ),
    ),
  );
}
