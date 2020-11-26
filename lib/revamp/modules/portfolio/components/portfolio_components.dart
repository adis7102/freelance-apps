import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/assets/urls.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/models/comment_model.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/screens/create_portfolio_screen.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

Widget TipsInfo(BuildContext context, String text) {
  return Row(
    children: <Widget>[
      SvgPicture.asset(
        Images.iconHint,
        height: ScreenUtil().setHeight(26),
        width: ScreenUtil().setWidth(26),
      ),
      SizedBox(width: ScreenUtil().setWidth(10)),
      Expanded(
        child: Text(
          text,
          textAlign: TextAlign.justify,
          style: TextStyle(
              color: Colors.black.withOpacity(.5),
              fontWeight: FontWeight.normal,
              height: 1.5,
              fontSize: ScreenUtil().setSp(10)),
        ),
      ),
    ],
  );
}

Widget TextFormFieldPrice(
    {TextEditingController controller,
    String hint,
    FocusNode focusNode,
    TextInputType keyboardType,
    TextStyle style,
    Function(String) validator,
    InputDecoration decoration,
    Function(String) onChanged,
    Function(String) onFieldSubmitted,
    Function() onPressedSuffix,
    Icon suffixIcon,
    int maxLength,
    Function() onEditingComplete}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(25),
            vertical: ScreenUtil().setHeight(20)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(ScreenUtil().setSp(5)),
            bottomLeft: Radius.circular(ScreenUtil().setSp(5)),
          ),
          border: Border.all(color: Colors.black.withOpacity(.5), width: .5),
          color: ColorApps.black,
        ),
        child: Text(
          'Rp',
          style: TextStyle(
            color: Colors.white,
            fontSize: ScreenUtil().setSp(15),
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      Expanded(
        child: TextFormFieldOutline(
          controller: controller,
          focusNode: focusNode,
          keyboardType: TextInputType.number,
          onChanged: (val) => onChanged(val),
          textInputAction: TextInputAction.next,
          maxLength: 12,
          onFieldSubmitted: (val) => onFieldSubmitted(val),
          decoration: InputDecoration(
            hintText: "0,-",
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: ColorApps.black.withOpacity(.2), width: 1),
                borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(ScreenUtil().setSp(5)))),
            contentPadding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            counterText: '',
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorApps.black, width: 1),
              borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(ScreenUtil().setSp(5))),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorApps.red, width: 1),
              borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(ScreenUtil().setSp(5))),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorApps.red, width: 1),
              borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(ScreenUtil().setSp(5))),
            ),
            suffixIcon: Visibility(
              visible: controller.text.isNotEmpty,
              child: GestureDetector(
                onTap: () => onPressedSuffix(),
                child: Icon(
                  Icons.close,
                  size: ScreenUtil().setSp(20),
                  color: Colors.black.withOpacity(.5),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

DialogConfirmDeletePortfolio(
  BuildContext context,
  String before,
  Function delete,
) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(ScreenUtil().setSp(10))),
          ),
          padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(20),
              vertical: ScreenUtil().setHeight(30)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: ScreenUtil().setHeight(20)),
              Text(
                Texts.sureToDelete,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(20),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(20)),
              Text(
                Texts.confirmDelete,
                style: TextStyle(
                  color: Colors.black.withOpacity(.5),
                  fontWeight: FontWeight.normal,
                  fontSize: ScreenUtil().setSp(12),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(50)),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: ScreenUtil().setHeight(56),
                      child: FlatButtonText(
                          context: context,
                          borderRadius: BorderRadius.zero,
                          color: Colors.white,
                          side: BorderSide(color: Colors.black, width: .5),
                          text: Texts.delete.toUpperCase(),
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(15)),
                          onPressed: () {
                            if (before == "edit") {
                              delete();
                            } else {
                              Navigation().navigateBack(context);
                              Navigation().navigateBack(context);
                            }
                          }),
                    ),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(10)),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: ScreenUtil().setHeight(56),
                      child: FlatButtonText(
                          context: context,
                          borderRadius: BorderRadius.zero,
                          color: Colors.black,
                          text: Texts.cancel.toUpperCase(),
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(15)),
                          onPressed: () {
                            Navigation().navigateBack(context);
                          }),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      });
}

