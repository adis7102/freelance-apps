import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:shimmer/shimmer.dart';
import 'package:soedja_freelance/old_ver/components/button.dart';
import 'package:soedja_freelance/old_ver/components/dialog.dart';
import 'package:soedja_freelance/old_ver/constants/assets.dart';
import 'package:soedja_freelance/old_ver/constants/lists.dart';
import 'package:soedja_freelance/old_ver/constants/strings.dart';
import 'package:soedja_freelance/old_ver/constants/urls.dart';
import 'package:soedja_freelance/old_ver/models/category.dart';
import 'package:soedja_freelance/old_ver/models/feeds.dart';
import 'package:soedja_freelance/old_ver/models/portfolio.dart';
import 'package:soedja_freelance/old_ver/models/subcategory.dart';
import 'package:soedja_freelance/old_ver/models/typecategory.dart';
import 'package:soedja_freelance/old_ver/models/user.dart';
import 'package:soedja_freelance/old_ver/screens/dashboard/dashboard.dart';
import 'package:soedja_freelance/old_ver/screens/feeds/detail_screen.dart';
import 'package:soedja_freelance/old_ver/services/category.dart';
import 'package:soedja_freelance/old_ver/services/portfolio.dart';
import 'package:soedja_freelance/old_ver/services/user.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';
import 'package:soedja_freelance/old_ver/utils/helpers.dart';
import 'package:soedja_freelance/old_ver/utils/keyboard.dart';
import 'package:soedja_freelance/old_ver/utils/navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soedja_freelance/old_ver/components/text_input.dart' as EditText;
import 'package:soedja_freelance/old_ver/components/text_input.dart';
import 'package:soedja_freelance/old_ver/utils/http_request.dart';
import 'dart:io';
import 'package:http/http.dart' show get;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class PortfolioCreateScreen extends StatefulWidget {
  final String before;
  final Feeds item;

  PortfolioCreateScreen({
    this.before,
    this.item,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PortfolioCreateScreen();
  }
}

class _PortfolioCreateScreen extends State<PortfolioCreateScreen> {
  BuildContext context;

  ScrollController scrollController = new ScrollController();
  TextEditingController titleController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController linkController = new TextEditingController();
  MoneyMaskedTextController paymentController = MoneyMaskedTextController(
    thousandSeparator: '.',
    decimalSeparator: '',
//    leftSymbol: 'Rp ',
    precision: 0,
  );

  List<File> imageGalleries;

  double duration = 1.0;
  int amount = 0;

  List<Category> categoryList = new List<Category>();
  List<SubCategory> subCategoryList = new List<SubCategory>();
  List<TypeCategory> typeCategoryList = new List<TypeCategory>();

  Category category = new Category();
  SubCategory subCategory = new SubCategory();
  TypeCategory typeCategory = new TypeCategory();

  bool isSelectCategory = false;
  bool isSelectSubCategory = false;
  bool isSelectTypeCategory = false;
  bool isHour = false;

  bool isLoadingCategory = true;
  bool isLoadingSubCategory = false;
  bool isLoadingTypeCategory = false;

  List<String> galleryDelete = [];
  List<int> galleryUpdate = [];

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
            toolbarColor: AppColors.primary,
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
      if (widget.before == 'detail') {
        galleryUpdate.add(imageGalleries.length - 1);
      }
    }
  }

  void fetchCategory(BuildContext context) async {
    CategoryService().getCategory(context).then((response) {
      if (response.length > 0) {
        setState(() {
          categoryList = response;
        });
      }
      setState(() {
        isLoadingCategory = false;
      });

      if (widget.before == 'detail') {
        for (Category val in categoryList) {
          if (val.category == widget.item.category) {
            setState(() {
              category = val;
              isSelectCategory = true;
            });
          }
        }
        fetchSubCategory(context);
      }
    });
  }

  void fetchSubCategory(BuildContext context) {
    SubCategoryPayload payload = new SubCategoryPayload();
    setState(() {
      payload = new SubCategoryPayload(
        category: category.category,
        type: category.type,
      );
    });

    CategoryService().getSubCategory(context, payload).then((response) {
      if (response.length > 0) {
        setState(() {
          subCategoryList = response;
        });
      }
      setState(() {
        isLoadingSubCategory = false;
      });

      if (widget.before == 'detail') {
        for (SubCategory val in subCategoryList) {
          if (val.subCategory == widget.item.subCategory) {
            setState(() {
              subCategory = val;
              isSelectSubCategory = true;
            });
          }
        }

        fetchTypeCategory(context);
      }
    });
  }

  void fetchTypeCategory(BuildContext context) {
    TypeCategoryPayload payload = new TypeCategoryPayload();
    setState(() {
      payload = new TypeCategoryPayload(
          type: category.type,
          category: category.category,
          subCategory: subCategory.subCategory ?? '');
    });

    CategoryService().getTypeCategory(context, payload).then((response) {
      if (response.length > 0) {
        setState(() {
          typeCategoryList = response;
        });
      }
      setState(() {
        isLoadingTypeCategory = false;
      });

      if (widget.before == 'detail') {
        for (TypeCategory val in typeCategoryList) {
          if (val.typeCategory == widget.item.typeCategory) {
            setState(() {
              typeCategory = val;
              isSelectTypeCategory = true;
            });
          }
        }
      }
    });
  }

  Profile profile = new Profile();

  void fetchProfile(BuildContext context) {
    UserService().getProfile(context).then((value) async {
      setState(() {
        profile = value;
      });
    });
  }

  void createPortfolio(BuildContext context) {
    showLoading(context);
    PortfolioPayload payload = new PortfolioPayload();
    payload = new PortfolioPayload(
      title: titleController.text,
      description: descriptionController.text,
      category: category.category,
      subCategory: subCategory.subCategory ?? '',
      typeCategory: typeCategory.typeCategory,
      amount: amount,
      youtubeUrl: linkController.text,
    );

    if (widget.before == 'detail') {
      PortfolioService()
          .update(context, payload, widget.item.portfolioId)
          .then((response) async {
        if (response.portfolioId != null) {
          dismissDialog(context);
          uploadPicture(context, response);
        }
      });
    } else {
      PortfolioService().create(context, payload).then((response) async {
        if (response.portfolioId != null) {
          dismissDialog(context);
          uploadPicture(context, response);
        }
      });
    }
  }

  void uploadPicture(BuildContext context, Portfolio portfolio) async {
    if (widget.before == 'detail') {
      if (galleryUpdate.length > 0) {
        List<File> imgs = [];

        for (int index in galleryUpdate) {
          for (int i = 0; i < imageGalleries.length; i++) {
            if (i == index) {
              imgs.add(imageGalleries[i]);
            }
          }
        }

        PortfolioService()
            .uploadPictures(context, imgs, portfolio.portfolioId)
            .then((response) {
          print(response.toJson().toString());
          if (galleryDelete.length > 0) {
            deletePicture(context, portfolio, 'update');
          } else {
            if (response.portfolioId != null) {
              Navigation().navigateReplacement(context, DashboardScreen());
              return showPortfolio(
                  context: context, type: 'update', item: portfolio);
            }
          }
          return null;
        });
      } else {
        if (galleryDelete.length > 0) {
          deletePicture(context, portfolio, 'update');
        } else {
          if (portfolio.portfolioId != null) {
            Navigation().navigateReplacement(context, DashboardScreen());
            return showPortfolio(
                context: context, type: 'update', item: portfolio);
          }
        }
        return null;
      }
    } else {
      PortfolioService()
          .uploadPictures(context, imageGalleries, portfolio.portfolioId)
          .then((response) {
        if (response.portfolioId != null) {
          Navigation().navigateReplacement(context, DashboardScreen());
          return showPortfolio(
              context: context, type: 'create', item: portfolio);
        }
        return null;
      });
    }
  }

  deletePicture(BuildContext context, Portfolio portfolio, String type) {
    bool status = false;
    int loop = 0;
    for (String path in galleryDelete) {
      PortfolioService()
          .deletePictures(context, widget.item.portfolioId, path)
          .then((response) {
        status = response;
        ++loop;
        if (status && loop == galleryDelete.length) {
          Navigation().navigateReplacement(context, DashboardScreen());
          return showPortfolio(context: context, type: type, item: portfolio);
        }
        return null;
      });
    }
  }

  void fetchEdit() async {
    if (widget.before == 'detail') {
      setState(() {
        titleController.text = widget.item.title;
        descriptionController.text = widget.item.description;
        linkController.text = widget.item.youtubeUrl;
        paymentController.text = currency.format(widget.item.amount);
        amount = widget.item.amount;
      });
      if (widget.item.pictures != null) {
        for (int i = 0; i < widget.item.pictures.length; i++) {
          var response =
              await get(BaseUrl.SoedjaAPI + '/' + widget.item.pictures[i].path);
          Directory documentDirectory =
              await getApplicationDocumentsDirectory();

          File file = new File(join(
              documentDirectory.path, widget.item.pictures[i].id + '.png'));

          print('File path ' + file.path);

          file.writeAsBytesSync(response.bodyBytes);
          setState(() {
            imageGalleries.add(file);
          });
        }
      }
    }
  }

  @override
  void initState() {
    imageGalleries = new List<File>();
    fetchCategory(context);
    fetchProfile(context);
    fetchEdit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBarSection(
        context: context,
        size: size,
        item: Feeds(
          userId: widget.item != null ? widget.item.userId : '',
          title: titleController.text,
          description: descriptionController.text,
          category: category.category,
          subCategory: subCategory.subCategory,
          typeCategory: typeCategory.typeCategory,
          userData: Profile(
              picture: profile.picture,
              name: profile.name,
              profession: profile.profession,
              province: profile.province),
          youtubeUrl: linkController.text,
        ),
        pictures: imageGalleries,
        profile: profile,
      ),
      body: bodySection(
          context: context,
          size: size,
          before: widget.before,
          onPickImage: _pickImage,
          duration: duration,
          onRemove: (index, file) {
            setState(() {
              imageGalleries.removeAt(index);
            });
            if (widget.before == 'detail') {
              galleryDelete.add(file.path.substring(51, file.path.length - 4));
              print(galleryDelete);
            }
          },
          imageList: imageGalleries,
          onChangedTitle: (val) {},
          onChangedDescription: (val) {},
          onChangedAmount: (val) {
            if (val.length > 0) {
              amount = int.parse(val.replaceAll('.', ''));
            }
          },
          onChangedDuration: (val) {
            if (val != null) {
              setState(() {
                duration = val;
              });
            }
          },
          propsTitle: new TextInputProps(
              controller: titleController,
              hintText: Strings.hintPortfolioTitle,
              validator: null,
              keyboardType: TextInputType.text,
              onFieldSubmitted: (val) {}),
          propsDescription: new TextInputProps(
              controller: descriptionController,
              hintText: Strings.hintPortfolioDesc,
              validator: null,
              keyboardType: TextInputType.text,
              onFieldSubmitted: (val) {}),
          propsLink: new TextInputProps(
              controller: linkController,
              hintText: Strings.insertLinkVideo,
              validator: null,
              keyboardType: TextInputType.multiline,
              onFieldSubmitted: (val) {}),
          propsPayment: new TextInputProps(
            controller: paymentController,
            hintText: '0,-',
            validator: null,
            keyboardType: TextInputType.text,
            onFieldSubmitted: (val) {},
          ),
          isLoadingCategory: isLoadingCategory,
          category: category,
          categoryList: categoryList,
          isSelectCategory: isSelectCategory,
          profile: profile,
          onChangedCategory: (val) {
            print(val.type);
            setState(() {
              category = val;
              subCategory = new SubCategory();
              typeCategory = new TypeCategory();
              isSelectCategory = true;

              isSelectSubCategory = false;
              subCategoryList.clear();

              isSelectTypeCategory = false;
              typeCategoryList.clear();

              if (val.type == 'creative') {
                isLoadingSubCategory = true;

                isHour = false;
                Future.delayed(
                    Duration(seconds: 1), () => fetchSubCategory(context));
              } else {
                isLoadingTypeCategory = true;

                isHour = true;
                Future.delayed(
                    Duration(seconds: 1), () => fetchTypeCategory(context));
              }
            });
          },
          isLoadingSubCategory: isLoadingSubCategory,
          subCategory: subCategory,
          subCategoryList: subCategoryList,
          isSelectSubCategory: isSelectSubCategory,
          onChangedSubCategory: (val) {
            setState(() {
              subCategory = val;
              typeCategory = new TypeCategory();
              isSelectSubCategory = true;

              isLoadingTypeCategory = true;

              isSelectTypeCategory = false;
              typeCategoryList.clear();
            });
            Future.delayed(
                Duration(seconds: 1), () => fetchTypeCategory(context));
          },
          isLoadingTypeCategory: isLoadingTypeCategory,
          typeCategory: typeCategory,
          typeCategoryList: typeCategoryList,
          isSelectTypeCategory: isSelectTypeCategory,
          onChangedTypeCategory: (val) {
            setState(() {
              typeCategory = val;
              isSelectTypeCategory = true;
            });
          },
          isHour: isHour,
          onTap: titleController.text.isNotEmpty &&
                  descriptionController.text.isNotEmpty &&
                  category != null &&
                  typeCategory != null &&
                  amount > 0 &&
                  imageGalleries.length > 0
              ? () => createPortfolio(context)
              : null,
          allowed: titleController.text.isNotEmpty &&
              descriptionController.text.isNotEmpty &&
              category.category != null &&
              typeCategory.typeCategory != null &&
              amount > 0 &&
              imageGalleries.length > 0),
    );
  }
}

