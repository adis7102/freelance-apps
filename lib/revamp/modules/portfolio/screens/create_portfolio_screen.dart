import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:soedja_freelance/revamp/assets/fonts.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/assets/urls.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/keyboard_helper.dart';
import 'package:soedja_freelance/revamp/helpers/masked_text.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_state.dart';
import 'package:soedja_freelance/revamp/modules/auth/components/register_components.dart';
import 'package:soedja_freelance/revamp/modules/auth/models/auth_models.dart';
import 'package:soedja_freelance/revamp/modules/category/bloc/category_bloc.dart';
import 'package:soedja_freelance/revamp/modules/category/bloc/category_state.dart';
import 'package:soedja_freelance/revamp/modules/category/models/category_model.dart';
import 'package:soedja_freelance/revamp/modules/feeds/components/feeds_component.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/bloc/portfolio_bloc.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/bloc/portfolio_state.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/components/portfolio_components.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/components/success_state_screen.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/screens/preview_screen.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

class CreatePortfolioScreen extends StatefulWidget {
  final AuthBloc authBloc;

  const CreatePortfolioScreen({
    Key key,
    this.authBloc,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CreatePortfolioScreen();
  }
}

class _CreatePortfolioScreen extends State<CreatePortfolioScreen> {
  GetProfileResponse getProfile = new GetProfileResponse();

  TextEditingController titleController = new TextEditingController();
  TextEditingController descController = new TextEditingController();
  TextEditingController youtubeController = new TextEditingController();
  MoneyMaskedTextController amountController = MoneyMaskedTextController(
    thousandSeparator: '.',
    decimalSeparator: '',
    precision: 0,
  );
  FocusNode titleFocus = new FocusNode();
  FocusNode descFocus = new FocusNode();
  FocusNode youtubeFocus = new FocusNode();
  FocusNode amountFocus = new FocusNode();

  List<File> imageGalleries = new List<File>();

  double duration = 1.0;
  int amount = 0;

  CategoryBloc categoryBloc = new CategoryBloc();
  Category category = new Category();
  SubCategory subCategory = new SubCategory();
  TypeCategory typeCategory = new TypeCategory();

  List<Category> categoryList = new List<Category>();
  List<SubCategory> subCategoryList = new List<SubCategory>();
  List<TypeCategory> typeCategoryList = new List<TypeCategory>();

  PortfolioBloc portfolioBloc = new PortfolioBloc();

