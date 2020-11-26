import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/assets/urls.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/account/components/share_components.dart';
import 'package:soedja_freelance/revamp/modules/feeds/components/feeds_component.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/components/portfolio_components.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/models/comment_model.dart';
import 'package:soedja_freelance/revamp/modules/profile/models/profile_models.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

Widget AppBarDetailPortfolio({
  BuildContext context,
  Feed feed,
  ProfileDetail authUser,
  Function onBookmark,
  Function onEdit,
  Function onScan,
}) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 1.0,
    leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () => Navigation().navigateBack(context)),
    actions: <Widget>[
      IconButton(
        icon: Icon(
          Icons.share,
          color: Colors.black,
        ),
        onPressed: () => shareApp(context),
      ),
      IconButton(
          icon: Icon(
            feed.hasBookmark == 1 ? Icons.star : Icons.star_border,
            color: feed.hasBookmark == 1 ? ColorApps.green : Colors.black,
          ),
          onPressed: onBookmark),
      Visibility(
        visible: authUser.userId == feed.userId,
        child: Container(
          height: AppBar().preferredSize.height,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Colors.black.withOpacity(.5), width: .2))),
          child: IconButton(
              icon: Container(
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.05),
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setSp(25))),
                height: ScreenUtil().setHeight(40),
                width: ScreenUtil().setWidth(40),
                child: Icon(
                  Icons.edit,
                  color: Colors.black,
                ),
              ),
              onPressed: onEdit
//                () => Navigation().navigateScreen(
//                context,
//                EditPortfolioScreen(
//                    authBloc: authBloc, feed: widget.portfolio)),
              ),
        ),
      ),
      SizedBox(width: ScreenUtil().setWidth(10)),
    ],
  );
}

Widget AppBarDetailPortfolioLoader(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 1.0,
    leading: Container(
      height: AppBar().preferredSize.height,
      margin: EdgeInsets.all(ScreenUtil().setHeight(10)),
      decoration: BoxDecoration(
        color: ColorApps.light,
        borderRadius: BorderRadius.circular(AppBar().preferredSize.height / 2),
      ),
      child: AspectRatio(
        aspectRatio: 1 / 1,
      ),
    ),
    actions: <Widget>[
      Container(
        height: AppBar().preferredSize.height,
        margin: EdgeInsets.all(ScreenUtil().setHeight(10)),
        decoration: BoxDecoration(
          color: ColorApps.light,
          borderRadius:
              BorderRadius.circular(AppBar().preferredSize.height / 2),
        ),
        child: AspectRatio(
          aspectRatio: 1 / 1,
        ),
      ),
      Container(
        height: AppBar().preferredSize.height,
        margin: EdgeInsets.all(ScreenUtil().setHeight(10)),
        decoration: BoxDecoration(
          color: ColorApps.light,
          borderRadius:
              BorderRadius.circular(AppBar().preferredSize.height / 2),
        ),
        child: AspectRatio(
          aspectRatio: 1 / 1,
        ),
      ),
      Container(
        height: AppBar().preferredSize.height,
        margin: EdgeInsets.all(ScreenUtil().setHeight(10)),
        decoration: BoxDecoration(
          color: ColorApps.light,
          borderRadius:
              BorderRadius.circular(AppBar().preferredSize.height / 2),
        ),
        child: AspectRatio(
          aspectRatio: 1 / 1,
        ),
      ),
    ],
  );
}

