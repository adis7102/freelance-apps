import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/urls.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

class GalleryPortfolioScreen extends StatefulWidget {
  final int index;
  final List<File> previewFIle;
  final List<Picture> previewGallery;

  const GalleryPortfolioScreen({
    Key key,
    this.index,
    this.previewFIle,
    this.previewGallery,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GalleryPortfolioScreen();
  }
}

class _GalleryPortfolioScreen extends State<GalleryPortfolioScreen> {
  int index = 0;

  @override
  void initState() {
    setIndex();
    super.initState();
  }

  setIndex() {
    setState(() {
      index = widget.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(.3),
      body: Stack(
        children: <Widget>[
          widget.previewFIle != null && widget.previewFIle.length > 0
              ? Positioned.fill(
                  child: CarouselSlider.builder(
                    options: CarouselOptions(
                      height: size.width,
                      initialPage: widget.index,
                      onPageChanged: (val, reason) {
                        setState(() {
                          index = val;
                        });
                      },
                      autoPlay: widget.previewFIle.length > 1,
                      scrollPhysics: widget.previewFIle.length > 1
                          ? ClampingScrollPhysics()
                          : NeverScrollableScrollPhysics(),
                      viewportFraction: 1.0,
                    ),
                    itemCount: widget.previewFIle.length ?? 1,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          color: ColorApps.light,
                          child: Image.file(
                            widget.previewFIle[index],
                            width: size.width,
                            height: size.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Positioned.fill(
                  child: CarouselSlider.builder(
                    options: CarouselOptions(
                      height: size.width,
                      initialPage: widget.index,
                      enableInfiniteScroll: false,
                      onPageChanged: (val, reason) {
                        setState(() {
                          index = val;
                        });
                      },
                      autoPlay: false,
                      scrollPhysics: widget.previewGallery.length > 1
                          ? ClampingScrollPhysics()
                          : NeverScrollableScrollPhysics(),
                      viewportFraction: 1.0,
                    ),
                    itemCount: widget.previewGallery.length ?? 1,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                            color: ColorApps.light,
                            child: FadeInImage.assetNetwork(
                                placeholder: Images.imgPlaceholder,
                                image: widget.previewGallery[index].path.length > 0
                                    ? BaseUrl.SoedjaAPI +
                                        "/" +
                                        widget.previewGallery[index].path
                                    : "")),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
