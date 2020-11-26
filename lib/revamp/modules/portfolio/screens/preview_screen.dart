import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/urls.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_state.dart';
import 'package:soedja_freelance/revamp/modules/auth/models/auth_models.dart';
import 'package:soedja_freelance/revamp/modules/feeds/components/feeds_component.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/components/portfolio_components.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PreviewPortfolioScreen extends StatefulWidget {
  final AuthBloc authBloc;
  final String title;
  final String description;
  final String category;
  final String subCategory;
  final String typeCategory;
  final int amount;
  final String youtubeUrl;
  final List<File> files;

  const PreviewPortfolioScreen(
      {Key key,
      this.title,
      this.description,
      this.category,
      this.subCategory,
      this.typeCategory,
      this.amount,
      this.youtubeUrl,
      this.authBloc,
      this.files})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PreviewPortfolioScreen();
  }
}

class _PreviewPortfolioScreen extends State<PreviewPortfolioScreen> {
  ScrollController controller = new ScrollController();
  GetProfileResponse getProfile = new GetProfileResponse();

  bool showColor = false;

  int index = 0;

  @override
  void initState() {
    controller.addListener(scrollListener);
    super.initState();
  }

  void scrollListener() {
    if (controller.position.pixels > MediaQuery.of(context).size.width) {
      setState(() {
        showColor = true;
      });
    } else {
      setState(() {
        showColor = false;
      });
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
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(ScreenUtil().setSp(20))),
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(20),
                vertical: ScreenUtil().setHeight(10)),
            child: Text(
              "Preview".toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(12),
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.cancel,
              color: Colors.black,
              size: ScreenUtil().setSp(30),
            ),
            onPressed: () {
              Navigation().navigateBack(context);
            },
          ),
          SizedBox(
            width: ScreenUtil().setWidth(10),
          ),
        ],
      ),
      body: ListView(
        physics: ClampingScrollPhysics(),
        children: <Widget>[
//          widget.youtubeUrl.contains("youtube.com")
//              ? YoutubePlayer(
//                  controller: _controller,
//                  showVideoProgressIndicator: true,
//                  progressIndicatorColor: ColorApps.primary,
//                  progressColors: ProgressBarColors(
//                      playedColor: ColorApps.primary,
//                      handleColor: Colors.white.withOpacity(.5),
//                      backgroundColor: Colors.white.withOpacity(.2),
//                      bufferedColor: Colors.white.withOpacity(.8)),
//                  onReady: () {
//                    _isPlayerReady = true;
//                  },
//                  topActions: <Widget>[
//                    SizedBox(width: ScreenUtil().setWidth(10)),
//                    Expanded(
//                      child: Text(
//                        _controller.metadata.title,
//                        style: const TextStyle(
//                          color: Colors.white,
//                          fontSize: 18.0,
//                        ),
//                        overflow: TextOverflow.ellipsis,
//                        maxLines: 1,
//                      ),
//                    ),
//                    IconButton(
//                      icon: Icon(
//                        _muted ? Icons.volume_off : Icons.volume_up,
//                        color: Colors.white,
//                      ),
//                      onPressed: _isPlayerReady
//                          ? () {
//                              _muted
//                                  ? _controller.unMute()
//                                  : _controller.mute();
//                              setState(() {
//                                _muted = !_muted;
//                              });
//                            }
//                          : null,
//                    ),
//                  ],
//                )
//              : Container(),
          SizedBox(height: ScreenUtil().setHeight(10)),
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.title,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(20),
                      height: 1.5),
                ),
                Divider(height: ScreenUtil().setHeight(40)),
                StreamBuilder<GetProfileState>(
                    stream: widget.authBloc.getProfile,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.isSuccess) {
                          if (snapshot.data.standby) {
                            getProfile = snapshot.data.data;
                          }
                        }
                      }
                      return Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(ScreenUtil().setSp(25)),
                            child: Container(
                              height: ScreenUtil().setHeight(40),
                              width: ScreenUtil().setWidth(40),
                              color: Colors.black.withOpacity(.05),
                              child: FadeInImage.assetNetwork(
                                  placeholder: avatar(getProfile.payload.name),
                                  fit: BoxFit.cover,
                                  image: getProfile.payload.picture.length > 0
                                      ? BaseUrl.SoedjaAPI +
                                          "/" +
                                          getProfile.payload.picture
                                      : ""),
                            ),
                          ),
                          SizedBox(width: ScreenUtil().setWidth(10)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        getProfile.payload.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: ScreenUtil().setSp(12),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: ScreenUtil().setWidth(10)),
                                    SvgPicture.asset(
                                      Images.iconLocationSvg,
                                      height: ScreenUtil().setHeight(16),
                                      width: ScreenUtil().setWidth(16),
                                    ),
                                    SizedBox(width: ScreenUtil().setWidth(5)),
//                                    Text(
//                                      getProfile.payload.regency.length > 0
//                                          ? "${getProfile.payload.regency}, Indonesia"
//                                          : "Di Bumi",
//                                      overflow: TextOverflow.ellipsis,
//                                      style: TextStyle(
//                                        color: Colors.black,
//                                        fontSize: ScreenUtil().setSp(12),
//                                        fontWeight: FontWeight.normal,
//                                      ),
//                                    ),
                                  ],
                                ),
                                SizedBox(height: ScreenUtil().setHeight(4)),
                                Text(
                                  getProfile.payload.profession,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(.8),
                                    fontSize: ScreenUtil().setSp(12),
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                SizedBox(height: ScreenUtil().setHeight(20)),
                Text(
                  widget.description,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.black.withOpacity(.8),
                      fontWeight: FontWeight.normal,
                      fontSize: ScreenUtil().setSp(12),
                      height: 1.5),
                ),
              ],
            ),
          ),

          Container(
            color: Colors.black.withOpacity(.05),
            height: ScreenUtil().setHeight(12),
            margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(30)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                child: Text(
                  "Galeri Foto",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black,
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(12)),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(10)),
              Container(
                height: 110,
                width: size.width,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(20)),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => ShowImagePreview(
                        context: context,
                        index: index,
                        files: widget.files,
                      ),
                      child: CardGallery(
                        context: context,
                        size: size,
                        image: widget.files[index],
                        isRemovable: false,
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(width: 8.0),
                  itemCount: widget.files.length,
                ),
              ),
            ],
          ),
          Container(
            color: Colors.black.withOpacity(.05),
            height: ScreenUtil().setHeight(12),
            margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(30)),
          ),
          PortfolioCategory(context, widget.category, widget.subCategory,
              widget.typeCategory),
          SizedBox(height: ScreenUtil().setHeight(50)),
        ],
      ),
    );
  }
}
