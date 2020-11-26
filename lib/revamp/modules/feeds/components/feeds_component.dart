import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/assets/urls.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';
import 'package:soedja_freelance/revamp/modules/feeds/screens/feeds_like_screen.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/screens/detail_portfolio_screen.dart';
import 'package:soedja_freelance/revamp/modules/profile/models/profile_models.dart';
import 'package:soedja_freelance/revamp/modules/profile/screens/profile_detail_screen.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

Widget CardFeedsItem(
    {BuildContext context,
    int index,
    Size size,
    AuthBloc authBloc,
    Feed feed,
    @required ProfileDetail authUser,
    Function onPressed,
    Function onLike,
    Function onBookmark}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      height: size.width,
      width: size.width,
      margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
              child: Container(
                  color: Colors.black.withOpacity(.05),
                  child: FadeInImage.assetNetwork(
                      placeholder: Images.imgPlaceholder,
                      height: size.width,
                      width: size.width,
                      fit: BoxFit.cover,
                      image: feed.pictures.length > 0
                          ? BaseUrl.SoedjaAPI + "/" + feed.pictures[0].path
                          : ""))),
          Positioned.fill(
              child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black12])),
          )),
          Positioned(
              top: 0,
              left: 0,
              child: Visibility(
                visible: feed.youtubeUrl.contains("youtube.com"),
                child: Container(
                  margin: EdgeInsets.all(ScreenUtil().setSp(20)),
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(10),
                      horizontal: ScreenUtil().setWidth(15)),
                  decoration: BoxDecoration(
                    color: ColorApps.primary,
                    borderRadius: BorderRadius.circular(ScreenUtil().setSp(20)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(1, 2)),
                    ],
                  ),
                  child: Text(
                    "Video",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(10),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              )),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.all(ScreenUtil().setSp(20)),
              padding: EdgeInsets.all(ScreenUtil().setSp(20)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ScreenUtil().setSp(15)),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: AvatarTitleSubtitle(
                            context: context,
                            authBloc: authBloc,
                            profile: feed.userData,
                            title: feed.title,
                            subtitle: feed.userData.name,
                            from: 'feeds',
                            profileAuth: authUser),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF0F0F0),
                          borderRadius: BorderRadius.circular(ScreenUtil().setHeight(50)),
                        ),
                        child: Container(
                          margin: EdgeInsets.only(top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(5), right: ScreenUtil().setWidth(5), left: ScreenUtil().setWidth(25)),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: ScreenUtil().setWidth(20),
                                height: ScreenUtil().setHeight(20),
                                margin: EdgeInsets.only(right: ScreenUtil().setWidth(5)),
                                child: SvgPicture.asset(
                                  Images.iconHowtoRegRedSvg,
                                  semanticsLabel: 'Icon viewed'
                                ),
                              ),
                              Container(
                                child: Text(
                                  '${feed.viewer.toString()}',
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(13)
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle
                                ),
                                padding: EdgeInsets.all(ScreenUtil().setHeight(10)),
                                child: Container(
                                  child: Icon(
                                    Icons.chevron_right,
                                    size: ScreenUtil().setSp(25),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                      // SizedBox(width: ScreenUtil().setWidth(10)),
                      // GestureDetector(
                      //   onTap: onBookmark,
                      //   child: Container(
                      //     color: Colors.white,
                      //     child: Icon(
                      //       feed.hasBookmark == 1
                      //           ? Icons.star
                      //           : Icons.star_border,
                      //       color: feed.hasBookmark == 1
                      //           ? ColorApps.green
                      //           : Colors.black,
                      //       size: ScreenUtil().setSp(24),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(width: ScreenUtil().setWidth(10)),
                      // Icon(
                      //   Icons.more_vert,
                      //   color: Colors.black,
                      //   size: ScreenUtil().setSp(24),
                      // ),
                    ],
                  ),
                  // Row(
                  //   children: <Widget>[
                  //     GestureDetector(
                  //       onTap: onLike,
                  //       child: Container(
                  //         width: ScreenUtil().setWidth(20),
                  //         color: Colors.white,
                  //         child: AspectRatio(
                  //           aspectRatio: 1 / 1,
                  //           child: SvgPicture.asset(
                  //             feed.hasLike == 0
                  //                 ? Images.iconHeart
                  //                 : Images.iconLiked,
                  //             width: ScreenUtil().setWidth(20),
                  //             semanticsLabel: "icon_heart",
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(width: ScreenUtil().setWidth(10)),
                  //     Container(
                  //       width: ScreenUtil().setWidth(120),
                  //       padding: EdgeInsets.symmetric(
                  //           horizontal: ScreenUtil().setWidth(10),
                  //           vertical: ScreenUtil().setHeight(8)),
                  //       decoration: BoxDecoration(
                  //         borderRadius:
                  //             BorderRadius.circular(ScreenUtil().setSp(25)),
                  //         border: Border.all(
                  //             color: Colors.black.withOpacity(.2), width: .2),
                  //       ),
                  //       child: Row(
                  //         children: <Widget>[
                  //           SizedBox(width: ScreenUtil().setWidth(5)),
                  //           SvgPicture.asset(
                  //             Images.iconCommentSvg,
                  //             height: ScreenUtil().setHeight(17),
                  //             width: ScreenUtil().setWidth(20),
                  //             semanticsLabel: "icon_comment",
                  //           ),
                  //           SizedBox(width: ScreenUtil().setWidth(10)),
                  //           Text(
                  //             Texts.comment,
                  //             style: TextStyle(
                  //                 color: Colors.black.withOpacity(.5),
                  //                 fontSize: ScreenUtil().setSp(10)),
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //     Expanded(
                  //         child: SizedBox(width: ScreenUtil().setWidth(5))),
                  //     SvgPicture.asset(
                  //       Images.iconCommentCountSvg,
                  //       height: ScreenUtil().setHeight(30),
                  //       width: ScreenUtil().setWidth(30),
                  //       semanticsLabel: "icon_comment_count",
                  //     ),
                  //     SizedBox(width: ScreenUtil().setWidth(5)),
                  //     Text(
                  //       feed.commentCount.toString(),
                  //       style: TextStyle(
                  //           color: Colors.black,
                  //           fontWeight: FontWeight.normal,
                  //           fontSize: ScreenUtil().setSp(12)),
                  //     ),
                  //     SizedBox(width: ScreenUtil().setWidth(15)),
                  //     GestureDetector(
                  //       onTap: () => Navigation().navigateScreen(
                  //           context,
                  //           FeedLikeScreen(
                  //             feed: feed,
                  //             authUser: authUser,
                  //           )),
                  //       child: Container(
                  //         color: Colors.white,
                  //         child: Row(
                  //           mainAxisSize: MainAxisSize.min,
                  //           children: <Widget>[
                  //             SvgPicture.asset(
                  //               Images.iconLikeCountSvg,
                  //               height: ScreenUtil().setHeight(30),
                  //               width: ScreenUtil().setWidth(30),
                  //               semanticsLabel: "icon_like_count",
                  //             ),
                  //             SizedBox(width: ScreenUtil().setWidth(5)),
                  //             Text(
                  //               feed.likeCount.toString(),
                  //               style: TextStyle(
                  //                   color: Colors.black,
                  //                   fontWeight: FontWeight.normal,
                  //                   fontSize: ScreenUtil().setSp(12)),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget CardFeedsLoader({BuildContext context, int index, Size size}) {
  return Container(
    height: size.width,
    width: size.width,
    margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
    child: Stack(
      children: <Widget>[
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(.05),
            height: size.width,
          ),
        ),
        Positioned(
            top: 0,
            left: 0,
            child: Container(
              margin: EdgeInsets.all(ScreenUtil().setSp(20)),
              padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(10),
                  horizontal: ScreenUtil().setWidth(15)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ScreenUtil().setSp(20)),
              ),
              child: Text(
                "Video",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(10),
                  fontWeight: FontWeight.normal,
                ),
              ),
            )),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            margin: EdgeInsets.all(ScreenUtil().setSp(20)),
            padding: EdgeInsets.all(ScreenUtil().setSp(20)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(ScreenUtil().setSp(5)),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setSp(18)),
                      child: Container(
                        width: ScreenUtil().setWidth(32),
                        color: Colors.black.withOpacity(.05),
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                        ),
                      ),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(ScreenUtil().setSp(20)),
                            height: ScreenUtil().setHeight(15),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.05),
                              borderRadius:
                                  BorderRadius.circular(ScreenUtil().setSp(5)),
                            ),
                          ),
                          SizedBox(height: ScreenUtil().setHeight(3)),
                          Container(
                            padding: EdgeInsets.all(ScreenUtil().setSp(20)),
                            height: ScreenUtil().setHeight(10),
                            width: ScreenUtil().setWidth(100),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.05),
                              borderRadius:
                                  BorderRadius.circular(ScreenUtil().setSp(5)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setSp(18)),
                      child: Container(
                        width: ScreenUtil().setWidth(32),
                        color: Colors.black.withOpacity(.05),
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                        ),
                      ),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setSp(18)),
                      child: Container(
                        width: ScreenUtil().setWidth(32),
                        color: Colors.black.withOpacity(.05),
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setSp(18)),
                      child: Container(
                        width: ScreenUtil().setWidth(20),
                        color: Colors.black.withOpacity(.05),
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                        ),
                      ),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    Container(
                      width: ScreenUtil().setWidth(120),
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(10),
                          vertical: ScreenUtil().setHeight(8)),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setSp(25)),
                        border: Border.all(
                            color: Colors.black.withOpacity(.2), width: .2),
                      ),
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: ScreenUtil().setWidth(5)),
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(ScreenUtil().setSp(18)),
                            child: Container(
                              height: ScreenUtil().setHeight(20),
                              color: Colors.black.withOpacity(.05),
                              child: AspectRatio(
                                aspectRatio: 1 / 1,
                              ),
                            ),
                          ),
                          SizedBox(width: ScreenUtil().setWidth(10)),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setSp(20)),
                            height: ScreenUtil().setHeight(15),
                            width: ScreenUtil().setWidth(50),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.05),
                              borderRadius:
                                  BorderRadius.circular(ScreenUtil().setSp(5)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: SizedBox(width: ScreenUtil().setWidth(5))),
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setSp(18)),
                      child: Container(
                        width: ScreenUtil().setWidth(32),
                        color: Colors.black.withOpacity(.05),
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                        ),
                      ),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(5)),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setSp(20)),
                      height: ScreenUtil().setHeight(20),
                      width: ScreenUtil().setWidth(32),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.05),
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setSp(5)),
                      ),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(15)),
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setSp(18)),
                      child: Container(
                        width: ScreenUtil().setWidth(32),
                        color: Colors.black.withOpacity(.05),
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                        ),
                      ),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(5)),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setSp(20)),
                      height: ScreenUtil().setHeight(20),
                      width: ScreenUtil().setWidth(32),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.05),
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setSp(5)),
                      ),
                    ),
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