  Future<Null> _pickImage() async {
    File image;
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _cropImage(image);
      });
    }
  }

  Future<Null> _cropImage(File image) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
              ]
            : [CropAspectRatioPreset.square],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Potong Gambar',
            toolbarColor: ColorApps.primary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          title: 'Potong Gambar',
        ));
    if (croppedFile != null) {
      setState(() {
        imageGalleries.add(croppedFile);
      });
    }
  }

  @override
  void initState() {
    categoryBloc.requestGetCategory(context, "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () {
        DialogConfirmLeavePortfolio(context);
        return null;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => DialogConfirmLeavePortfolio(context),
          ),
          actions: <Widget>[
            IconButton(
              icon: SvgPicture.asset(
                Images.iconDeleteSvg,
                height: ScreenUtil().setHeight(20),
                width: ScreenUtil().setWidth(20),
              ),
              onPressed: () {
                DialogConfirmDeletePortfolio(context, "", () {});
              },
            ),
            IconButton(
              icon: Container(
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.05),
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setSp(25))),
                padding: EdgeInsets.all(ScreenUtil().setSp(10)),
                child: SvgPicture.asset(
                  Images.iconPreviewSvg,
                  height: ScreenUtil().setHeight(20),
                  width: ScreenUtil().setWidth(20),
                ),
              ),
              padding: EdgeInsets.zero,
              onPressed: () {
                validateField(context, "preview");
              },
            ),
            SizedBox(width: ScreenUtil().setWidth(10)),
          ],
        ),
        body: GestureDetector(
          onTap: () => Keyboard().closeKeyboard(context),
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              YellowBanner(context: context, message: Texts.createGalleryInfo),
              Container(
                height: 110,
                width: size.width,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(20)),
                  itemBuilder: (BuildContext context, int index) {
                    if (index < imageGalleries.length) {
                      return CardGallery(
                        context: context,
                        size: size,
                        image: imageGalleries[index],
                        isRemovable: true,
                        onRemove: () {
                          setState(() {
                            imageGalleries.removeAt(index);
                          });
                        },
                      );
                    } else if (index == imageGalleries.length) {
                      return cardAddPicture(
                          context: context,
                          size: size,
                          onPickImage: _pickImage);
//                  } else {
                    }
                    return Container();
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(width: 8.0),
                  itemCount: 5,
                ),
              ),
              Container(
                color: Colors.black.withOpacity(.05),
                height: ScreenUtil().setHeight(12),
                margin:
                    EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(30)),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
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
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    ScreenUtil().setSp(18)),
                                child: Container(
                                  height: ScreenUtil().setHeight(32),
                                  color: Colors.black.withOpacity(.05),
                                  child: AspectRatio(
                                    aspectRatio: 1 / 1,
                                    child: FadeInImage.assetNetwork(
                                        placeholder:
                                            avatar(getProfile.payload.name),
                                        fit: BoxFit.cover,
                                        image: getProfile
                                                    .payload.picture.length >
                                                0
                                            ? BaseUrl.SoedjaAPI +
                                                "/" +
                                                getProfile.payload.picture
                                            : ""),
                                  ),
                                ),
                              );
                            }),
                        SizedBox(width: ScreenUtil().setWidth(20)),
                        Expanded(
                          child: TextFormFieldAreaOutline(
                            controller: titleController,
                            focusNode: titleFocus,
                            textInputAction: TextInputAction.next,
                            maxLines: 2,
                            onPressedSuffix: () {
                              setState(() {
                                titleController.clear();
                              });
                            },
                            onFieldSubmitted: (val) => onFieldSubmitted(
                                context, titleFocus, descFocus),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: Texts.hintPortfolioTitle,
                              hintStyle:
                                  TextStyle(fontSize: ScreenUtil().setSp(12)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(20)),
                    TextFormFieldAreaOutline(
                      controller: descController,
                      focusNode: descFocus,
                      minLines: 5,
                      maxLines: 20,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      hint: Texts.hintPortfolioDesc,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(14),
                        height: 1.5,
                        fontWeight: FontWeight.normal,
                      ),
                      contentPadding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                      onPressedSuffix: () {
                        setState(() {
                          descController.clear();
                        });
                      },
//                      textInputAction: TextInputAction.next,
//                      onFieldSubmitted: (val) =>
//                          onFieldSubmitted(context, descFocus, youtubeFocus),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(20)),
                    TipsInfo(context, Texts.tipsPortfolio),
                    SizedBox(height: ScreenUtil().setHeight(20)),
                    Row(
                      children: <Widget>[
                        Image.asset(
                          Images.logoSoedjaStudio,
                          height: ScreenUtil().setHeight(25),
                        ),
                        GestureDetector(
                          onTap: () => DialogStudioInfo(context, widget.authBloc, "portfolio"),
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(20)),
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(10),
                                vertical: ScreenUtil().setHeight(5)),
                            decoration: BoxDecoration(
                                color: ColorApps.primary,
                                borderRadius: BorderRadius.circular(
                                    ScreenUtil().setSp(10))),
                            child: Text(
                              "Info",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(10),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(20)),
                    TextFormFieldOutline(
                      controller: youtubeController,
                      focusNode: youtubeFocus,
                      hint: Texts.hintEmbedVideo,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: ScreenUtil().setSp(12)),
                      suffixIcon: IconButton(
                        icon: SvgPicture.asset(
                          Images.iconCopasSvg,
                          height: ScreenUtil().setHeight(20),
                          width: ScreenUtil().setWidth(20),
                        ),
                        onPressed: () {},
                      ),
                      prefixIcon: Container(
                        margin: EdgeInsets.symmetric(
                            vertical: ScreenUtil().setHeight(15)),
                        height: ScreenUtil().setHeight(26),
                        width: ScreenUtil().setWidth(26),
                        child: SvgPicture.asset(
                          Images.iconVideoSvg,
                          height: ScreenUtil().setHeight(26),
                          width: ScreenUtil().setWidth(26),
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (val) =>
                          Keyboard().closeKeyboard(context),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(20)),
                    TipsInfo(context, Texts.tipsLinkVideo),
                  ],
                ),
              ),
              Container(
                color: Colors.black.withOpacity(.05),
                height: ScreenUtil().setHeight(12),
                margin:
                    EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(30)),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: Texts.finalPaymentTotal.toUpperCase() + "  ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: ScreenUtil().setSp(12),
                          fontFamily: Fonts.ubuntu,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: ColorApps.red,
                              fontWeight: FontWeight.normal,
                              fontSize: ScreenUtil().setSp(12),
                              fontFamily: Fonts.ubuntu,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(10)),
                    Text(
                      Texts.infoPayment,
                      style: TextStyle(
                        color: Colors.black.withOpacity(.5),
                        fontSize: ScreenUtil().setSp(10),
                        fontWeight: FontWeight.normal,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(20)),
                    Row(
                      children: <Widget>[
                        Container(
                          width: ScreenUtil().setWidth(60),
                          child: TextFormFieldAreaOutline(
                            enabled: false,
                            hint: "Rp",
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(
                                    ScreenUtil().setHeight(5))),
                          ),
                        ),
                        Expanded(
                          child: TextFormFieldOutline(
                            focusNode: amountFocus,
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            hint: "Rp 0",
                            borderRadius: BorderRadius.horizontal(
                                right:
                                    Radius.circular(ScreenUtil().setHeight(5))),
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (val) {
                              Keyboard().closeKeyboard(context);
                            },
                            onChanged: (val) => setState(() {}),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(20)),
                    RichText(
                      text: TextSpan(
                        text: Texts.duration.toUpperCase() + "  ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: ScreenUtil().setSp(12),
                          fontFamily: Fonts.ubuntu,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: ColorApps.red,
                              fontWeight: FontWeight.normal,
                              fontSize: ScreenUtil().setSp(12),
                              fontFamily: Fonts.ubuntu,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(10)),
                    Text(
                      Texts.infoDuration,
                      style: TextStyle(
                        color: Colors.black.withOpacity(.5),
                        fontSize: ScreenUtil().setSp(10),
                        fontWeight: FontWeight.normal,
                        height: 1.5,
                      ),
                    ),
                    Divider(
                      height: ScreenUtil().setHeight(40),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${duration.toInt().toString()} ' +
                            Texts.days.toUpperCase(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenUtil().setSp(10),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(10)),
                    Container(
                      height: ScreenUtil().setHeight(20),
                      child: SliderTheme(
                        data: SliderThemeData(
                            trackHeight: 4.0,
                            thumbShape: RoundSliderThumbShape(
                                enabledThumbRadius:
                                    ScreenUtil().setHeight(10))),
                        child: Slider(
                          activeColor: ColorApps.primary,
                          inactiveColor: ColorApps.grey,
                          value: duration,
                          min: 1.0,
                          max: 90.0,
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                duration = val;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.black.withOpacity(.05),
                height: ScreenUtil().setHeight(12),
                margin:
                    EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(30)),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: Texts.categoryPortfolio.toUpperCase() + "  ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: ScreenUtil().setSp(12),
                          fontFamily: Fonts.ubuntu,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: ColorApps.red,
                              fontWeight: FontWeight.normal,
                              fontSize: ScreenUtil().setSp(12),
                              fontFamily: Fonts.ubuntu,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(20)),
                    CategoryDropDown(),
                    category.category == null || category.type == 'creative'
                        ? SubCategoryDropDown()
                        : SizedBox(height: ScreenUtil().setHeight(20)),
                    TypeCategoryDropDown(),
                  ],
                ),
              ),
              Container(
                color: Colors.black.withOpacity(.05),
                height: ScreenUtil().setHeight(52),
                margin:
                    EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(30)),
              ),
              StreamBuilder<CreatePortfolioState>(
                  stream: portfolioBloc.getCreateStatus,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.isLoading) {
                        return RaisedButtonLoading(
                            context, size, Colors.black, Colors.white);
                      } else if (snapshot.data.hasError) {
                        onWidgetDidBuild(() {
                          if (snapshot.data.standby) {
                            showDialogMessage(context, snapshot.data.message,
                                "Buat Portfolio gagal, silahkan coba lagi");
                            portfolioBloc.unStandBy();
                          }
                        });
                      } else if (snapshot.data.isSuccess) {
                        onWidgetDidBuild(() {
                          if (snapshot.data.standby) {
                            DialogUploadPhoto(context);
                            portfolioBloc
                                .uploadPortfolioPictures(
                              context,
                              imageGalleries,
                              snapshot.data.data.payload.portfolioId,
                            )
                                .then((response) {
                              if (response.code == "success") {
                                Navigation().navigateBack(context);
                                SuccessScreenPortfolio(context, widget.authBloc,
                                    snapshot.data.data.payload, "create", () {
                                  Navigation().navigateBack(context);
                                  setState(() {
                                    imageGalleries = new List<File>();
                                    titleController.clear();
                                    descController.clear();
                                    youtubeController.clear();
                                    amountController.text = "0";
                                    duration = 1;
                                    category = new Category();
                                    subCategory = new SubCategory();
                                    typeCategory = new TypeCategory();
                                    categoryList.clear();
                                    subCategoryList.clear();
                                    typeCategoryList.clear();
                                    categoryBloc.unStandBy();
                                    categoryBloc.requestGetCategory(
                                        context, "");
                                  });
                                });
                              } else {
                                Navigation().navigateBack(context);
                                showDialogMessage(
                                    context,
                                    response.message,"Terjadi Kesalahan, silahkan coba lagi.");
                              }
                            });

                            portfolioBloc.unStandBy();
                          }
                        });
                      }
                    }
                    return Container(
                      width: size.width,
                      height: ScreenUtil().setHeight(56),
                      margin: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20)),
                      child: RaisedButtonText(
                        text: Texts.createPortfolio.toUpperCase(),
                        color: Colors.black,
                        padding: EdgeInsets.all(1),
                        textStyle: TextStyle(
                            color: ColorApps.white,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(14)),
                        onPressed: () {
                          validateField(context, "create");
                        },
                      ),
                    );
                  }),
              SizedBox(height: ScreenUtil().setHeight(20)),