DialogConfirmLeavePortfolio(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(ScreenUtil().setSp(10))),
          ),
          padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(20),
              vertical: ScreenUtil().setHeight(30)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: ScreenUtil().setHeight(20)),
              Text(
                Texts.sureToLeavePortfolio,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(20),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(20)),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(40)),
                child: Text(
                  Texts.confirmLeavePortfolio,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black.withOpacity(.5),
                    fontWeight: FontWeight.normal,
                    height: 1.5,
                    fontSize: ScreenUtil().setSp(12),
                  ),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(50)),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: ScreenUtil().setHeight(56),
                      child: FlatButtonText(
                          context: context,
                          borderRadius: BorderRadius.zero,
                          color: Colors.white,
                          side: BorderSide(color: Colors.black, width: .5),
                          text: Texts.leave.toUpperCase(),
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(15)),
                          onPressed: () {
                            Navigation().navigateBack(context);
                            Navigation().navigateBack(context);
                          }),
                    ),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(10)),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: ScreenUtil().setHeight(56),
                      child: FlatButtonText(
                          context: context,
                          borderRadius: BorderRadius.zero,
                          color: Colors.black,
                          text: Texts.ehCancel.toUpperCase(),
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(15)),
                          onPressed: () {
                            Navigation().navigateBack(context);
                          }),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      });
}

YellowBanner(
    {BuildContext context,
    String message,
    EdgeInsets margin,
    double fontSize}) {
  return Container(
    padding: EdgeInsets.all(ScreenUtil().setHeight(10)),
    margin: margin ??
        EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(20),
            vertical: ScreenUtil().setHeight(15)),
    decoration: BoxDecoration(
        color: ColorApps.yellow.withOpacity(.15),
        borderRadius: BorderRadius.circular(5.0)),
    child: Row(
      children: <Widget>[
        Image.asset(
          Images.iconWaveYellow,
          height: 20.0,
          width: 20.0,
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            message,
            style: TextStyle(
              color: ColorApps.yellowDark,
              fontSize: fontSize ?? ScreenUtil().setSp(10),
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    ),
  );
}

DialogStudioInfo(BuildContext context, AuthBloc authBloc, String before) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(ScreenUtil().setSp(10))),
          ),
          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                Images.logoSoedjaStudio,
                height: ScreenUtil().setHeight(35),
              ),
              Container(
                color: Colors.black.withOpacity(.05),
                height: ScreenUtil().setHeight(30),
                margin:
                    EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(20)),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      Texts.infoDescSoedjaStudio,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black.withOpacity(.8),
                        fontWeight: FontWeight.normal,
                        height: 1.5,
                        fontSize: ScreenUtil().setSp(12),
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(30)),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: ScreenUtil().setHeight(56),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(ScreenUtil().setSp(5)),
                              border: Border.all(
                                  color: Colors.black.withOpacity(.2),
                                  width: .5),
                            ),
                            child: Text(
                              Texts.unlimitedIncome,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(12),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: ScreenUtil().setWidth(10)),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: ScreenUtil().setHeight(56),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(ScreenUtil().setSp(5)),
                              border: Border.all(
                                  color: Colors.black.withOpacity(.2),
                                  width: .5),
                            ),
                            child: Text(
                              Texts.noMinFollowers,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(30)),
                    Text(
                      Texts.calculateSharing,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(12)),
                    ),
                    Divider(height: ScreenUtil().setHeight(40)),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
                child: Stack(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              width: ScreenUtil().setWidth(30),
                              child: SvgPicture.asset(
                                Images.iconPrice,
                                height: ScreenUtil().setHeight(12),
                                width: ScreenUtil().setWidth(12),
                              ),
                            ),
                            Text(
                              Texts.yourIncome,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenUtil().setSp(10),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Text(
                              Texts.fromViewer,
                              style: TextStyle(
                                color: Colors.black.withOpacity(.7),
                                fontSize: ScreenUtil().setSp(10),
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: ScreenUtil().setHeight(10)),
                        Container(
                          child: Stack(
                            children: <Widget>[
                              Container(
                                height: ScreenUtil().setHeight(56),
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(32)),
                                decoration: BoxDecoration(
                                    color: ColorApps.light,
                                    borderRadius: BorderRadius.circular(
                                        ScreenUtil().setSp(5))),
                              ),
                              Container(
                                height: ScreenUtil().setHeight(110),
                                child: VerticalDivider(
                                  width: ScreenUtil().setWidth(30),
                                  thickness: 1.0,
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        width: ScreenUtil().setWidth(30),
                                        child: SvgPicture.asset(
                                          Images.iconPrice,
                                          height: ScreenUtil().setHeight(12),
                                          width: ScreenUtil().setWidth(12),
                                        ),
                                      ),
                                      Text(
                                        Texts.decreaseCommission,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: ScreenUtil().setSp(10),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(),
                                      ),
                                      Text(
                                        Texts.perTransaction,
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(.7),
                                          fontSize: ScreenUtil().setSp(10),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(30)),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        width: ScreenUtil().setWidth(30),
                                        child: SvgPicture.asset(
                                          Images.iconCircleGrey,
                                          height: ScreenUtil().setHeight(12),
                                          width: ScreenUtil().setWidth(12),
                                        ),
                                      ),
                                      Text(
                                        Texts.platformSoedjaFee,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: ScreenUtil().setSp(10),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(10)),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        width: ScreenUtil().setWidth(30),
                                        child: SvgPicture.asset(
                                          Images.iconCircleGrey,
                                          height: ScreenUtil().setHeight(12),
                                          width: ScreenUtil().setWidth(12),
                                        ),
                                      ),
                                      Text(
                                        Texts.taxPPh,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: ScreenUtil().setSp(10),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(30)),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        width: ScreenUtil().setWidth(30),
                                        child: SvgPicture.asset(
                                          Images.iconPriceBlack,
                                          height: ScreenUtil().setHeight(12),
                                          width: ScreenUtil().setWidth(12),
                                        ),
                                      ),
                                      Text(
                                        Texts.amountIncome,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: ScreenUtil().setSp(10),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(20)),
              Visibility(
                visible: before != "portfolio",
                child: Container(
                  height: ScreenUtil().setHeight(56),
                  margin: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(20)),
                  width: size.width,
                  child: FlatButtonText(
                      color: Colors.black,
                      text: "Unggah Konten",
                      onPressed: () => Navigation().navigateScreen(
                          context,
                          CreatePortfolioScreen(
                            authBloc: authBloc,
                          ))),
                ),
              ),
            ],
          ),
        );
      });
}