Widget CardVideoItem({
  BuildContext context,
  int index,
  Size size,
  Feed feed,
  AuthBloc authBloc,
  ProfileDetail authUser,
  Function onBookmark,
  Function onDetail,
}) {
  return GestureDetector(
    onTap: onDetail,
    child: Container(
      width: size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              width: ScreenUtil().setWidth(80),
              color: Colors.black.withOpacity(.05),
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: FadeInImage.assetNetwork(
                    placeholder: Images.imgPlaceholder,
                    fit: BoxFit.cover,
                    image: feed.pictures.length > 0
                        ? BaseUrl.SoedjaAPI + "/" + feed.pictures[0].path
                        : ""),
              )),
          SizedBox(width: ScreenUtil().setWidth(20)),
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: ScreenUtil().setHeight(40),
                        child: Text(
                          feed.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: ScreenUtil().setSp(12),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    GestureDetector(
                      onTap: onBookmark,
                      child: Container(
                        color: Colors.white,
                        child: Icon(
                          feed.hasBookmark == 1
                              ? Icons.star
                              : Icons.star_border,
                          color: feed.hasBookmark == 1
                              ? ColorApps.green
                              : Colors.black,
                          size: ScreenUtil().setSp(24),
                        ),
                      ),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    Icon(
                      Icons.more_vert,
                      color: Colors.black,
                      size: ScreenUtil().setSp(24),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtil().setHeight(10)),
                Row(
                  children: <Widget>[
                    AvatarTitleSubtitle(
                        context: context,
                        authBloc: authBloc,
                        profile: feed.userData,
                        title: feed.userData.name,
                        fontSize: 10,
                        subtitle: (feed.userData.province.length > 0
                            ? "${feed.userData.province}, Indonesia"
                            : "Indonesia"),
                        from: 'videos',
                        profileAuth: authUser),
                    Container(
                      height: ScreenUtil().setHeight(36),
                      child: FlatButtonWidget(
                          context: context,
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(10)),
                          side: BorderSide(
                              color: Colors.black.withOpacity(.5), width: .2),
                          borderRadius: BorderRadius.circular(
                            ScreenUtil().setHeight(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.play_arrow,
                                color: Colors.black,
                                size: ScreenUtil().setHeight(20),
                              ),
                              SizedBox(width: ScreenUtil().setWidth(5)),
                              Text(
                                "Lihat",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: ScreenUtil().setSp(12)),
                              )
                            ],
                          ),
                          onPressed: onDetail),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget CardVideoLoader({BuildContext context, int index, Size size}) {
  return Container(
    width: size.width,
    child: Row(
      children: <Widget>[
        Container(
            width: ScreenUtil().setWidth(80),
            color: Colors.black.withOpacity(.05),
            child: AspectRatio(
              aspectRatio: 1 / 1,
            )),
        SizedBox(width: ScreenUtil().setWidth(20)),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: ScreenUtil().setWidth(200),
                          height: ScreenUtil().setHeight(12),
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.05),
                              borderRadius: BorderRadius.circular(
                                  ScreenUtil().setHeight(10))),
                        ),
                        SizedBox(height: ScreenUtil().setWidth(5)),
                        Container(
                          width: ScreenUtil().setWidth(200),
                          height: ScreenUtil().setHeight(12),
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.05),
                              borderRadius: BorderRadius.circular(
                                  ScreenUtil().setHeight(10))),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(10)),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(ScreenUtil().setSp(18)),
                    child: Container(
                      width: ScreenUtil().setWidth(32),
                      color: Colors.black.withOpacity(.05),
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                      ),
                    ),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(10)),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(ScreenUtil().setSp(18)),
                    child: Container(
                      width: ScreenUtil().setWidth(32),
                      color: Colors.black.withOpacity(.05),
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtil().setHeight(10)),
              Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(ScreenUtil().setSp(18)),
                    child: Container(
                      width: ScreenUtil().setWidth(32),
                      color: Colors.black.withOpacity(.05),
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                      ),
                    ),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(10)),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(ScreenUtil().setSp(20)),
                          height: ScreenUtil().setHeight(15),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(.05),
                            borderRadius:
                                BorderRadius.circular(ScreenUtil().setSp(5)),
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(3)),
                        Container(
                          padding: EdgeInsets.all(ScreenUtil().setSp(20)),
                          height: ScreenUtil().setHeight(10),
                          width: ScreenUtil().setWidth(100),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(.05),
                            borderRadius:
                                BorderRadius.circular(ScreenUtil().setSp(5)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(10)),
                  Container(
                    height: ScreenUtil().setHeight(36),
                    width: ScreenUtil().setWidth(100),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.05),
                      borderRadius: BorderRadius.circular(
                        ScreenUtil().setHeight(20),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget AvatarTitleSubtitle({
  BuildContext context,
  ProfileDetail profile,
  @required ProfileDetail profileAuth,
  AuthBloc authBloc,
  String title,
  String subtitle,
  String from,
  double fontSize,
}) {
  return Expanded(
    child: GestureDetector(
      onTap: () {
        Navigation().navigateScreen(
            context,
            ProfileDetailScreen(
              authBloc: authBloc,
              authUser: profileAuth,
              profileDetail: profile,
              before: "",
//              profileAuth: profileAuth,
//              profile: profile,
            ));
      },
      child: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(ScreenUtil().setSp(18)),
              child: Container(
                width: ScreenUtil().setWidth(32),
                color: Colors.black.withOpacity(.05),
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: FadeInImage.assetNetwork(
                      placeholder: avatar(profile.name),
                      fit: BoxFit.cover,
                      image: profile.picture.length > 0
                          ? BaseUrl.SoedjaAPI + "/" + profile.picture
                          : ""),
                ),
              ),
            ),
            SizedBox(width: ScreenUtil().setWidth(10.5)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    subtitle,
                    style: TextStyle(
                        color: Colors.black.withOpacity(.5),
                        fontSize: ScreenUtil().setSp(11),
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(5)),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(fontSize ?? 12.8),
                        fontWeight: FontWeight.bold),
                  ),                  
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget PortfolioCategory(
  BuildContext context,
  String category,
  String subCategory,
  String typeCategory,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(20),
              vertical: ScreenUtil().setHeight(10)),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(ScreenUtil().setSp(20)),
          ),
          child: Text(
            category,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: ScreenUtil().setSp(12),
            ),
          ),
        ),
        Divider(height: ScreenUtil().setHeight(40)),
        Wrap(
          spacing: ScreenUtil().setWidth(10),
          children: <Widget>[
            subCategory != null && subCategory.length > 0
                ? Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(20),
                        vertical: ScreenUtil().setHeight(10)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: Colors.black.withOpacity(.8), width: .2),
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setSp(20)),
                    ),
                    child: Text(
                      subCategory ?? "",
                      style: TextStyle(
                        color: Colors.black.withOpacity(.5),
                        fontWeight: FontWeight.normal,
                        fontSize: ScreenUtil().setSp(12),
                      ),
                    ),
                  )
                : Container(),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(20),
                  vertical: ScreenUtil().setHeight(10)),
              decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(color: Colors.black.withOpacity(.8), width: .2),
                borderRadius: BorderRadius.circular(ScreenUtil().setSp(20)),
              ),
              child: Text(
                typeCategory,
                style: TextStyle(
                  color: Colors.black.withOpacity(.5),
                  fontWeight: FontWeight.normal,
                  fontSize: ScreenUtil().setSp(12),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget CardGallery({
  BuildContext context,
  Size size,
  File image,
  String path,
  Function onRemove,
  bool isRemovable,
  bool loadingRemove = false,
}) {
  return Container(
    width: 110,
    height: 110,
    decoration: BoxDecoration(
        color: ColorApps.white,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: ColorApps.grey707070, width: .2)),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: image != null
                ? Container(
                    child: Image.file(
                      image,
                      width: 105,
                      height: 105,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    child: FadeInImage.assetNetwork(
                        placeholder: Images.imgPlaceholder,
                        fit: BoxFit.cover,
                        width: 105,
                        height: 105,
                        image: path.length > 0
                            ? BaseUrl.SoedjaAPI + "/" + path
                            : ""),
                  ),
          ),
          Positioned.fill(
            child: Visibility(
              visible: loadingRemove,
              child: Container(
                width: 105,
                height: 105,
                color: Colors.white.withOpacity(.8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SmallLayoutLoading(context, Colors.black),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: ScreenUtil().setSp(6),
            right: ScreenUtil().setSp(6),
            child: Visibility(
              visible: isRemovable && !loadingRemove,
              child: GestureDetector(
                onTap: onRemove,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 3)
                      ],
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setSp(12))),
                  child: Icon(
                    Icons.close,
                    size: ScreenUtil().setSp(20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget EmptyFeeds() {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset(
          Images.illustrationEmptyFeeds,
          width: ScreenUtil().setWidth(80.0),
          height: ScreenUtil().setHeight(80.0),
        ),
        SizedBox(height: ScreenUtil().setHeight(10)),
        Text(
          Texts.notFound,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: ScreenUtil().setSp(20),
            height: 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.0),
        Text(
          Texts.emptySearch,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black.withOpacity(.5),
            fontSize: ScreenUtil().setSp(12),
            height: 1.5,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}

Widget CardSearchFeedsItem({
  BuildContext context,
  bool isBookmark,
  AuthBloc authBloc,
  int index,
  Size size,
  Feed feed,
  ProfileDetail profileDetail,
  @required ProfileDetail authUser,
  Function onPressed,
  Function onBookmark,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      color: Colors.white,
      width: (size.width - ScreenUtil().setWidth(40)) * 1 / 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              width: (size.width - ScreenUtil().setWidth(40)) * 1 / 2,
              color: Colors.black.withOpacity(.05),
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: FadeInImage.assetNetwork(
                    placeholder: Images.imgPlaceholder,
                    fit: BoxFit.cover,
                    image: feed != null && feed.pictures.length > 0
                        ? BaseUrl.SoedjaAPI + "/" + feed.pictures[0].path
                        : ""),
              )),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Container(
            height: ScreenUtil().setHeight(40),
            child: Text(
              feed != null ? feed.title : "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(12),
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              AvatarTitleSubtitle(
                context: context,
                authBloc: authBloc,
                profile: feed.userData != null ? feed.userData : profileDetail,
                title: feed.userData != null
                    ? feed.userData.name
                    : profileDetail.name,
                subtitle: feed.userData != null
                    ? feed.userData.name
                    : profileDetail.name,
                from: 'feeds',
                profileAuth: authUser,
              ),
              IconButton(
                onPressed: onBookmark,
                icon: Icon(
                  feed.hasBookmark == 1 || isBookmark
                      ? Icons.star
                      : Icons.star_border,
                  color: feed.hasBookmark == 1 || isBookmark
                      ? ColorApps.green
                      : Colors.black,
                  size: ScreenUtil().setWidth(20),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget CardSearchFeedsLoader(
    {BuildContext context,
    int index,
    Size size,
    Feed feed,
    Function onPressed}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      color: Colors.white,
      width: (size.width - ScreenUtil().setWidth(40)) * 1 / 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              width: (size.width - ScreenUtil().setWidth(40)) * 1 / 2,
              color: Colors.black.withOpacity(.05),
              child: AspectRatio(
                aspectRatio: 1 / 1,
              )),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Container(
            width: (size.width - ScreenUtil().setWidth(40)) * 1 / 2,
            height: ScreenUtil().setHeight(14),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(.05),
                borderRadius:
                    BorderRadius.circular(ScreenUtil().setHeight(10))),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(5),
          ),
          Container(
            width: (size.width - ScreenUtil().setWidth(40)) * 1 / 4,
            height: ScreenUtil().setHeight(14),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(.05),
                borderRadius:
                    BorderRadius.circular(ScreenUtil().setHeight(10))),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(ScreenUtil().setSp(18)),
                child: Container(
                  width: ScreenUtil().setWidth(32),
                  color: Colors.black.withOpacity(.05),
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                  ),
                ),
              ),
              SizedBox(width: ScreenUtil().setWidth(10)),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(ScreenUtil().setSp(20)),
                      height: ScreenUtil().setHeight(15),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.05),
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setSp(5)),
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(3)),
                    Container(
                      padding: EdgeInsets.all(ScreenUtil().setSp(20)),
                      height: ScreenUtil().setHeight(10),
                      width: ScreenUtil().setWidth(100),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.05),
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setSp(5)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: ScreenUtil().setWidth(10)),
              ClipRRect(
                borderRadius: BorderRadius.circular(ScreenUtil().setSp(18)),
                child: Container(
                  width: ScreenUtil().setWidth(32),
                  color: Colors.black.withOpacity(.05),
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
