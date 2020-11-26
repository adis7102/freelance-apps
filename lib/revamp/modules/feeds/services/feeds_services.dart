import 'package:flutter/cupertino.dart';
import 'package:soedja_freelance/revamp/assets/urls.dart';
import 'package:soedja_freelance/revamp/helpers/http_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/models/register_models.dart';
import 'package:soedja_freelance/revamp/modules/category/models/category_model.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/bookmark_models.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/like_models.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/portfolio_models.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/studio_models.dart';

abstract class FeedsAPI {
  Future<FeedsListResponse> getFeedsList(
      BuildContext context, FeedListPayload payload);

  Future<FeedsListResponse> getExploreFeeds(
      BuildContext context,
      FeedListPayload payload,
      Category category,
      String subCategory,
      String typeCategory);

  Future<UpdateInterestResponse> updateInterest(
      BuildContext context, List<String> categoryList);

  Future<FeedLikeListResponse> getLikeList(
      BuildContext context, String portfolioId, FeedListPayload payload);

  Future<CreateLikeResponse> createLike(
      BuildContext context, String portfolioId);

  Future<DefaultResponse> deleteLike(BuildContext context, String likeId);

  Future<BookmarkListResponse> getBookmarkList(
      BuildContext context, FeedListPayload payload);

  Future<CreateBookmarkResponse> createBookmark(
      BuildContext context, String portfolioId);

  Future<DefaultResponse> deleteBookmark(
      BuildContext context, String bookmarkId);

  Future<BannerStudioResponse> getStudioBanner(BuildContext context);

  Future<PortfolioListResponse> getPortfolioList(
      BuildContext context, String userId, FeedListPayload payload);

  Future<UpdateViewerResponse> updateViewer(BuildContext context, String id);

  Future<DeletePictureResponse> deletePicture(
      BuildContext context, String portfolioId, String pictureId);
}

