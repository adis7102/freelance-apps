import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:soedja_freelance/old_ver/components/button.dart';
import 'package:soedja_freelance/old_ver/constants/assets.dart';
import 'package:soedja_freelance/old_ver/constants/strings.dart';
import 'package:soedja_freelance/old_ver/constants/urls.dart';
import 'package:soedja_freelance/old_ver/models/bookmark.dart';
import 'package:soedja_freelance/old_ver/models/feeds.dart';
import 'package:soedja_freelance/old_ver/screens/feeds/detail_screen.dart';
import 'package:soedja_freelance/old_ver/screens/feeds/feeds_screen.dart';
import 'package:soedja_freelance/old_ver/screens/search/search_home_screen.dart';
import 'package:soedja_freelance/old_ver/services/bookmark.dart';
import 'package:soedja_freelance/old_ver/services/feeds.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';
import 'package:soedja_freelance/old_ver/utils/helpers.dart';
import 'package:soedja_freelance/old_ver/utils/navigation.dart';

class BookmarkScreen extends StatefulWidget {
  final Function onUpdate;

  BookmarkScreen({
    this.onUpdate,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BookmarkScreen();
  }
}

class _BookmarkScreen extends State<BookmarkScreen> {
  ScrollController controller = new ScrollController();

  int page = 1;
  int limit = 10;

  List<Bookmarks> bookmarkList = new List<Bookmarks>();
  bool isEmpty = false;
  bool isLoading = true;
  bool disableLoad = false;
  bool isLoadMore = false;

  void scrollListener() {
    if (controller.position.pixels >
        controller.position.maxScrollExtent - 100) {
      if (isLoadMore && !isLoading && !disableLoad) {
        setState(() {
          disableLoad = true;
          page++;
          bookmarkList.add(Bookmarks());
          bookmarkList.add(Bookmarks());
        });

        Future.delayed(Duration(seconds: 1), () => fetchBookmark());
      }
    }
  }

  void fetchBookmark() {
    BookmarkService()
        .getBookmark(context, BookmarksPayload(limit: limit, page: page))
        .then((response) {
      if (page > 1) {
        bookmarkList.removeLast();
        bookmarkList.removeLast();
        if (response.length > 0) {
          setState(() {
            if (response.length < 10) {
              isLoadMore = false;
              disableLoad = true;
            } else {
              disableLoad = false;
            }
            bookmarkList.addAll(response);
          });
        } else {
          setState(() {
            isLoadMore = false;
            disableLoad = true;
          });
        }
      } else {
        if (response.length > 0) {
          setState(() {
            isLoading = false;
            isEmpty = false;
            isLoadMore = true;
            disableLoad = false;
            bookmarkList = response;
          });
        } else {
          setState(() {
            isLoading = false;
            disableLoad = true;
            isEmpty = true;
          });
        }
      }
    });
  }

  void onRemove(Feeds item, int position) {
    FeedsService().deleteBookmark(context, item).then((response) async {
      if (response) {
        setState(() {
          bookmarkList.removeAt(position);
        });
      }
    });
  }

  @override
  void initState() {
    controller.addListener(scrollListener);
    fetchBookmark();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBarSection(
        context: context,
        onUpdate: widget.onUpdate,
      ),
      body: bodySection(
        context: context,
        size: size,
        isEmpty: isEmpty,
        isLoading: isLoading,
        controller: controller,
        list: bookmarkList,
        onRemove: (val, index) =>
            onRemove(Feeds(bookmarkId: val.bookmarkId), index),
      ),
    );
  }
}

