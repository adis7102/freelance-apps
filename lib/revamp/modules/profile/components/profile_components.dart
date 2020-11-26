import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/assets/urls.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_state.dart';
import 'package:soedja_freelance/revamp/modules/auth/models/auth_models.dart';
import 'package:soedja_freelance/revamp/modules/feeds/components/feeds_component.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';
import 'package:soedja_freelance/revamp/modules/profile/bloc/profile_bloc.dart';
import 'package:soedja_freelance/revamp/modules/profile/bloc/profile_state.dart';
import 'package:soedja_freelance/revamp/modules/profile/models/profile_models.dart';
import 'package:soedja_freelance/revamp/modules/profile/screens/profile_edit_screen.dart';
import 'package:soedja_freelance/revamp/modules/profile/screens/profile_follow_screen.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

Widget CardSearchProfileItem({
  BuildContext context,
  int hasFollow,
  int index,
  Size size,
  ProfileDetail profile,
  ProfileDetail authUser,
  Function onPressed,
  Function onFollow,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      color: Colors.white,
      width: size.width,
      child: Row(
        children: <Widget>[
          AvatarTitleSubtitle(
              context: context,
              profile: profile,
              title: profile.name,
              subtitle: profile.province.length > 0
                  ? "${profile.province}, Indonesia"
                  : "Indonesia",
              from: 'search',
              profileAuth: authUser),
          Visibility(
            visible: authUser.userId != profile.userId,
            child: Container(
                height: ScreenUtil().setHeight(34),
                child: FlatButtonText(
                    onPressed: onFollow,
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setHeight(20)),
                    textStyle: TextStyle(
                      color: profile.hasFollow == null
                          ? (hasFollow == 1 ? Colors.black : Colors.white)
                          : (profile.hasFollow == 1
                              ? Colors.black
                              : Colors.white),
                      fontWeight: FontWeight.normal,
                      fontSize: ScreenUtil().setSp(12),
                    ),
                    side: profile.hasFollow == null
                        ? (hasFollow == 1
                            ? BorderSide(color: Colors.black, width: 1)
                            : null)
                        : (profile.hasFollow == 1
                            ? BorderSide(color: Colors.black, width: 1)
                            : null),
                    text: profile.hasFollow == null
                        ? (hasFollow == 1 ? Texts.following : Texts.follow)
                        : (profile.hasFollow == 1
                            ? Texts.following
                            : Texts.follow),
                    color: profile.hasFollow == null
                        ? (hasFollow == 1 ? Colors.white : Colors.black)
                        : (profile.hasFollow == 1
                            ? Colors.white
                            : Colors.black))),
          ),
        ],
      ),
    ),
  );
}