Widget BodyDetailPortfolioLoader(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return ListView(
    children: <Widget>[
      Container(
        width: size.width,
        decoration: BoxDecoration(
          color: ColorApps.light,
        ),
        child: AspectRatio(
          aspectRatio: 16 / 9,
        ),
      ),
      Container(
        color: Colors.white,
        padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: ScreenUtil().setHeight(20),
              width: size.width,
              decoration: BoxDecoration(
                color: ColorApps.light,
                borderRadius: BorderRadius.circular(ScreenUtil().setHeight(5)),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(10)),
            Container(
              height: ScreenUtil().setHeight(20),
              width: size.width / 2,
              decoration: BoxDecoration(
                color: ColorApps.light,
                borderRadius: BorderRadius.circular(ScreenUtil().setHeight(5)),
              ),
            ),
            Divider(height: ScreenUtil().setHeight(40)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(40),
                  decoration: BoxDecoration(
                    color: ColorApps.light,
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setWidth(25)),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                  ),
                ),
                SizedBox(width: ScreenUtil().setWidth(10)),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: ScreenUtil().setHeight(15),
                        width: ScreenUtil().setWidth(150),
                        decoration: BoxDecoration(
                          color: ColorApps.light,
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().setHeight(5)),
                        ),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      Container(
                        height: ScreenUtil().setHeight(15),
                        width: ScreenUtil().setWidth(100),
                        decoration: BoxDecoration(
                          color: ColorApps.light,
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().setHeight(5)),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: ScreenUtil().setWidth(24),
                  decoration: BoxDecoration(
                    color: ColorApps.light,
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setWidth(14)),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                  ),
                ),
                SizedBox(width: ScreenUtil().setWidth(10)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: ScreenUtil().setHeight(15),
                      width: ScreenUtil().setWidth(80),
                      decoration: BoxDecoration(
                        color: ColorApps.light,
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setHeight(5)),
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(10)),
                    Container(
                      height: ScreenUtil().setHeight(15),
                      width: ScreenUtil().setWidth(50),
                      decoration: BoxDecoration(
                        color: ColorApps.light,
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setHeight(5)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: ScreenUtil().setHeight(30)),
            Container(
              height: ScreenUtil().setHeight(15),
              width: size.width,
              decoration: BoxDecoration(
                color: ColorApps.light,
                borderRadius: BorderRadius.circular(ScreenUtil().setHeight(5)),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(10)),
            Container(
              height: ScreenUtil().setHeight(15),
              width: size.width,
              decoration: BoxDecoration(
                color: ColorApps.light,
                borderRadius: BorderRadius.circular(ScreenUtil().setHeight(5)),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(10)),
            Container(
              height: ScreenUtil().setHeight(15),
              width: size.width,
              decoration: BoxDecoration(
                color: ColorApps.light,
                borderRadius: BorderRadius.circular(ScreenUtil().setHeight(5)),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(10)),
            Container(
              height: ScreenUtil().setHeight(15),
              width: size.width / 2,
              decoration: BoxDecoration(
                color: ColorApps.light,
                borderRadius: BorderRadius.circular(ScreenUtil().setHeight(5)),
              ),
            ),
          ],
        ),
      ),
      DividerWidget(height: ScreenUtil().setHeight(12)),
      Container(
        color: Colors.white,
        padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: ScreenUtil().setHeight(20),
              width: ScreenUtil().setWidth(100),
              decoration: BoxDecoration(
                color: ColorApps.light,
                borderRadius: BorderRadius.circular(ScreenUtil().setHeight(5)),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(10)),
            Wrap(
              spacing: ScreenUtil().setWidth(10),
              children: <Widget>[
                Container(
                  height: ScreenUtil().setHeight(105),
                  decoration: BoxDecoration(
                    color: ColorApps.light,
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setHeight(10)),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                  ),
                ),
                Container(
                  height: ScreenUtil().setHeight(105),
                  decoration: BoxDecoration(
                    color: ColorApps.light,
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setHeight(10)),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                  ),
                ),
                Container(
                  height: ScreenUtil().setHeight(105),
                  decoration: BoxDecoration(
                    color: ColorApps.light,
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setHeight(10)),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      DividerWidget(height: ScreenUtil().setHeight(12)),
      Container(
        color: Colors.white,
        padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: ScreenUtil().setHeight(30),
              width: ScreenUtil().setWidth(100),
              decoration: BoxDecoration(
                color: ColorApps.light,
                borderRadius: BorderRadius.circular(ScreenUtil().setHeight(15)),
              ),
            ),
            Divider(height: ScreenUtil().setHeight(40)),
            Wrap(
              spacing: ScreenUtil().setWidth(10),
              children: <Widget>[
                Container(
                  height: ScreenUtil().setHeight(30),
                  width: ScreenUtil().setWidth(100),
                  decoration: BoxDecoration(
                    color: ColorApps.light,
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setHeight(15)),
                  ),
                ),
                Container(
                  height: ScreenUtil().setHeight(30),
                  width: ScreenUtil().setWidth(100),
                  decoration: BoxDecoration(
                    color: ColorApps.light,
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setHeight(15)),
                  ),
                ),
                Container(
                  height: ScreenUtil().setHeight(30),
                  width: ScreenUtil().setWidth(100),
                  decoration: BoxDecoration(
                    color: ColorApps.light,
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setHeight(15)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      DividerWidget(height: ScreenUtil().setHeight(40)),
    ],
  );
}

Widget BodyDetailPortfolio({
  BuildContext context,
  Feed feed,
  ProfileDetail profileDetail,
  ProfileDetail authUser,
  Function onVideoScreen,
  Function onUserDetail,
  bool show,
  Function(bool) isShow,
}) {
  Size size = MediaQuery.of(context).size;
  return ListView(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    children: <Widget>[
      Visibility(
        visible: feed.youtubeUrl.contains("youtube"),
        child: GestureDetector(
          onTap: onVideoScreen,
          child: Container(
            width: size.width,
            decoration: BoxDecoration(
              color: ColorApps.light,
            ),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                children: <Widget>[
                  FadeInImage.assetNetwork(
                      placeholder: Images.imgPlaceholder,
                      width: size.width,
                      fit: BoxFit.cover,
                      image: feed.pictures.length > 0
                          ? BaseUrl.SoedjaAPI + "/" + feed.pictures[0].path
                          : ""),
                  Container(
                    color: Colors.black38,
                  ),
                  Center(
                    child: Icon(
                      Icons.play_circle_outline,
                      color: Colors.white.withOpacity(.5),
                      size: size.width / 4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      Container(
        color: Colors.white,
        padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              feed.title,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.black,
                  height: 1.5,
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(20)),
            ),
            Divider(height: ScreenUtil().setHeight(40)),
            GestureDetector(
              onTap: onUserDetail,
              child: Container(
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setWidth(25)),
                      child: Container(
                        width: ScreenUtil().setWidth(40),
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: FadeInImage.assetNetwork(
                              placeholder: avatar(profileDetail.name ?? "A"),
                              fit: BoxFit.cover,
                              image: profileDetail.picture.length > 0
                                  ? BaseUrl.SoedjaAPI +
                                      "/" +
                                      profileDetail.picture
                                  : ""),
                        ),
                      ),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            profileDetail.name,
                            style: TextStyle(
                                color: Colors.black,
                                height: 1.5,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(12)),
                          ),
                          Text(
                            profileDetail.profession.length > 0
                                ? profileDetail.profession
                                : "Belum Ada Pekerjaan",
                            style: TextStyle(
                                color: Colors.black.withOpacity(.8),
                                height: 1.5,
                                fontWeight: FontWeight.w300,
                                fontSize: ScreenUtil().setSp(12)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(24),
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Icon(
                          Icons.remove_red_eye,
                          size: ScreenUtil().setWidth(24),
                        ),
                      ),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Telah dilihat",
                          style: TextStyle(
                              color: Colors.black,
                              height: 1.5,
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenUtil().setSp(12)),
                        ),
                        Text(
                          formatCurrency.format(feed.viewer ?? 0),
                          style: TextStyle(
                              color: Colors.black,
                              height: 1.5,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(12)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(30)),
            Text(
              feed.description,
              textAlign: TextAlign.justify,
              maxLines: feed.description.length > 255 && !show ? 3 : null,
              style: TextStyle(
                  color: Colors.black,
                  height: 1.5,
                  fontWeight: FontWeight.normal,
                  fontSize: ScreenUtil().setSp(14)),
            ),
            SizedBox(height: ScreenUtil().setHeight(5)),
            Visibility(
              visible: feed.description.length > 255,
              child: GestureDetector(
                onTap: () => isShow(!show),
                child: Container(
                  color: Colors.white,
                  padding:
                      EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(5)),
                  child: Text(
                    !show ? Texts.readMore : Texts.readLess,
                    style: TextStyle(
                        color: ColorApps.primary,
                        fontWeight: FontWeight.w300,
                        fontSize: ScreenUtil().setSp(12)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      DividerWidget(height: ScreenUtil().setHeight(12)),
      Container(
        color: Colors.white,
        padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Galeri Foto",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.black,
                  height: 1.5,
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(12)),
            ),
            SizedBox(height: ScreenUtil().setHeight(10)),
            feed.pictures.length > 0
                ? Container(
                    height: 110,
                    width: size.width,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () => ShowImagePreview(
                            context: context,
                            index: index,
                            pictures: feed.pictures,
                          ),
                          child: CardGallery(
                            context: context,
                            size: size,
                            path: feed.pictures[index].path,
                            isRemovable: false,
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(width: 10.0),
                      itemCount: feed.pictures.length,
                    ),
                  )
                : Text(
                    "Belum ada Foto",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: ScreenUtil().setSp(12)),
                  ),
          ],
        ),
      ),
      DividerWidget(height: ScreenUtil().setHeight(12)),
      Container(
        color: Colors.white,
        padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                feed.category,
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
                feed.subCategory != null && feed.subCategory.length > 0
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
                          feed.subCategory ?? "",
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
                    border: Border.all(
                        color: Colors.black.withOpacity(.8), width: .2),
                    borderRadius: BorderRadius.circular(ScreenUtil().setSp(20)),
                  ),
                  child: Text(
                    feed.typeCategory,
                    style: TextStyle(
                      color: Colors.black.withOpacity(.5),
                      fontWeight: FontWeight.normal,
                      fontSize: ScreenUtil().setSp(12),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      DividerWidget(height: ScreenUtil().setHeight(40)),
    ],
  );
}

Widget PortfolioComment({
  BuildContext context,
  Feed feed,
  Function onLike,
  Function onLikeList,
  List<Comment> commentList,
}) {
  Size size = MediaQuery.of(context).size;
  return Container(
    padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(20),
        vertical: ScreenUtil().setHeight(20)),
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.comment,
              color: Colors.black,
            ),
            SizedBox(width: ScreenUtil().setWidth(10)),
            Text(
              formatCurrency.format(feed.commentCount ?? 0),
              style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(16),
                fontWeight: FontWeight.normal,
              ),
            ),
            Expanded(child: SizedBox(width: ScreenUtil().setWidth(10))),
            GestureDetector(
              onTap: onLike,
              child: Container(
                width: ScreenUtil().setWidth(22),
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: SvgPicture.asset(
                    feed.hasLike == 0 ? Images.iconHeart : Images.iconLiked,
                    width: ScreenUtil().setWidth(22),
                    semanticsLabel: "icon_heart",
                  ),
                ),
              ),
            ),
            SizedBox(width: ScreenUtil().setWidth(10)),
            GestureDetector(
              onTap: onLikeList,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
                child: Text(
                  formatCurrency.format(feed.likeCount ?? 0),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(16),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(height: ScreenUtil().setHeight(40)),
        ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              print(commentList[index].toString());
              
              if (commentList[index].commentId != null) {
                return CardCommentItem(
                  context: context,
                  index: index,
                  size: size,
                  comment: commentList[index],
                );
              } else {
                return CardCommentLoader();
              }
            },
            separatorBuilder: (BuildContext context, int index) => SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
            itemCount: commentList.length),
      ],
    ),
  );
}

Widget VideoComment({
  BuildContext context,
  Feed feed,
  Function onLike,
  Function onLikeList,
  List<Comment> commentList,
}) {
  Size size = MediaQuery.of(context).size;
  return Container(
    padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(20),
        vertical: ScreenUtil().setHeight(20)),
    child: Column(
      children: <Widget>[
        ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            reverse: true,
            itemBuilder: (BuildContext context, int index) {
              if (commentList[index].commentId != null) {
                return CardCommentVideoItem(
                  context: context,
                  index: index,
                  size: size,
                  comment: commentList[index],
                );
              } else {
                return CardCommentLoader();
              }
            },
            separatorBuilder: (BuildContext context, int index) => SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
            itemCount: commentList.length),
      ],
    ),
  );
}
