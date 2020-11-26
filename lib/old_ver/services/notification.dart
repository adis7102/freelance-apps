import 'package:flutter/material.dart';
import 'package:soedja_freelance/old_ver/constants/urls.dart';
import 'package:soedja_freelance/old_ver/models/notification.dart';
import 'package:soedja_freelance/old_ver/utils/http_request.dart';

class NotificationService {
  Future<List<Notifications>> getNotification(
      BuildContext context, NotificationPayload payload) async {
    try {
      List<Notifications> list = new List<Notifications>();

      String params = '?limit=${payload.limit}'
          '&page=${payload.page}';

      final response = await HttpRequest.get(
          context: context, url: Url.notification + params, useAuth: true);

      response['payload']['rows'].forEach((data) {
        list.add(Notifications.fromJson(data));
      });

      return list;
    } catch (err) {
      return [];
    }
  }

  Future<bool> updateToken(
      BuildContext context, UpdateTokenPayload payload) async {
    try {
      final response = await HttpRequest.put(
          context: context, url: Url.updateToken, bodyJson: payload.toJson());

      if(response['code'] == 'success'){
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }

  Future<bool> readNotification(
      BuildContext context, String id) async {
    try {
      final response = await HttpRequest.put(
          context: context, url: Url.readNotification + '/$id',);

      if(response['code'] == 'success'){
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }
}