Widget appBarSection({
  BuildContext context,
  Size size,
  Feeds item,
  List<File> pictures,
  Profile profile,
}) {
  return AppBar(
    backgroundColor: AppColors.white,
    elevation: 1.0,
    iconTheme: IconThemeData(),
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: AppColors.black,
      ),
      onPressed: () => Navigation().navigateBack(context),
    ),
    actions: <Widget>[
      Visibility(
        visible: profile.userId == item.userId,
        child: IconButton(
          icon: Icon(
            Icons.delete,
            color: AppColors.grey707070,
          ),
          onPressed: () => {},
        ),
      ),
      ButtonPrimary(
        padding: EdgeInsets.all(4.0),
        buttonColor: AppColors.white,
        borderRadius: BorderRadius.circular(20.0),
        child: pictures.length > 0 &&
                item.title != null &&
                item.description != null &&
                item.category != null &&
                item.subCategory != null &&
                item.typeCategory != null
            ? Image.asset(
                Assets.iconEye,
                height: 40.0,
                width: 40.0,
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(Colors.grey, BlendMode.color),
                  child: Image.asset(
                    Assets.iconEye,
                    height: 40.0,
                    width: 40.0,
                  ),
                ),
              ),
        onTap: pictures.length > 0 &&
                item.title != null &&
                item.description != null &&
                item.category != null &&
                item.subCategory != null &&
                item.typeCategory != null
            ? () => Navigation().navigateScreen(
                context,
                FeedsDetailScreen(
                  index: 1,
                  item: item,
                  pictures: pictures,
                  before: 'preview',
                  onUpdate: (item) => Navigation().navigateBack(context),
                ))
            : null,
      ),
      SizedBox(
        width: 16.0,
      ),
    ],
  );
}