Future<dynamic> ShowImagePreview(
    {BuildContext context,
    int index,
    List<File> files,
    List<Picture> pictures}) {
  PageController pageController = new PageController(initialPage: index);
  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.black.withOpacity(.5),
    context: context,
    enableDrag: false,
    builder: (BuildContext context) {
      Size size = MediaQuery.of(context).size;

      return GestureDetector(
        onTap: () => Navigation().navigateBack(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: ScreenUtil().setHeight(20)),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(
                  Icons.cancel,
                  color: Colors.white,
                ),
                onPressed: () => Navigation().navigateBack(context),
              ),
            ),
            files != null
                ? Expanded(
                    child: PhotoViewGallery.builder(
                      pageController: pageController,
                      scrollPhysics: const BouncingScrollPhysics(),
                      builder: (BuildContext context, int index) {
                        return PhotoViewGalleryPageOptions(
                          imageProvider: FileImage(files[index]),
                          initialScale: PhotoViewComputedScale.contained * 0.9,
                        );
                      },
                      itemCount: files.length,
                      backgroundDecoration:
                          BoxDecoration(color: Colors.transparent),
                      loadingBuilder: (context, event) => Center(
                        child: Container(
                          width: 20.0,
                          height: 20.0,
                          child: CircularProgressIndicator(
                            value: event == null
                                ? 0
                                : event.cumulativeBytesLoaded /
                                    event.expectedTotalBytes,
                          ),
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: PhotoViewGallery.builder(
                      pageController: pageController,
                      scrollPhysics: const BouncingScrollPhysics(),
                      builder: (BuildContext context, int index) {
                        return PhotoViewGalleryPageOptions(
                          imageProvider: NetworkImage(
                              pictures[index].path.length > 0
                                  ? BaseUrl.SoedjaAPI +
                                      "/" +
                                      pictures[index].path
                                  : ""),
                          initialScale: PhotoViewComputedScale.contained * 0.9,
                        );
                      },
                      itemCount: pictures.length,
                      backgroundDecoration:
                          BoxDecoration(color: Colors.transparent),
                      loadingBuilder: (context, event) => Center(
                        child: Container(
                          width: 20.0,
                          height: 20.0,
                          child: CircularProgressIndicator(
                            value: event == null
                                ? 0
                                : event.cumulativeBytesLoaded /
                                    event.expectedTotalBytes,
                          ),
                        ),
                      ),
                    ),
                  ),
//            Expanded(
//              child: files != null && files.length > 0
//                  ? CarouselSlider.builder(
//                      options: CarouselOptions(
//                        height: size.width,
//                        initialPage: index,
//                        enableInfiniteScroll: false,
//                        onPageChanged: (val, reason) {
////                        setState(() {
////                          index = val;
////                        });
//                        },
//                        autoPlay: false,
//                        scrollPhysics: files.length > 1
//                            ? ClampingScrollPhysics()
//                            : NeverScrollableScrollPhysics(),
//                        viewportFraction: 1.0,
//                      ),
//                      itemCount: files.length ?? 1,
//                      itemBuilder: (BuildContext context, int index) {
//                        return GestureDetector(
//                          onTap: () {},
//                          child: Container(
//                            color: ColorApps.light,
//                            child: PhotoView(
//                              imageProvider: FileImage(
//                                files[index],
//                              ),
//                            ),
//                          ),
//                        );
//                      },
//                    )
//                  : CarouselSlider.builder(
//                      options: CarouselOptions(
//                        height: size.width,
//                        initialPage: index,
//                        enableInfiniteScroll: false,
//                        onPageChanged: (val, reason) {
////                        setState(() {
////                          index = val;
////                        });
//                        },
//                        autoPlay: false,
//                        scrollPhysics: pictures.length > 1
//                            ? ClampingScrollPhysics()
//                            : NeverScrollableScrollPhysics(),
//                        viewportFraction: 1.0,
//                      ),
//                      itemCount: pictures.length ?? 1,
//                      itemBuilder: (BuildContext context, int index) {
//                        return GestureDetector(
//                          onTap: () {},
//                          child: Container(
//                              color: ColorApps.light,
//                              child: PhotoView(
//                                imageProvider: NetworkImage(
//                                    pictures[index].path.length > 0
//                                        ? BaseUrl.SoedjaAPI +
//                                            "/" +
//                                            pictures[index].path
//                                        : ""),
//                              )),
//                        );
//                      },
//                    ),
//            ),
          ],
        ),
      );
    },
  );
}

