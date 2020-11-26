import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:soedja_freelance/old_ver/components/button.dart';
import 'package:soedja_freelance/old_ver/components/dialog.dart';
import 'package:soedja_freelance/old_ver/constants/assets.dart';
import 'package:soedja_freelance/old_ver/constants/local_storage.dart';
import 'package:soedja_freelance/old_ver/constants/strings.dart';
import 'package:soedja_freelance/old_ver/constants/urls.dart';
import 'package:soedja_freelance/old_ver/models/category.dart';
import 'package:soedja_freelance/old_ver/models/feeds.dart';
import 'package:soedja_freelance/old_ver/models/interest.dart';
import 'package:soedja_freelance/old_ver/models/user.dart';
import 'package:soedja_freelance/old_ver/services/category.dart';
import 'package:soedja_freelance/old_ver/services/feeds.dart';
import 'package:soedja_freelance/old_ver/services/user.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';
import 'package:soedja_freelance/old_ver/utils/local_storage.dart';
import 'package:soedja_freelance/old_ver/utils/navigation.dart';

class InterestScreen extends StatefulWidget {
  final String before;
  final Profile profile;
  final Function update;

  InterestScreen({
    this.before,
    this.profile,
    this.update,
  });

  @override
  State<StatefulWidget> createState() {
    return _InterestScreen();
  }
}

class _InterestScreen extends State<InterestScreen> {
  ScrollController categoryController = new ScrollController();

  List<CategoryInterest> categoryList = new List<CategoryInterest>();
  int interest = 0;

  bool isEmpty = false;
  bool isLoading = true;

  Profile profile = new Profile();

  void closeInterest() async {
    if (widget.before == 'feeds') {
      widget.update();
    }
    await LocalStorage.set(LocalStorageKey.ShowInterest, 'false')
        .then((value) {
          Navigation().navigateBack(context);
    });
  }

  void fetchCategory() async {
    CategoryService().getCategory(context).then((response) {
      if (response.length > 0) {
        setState(() {
          for (Category category in response) {
            categoryList
                .add(CategoryInterest(category: category, selected: false));
          }
          categoryList.add(CategoryInterest(
              category: Category(category: 'Selesai'), selected: false));
          isLoading = false;
        });
      }
      Future.delayed(Duration(seconds: 1), () => fetchInterest());
    });
  }

  void fetchProfile() {
    UserService().getProfile(context).then((value) async {
      setState(() {
        profile = value;
      });
    });
  }

  void fetchInterest() {
    if (profile.interests != null && categoryList.length>0) {
      for(CategoryInterest categoryInterest in categoryList){
        for (String category in profile.interests) {
          if(categoryInterest.category.category.contains(category)){
            setState(() {
              categoryInterest.selected = true;
              interest++;
            });
          }
        }
      }
    }
  }

  void updateInterest() {
    if (interest > 0) {
      showLoading(context);

      List<String> categories = [];
      for (CategoryInterest categoryInterest in categoryList) {
        if (categoryInterest.selected) {
          categories
              .add(categoryInterest.category.category.replaceAll('Jasa ', ''));
        }
      }

      FeedsService()
          .updateInterest(context, InterestPayload(interests: categories))
          .then((response) async {
        dismissDialog(context);
        if (response) {
          await LocalStorage.set(LocalStorageKey.ShowInterest, 'false')
              .then((value) {
            showInterest(context);
          });
        }
      });
    }
  }

  @override
  void initState() {
    profile = widget.profile;
    fetchCategory();
    fetchProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: (){
        closeInterest();
      },
      child: Scaffold(
        appBar: appBarSection(),
        body: bodySection(size: size),
      ),
    );
  }

  Widget appBarSection() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.white,
      elevation: 0.0,
      titleSpacing: 24.0,
      title: Text(
        '$interest/3',
        style: TextStyle(color: AppColors.black, fontSize: 15.0),
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 12.0, 16.0, 4.0),
          child: ButtonPrimary(
            child: Icon(
              Icons.close,
              color: AppColors.black,
            ),
            borderRadius: BorderRadius.circular(20.0),
            padding: EdgeInsets.all(8.0),
            buttonColor: AppColors.white,
            boxShadow: [
              BoxShadow(
                  color: AppColors.black.withOpacity(.2),
                  blurRadius: 5,
                  offset: Offset(0.0, 2.0))
            ],
            onTap: () => closeInterest(),
          ),
        ),
      ],
    );
  }

  Widget bodySection({
    Size size,
  }) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            Strings.chooseInterest,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            Strings.descInterest,
            style: TextStyle(
              fontSize: 14.0,
              color: AppColors.black,
              height: 1.5,
            ),
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Wrap(
                spacing: 16.0,
                runSpacing: 16.0,
                children: isLoading
                    ? loaderSection(size: size, length: 6)
                    : listSection(size: size, list: categoryList),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> loaderSection({Size size, int length}) {
    List<Widget> widgets = [];

    List.generate(length, (index) {
      Widget shimmer = Shimmer.fromColors(
        baseColor: AppColors.light,
        highlightColor: AppColors.lighter,
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.light, borderRadius: BorderRadius.circular(5.0)),
          height: 64.0,
          width: (size.width - 16 - 16 - 16) / 2,
        ),
      );

      widgets.add(shimmer);
    });

    return widgets;
  }

  List<Widget> listSection({Size size, List<CategoryInterest> list}) {
    List<Widget> widgets = [];

    List.generate(list.length, (index) {
      Widget card;
      if (list[index].category.type != null) {
        card = ButtonPrimary(
          onTap: () {
            if (list[index].selected == true) {
              setState(() {
                list[index].selected = false;
                interest--;
              });
            } else {
              if (interest < 3) {
                setState(() {
                  list[index].selected = true;
                  interest++;
                });
              }
            }
          },
          width: (size.width - 16 - 16 - 16) / 2,
          height: 64.0,
          buttonColor: AppColors.white,
          padding: EdgeInsets.all(0.0),
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Container(
                  color: AppColors.light,
                  child: FadeInImage.assetNetwork(
                    placeholder: Assets.imgPlaceholder,
                    image: list[index].category.pictureCover != null
                        ? BaseUrl.SoedjaAPI +
                            '/' +
                            list[index].category.pictureCover
                        : '',
                    width: (size.width - 16 - 16 - 16) / 2,
                    height: 64.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.black.withOpacity(.3),
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 16.0),
                    Container(
                      width: 17.0,
                      height: 17.0,
                      decoration: BoxDecoration(
                        color: list[index].selected
                            ? AppColors.green
                            : AppColors.lighter,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: AppColors.white, width: 2.0),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Text(
                        list[index].category.category.replaceAll('Jasa ', ''),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                  ],
                ),
              ),
            ],
          ),
        );
      } else {
        card = buttonDone(size);
      }
      widgets.add(card);
    });
    return widgets;
  }

  Widget buttonDone(Size size) {
    return ButtonPrimary(
      width: (size.width - 16 - 16 - 16 - 4) / 2,
      height: 64.0 - 2.0,
      buttonColor: AppColors.white,
      padding: EdgeInsets.all(8.0),
      border: Border.all(color: AppColors.black, width: 1.0),
      onTap: interest > 0 ? () => updateInterest() : null,
      child: Text(
        Strings.done.toUpperCase(),
        style: TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.bold,
          fontSize: 15.0,
        ),
      ),
    );
  }
}