Widget bodySection({
  BuildContext context,
  Size size,
  ScrollController controller,
  String before,
  Function onPickImage,
  Function(int, File) onRemove,
  List<File> imageList,
  Function(String) onChangedTitle,
  Function(String) onChangedDescription,
  TextInputProps propsTitle,
  TextInputProps propsDescription,
  TextInputProps propsLink,
  TextInputProps propsPayment,
  Function(String) onChangedAmount,
  double duration,
  Function(double) onChangedDuration,
  bool isLoadingCategory,
  Category category,
  List<Category> categoryList,
  bool isSelectCategory,
  Function(Category) onChangedCategory,
  bool isLoadingSubCategory,
  SubCategory subCategory,
  List<SubCategory> subCategoryList,
  bool isSelectSubCategory,
  Function(SubCategory) onChangedSubCategory,
  bool isLoadingTypeCategory,
  TypeCategory typeCategory,
  List<TypeCategory> typeCategoryList,
  bool isSelectTypeCategory,
  Function(TypeCategory) onChangedTypeCategory,
  bool isHour,
  Function onTap,
  Profile profile,
  bool allowed,
}) {
  return GestureDetector(
    onTap: () => Keyboard().closeKeyboard(context),
    child: ListView(
      shrinkWrap: true,
      controller: controller,
      padding: EdgeInsets.symmetric(vertical: 16.0),
      children: <Widget>[
        gallerySection(
            context: context,
            size: size,
            before: before,
            onPickImage: onPickImage,
            imageList: imageList,
            onRemove: (index, file) => onRemove(index, file)),
        dividerColor(),
        descriptionSection(
          context: context,
          size: size,
          onChanged: (val) => onChangedTitle(val),
          propsTitle: propsTitle,
          propsDescription: propsDescription,
          propsLink: propsLink,
          profile: profile,
        ),
        dividerColor(),
        paymentSection(
            context: context,
            size: size,
            propsPayment: propsPayment,
            duration: duration,
            onChanged: (val) => onChangedAmount(val),
            onChangedDuration: (val) => onChangedDuration(val)),
        dividerColor(),
        categorySection(
          context: context,
          size: size,
          isLoadingCategory: isLoadingCategory,
          category: category,
          categoryList: categoryList,
          isSelectCategory: isSelectCategory,
          onChangedCategory: (val) => onChangedCategory(val),
          isLoadingSubCategory: isLoadingSubCategory,
          subCategory: subCategory,
          subCategoryList: subCategoryList,
          isSelectSubCategory: isSelectSubCategory,
          onChangedSubCategory: (val) => onChangedSubCategory(val),
          isLoadingTypeCategory: isLoadingTypeCategory,
          typeCategory: typeCategory,
          typeCategoryList: typeCategoryList,
          isSelectTypeCategory: isSelectTypeCategory,
          onChangedTypeCategory: (val) => onChangedTypeCategory(val),
          isHour: isHour,
        ),
        dividerColor(height: 52.0),
        buttonSection(
          context: context,
          size: size,
          onTap: onTap,
          allowed: allowed,
        ),
      ],
    ),
  );
}

