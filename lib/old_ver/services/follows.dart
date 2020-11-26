import 'package:flutter/material.dart';
import 'package:soedja_freelance/old_ver/constants/urls.dart';
import 'package:soedja_freelance/old_ver/models/feeds.dart';
import 'package:soedja_freelance/old_ver/models/follows.dart';
import 'package:soedja_freelance/old_ver/utils/http_request.dart';

class FollowsService {
  Future<List<Following>> getFollowing(
      BuildContext context, FeedsPayload payload) async {
    try {
      List<Following> list = new List<Following>();

      String params = '?limit=${payload.limit}'
          '&page=${payload.page}';

      final response = await HttpRequest.get(
        context: context,
        url: Url.getFollowing + params,
        useAuth: true,
      );

      response['payload']['rows'].forEach((data) {
        list.add(Following.fromJson(data));
      });

      return list;
    } catch (err) {
      return [];
    }
  }

  Future<List<Follower>> getFollower(
      BuildContext context, FeedsPayload payload) async {
    try {
      List<Follower> list = new List<Follower>();

      String params = '?limit=${payload.limit}'
          '&page=${payload.page}';

      final response = await HttpRequest.get(
        context: context,
        url: Url.getFollower + params,
        useAuth: true,
      );

      response['payload']['rows'].forEach((data) {
        list.add(Follower.fromJson(data));
      });

      return list;
    } catch (err) {
      return [];
    }
  }
}