Widget appBarSection({
  BuildContext context,
  Function onUpdate,
}) {
  return AppBar(
    backgroundColor: AppColors.white,
    titleSpacing: 0.0,
    elevation: .5,
    iconTheme: IconThemeData(),
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: AppColors.black,
      ),
      onPressed: () => onUpdate(),
    ),
    title: Text(
      Strings.bookmark,
      style: TextStyle(
        color: AppColors.black,
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget bodySection({
  BuildContext context,
  bool isLoading,
  bool isEmpty,
  List<Bookmarks> list,
  ScrollController controller,
  Size size,
  Function(Bookmarks, int) onRemove,
}) {
  if (isLoading) {
    return loaderBookmark(context: context, size: size, count: 6);
  } else {
    if (isEmpty) {
      return emptySection(context: context, size: size);
    } else {
      return bookmarkList(
        context: context,
        size: size,
        controller: controller,
        list: list,
        onRemove: (val, index) => onRemove(val, index),
      );
    }
  }
}

Widget loaderBookmark({BuildContext context, Size size, int count}) {
  return StaggeredGridView.countBuilder(
    crossAxisCount: 4,
    itemCount: count,
    shrinkWrap: true,
    staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
    mainAxisSpacing: 16.0,
    crossAxisSpacing: 16.0,
    padding: EdgeInsets.all(16.0),
    itemBuilder: (BuildContext context, int index) {
      return loaderBookmarks(context: context, size: size);
    },
  );
}

Widget loaderBookmarks({BuildContext context, Size size}) {
  return Shimmer.fromColors(
    baseColor: AppColors.light,
    highlightColor: AppColors.lighter,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          color: AppColors.light,
          height: (size.width - (16 * 3)) / 2,
          width: (size.width - (16 * 3)) / 2,
        ),
        SizedBox(height: 16.0),
        Container(
          color: AppColors.light,
          height: 13.0,
          width: (size.width - (16 * 3)) / 2,
        ),
        SizedBox(height: 4.0),
        Container(
          color: AppColors.light,
          height: 13.0,
          width: (size.width - (16 * 3)) / 3,
        ),
        SizedBox(height: 16.0),
        Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                color: AppColors.light,
                width: 32.0,
                height: 32.0,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    color: AppColors.light,
                    height: 13.0,
                    width: 100.0,
                  ),
                  SizedBox(height: 4.0),
                  Container(
                    color: AppColors.light,
                    height: 13.0,
                    width: 200.0,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                color: AppColors.light,
                width: 24.0,
                height: 24.0,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget bookmarkList({
  BuildContext context,
  Size size,
  ScrollController controller,
  List<Bookmarks> list,
  Function(Bookmarks, int) onRemove,
}) {
  return StaggeredGridView.countBuilder(
    controller: controller,
    crossAxisCount: 4,
    itemCount: list.length,
    shrinkWrap: true,
    staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
    mainAxisSpacing: 16.0,
    crossAxisSpacing: 16.0,
    padding: EdgeInsets.all(16.0),
    itemBuilder: (BuildContext context, int index) {
      return cardBookmark(
          context: context,
          item: list[index],
          isLoading: list[index].portfolioDetail == null,
          size: size,
          onRemove: (val) => onRemove(val, index));
    },
  );
}

Widget cardBookmark({
  BuildContext context,
  Bookmarks item,
  Size size,
  bool isLoading = false,
  Function(Bookmarks) onRemove,
}) {
  if (!isLoading) {
    return GestureDetector(
      onTap: () => Navigation().navigateScreen(
          context,
          FeedsDetailScreen(
            item: Feeds.fromJson(item.toJson()),
            index: null,
            onUpdate: (val) => {},
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: AppColors.light,
            child: FadeInImage.assetNetwork(
              placeholder: Assets.imgPlaceholder,
              image: item.portfolioDetail.pictures.length > 0
                  ? BaseUrl.SoedjaAPI +
                      '/' +
                      item.portfolioDetail.pictures[0].path
                  : '',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            item.portfolioDetail.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
                fontSize: 12.0),
          ),
          SizedBox(height: 16.0),
          Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  color: AppColors.light,
                  child: FadeInImage.assetNetwork(
                    placeholder: avatar(item.userDetail.name),
                    image: BaseUrl.SoedjaAPI + '/' + item.userDetail.picture,
                    width: 32.0,
                    height: 32.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.userDetail.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 10.0),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      item.userDetail.province + ', Indonesia',
                      style: TextStyle(
                          color: AppColors.black.withOpacity(.6),
                          fontWeight: FontWeight.bold,
                          fontSize: 10.0),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.0),
              ButtonPrimary(
                onTap: () => onRemove(item),
                buttonColor: AppColors.white,
                padding: EdgeInsets.all(4.0),
                child: Icon(
                  Icons.bookmark,
                  color: AppColors.green,
                  size: 16.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  } else {
    return loaderBookmark(context: context, size: size);
  }
}