Widget gallerySection({
  BuildContext context,
  Size size,
  String before,
  Function onPickImage,
  List<File> imageList,
  Function(int, File) onRemove,
}) {
  return Container(
    padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
//        Container(
//          padding: EdgeInsets.symmetric(horizontal: 16.0),
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              Text(
//                Strings.uploadImage.toUpperCase(),
//                style: TextStyle(color: AppColors.black, fontSize: 12.0),
//              ),
//              SizedBox(height: 16.0),
//              Row(
//                children: <Widget>[
//                  ButtonPrimary(
//                      onTap: imageList.length < 5 ? onPickImage : null,
//                      child: Row(
//                        children: <Widget>[
//                          Image.asset(
//                            Assets.iconGallery,
//                            height: 45.0,
//                            width: 45.0,
//                          ),
//                          SizedBox(width: 16.0),
//                          Text(
//                            Strings.openGallery,
//                            style: TextStyle(
//                              color: AppColors.white,
//                              fontSize: 12.0,
//                            ),
//                          )
//                        ],
//                      ),
//                      buttonColor: AppColors.black),
//                  SizedBox(width: 16.0),
//                  Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      Text(
//                        Strings.recommendation + ':',
//                        style: TextStyle(
//                            color: AppColors.black.withOpacity(.5),
//                            fontSize: 12.0),
//                      ),
//                      SizedBox(height: 8.0),
//                      Text(
//                        Strings.sizeImg410,
//                        style:
//                            TextStyle(color: AppColors.black, fontSize: 12.0),
//                      ),
//                    ],
//                  ),
//                ],
//              ),
//            ],
//          ),
//        ),
//        dividerLine(),
        yellowBanner(
            title: Strings.createGalleryInfo,
            margin: EdgeInsets.symmetric(horizontal: 16.0)),
        SizedBox(height: 16.0),
        galleryList(
            context: context,
            size: size,
            imageList: imageList,
            onPickImage: onPickImage,
            onRemove: (index, file) => onRemove(index, file)),
      ],
    ),
  );
}