Widget CardSearchProfileLoader(
    {BuildContext context, int index, Size size, Function onPressed}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      color: Colors.white,
      width: size.width,
      child: Row(
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
                  height: ScreenUtil().setHeight(13),
                  width: ScreenUtil().setWidth(200),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.05),
                    borderRadius: BorderRadius.circular(ScreenUtil().setSp(5)),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(3)),
                Container(
                  padding: EdgeInsets.all(ScreenUtil().setSp(20)),
                  height: ScreenUtil().setHeight(10),
                  width: ScreenUtil().setWidth(100),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.05),
                    borderRadius: BorderRadius.circular(ScreenUtil().setSp(5)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: ScreenUtil().setWidth(10)),
          Container(
            height: ScreenUtil().setHeight(34),
            width: ScreenUtil().setWidth(100),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.05),
              borderRadius: BorderRadius.circular(ScreenUtil().setSp(20)),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget ProfileDetailContent({
  BuildContext context,
  Size size,
  AuthBloc authBloc,
  ProfileDetail profileDetail,
  ProfileDetail authUser,
  ProfileFollow profileFollow,
  bool showAll,
  Function(bool) isShow,
  Function onFollow,
}) {
  return ListView(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    children: <Widget>[
      authUser.userId == profileDetail.userId
          ? StreamUserIdentity(
              context: context,
              authBloc: authBloc,
              profileFollow: profileFollow,
              onFollow: onFollow,
            )
          : UserIdentity(
              context: context,
              profileDetail: profileDetail,
              authUser: authUser,
              profileFollow: profileFollow,
              onFollow: onFollow,
            ),
      DividerWidget(
        padding: EdgeInsets.zero,
        child: Container(height: ScreenUtil().setHeight(24)),
      ),
      authUser.userId == profileDetail.userId
          ? StreamUserDescripstion(
              context: context,
              authBloc: authBloc,
              show: showAll,
              isShow: (val) => isShow(val),
            )
          : UserDescripstion(
              context: context,
              profileDetail: profileDetail,
              show: showAll,
              isShow: (val) => isShow(val),
            ),
      DividerWidget(
        padding: EdgeInsets.zero,
        child: Container(height: ScreenUtil().setHeight(24)),
      ),
      SizedBox(height: ScreenUtil().setHeight(10)),
      Container(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(20),
            vertical: ScreenUtil().setHeight(10)),
        margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    color: Colors.black.withOpacity(.5), width: .2))),
        child: Text(
          Texts.portfolio,
          style: TextStyle(
            color: Colors.black,
            fontSize: ScreenUtil().setSp(15),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}

StreamUserIdentity(
    {BuildContext context,
    AuthBloc authBloc,
    Function onFollow,
    ProfileFollow profileFollow}) {
  return StreamBuilder<GetProfileState>(
      stream: authBloc.getProfile,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.isLoading) {
            return Container();
          } else if (snapshot.data.hasError) {
            if (snapshot.data.standby) {
              onWidgetDidBuild(() {
                showDialogMessage(context, snapshot.data.message,
                    "Terjadi kesalahan, silahkan coba lagi.");
              });
            }
          } else if (snapshot.data.isSuccess) {
            return UserIdentity(
              context: context,
              authBloc: authBloc,
              profileDetail: snapshot.data.data.payload,
              authUser: snapshot.data.data.payload,
              profileFollow: profileFollow,
              onFollow: onFollow,
            );
          }
        }
        return Container();
      });
}

Widget UserIdentity({
  BuildContext context,
  AuthBloc authBloc,
  ProfileDetail profileDetail,
  ProfileDetail authUser,
  ProfileFollow profileFollow,
  Function onFollow,
}) {
  return Container(
    color: Colors.white,
    padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(ScreenUtil().setSp(32)),
          child: Container(
            width: ScreenUtil().setWidth(60),
            color: Colors.black.withOpacity(.05),
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: FadeInImage.assetNetwork(
                  placeholder: avatar(profileDetail.name),
                  fit: BoxFit.cover,
                  image: profileDetail.picture.length > 0
                      ? BaseUrl.SoedjaAPI + "/" + profileDetail.picture
                      : ""),
            ),
          ),
        ),
        SizedBox(width: ScreenUtil().setWidth(20)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: ScreenUtil().setHeight(5)),
              Text(
                profileDetail.name ?? "User Name",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(15),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(10)),
              Text(
                profileDetail.profession.length > 0
                    ? profileDetail.profession
                    : "Belum Ada Pekerjaan",
                style: TextStyle(
                  color: Colors.black.withOpacity(.8),
                  fontSize: ScreenUtil().setSp(12),
                  fontWeight: FontWeight.w300,
                ),
              ),
              Divider(height: ScreenUtil().setHeight(30)),
              Row(
                children: <Widget>[
                  Visibility(
                    visible: authUser.userId != profileDetail.userId,
                    child: Container(
                      height: ScreenUtil().setHeight(30),
                      width: ScreenUtil().setWidth(90),
                      child: FlatButtonText(
                          onPressed: onFollow,
                          padding: EdgeInsets.zero,
                          color: profileDetail.hasFollow == 1
                              ? Colors.white
                              : Colors.black,
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().setHeight(34)),
                          side: profileDetail.hasFollow == 1
                              ? BorderSide(color: Colors.black, width: 1)
                              : null,
                          text: profileDetail.hasFollow == 1
                              ? Texts.following
                              : Texts.follow,
                          textStyle: TextStyle(
                            color: profileDetail.hasFollow == 1
                                ? Colors.black
                                : Colors.white,
                            fontSize: ScreenUtil().setSp(10),
                            fontWeight: FontWeight.normal,
                          )),
                    ),
                  ),
                  Visibility(
                    visible: authUser.userId == profileDetail.userId,
                    child: Container(
                      height: ScreenUtil().setHeight(30),
                      width: ScreenUtil().setWidth(90),
                      child: FlatButtonText(
                          onPressed: () => Navigation().navigateScreen(
                              context,
                              ProfileEditScreen(
                                authBloc: authBloc,
                                profileDetail: profileDetail,
                              )),
                          padding: EdgeInsets.zero,
                          color: Colors.black,
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().setHeight(34)),
                          text: Texts.editProfile,
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(10),
                            fontWeight: FontWeight.normal,
                          )),
                    ),
                  ),
                  Expanded(child: Container()),
                  GestureDetector(
                    onTap: () => Navigation().navigateScreen(
                        context,
                        ProfileFollowScreen(
                          before: "follower",
                          authUser: authUser,
                          profileDetail: profileDetail,
                        )),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            Texts.follower,
                            style: TextStyle(
                              color: Colors.black.withOpacity(.5),
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenUtil().setSp(10),
                              height: 1.5,
                            ),
                          ),
                          Text(
                            formatCurrency.format(profileFollow.follower != null
                                ? profileFollow.follower
                                : 0),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(10),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(20)),
                  GestureDetector(
                    onTap: () => Navigation().navigateScreen(
                        context,
                        ProfileFollowScreen(
                          before: "following",
                          authUser: authUser,
                          profileDetail: profileDetail,
                        )),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            Texts.following,
                            style: TextStyle(
                              color: Colors.black.withOpacity(.5),
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenUtil().setSp(10),
                              height: 1.5,
                            ),
                          ),
                          Text(
                            formatCurrency.format(
                                profileFollow.following != null
                                    ? profileFollow.following
                                    : 0),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(10),
                              height: 1.5,
                            ),
                          ),
                        ],
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

