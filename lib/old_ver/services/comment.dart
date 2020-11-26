import 'package:flutter/material.dart';
import 'package:soedja_freelance/old_ver/constants/urls.dart';
import 'package:soedja_freelance/old_ver/models/comment.dart';
import 'package:soedja_freelance/old_ver/utils/http_request.dart';

class CommentService {
  Future<List<Comment>> getComment({BuildContext context,
    CommentPayload payload,
    String feedId,
  }) async {
    try {
      List<Comment> list = new List<Comment>();

      String params = '?limit=${payload.limit}'
          '&page=${payload.page}';

      final response = await HttpRequest.get(context: context,
          url: Url.commentList + feedId + params, useAuth: true);

      response['payload']['rows'].forEach((data) {
        list.add(Comment.fromJson(data));
      });

      return list;
    } catch (err) {
      return [];
    }
  }
}