Widget yellowBanner({String title, EdgeInsets margin}) {
  return Container(
    padding: EdgeInsets.all(8.0),
    margin: margin,
    decoration: BoxDecoration(
        color: AppColors.yellow.withOpacity(.15),
        borderRadius: BorderRadius.circular(5.0)),
    child: Row(
      children: <Widget>[
        Image.asset(
          Assets.iconWaveYellow,
          height: 20.0,
          width: 20.0,
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            title,
            style: TextStyle(color: AppColors.yellowDark, fontSize: 10.0),
          ),
        ),
      ],
    ),
  );
}

Widget galleryList({
  BuildContext context,
  Size size,
  List<File> imageList,
  Function(int, File) onRemove,
  Function onPickImage,
}) {
  return Container(
      height: 110.0,
      width: size.width,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        itemBuilder: (BuildContext context, int index) {
          if (index < imageList.length) {
            return cardGallery(
                context: context,
                size: size,
                image: imageList[index],
                onRemove: () => onRemove(index, imageList[index]));
          } else if (index == imageList.length) {
            return cardAddPicture(
                context: context, size: size, onPickImage: onPickImage);
          } else {
            return Container();
          }
        },
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(width: 8.0),
        itemCount: 5,
      ));
}

Widget cardAddPicture({
  BuildContext context,
  Size size,
  Function onPickImage,
}) {
  return GestureDetector(
    onTap: onPickImage,
    child: Container(
      height: 105.0,
      width: 105.0,
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(vertical: 5.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: AppColors.grey, borderRadius: BorderRadius.circular(5.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.add,
            color: Colors.black38,
          ),
          SizedBox(height: 4),
          Text(
            "Tambah",
            style: TextStyle(color: Colors.black38, fontSize: 12),
          ),
        ],
      ),
    ),
  );
}