//              StreamBuilder<UploadPortfolioState>(
//                  stream: portfolioBloc.getUploadStatus,
//                  builder: (context, snapshot) {
//                    if (snapshot.hasData) {
//                      if(snapshot.data.isLoading){
//                        if (snapshot.data.standby) {
//                          onWidgetDidBuild(() {
//                            showSnackProgressBar(context: context, message: "Sedang upload Galeri Foto");
//                          });
//                          portfolioBloc.unStandBy();
//                        }
//                      } else if (snapshot.data.hasError) {
//                        if (snapshot.data.standby) {
//                          onWidgetDidBuild(() {
//                            showDialogMessage(context, snapshot.data.message,
//                                "Terjadi kesalahan, silahkan coba lagi.");
//                          });
//                          portfolioBloc.unStandBy();
//                        }
//                      } else if(snapshot.data.isSuccess){
//                        if (snapshot.data.standby) {
//                          onWidgetDidBuild(() {
//                            Navigation().navigateBack(context);
//
//                          });
//                          portfolioBloc.unStandBy();
//                        }
//                      }
//                    }
//                    return SizedBox(height: ScreenUtil().setHeight(20));
//                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardAddPicture({
    BuildContext context,
    Size size,
    Function onPickImage,
  }) {
    return GestureDetector(
      onTap: onPickImage,
      child: Container(
        height: ScreenUtil().setHeight(105),
        width: ScreenUtil().setWidth(105),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: ColorApps.white,
            borderRadius: BorderRadius.circular(ScreenUtil().setSp(5)),
            border: Border.all(color: Colors.black.withOpacity(.5), width: .2)),
        child: Image.asset(
          Images.imgPlaceholder,
          height: ScreenUtil().setHeight(30),
          width: ScreenUtil().setWidth(30),
        ),
      ),
    );
  }

  Widget CategoryDropDown() {
    return Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: ColorApps.light,
              borderRadius: BorderRadius.circular(ScreenUtil().setSp(20))),
          height: ScreenUtil().setHeight(36),
          width: ScreenUtil().setWidth(36),
          alignment: Alignment.center,
          child: Text(
            '1.',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: ScreenUtil().setSp(14),
              fontFamily: Fonts.ubuntu,
            ),
          ),
        ),
        SizedBox(width: ScreenUtil().setWidth(16)),
        Expanded(
          child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
            decoration: BoxDecoration(
                color: ColorApps.white,
                borderRadius: BorderRadius.circular(ScreenUtil().setSp(5)),
                border:
                    Border.all(color: Colors.black.withOpacity(.5), width: .2)),
            child: StreamBuilder<CategoryListState>(
                stream: categoryBloc.getCategory,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.isLoading) {
                      return DropdownButton<Category>(
                        isExpanded: true,
                        onChanged: (val) {},
                        icon: Icon(Icons.keyboard_arrow_down),
                        hint: Container(
                          height: ScreenUtil().setHeight(14),
                          width: ScreenUtil().setWidth(56),
                          child: LoadingIndicator(
                            indicatorType: Indicator.ballPulse,
                            color: Colors.black.withOpacity(.5),
                          ),
                        ),
                        underline: Container(),
                        items: categoryList.map((data) {
                          return DropdownMenuItem(
                            child: new Text(data.category),
                            value: data,
                          );
                        }).toList(),
                      );
                    } else if (snapshot.data.hasError) {
                      onWidgetDidBuild(() {
                        if (snapshot.data.standby) {
                          showDialogMessage(context, "Gagal Mengambil Data",
                              "Terjadi Kesalahan, silahkan coba lagi.");
                          categoryBloc.unStandBy();
                        }
                      });
                    } else if (snapshot.data.isSuccess) {
                      if (snapshot.data.standby) {
                        categoryList = snapshot.data.data.payload.rows;
                      }
                    }
                  }
                  return DropdownButton<Category>(
                    isExpanded: true,
                    icon: Icon(Icons.keyboard_arrow_down),
                    hint: Text(
                      Texts.selectCategory,
                      style: TextStyle(
                        color: Colors.black.withOpacity(.5),
                        fontWeight: FontWeight.normal,
                        fontSize: ScreenUtil().setSp(12),
                        fontFamily: Fonts.ubuntu,
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: ScreenUtil().setSp(12),
                      fontFamily: Fonts.ubuntu,
                    ),
                    value: category.category != null ? category : null,
                    underline: Container(),
                    onChanged: (val) {
                      setState(() {
                        category = val;
                        subCategory = new SubCategory();
                        typeCategory = new TypeCategory();
                        subCategoryList.clear();
                        typeCategoryList.clear();
                        if (category.type == 'creative') {
                          categoryBloc.requestGetSubCategory(
                              context, category.type, category.category);
                        } else {
                          categoryBloc.requestGetTypeCategory(
                            context,
                            category.type,
                            category.category,
                            "",
                            "50",
                            "0,1",
                          );
                        }
                      });
                    },
                    items: categoryList.map((data) {
                      return DropdownMenuItem(
                        child: new Text(data.category),
                        value: data,
                      );
                    }).toList(),
                  );
                }),
          ),
        )
      ],
    );
  }

  Widget SubCategoryDropDown() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(20)),
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: ColorApps.light,
                borderRadius: BorderRadius.circular(ScreenUtil().setSp(20))),
            height: ScreenUtil().setHeight(36),
            width: ScreenUtil().setWidth(36),
            alignment: Alignment.center,
            child: Text(
              '2.',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: ScreenUtil().setSp(14),
                fontFamily: Fonts.ubuntu,
              ),
            ),
          ),
          SizedBox(width: ScreenUtil().setWidth(16)),
          Expanded(
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
              decoration: BoxDecoration(
                  color: ColorApps.white,
                  borderRadius: BorderRadius.circular(ScreenUtil().setSp(5)),
                  border: Border.all(
                      color: Colors.black.withOpacity(.5), width: .2)),
              child: StreamBuilder<SubCategoryListState>(
                  stream: categoryBloc.getSubCategory,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.isLoading) {
                        return DropdownButton<Category>(
                          isExpanded: true,
                          onChanged: (val) {},
                          icon: Icon(Icons.keyboard_arrow_down),
                          hint: Container(
                            height: ScreenUtil().setHeight(14),
                            width: ScreenUtil().setWidth(56),
                            child: LoadingIndicator(
                              indicatorType: Indicator.ballPulse,
                              color: Colors.black.withOpacity(.5),
                            ),
                          ),
                          underline: Container(),
                          items: categoryList.map((data) {
                            return DropdownMenuItem(
                              child: new Text(data.category),
                              value: data,
                            );
                          }).toList(),
                        );
                      } else if (snapshot.data.hasError) {
                        onWidgetDidBuild(() {
                          if (snapshot.data.standby) {
                            showDialogMessage(context, "Gagal Mengambil Data",
                                "Terjadi Kesalahan, silahkan coba lagi.");
                            categoryBloc.unStandBy();
                          }
                        });
                      } else if (snapshot.data.isSuccess) {
                        if (snapshot.data.standby) {
                          subCategoryList = snapshot.data.data.payload.rows;
                        }
                      }
                    }
                    return DropdownButton<SubCategory>(
                      isExpanded: true,
                      icon: Icon(Icons.keyboard_arrow_down),
                      hint: Text(
                        Texts.selectSubCategory,
                        style: TextStyle(
                          color: Colors.black.withOpacity(.5),
                          fontWeight: FontWeight.normal,
                          fontSize: ScreenUtil().setSp(12),
                          fontFamily: Fonts.ubuntu,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: ScreenUtil().setSp(12),
                        fontFamily: Fonts.ubuntu,
                      ),
                      value:
                          subCategory.subCategory != null ? subCategory : null,
                      underline: Container(),
                      onChanged: (val) {
                        setState(() {
                          subCategory = val;
                          typeCategory = new TypeCategory();
                          typeCategoryList.clear();
                          categoryBloc.requestGetTypeCategory(
                            context,
                            category.type,
                            category.category,
                            subCategory.subCategory,
                            "50",
                            "0,1",
                          );
                        });
                      },
                      items: subCategoryList.map((data) {
                        return DropdownMenuItem(
                          child: new Text(data.subCategory),
                          value: data,
                        );
                      }).toList(),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }

  Widget TypeCategoryDropDown() {
    return Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: ColorApps.light,
              borderRadius: BorderRadius.circular(ScreenUtil().setSp(20))),
          height: ScreenUtil().setHeight(36),
          width: ScreenUtil().setWidth(36),
          alignment: Alignment.center,
          child: Text(
            category.category == null || category.type == 'creative'
                ? '3.'
                : '2.',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: ScreenUtil().setSp(14),
              fontFamily: Fonts.ubuntu,
            ),
          ),
        ),
        SizedBox(width: ScreenUtil().setWidth(16)),
        Expanded(
          child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
            decoration: BoxDecoration(
                color: ColorApps.white,
                borderRadius: BorderRadius.circular(ScreenUtil().setSp(5)),
                border:
                    Border.all(color: Colors.black.withOpacity(.5), width: .2)),
            child: StreamBuilder<TypeCategoryListState>(
                stream: categoryBloc.getTypeCategory,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.isLoading) {
                      return DropdownButton<TypeCategory>(
                        isExpanded: true,
                        onChanged: (val) {},
                        icon: Icon(Icons.keyboard_arrow_down),
                        hint: Container(
                          height: ScreenUtil().setHeight(14),
                          width: ScreenUtil().setWidth(56),
                          child: LoadingIndicator(
                            indicatorType: Indicator.ballPulse,
                            color: Colors.black.withOpacity(.5),
                          ),
                        ),
                        underline: Container(),
                        items: typeCategoryList.map((data) {
                          return DropdownMenuItem(
                            child: new Text(data.typeCategory),
                            value: data,
                          );
                        }).toList(),
                      );
                    } else if (snapshot.data.hasError) {
                      onWidgetDidBuild(() {
                        if (snapshot.data.standby) {
                          showDialogMessage(context, "Gagal Mengambil Data",
                              "Terjadi Kesalahan, silahkan coba lagi.");
                          categoryBloc.unStandBy();
                        }
                      });
                    } else if (snapshot.data.isSuccess) {
                      if (snapshot.data.standby) {
                        typeCategoryList = snapshot.data.data.payload.rows;
                      }
                    }
                  }
                  return DropdownButton<TypeCategory>(
                    isExpanded: true,
                    icon: Icon(Icons.keyboard_arrow_down),
                    hint: Text(
                      Texts.selectTypeCategory,
                      style: TextStyle(
                        color: Colors.black.withOpacity(.5),
                        fontWeight: FontWeight.normal,
                        fontSize: ScreenUtil().setSp(12),
                        fontFamily: Fonts.ubuntu,
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: ScreenUtil().setSp(12),
                      fontFamily: Fonts.ubuntu,
                    ),
                    value:
                        typeCategory.typeCategory != null ? typeCategory : null,
                    underline: Container(),
                    onChanged: (val) {
                      setState(() {
                        typeCategory = val;
                      });
                    },
                    items: typeCategoryList.map((data) {
                      return DropdownMenuItem(
                        child: new Text(data.typeCategory),
                        value: data,
                      );
                    }).toList(),
                  );
                }),
          ),
        )
      ],
    );
  }

  void validateField(BuildContext context, String type) {
    if (imageGalleries.length == 0) {
      showDialogMessage(context, "Gambar Portfolio Belum Dipilih",
          "Masukan minimum 1 gambar portfolio kamu");
      return null;
    }
    if (titleController.text.isEmpty) {
      showDialogMessage(context, "Judul Portfolio Belum Ada",
          "Silahkan isi judul portfolio kamu");
      return null;
    }
    if (descController.text.isEmpty) {
      showDialogMessage(context, "Deskripsi Portfolio Belum Ada",
          "Silahkan isi deskripsi mengenai portfolio kamu");
      return null;
    }
    if (category.category == null) {
      showDialogMessage(context, "Jasa Pekerjaan Belum Dipilih",
          "Silahkan pilih jasa pekerjaan portfolio kamu");
      return null;
    }
    if (category.type == 'creative' && subCategory.subCategory == null) {
      showDialogMessage(context, "Kategori Pekerjaan Belum Dipilih",
          "Silahkan pilih kategori pekerjaan portfolio kamu");
      return null;
    }
    if (typeCategory.typeCategory == null) {
      showDialogMessage(context, "Tipe Pekerjaan Belum Dipilih",
          "Silahkan pilih tipe pekerjaan portfolio kamu");
      return null;
    }

    Keyboard().closeKeyboard(context);
    if (type == 'preview') {
      Navigation().navigateScreen(
          context,
          PreviewPortfolioScreen(
            files: imageGalleries,
            authBloc: widget.authBloc,
            title: titleController.text,
            description: descController.text,
            category: category.category,
            subCategory: subCategory.subCategory,
            typeCategory: typeCategory.typeCategory,
            amount: int.parse(amountController.text.replaceAll(".", "")),
            youtubeUrl: youtubeController.text,
          ));
    } else {
      portfolioBloc.requestCreate(
          context,
          titleController.text,
          descController.text,
          category.category,
          subCategory.subCategory ?? "",
          typeCategory.typeCategory,
          int.parse(amountController.text.replaceAll(".", "")),
          duration.toInt(),
          youtubeController.text);
    }
  }
}
