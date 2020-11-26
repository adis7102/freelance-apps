import 'package:flutter/cupertino.dart';
import 'package:soedja_freelance/old_ver/constants/urls.dart';
import 'package:soedja_freelance/old_ver/models/comment.dart';
import 'package:soedja_freelance/old_ver/models/feeds.dart';
import 'package:soedja_freelance/old_ver/models/interest.dart';
import 'package:soedja_freelance/old_ver/utils/http_request.dart';

class FeedsService {
  Future<List<Feeds>> getFeeds(
      BuildContext context, FeedsPayload payload) async {
    try {
      List<Feeds> list = new List<Feeds>();

      String params = '?limit=${payload.limit}'
          '&page=${payload.page}'
          '&title=${payload.title ?? ''}';

      final response = await HttpRequest.get(
          context: context, url: Url.feedList + params, useAuth: true);

      response['payload']['rows'].forEach((data) {
        list.add(Feeds.fromJson(data));
      });

      return list;
    } catch (err) {
      return [];
    }
  }

  Future<List<FeedProfiles>> getProfiles(
      BuildContext context, FeedsPayload payload) async {
    try {
      List<FeedProfiles> list = new List<FeedProfiles>();

      String params = '?limit=${payload.limit}'
          '&page=${payload.page}'
          '&title=${payload.title ?? ''}';

      final response = await HttpRequest.get(
          context: context, url: Url.profilesList + params, useAuth: true);

      response['payload']['rows'].forEach((data) {
        list.add(FeedProfiles.fromJson(data));
      });

      return list;
    } catch (err) {
      return [];
    }
  }

  Future<List<Feeds>> getExplore(
      BuildContext context, ExplorePayload payload) async {
    try {
      List<Feeds> list = new List<Feeds>();

      String params = '?limit=${payload.limit}'
          '&page=${payload.page}'
          '&title=${payload.title ?? ''}'
          '&category=${payload.category != 'Semua' ? payload.category : ''}'
          '&sub_category=${payload.subCategory != 'Semua' ? payload.subCategory : ''}'
          '&type_category=${payload.typeCategory != 'Semua' ? payload.typeCategory : ''}';

      final response = await HttpRequest.get(
          context: context, url: Url.exploreList + params, useAuth: true);

      response['payload']['rows'].forEach((data) {
        list.add(Feeds.fromJson(data));
      });

      return list;
    } catch (err) {
      return [];
    }
  }

  Future<Like> like(BuildContext context, LikePayload payload) async {
    try {
      Like like = new Like();

      final response = await HttpRequest.post(
          context: context,
          url: Url.feedLike,
          bodyJson: payload.toJson(),
          useAuth: true);

      like = new Like(
          likeId: response['payload']['like_id'],
          contentId: response['payload']['content_id']);

      return like;
    } catch (err) {
      return Like.withError(err.toString());
    }
  }

  Future<bool> deleteLike(BuildContext context, Feeds item) async {
    try {
      final response = await HttpRequest.delete(
          context: context,
          url: Url.removeLike + item.portfolioId,
          useAuth: true);

      if (response['code'] == 'success') {
        return true;
      }

      return false;
    } catch (err) {
      return false;
    }
  }

  Future<Bookmark> bookmark(
      BuildContext context, BookmarkPayload payload) async {
    try {
      Bookmark bookmark = new Bookmark();

      final response = await HttpRequest.post(
          context: context,
          url: Url.feedBookmark,
          bodyJson: payload.toJson(),
          useAuth: true);

      bookmark = new Bookmark(
          bookmarkId: response['payload']['bookmark_id'],
          portfolioId: response['payload']['portfolio_id']);

      return bookmark;
    } catch (err) {
      return Bookmark.withError(err.toString());
    }
  }

  Future<bool> deleteBookmark(BuildContext context, Feeds item) async {
    try {
      final response = await HttpRequest.delete(
          context: context,
          url: Url.removeBookmark + item.bookmarkId,
          useAuth: true);

      if (response['code'] == 'success') {
        return true;
      }

      return false;
    } catch (err) {
      return false;
    }
  }

  Future<Follow> follow(BuildContext context, FollowPayload payload) async {
    try {
      Follow follow = new Follow();

      final response = await HttpRequest.post(
          context: context,
          url: Url.profilesFollow,
          bodyJson: payload.toJson(),
          useAuth: true);

      follow = new Follow(
          followingId: response['payload']['following_id'],
          followerId: response['payload']['follower_id']);

      return follow;
    } catch (err) {
      return Follow.withError(err.toString());
    }
  }

  Future<bool> deleteFollow(BuildContext context, FeedProfiles item) async {
    try {
      final response = await HttpRequest.delete(
          context: context, url: Url.removeFollow + item.userId, useAuth: true);

      if (response['code'] == 'success') {
        return true;
      }

      return false;
    } catch (err) {
      return false;
    }
  }

  Future<Comment> comment(
      BuildContext context, GiveCommentPayload payload) async {
    try {
      Comment comment = new Comment();

      final response = await HttpRequest.post(
          context: context,
          url: Url.feedComment,
          bodyJson: payload.toJson(),
          useAuth: true);

      comment = new Comment(
          comment: response['payload']['comment'],
          commentId: response['payload']['comment_id'],
          userId: response['payload']['user_id'],
          createdAt: response['payload']['created_at']);

      return comment;
    } catch (err) {
      return Comment.withError(err.toString());
    }
  }

  Future<bool> updateInterest(
      BuildContext context, InterestPayload payload) async {
    try {
      final response = await HttpRequest.put(
          context: context,
          url: Url.updateInterest,
          bodyJson: payload.toJson(),
          useAuth: true);

      if (response['code'] == 'success') {
        return true;
      }
      return false;
    } catch (err) {
      return false;
    }
  }
}
