import 'package:flutter/material.dart';
import 'package:soedja_freelance/revamp/assets/urls.dart';
import 'package:soedja_freelance/revamp/helpers/http_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/models/register_models.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/portfolio_models.dart';
import 'package:soedja_freelance/revamp/modules/notification/models/notification_models.dart';

abstract class NotificationAPI {
  Future<NotificationListResponse> getNotifList(BuildContext context, FeedListPayload payload);
  Future<DefaultResponse> setRead(BuildContext context, String messageId);
}

class NotificationService extends NotificationAPI{
  @override
  Future<NotificationListResponse> getNotifList(BuildContext context, FeedListPayload payload) async {
    String url = Urls.notification +
        "?limit=${payload.limit}"
            "&page=${payload.page}";

    try {
      var response = await HttpRequest.get(
        context: context,
        useAuth: true,
        url: url,
      );
      if (response['code'] == "success") {
        return NotificationListResponse.fromJson(response);
      } else {
        return NotificationListResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return NotificationListResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<DefaultResponse> setRead(BuildContext context, String messageId) async {
    String url = Urls.readNotification+messageId;

    try {
      var response = await HttpRequest.put(
        context: context,
        useAuth: true,
        url: url,
      );
      if (response['code'] == "success") {
        return DefaultResponse.fromJson(response);
      } else {
        return DefaultResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return DefaultResponse(code: "failed", message: e.toString());
    }
  }

}