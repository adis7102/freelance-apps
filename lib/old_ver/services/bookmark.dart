import 'package:flutter/material.dart';
import 'package:soedja_freelance/old_ver/constants/urls.dart';
import 'package:soedja_freelance/old_ver/models/bookmark.dart';
import 'package:soedja_freelance/old_ver/utils/http_request.dart';

class BookmarkService {

  Future<List<Bookmarks>> getBookmark(BuildContext context, BookmarksPayload payload) async {
    try {
      List<Bookmarks> list = new List<Bookmarks>();

      String params = '?limit=${payload.limit}'
          '&page=${payload.page}';

      final response =
      await HttpRequest.get(context: context,url: Url.bookmarkList + params, useAuth: true);

      response['payload']['rows'].forEach((data) {
        list.add(Bookmarks.fromJson(data));
      });

      return list;
    } catch (err) {
      return [];
    }
  }
}