Widget cardGallery({
  BuildContext context,
  Size size,
  File image,
  Function onRemove,
}) {
  return Stack(
    children: <Widget>[
      Container(
        height: 105.0,
        width: 105.0,
        margin: EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: AppColors.grey707070, width: .2)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.file(
            image,
            width: 40.0,
            height: 40.0,
            fit: BoxFit.cover,
          ),
        ),
      ),
      Positioned(
        top: 8,
        right: 8,
        child: ButtonPrimary(
          onTap: onRemove,
          buttonColor: AppColors.white,
          borderRadius: BorderRadius.circular(16.0),
          padding: EdgeInsets.all(2.0),
          child: Icon(
            Icons.close,
            size: 20.0,
            color: AppColors.black,
          ),
        ),
      ),
    ],
  );
}

Widget descriptionSection({
  BuildContext context,
  Size size,
  TextInputProps propsTitle,
  TextInputProps propsDescription,
  TextInputProps propsLink,
  Function(String) onChanged,
  Profile profile,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(21.0),
              child: Container(
                color: AppColors.light,
                child: FadeInImage.assetNetwork(
                  placeholder: avatar(profile.name),
                  image: BaseUrl.SoedjaAPI + '/' + (profile.picture ?? ''),
                  width: 40.0,
                  height: 40.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: EditText.TextInput(
                props: propsTitle,
                border: InputBorder.none,
                minLines: 2,
                maxLines: 2,
                onChanged: (val) {
                  onChanged(val);
                },
              ),
            ),
          ],
        ),
        Container(
          width: size.width,
          margin: EdgeInsets.symmetric(vertical: 16.0),
          child: Expanded(
            child: EditText.TextInput(
              padding: EdgeInsets.all(16.0),
              props: propsDescription,
              minLines: 10,
              maxLines: 10,
              onChanged: (val) {
                onChanged(val);
              },
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Image.asset(
              Assets.iconNews,
              width: 26.0,
              height: 26.0,
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Text(
                Strings.tipsPortfolio,
                style: TextStyle(
                    color: AppColors.grey707070, height: 1.5, fontSize: 8.0),
              ),
            )
          ],
        ),
        SizedBox(height: 24.0),
        Text(
          Strings.optionalVideo.toUpperCase(),
          style: TextStyle(color: AppColors.black, fontSize: 12.0),
        ),
        Container(
          decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.grey707070, width: 0.5),
              borderRadius: BorderRadius.circular(5.0)),
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          margin: EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: <Widget>[
              Image.asset(
                Assets.iconYoutubeLink,
                height: 26.0,
                width: 26.0,
              ),
              SizedBox(width: 8.0),
              Text(
                Strings.youtubeLink,
                style: TextStyle(
                  color: AppColors.grey707070,
                  fontSize: 12.0,
                ),
              ),
              SizedBox(width: 2.0),
              Expanded(
                child: EditText.TextInput(
                  props: propsLink,
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  border: InputBorder.none,
                  onChanged: (val) {
                    onChanged(val);
                  },
                ),
              ),
              SizedBox(width: 4.0),
              ButtonPrimary(
                  buttonColor: AppColors.white,
                  padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                  child: Image.asset(
                    Assets.iconCopas,
                    height: 20.0,
                    width: 20.0,
                  ))
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Image.asset(
              Assets.iconNews,
              width: 26.0,
              height: 26.0,
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Text(
                Strings.tipsLinkVideo,
                style: TextStyle(
                    color: AppColors.grey707070, height: 1.5, fontSize: 8.0),
              ),
            )
          ],
        ),
      ],
    ),
  );
}