StreamUserDescripstion({
  BuildContext context,
  AuthBloc authBloc,
  bool show,
  Function(bool) isShow,
}) {
  return StreamBuilder<GetProfileState>(
      stream: authBloc.getProfile,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.isLoading) {
            return Container();
          } else if (snapshot.data.hasError) {
            if (snapshot.data.standby) {
              onWidgetDidBuild(() {
                showDialogMessage(context, snapshot.data.message,
                    "Terjadi kesalahan, silahkan coba lagi.");
              });
            }
          } else if (snapshot.data.isSuccess) {
            return UserDescripstion(
              context: context,
              profileDetail: snapshot.data.data.payload,
              show: show,
              isShow: (val) => isShow(val),
            );
          }
        }
        return Container();
      });
}

Widget UserDescripstion({
  BuildContext context,
  ProfileDetail profileDetail,
  bool show,
  Function(bool) isShow,
}) {
  return Container(
    padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          Texts.about,
          style: TextStyle(
            color: Colors.black,
            fontSize: ScreenUtil().setSp(15),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(10)),
        Text(
          profileDetail.about.length > 2
              ? profileDetail.about
              : "Belum Ada Penjelasan",
          maxLines: profileDetail.about.length > 255 && !show ? 3 : null,
          textAlign: TextAlign.justify,
          style: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil().setSp(12),
              fontWeight: FontWeight.w300,
              height: 1.5),
        ),
        SizedBox(height: ScreenUtil().setHeight(5)),
        Visibility(
          visible: profileDetail.about.length > 255,
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
  );
}

Widget CardProfilePortfolioItem({
  BuildContext context,
  int index,
  Size size,
  Feed feed,
  Function onPressed,
  Function onFollow,
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
                    image: feed.pictures.length > 0
                        ? BaseUrl.SoedjaAPI + "/" + feed.pictures[0].path
                        : ""),
              )),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Container(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                feed.subCategory.length > 0
                    ? feed.subCategory
                    : feed.typeCategory,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: ScreenUtil().setSp(10)),
              ),
              Container(
                width: ScreenUtil().setWidth(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setWidth(15)),
                    border: Border.all(
                        color: Colors.black.withOpacity(.5), width: .5)),
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "+${feed.subCategory.length > 0 ? 3 : 2}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          fontSize: ScreenUtil().setSp(10)),
                    ),
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

Widget ProfileDetailLoader(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Container();
}
