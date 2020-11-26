import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:soedja_freelance/old_ver/components/button.dart';
import 'package:soedja_freelance/old_ver/constants/strings.dart';
import 'package:soedja_freelance/old_ver/constants/urls.dart';
import 'package:soedja_freelance/old_ver/models/feeds.dart';
import 'package:soedja_freelance/old_ver/models/follows.dart';
import 'package:soedja_freelance/old_ver/models/user.dart';
import 'package:soedja_freelance/old_ver/screens/feeds/detail_screen.dart';
import 'package:soedja_freelance/old_ver/screens/feeds/feeds_screen.dart';
import 'package:soedja_freelance/old_ver/services/feeds.dart';
import 'package:soedja_freelance/old_ver/services/follows.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';
import 'package:soedja_freelance/old_ver/utils/helpers.dart';
import 'package:soedja_freelance/old_ver/utils/navigation.dart';

class FollowsDataScreen extends StatefulWidget {
  final String before;
  final Profile profile;

  FollowsDataScreen({
    this.before,
    this.profile,
  });

  @override
  State<StatefulWidget> createState() {
    return _FollowsDataScreen();
  }
}

class _FollowsDataScreen extends State<FollowsDataScreen> {
  ScrollController controller = new ScrollController();

  int page = 1;
  int limit = 10;

  List<Following> followingList = new List<Following>();
  List<Follower> followerList = new List<Follower>();
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
          if (widget.before == 'follower') {
            followerList.add(Follower());
          } else {
            followingList.add(Following());
          }
        });

        Future.delayed(Duration(seconds: 1), () {
          if (widget.before == 'following') {
            fetchFollowing(context: context, payload: FeedsPayload(limit: limit, page: page));
          } else {
            fetchFollower(context: context, payload: FeedsPayload(limit: limit, page: page));
          }
        });
      }
    }
  }

  void fetchFollowing({BuildContext context, FeedsPayload payload}) async {
    FollowsService()
        .getFollowing(context, payload)
        .then((response) {
      if (page > 1) {
        followingList.removeLast();
        if (response.length > 0) {
          setState(() {
            if (response.length < 10) {
              isLoadMore = false;
              disableLoad = true;
            }
            followingList.addAll(response);
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
            followingList = response;
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

  void fetchFollower({BuildContext context, FeedsPayload payload}) async {
    FollowsService()
        .getFollower(context, payload)
        .then((response) {
      if (page > 1) {
        followerList.removeLast();
        if (response.length > 0) {
          setState(() {
            if (response.length < 10) {
              isLoadMore = false;
              disableLoad = true;
            }
            followerList.addAll(response);
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
            followerList = response;
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

  @override
  void initState() {
    super.initState();
    if(widget.before == 'following'){
      fetchFollowing(context: context, payload: FeedsPayload(limit: limit, page: page));
    } else {
      fetchFollower(context: context, payload: FeedsPayload(limit: limit, page: page));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBarSection(),
      body: bodySection(
        size: size,
      ),
    );
  }

  Widget appBarSection() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.white,
      elevation: 1.0,
      iconTheme: IconThemeData(),
      title: Text(
        widget.before == 'follower' ? Strings.follower : Strings.following,
        style: TextStyle(
          color: AppColors.black,
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: AppColors.black,
        ),
        onPressed: () => Navigation().navigateBack(context),
      ),
    );
  }

  Widget bodySection({
    Size size,
  }) {
    if (isLoading) {
      return loaderSection(size);
    } else {
      if (isEmpty) {
        return emptySection(context: context, size: size);
      } else {
        return followsListSection(size);
      }
    }
  }

  Widget loaderSection(Size size) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.all(16.0),
      separatorBuilder: (BuildContext context, int index) => dividerLine(),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return loaderAccount(context: context, size: size);
      },
    );
  }

  Widget loaderAccount({BuildContext context, Size size}) {
    return Shimmer.fromColors(
      baseColor: AppColors.light,
      highlightColor: AppColors.lighter,
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
              color: AppColors.light,
              width: 32.0,
              height: 32.0,
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Container(
              color: AppColors.light,
              width: 120.0,
              height: 12.0,
            ),
          ),
          SizedBox(width: 16.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
              color: AppColors.light,
              width: 100.0,
              height: 30.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget followsListSection(Size size) {

    if(widget.before == 'following'){
      return ListView.separated(
        controller: controller,
        shrinkWrap: true,
        padding: EdgeInsets.all(16.0),
        separatorBuilder: (BuildContext context, int index) => dividerLine(),
        itemCount: followingList.length,
        itemBuilder: (BuildContext context, int index) {
          return cardFollowing(
            context: context,
            size: size,
            item: followingList[index],
            isLoading: followingList[index].followingId == null,
          );
        },
      );
    } else {
      return ListView.separated(
        controller: controller,
        shrinkWrap: true,
        padding: EdgeInsets.all(16.0),
        separatorBuilder: (BuildContext context, int index) => dividerLine(),
        itemCount: followerList.length,
        itemBuilder: (BuildContext context, int index) {
          return cardFollower(
            context: context,
            size: size,
            item: followerList[index],
            isLoading: followerList[index].followingId == null,
          );
        },
      );
    }

  }

  Widget cardFollowing({
    BuildContext context,
    Size size,
    Following item,
    bool isLoading = false,
  }) {
    if (!isLoading) {
      return Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
              color: AppColors.light,
              child: FadeInImage.assetNetwork(
                placeholder: avatar(item.followingDetail.name),
                image: BaseUrl.SoedjaAPI + '/' + item.followingDetail.picture,
                width: 32.0,
                height: 32.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.followingDetail.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0),
                ),
                SizedBox(height: 4.0),
                Text(
                  item.followingDetail.province + ', Indonesia',
                  style: TextStyle(
                      color: AppColors.black.withOpacity(.6), fontSize: 10.0),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.0),
          ButtonPrimary(
            buttonColor: AppColors.white,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            width: 100.0,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: AppColors.black, width: 1.0),
            child: Text(
              Strings.follow,
              style: TextStyle(color: AppColors.black, fontSize: 12.0),
            ),
          ),
        ],
      );
    } else {
      return loaderAccount(context: context, size: size);
    }
  }

  Widget cardFollower({
    BuildContext context,
    Size size,
    Follower item,
    bool isLoading = false,
  }) {
    if (!isLoading) {
      return Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
              color: AppColors.light,
              child: FadeInImage.assetNetwork(
                placeholder: avatar(item.followerDetail.name),
                image: BaseUrl.SoedjaAPI + '/' + item.followerDetail.picture,
                width: 32.0,
                height: 32.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.followerDetail.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0),
                ),
                SizedBox(height: 4.0),
                Text(
                  item.followerDetail.province + ', Indonesia',
                  style: TextStyle(
                      color: AppColors.black.withOpacity(.6), fontSize: 10.0),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.0),
          ButtonPrimary(
            buttonColor: AppColors.white,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            width: 100.0,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: AppColors.black, width: 1.0),
            child: Text(
              Strings.follow,
              style: TextStyle(color: AppColors.black, fontSize: 12.0),
            ),
          ),
        ],
      );
    } else {
      return loaderAccount(context: context, size: size);
    }
  }
}