Widget paymentSection({
  BuildContext context,
  Size size,
  EditText.TextInputProps propsPayment,
  Function(String) onChanged,
  double duration,
  Function(double) onChangedDuration,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RichText(
          text: TextSpan(
            text: Strings.finalPaymentTotal.toUpperCase() + "  ",
            style: TextStyle(
              fontSize: 12.0,
              color: AppColors.black,
              fontFamily: Fonts.ubuntu,
            ),
            children: <TextSpan>[
              TextSpan(
                text: '*',
                style: TextStyle(
                  fontSize: 15.0,
                  color: AppColors.red,
                  fontFamily: Fonts.ubuntu,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          Strings.infoPayment,
          style: TextStyle(
            color: AppColors.dark.withOpacity(.6),
            fontSize: 10.0,
            height: 1.5,
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          children: <Widget>[
            Container(
              height: 48.0,
              alignment: Alignment.center,
              width: 80.0,
              decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(5.0))),
              child: Text(
                'Rp',
                style: TextStyle(color: AppColors.white, fontSize: 15.0),
              ),
            ),
            Expanded(
              flex: 10,
              child: EditText.TextInput(
                padding: EdgeInsets.all(16.0),
                border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.horizontal(right: Radius.circular(5.0))),
                props: propsPayment,
                onChanged: (val) {
                  onChanged(val);
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 24.0),
        RichText(
          text: TextSpan(
            text: Strings.duration.toUpperCase() + "  ",
            style: TextStyle(
              fontSize: 12.0,
              color: AppColors.black,
              fontFamily: Fonts.ubuntu,
            ),
            children: <TextSpan>[
              TextSpan(
                text: '*',
                style: TextStyle(
                  fontSize: 15.0,
                  color: AppColors.red,
                  fontFamily: Fonts.ubuntu,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          Strings.infoDuration,
          style: TextStyle(
            color: AppColors.dark.withOpacity(.6),
            fontSize: 10.0,
            height: 1.5,
          ),
        ),
        dividerLine(height: 32.0),
        Container(
          alignment: Alignment.centerRight,
          child: Text(
            '${duration.toInt().toString()} ' + Strings.days.toUpperCase(),
            style: TextStyle(fontSize: 10.0, color: AppColors.dark),
          ),
        ),
        SizedBox(height: 4.0),
        Container(
          height: 20.0,
          child: SliderTheme(
            data: SliderThemeData(
                trackHeight: 5.0,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0)),
            child: Slider(
              activeColor: AppColors.primary,
              inactiveColor: AppColors.grey,
              value: duration,
              min: 1.0,
              max: 365.0,
              onChanged: (val) => onChangedDuration(val),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget categorySection({
  BuildContext context,
  Size size,
  bool isLoadingCategory,
  Category category,
  List<Category> categoryList,
  bool isSelectCategory,
  Function(Category) onChangedCategory,
  bool isLoadingSubCategory,
  SubCategory subCategory,
  List<SubCategory> subCategoryList,
  bool isSelectSubCategory,
  Function(SubCategory) onChangedSubCategory,
  bool isLoadingTypeCategory,
  TypeCategory typeCategory,
  List<TypeCategory> typeCategoryList,
  bool isSelectTypeCategory,
  Function(TypeCategory) onChangedTypeCategory,
  bool isHour,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RichText(
          text: TextSpan(
            text: Strings.categoryPortfolio.toUpperCase() + "  ",
            style: TextStyle(
              fontSize: 12.0,
              color: AppColors.black,
              fontFamily: Fonts.ubuntu,
            ),
            children: <TextSpan>[
              TextSpan(
                text: '*',
                style: TextStyle(
                  fontSize: 15.0,
                  color: AppColors.red,
                  fontFamily: Fonts.ubuntu,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: !isHour ? 180.0 : 110.0,
          width: size.width,
          margin: EdgeInsets.only(top: 16.0),
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: 16.0,
                  left: 15.0,
                  bottom: 16.0,
                  child: Container(
                    width: 5.0,
                    color: AppColors.light,
                  )),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: AppColors.light,
                                borderRadius: BorderRadius.circular(20.0)),
                            height: 36.0,
                            width: 36.0,
                            alignment: Alignment.center,
                            child: Text(
                              '1.',
                              style: TextStyle(
                                  color: AppColors.black, fontSize: 12.0),
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                      color: AppColors.grey707070, width: .2)),
                              child: DropdownButton<Category>(
                                isExpanded: true,
                                hint: isLoadingCategory
                                    ? Shimmer.fromColors(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          height: 12.0,
                                          width: 150.0,
                                        ),
                                        baseColor: AppColors.light,
                                        highlightColor: AppColors.lighter)
                                    : Text(
                                        isSelectCategory
                                            ? category.category
                                            : Strings.selectCategory,
                                        style: TextStyle(
                                          color: AppColors.grey707070,
                                          fontSize: 12.0,
                                          fontFamily: Fonts.ubuntu,
                                        ),
                                      ),
                                style: TextStyle(
                                  color: AppColors.dark,
                                  fontSize: 12.0,
                                  fontFamily: Fonts.ubuntu,
                                ),
                                value: isSelectCategory ? category : null,
                                underline: Container(),
                                onChanged: categoryList.length > 0
                                    ? (val) => onChangedCategory(val)
                                    : null,
                                items: categoryList.map((data) {
                                  return DropdownMenuItem(
                                    child: new Text(data.category),
                                    value: data,
                                  );
                                }).toList(),
                              ),
                            ),
                          )
                        ],
                      ),
                      Visibility(
                        visible: !isHour,
                        child: Row(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.light,
                                  borderRadius: BorderRadius.circular(20.0)),
                              height: 36.0,
                              width: 36.0,
                              alignment: Alignment.center,
                              child: Text(
                                '2.',
                                style: TextStyle(
                                    color: AppColors.black, fontSize: 12.0),
                              ),
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                        color: AppColors.grey707070,
                                        width: .2)),
                                child: DropdownButton<SubCategory>(
                                  isExpanded: true,
                                  hint: isLoadingSubCategory
                                      ? Shimmer.fromColors(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: AppColors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                            height: 12.0,
                                            width: 150.0,
                                          ),
                                          baseColor: AppColors.light,
                                          highlightColor: AppColors.lighter)
                                      : Text(
                                          isSelectSubCategory
                                              ? subCategory.subCategory
                                              : Strings.selectSubCategory,
                                          style: TextStyle(
                                            color: AppColors.grey707070,
                                            fontSize: 12.0,
                                            fontFamily: Fonts.ubuntu,
                                          ),
                                        ),
                                  style: TextStyle(
                                    color: AppColors.dark,
                                    fontSize: 12.0,
                                    fontFamily: Fonts.ubuntu,
                                  ),
                                  value:
                                      isSelectSubCategory ? subCategory : null,
                                  underline: Container(),
                                  onChanged: subCategoryList.length > 0
                                      ? (val) => onChangedSubCategory(val)
                                      : null,
                                  items: subCategoryList.map((data) {
                                    return DropdownMenuItem(
                                      child: new Text(data.subCategory),
                                      value: data,
                                    );
                                  }).toList(),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: AppColors.light,
                                borderRadius: BorderRadius.circular(20.0)),
                            height: 36.0,
                            width: 36.0,
                            alignment: Alignment.center,
                            child: Text(
                              isHour ? '2.' : '3.',
                              style: TextStyle(
                                  color: AppColors.black, fontSize: 12.0),
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                      color: AppColors.grey707070, width: .2)),
                              child: DropdownButton<TypeCategory>(
                                isExpanded: true,
                                hint: isLoadingTypeCategory
                                    ? Shimmer.fromColors(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          height: 12.0,
                                          width: 150.0,
                                        ),
                                        baseColor: AppColors.light,
                                        highlightColor: AppColors.lighter)
                                    : Text(
                                        isSelectTypeCategory
                                            ? typeCategory.typeCategory
                                            : Strings.selectTypeCategory,
                                        style: TextStyle(
                                          color: AppColors.grey707070,
                                          fontSize: 12.0,
                                          fontFamily: Fonts.ubuntu,
                                        ),
                                      ),
                                style: TextStyle(
                                  color: AppColors.dark,
                                  fontSize: 12.0,
                                  fontFamily: Fonts.ubuntu,
                                ),
                                value:
                                    isSelectTypeCategory ? typeCategory : null,
                                underline: Container(),
                                onChanged: typeCategoryList.length > 0
                                    ? (val) => onChangedTypeCategory(val)
                                    : null,
                                items: typeCategoryList.map((data) {
                                  return DropdownMenuItem(
                                    child: new Text(data.typeCategory),
                                    value: data,
                                  );
                                }).toList(),
                              ),
                            ),
                          )
                        ],
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buttonSection(
    {BuildContext context, Size size, Function onTap, bool allowed}) {
  return Container(
    padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
    child: ButtonPrimary(
        onTap: allowed ? onTap : null,
        allowed: allowed,
        buttonColor: AppColors.black,
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Text(
          Strings.publish.toUpperCase(),
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
          ),
        )),
  );
}