class FeedServices extends FeedsAPI {
  @override
  Future<FeedsListResponse> getFeedsList(
      BuildContext context, FeedListPayload payload) async {
    String url = Urls.feedList +
        "?title=${payload.title ?? ""}"
            "&limit=${payload.limit}"
            "&page=${payload.page}"
            "&is_video=${payload.isVideo ?? ""}";

    try {
      var response =
          await HttpRequest.get(context: context, useAuth: true, url: url);
      if (response['code'] == "success") {
        return FeedsListResponse.fromJson(response);
      } else {
        return FeedsListResponse(code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return FeedsListResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<FeedsListResponse> getExploreFeeds(
      BuildContext context,
      FeedListPayload payload,
      Category category,
      String subCategory,
      String typeCategory) async {
    String sub = "";
    if (category.type == "creative") {
      sub = subCategory.length > 0
          ? "&sub_category=${Uri.encodeComponent(subCategory)}"
          : "";
    } else {
      sub = "&sub_category=${Uri.encodeComponent(subCategory)}";
    }
    String type = typeCategory.length > 0
        ? "&type_category=${Uri.encodeComponent(typeCategory)}"
        : "";

    String url = Urls.exploreList +
        "?category=${category.category}"
            "$sub"
            "$type"
            "&limit=${payload.limit}"
            "&page=${payload.page}";

    try {
      var response =
          await HttpRequest.get(context: context, useAuth: true, url: url);
      if (response['code'] == "success") {
        return FeedsListResponse.fromJson(response);
      } else {
        return FeedsListResponse(code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return FeedsListResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<UpdateInterestResponse> updateInterest(
      BuildContext context, List<String> categoryList) async {
    String url = Urls.updateInterest;

    var body = {
      "interests": categoryList,
    };

    try {
      var response = await HttpRequest.put(
          context: context, useAuth: true, url: url, bodyJson: body);
      if (response['code'] == "success") {
        return UpdateInterestResponse.fromJson(response);
      } else {
        return UpdateInterestResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return UpdateInterestResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<FeedLikeListResponse> getLikeList(
      BuildContext context, String portfolioId, FeedListPayload payload) async {
    String url = Urls.getLikeList +
        portfolioId +
        "?limit=${payload.limit}"
            "&page=${payload.page}";

    try {
      var response = await HttpRequest.get(
        context: context,
        useAuth: true,
        url: url,
      );
      if (response['code'] == "success") {
        return FeedLikeListResponse.fromJson(response);
      } else {
        return FeedLikeListResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return FeedLikeListResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<CreateLikeResponse> createLike(
      BuildContext context, String portfolioId) async {
    String url = Urls.feedLike;

    var body = {
      "content_id": portfolioId,
    };

    try {
      var response = await HttpRequest.post(
          context: context, useAuth: true, url: url, bodyJson: body);
      if (response['code'] == "success") {
        return CreateLikeResponse.fromJson(response);
      } else {
        return CreateLikeResponse(code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return CreateLikeResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<DefaultResponse> deleteLike(
      BuildContext context, String likeId) async {
    String url = Urls.removeLike + likeId;

    try {
      var response =
          await HttpRequest.delete(context: context, useAuth: true, url: url);
      if (response['code'] == "success") {
        return DefaultResponse.fromJson(response);
      } else {
        return DefaultResponse(code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return DefaultResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<BookmarkListResponse> getBookmarkList(
      BuildContext context, FeedListPayload payload) async {
    String url = Urls.bookmarkList +
        "?limit=${payload.limit}"
            "&page=${payload.page}";

    try {
      var response = await HttpRequest.get(
        context: context,
        useAuth: true,
        url: url,
      );
      if (response['code'] == "success") {
        return BookmarkListResponse.fromJson(response);
      } else {
        return BookmarkListResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return BookmarkListResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<CreateBookmarkResponse> createBookmark(
      BuildContext context, String portfolioId) async {
    String url = Urls.feedBookmark;

    var body = {
      "portfolio_id": portfolioId,
    };

    try {
      var response = await HttpRequest.post(
          context: context, useAuth: true, url: url, bodyJson: body);
      if (response['code'] == "success") {
        return CreateBookmarkResponse.fromJson(response);
      } else {
        return CreateBookmarkResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return CreateBookmarkResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<DefaultResponse> deleteBookmark(
      BuildContext context, String bookmarkId) async {
    String url = Urls.removeBookmark + bookmarkId;

    try {
      var response =
          await HttpRequest.delete(context: context, useAuth: true, url: url);
      if (response['code'] == "success") {
        return DefaultResponse.fromJson(response);
      } else {
        return DefaultResponse(code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return DefaultResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<BannerStudioResponse> getStudioBanner(BuildContext context) async {
    String url = Urls.studioBanner + "?status=1";
    try {
      var response = await HttpRequest.get(
        context: context,
        useAuth: true,
        url: url,
      );
      if (response['code'] == "success") {
        return BannerStudioResponse.fromJson(response);
      } else {
        return BannerStudioResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return BannerStudioResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<PortfolioListResponse> getPortfolioList(
      BuildContext context, String userId, FeedListPayload payload) async {
    String url = Urls.getPortfolioProfile +
        userId +
        "?title=${payload.title ?? ""}"
            "&limit=${payload.limit}"
            "&page=${payload.page}";
    try {
      var response = await HttpRequest.get(
        context: context,
        useAuth: true,
        url: url,
      );
      if (response['code'] == "success") {
        return PortfolioListResponse.fromJson(response);
      } else {
        return PortfolioListResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return PortfolioListResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<UpdateViewerResponse> updateViewer(
      BuildContext context, String id) async {
    String url = Urls.updateViewer + id;

    try {
      var response = await HttpRequest.put(
        context: context,
        useAuth: true,
        url: url,
      );
      if (response['code'] == "success") {
        return UpdateViewerResponse.fromJson(response);
      } else {
        return UpdateViewerResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return UpdateViewerResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<PortfolioDetailResponse> getPortfolioDetail(
      BuildContext context, String id) async {
    String url = Urls.getPortfolioDetail + id;

    try {
      var response = await HttpRequest.get(
        context: context,
        useAuth: true,
        url: url,
      );
      if (response['code'] == "success") {
        return PortfolioDetailResponse.fromJson(response);
      } else {
        return PortfolioDetailResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return PortfolioDetailResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<DeletePictureResponse> deletePicture(
      BuildContext context, String portfolioId, String pictureId) async {
    String url = Urls.removePictures + "$portfolioId/$pictureId";

    try {
      var response = await HttpRequest.delete(
        context: context,
        useAuth: true,
        url: url,
      );
      if (response['code'] == "success") {
        return DeletePictureResponse.fromJson(response);
      } else {
        return DeletePictureResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return DeletePictureResponse(code: "failed", message: e.toString());
    }
  }
}
