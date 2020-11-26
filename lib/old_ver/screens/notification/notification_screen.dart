import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:soedja_freelance/old_ver/constants/assets.dart';
import 'package:soedja_freelance/old_ver/constants/strings.dart';
import 'package:soedja_freelance/old_ver/constants/urls.dart';
import 'package:soedja_freelance/old_ver/models/feeds.dart';
import 'package:soedja_freelance/old_ver/models/notification.dart';
import 'package:soedja_freelance/old_ver/screens/feeds/detail_screen.dart';
import 'package:soedja_freelance/old_ver/screens/feeds/feeds_screen.dart';
import 'package:soedja_freelance/old_ver/services/notification.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';
import 'package:soedja_freelance/old_ver/utils/helpers.dart';
import 'package:soedja_freelance/old_ver/utils/navigation.dart';
import 'dart:math' as math;

class NotificationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NotificationScreen();
  }
}

class _NotificationScreen extends State<NotificationScreen> {
  ScrollController controller = new ScrollController();

  int page = 1;
  int limit = 10;

  List<Notifications> notificationList;
  bool isEmpty = false;
  bool isLoading = true;
  bool disableLoad = false;
  bool isLoadMore = false;

  void scrollListener() {
    if (controller.position.pixels >
        controller.position.maxScrollExtent -
            MediaQuery.of(context).size.width) {
      if (isLoadMore && !isLoading && !disableLoad) {
        setState(() {
          disableLoad = true;
          page++;
          notificationList.add(Notifications());
        });

        Future.delayed(Duration(seconds: 1), () => fetchNotification());
      }
    }
  }

  void fetchNotification() {
    NotificationPayload payload = new NotificationPayload();
    payload = new NotificationPayload(limit: limit, page: page);

    getNotification(context: context, payload: payload);
  }

  void getNotification(
      {BuildContext context, NotificationPayload payload}) async {
    NotificationService().getNotification(context, payload).then((response) {
      if (page > 1) {
        notificationList.removeLast();
        if (response.length > 0) {
          setState(() {
            if (response.length < 10) {
              isLoadMore = false;
              disableLoad = true;
            } else {
              disableLoad = false;
            }
            notificationList.addAll(response);
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
            notificationList = response;
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

  void updateNotification(Notifications item, int index) {
    setState(() {
      notificationList[index].isRead = true;
    });
    NotificationService().readNotification(context, item.messageId);
    Feeds feeds = new Feeds(portfolioId: 'AJN78TcXURiD57g4SsCUACcmG8fONI');
//    Navigation().navigateScreen(
//        context,
//        FeedsDetailScreen(
//          before: 'notification',
//          item: feeds,
//          index: index,
//          onUpdate: (item) => Navigation().navigateBack(context),
//        ));
  }

  @override
  void initState() {
    controller.addListener(scrollListener);
    fetchNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBarSection(context: context),
      body: bodySection(
        context: context,
        isEmpty: isEmpty,
        isLoading: isLoading,
        size: size,
        controller: controller,
        list: notificationList,
        isLoadMode: isLoadMore,
        disableLoad: disableLoad,
        onUpdate: (val, index) {
          updateNotification(val, index);
        },
      ),
    );
  }
}

Widget appBarSection({BuildContext context}) {
  return AppBar(
    backgroundColor: AppColors.white,
    elevation: 1.0,
    textTheme: TextTheme(),
    automaticallyImplyLeading: false,
    title: Text(
      Strings.activity,
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
  List<Notifications> list,
  ScrollController controller,
  Size size,
  bool isLoadMode,
  bool disableLoad,
  Function(Notifications, int) onUpdate,
}) {
  if (isLoading) {
    return loaderSection(context: context, size: size, count: 10);
  } else {
    if (isEmpty) {
      return emptySection(context: context, size: size);
    } else {
      return notificationListSection(
        context: context,
        size: size,
        controller: controller,
        list: list,
        isLoadMore: isLoadMode,
        isLoading: isLoading,
        disableLoad: disableLoad,
        onUpdate: (val, index) => onUpdate(val, index),
      );
    }
  }
}

Widget loaderSection({BuildContext context, Size size, int count}) {
  return ListView.separated(
    shrinkWrap: true,
    padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 40.0),
    separatorBuilder: (BuildContext context, int index) =>
        dividerLine(height: 16.0),
    itemCount: count,
    itemBuilder: (BuildContext context, int index) {
      return loaderNotification(context: context, size: size);
    },
  );
}

Widget loaderNotification({BuildContext context, Size size}) {
  return Container(
    color: AppColors.white,
    width: size.width,
    child: Shimmer.fromColors(
      baseColor: AppColors.light,
      highlightColor: AppColors.lighter,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 33.0,
            width: 33.0,
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(17.0)),
          ),
          SizedBox(width: 8.0),
          Container(
            height: 33.0,
            width: 33.0,
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(17.0)),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 12.0,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(4.0)),
                ),
                SizedBox(height: 2.0),
                Container(
                  height: 12.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(4.0)),
                ),
                SizedBox(height: 8.0),
                Container(
                  height: 10.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(4.0)),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget notificationListSection({
  BuildContext context,
  Size size,
  ScrollController controller,
  List<Notifications> list,
  bool isLoading,
  bool isLoadMore,
  bool disableLoad,
  Function(Notifications, int) onUpdate,
}) {
  return ListView.separated(
    controller: controller,
    shrinkWrap: true,
    padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 40.0),
    separatorBuilder: (BuildContext context, int index) =>
        dividerLine(height: 16.0),
    itemCount: list.length,
    itemBuilder: (BuildContext context, int index) {
      return cardNotification(
          context: context,
          item: list[index],
          index: index,
          size: size,
          isLoading: list[index].detail == null,
          onUpdate: (val) => onUpdate(val, index));
    },
  );
}

Widget cardNotification({
  BuildContext context,
  int index,
  Notifications item,
  Size size,
  bool isLoading = false,
  Function(Notifications) onUpdate,
}) {
  if (!isLoading) {
    Feeds feeds = new Feeds();
    return GestureDetector(
      onTap: () => onUpdate(item),
      child: Container(
        color: AppColors.white,
        width: size.width,
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            item.isRead
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: ColorFiltered(
                      colorFilter:
                          ColorFilter.mode(Colors.grey, BlendMode.color),
                      child: Image.asset(
                        item.type == 'comment'
                            ? Assets.iconNotificationComment
                            : Assets.iconNotificationLike,
                        height: 33.0,
                        width: 33.0,
                      ),
                    ),
                  )
                : Image.asset(
                    item.type == 'comment'
                        ? Assets.iconNotificationComment
                        : Assets.iconNotificationLike,
                    height: 33.0,
                    width: 33.0,
                  ),
            SizedBox(width: 8.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: Container(
                color: AppColors.light,
                child: FadeInImage.assetNetwork(
                  placeholder: Assets.imgPlaceholder,
                  image: item.detail.picture != null
                      ? BaseUrl.SoedjaAPI + '/' + item.detail.picture
                      : '',
                  width: 33.0,
                  height: 33.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      text: item.detail.name + ' ',
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: Fonts.ubuntu),
                      children: <TextSpan>[
                        item.type == 'comment'
                            ? TextSpan(
                                text: Strings.descriptionComment,
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: Fonts.ubuntu),
                              )
                            : TextSpan(
                                text: Strings.descriptionLike,
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: Fonts.ubuntu),
                              ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    dateFormat(date: item.createdAt),
                    style: TextStyle(
                      color: AppColors.dark.withOpacity(.7),
                      fontSize: 10.0,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  } else {
    return loaderNotification(context: context, size: size);
  }
}