CardCommentItem(
    {BuildContext context,
    int index,
    Size size,
    Comment comment,
    Function onPressed}) {
  return Container(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            // Navigation().navigateScreen(context, );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(ScreenUtil().setSp(30)),
            child: Container(
              color: ColorApps.light,
              width: ScreenUtil().setWidth(46),
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: FadeInImage.assetNetwork(
                  placeholder: avatar(comment.userData.name),
                  image: comment.userData.picture.length > 0
                      ? BaseUrl.SoedjaAPI + "/" + comment.userData.picture
                      : "",
                  width: ScreenUtil().setWidth(46),
                  height: ScreenUtil().setHeight(46),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: ScreenUtil().setWidth(10)),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: ScreenUtil().setHeight(5)),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      comment.userData.name ?? 'Owner Name',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: ColorApps.black,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(12)),
                    ),
                  ),
                  Text(
                    dateFormat(date: comment.createdAt),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: ColorApps.grey707070,
                        fontWeight: FontWeight.w300,
                        fontSize: ScreenUtil().setSp(10)),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtil().setHeight(5)),
              Text(
                comment.comment ?? '',
                style: TextStyle(
                    color: ColorApps.black,
                    fontWeight: FontWeight.w300,
                    fontSize: ScreenUtil().setSp(12)),
              ),
              SizedBox(height: ScreenUtil().setHeight(10)),
              Visibility(
                visible: comment.isSawer == 1,
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.05),
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().setSp(25))),
                      height: ScreenUtil().setHeight(25),
                      width: ScreenUtil().setWidth(25),
                      child: Icon(
                        Icons.card_giftcard,
                        color: Colors.black,
                        size: ScreenUtil().setWidth(15),
                      ),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(5)),
                    Text(
                      "Rp ${formatCurrency.format(comment.amount != null ? comment.amount : 0)}",
                      style: TextStyle(
                          color: ColorApps.green,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(12)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

CardCommentVideoItem(
    {BuildContext context,
    int index,
    Size size,
    Comment comment,
    Function onPressed}) {
  return Container(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(ScreenUtil().setSp(30)),
          child: Container(
            color: ColorApps.light,
            width: ScreenUtil().setWidth(46),
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: FadeInImage.assetNetwork(
                placeholder: avatar(comment.userData.name),
                image: comment.userData.picture.length > 0
                    ? BaseUrl.SoedjaAPI + "/" + comment.userData.picture
                    : "",
                width: ScreenUtil().setWidth(46),
                height: ScreenUtil().setHeight(46),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(width: ScreenUtil().setWidth(10)),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: ScreenUtil().setHeight(5)),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      comment.userData.name ?? 'Owner Name',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(12)),
                    ),
                  ),
                  Text(
                    dateFormat(date: comment.createdAt),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: ColorApps.grey707070,
                        fontSize: ScreenUtil().setSp(10)),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtil().setHeight(5)),
              Text(
                comment.comment ?? '',
                style: TextStyle(
                    color: ColorApps.white,
                    fontWeight: FontWeight.w300,
                    fontSize: ScreenUtil().setSp(12)),
              ),
              SizedBox(height: ScreenUtil().setHeight(10)),
              Visibility(
                visible: comment.isSawer == 1,
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.1),
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().setSp(25))),
                      height: ScreenUtil().setHeight(25),
                      width: ScreenUtil().setWidth(25),
                      child: Icon(
                        Icons.card_giftcard,
                        color: Colors.white,
                        size: ScreenUtil().setWidth(15),
                      ),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(5)),
                    Text(
                      "Rp ${formatCurrency.format(comment.amount != null ? comment.amount : 0)}",
                      style: TextStyle(
                          color: ColorApps.green,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(12)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

CardCommentLoader() {
  return Container(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(ScreenUtil().setSp(30)),
          child: Container(
            color: ColorApps.light,
            width: ScreenUtil().setWidth(46),
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
              SizedBox(height: ScreenUtil().setHeight(5)),
              Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(ScreenUtil().setSp(30)),
                    child: Container(
                      color: ColorApps.light,
                      width: ScreenUtil().setWidth(100),
                      height: ScreenUtil().setHeight(12),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(ScreenUtil().setSp(30)),
                    child: Container(
                      color: ColorApps.light,
                      width: ScreenUtil().setWidth(100),
                      height: ScreenUtil().setHeight(12),
                    ),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtil().setHeight(5)),
              ClipRRect(
                borderRadius: BorderRadius.circular(ScreenUtil().setSp(30)),
                child: Container(
                  color: ColorApps.light,
                  width: ScreenUtil().setWidth(200),
                  height: ScreenUtil().setHeight(12),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(5)),
              ClipRRect(
                borderRadius: BorderRadius.circular(ScreenUtil().setSp(30)),
                child: Container(
                  color: ColorApps.light,
                  width: ScreenUtil().setWidth(150),
                  height: ScreenUtil().setHeight(12),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(5)),
            ],
          ),
        ),
      ],
    ),
  );
}

DialogUploadPhoto(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
          Size size = MediaQuery.of(context).size;

          return Container(
            padding: EdgeInsets.all(ScreenUtil().setWidth(60)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(ScreenUtil().setSp(10))),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SmallLayoutLoading(context, Colors.black),
                SizedBox(height: ScreenUtil().setHeight(20)),
                Text(
                  "Sedang Mengirim Foto ...",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: ScreenUtil().setSp(15),
                  ),
                ),
              ],
            ),
          );
        });
      });
}
