import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';
import 'package:soedja_freelance/revamp/modules/notification/bloc/notification_state.dart';
import 'package:soedja_freelance/revamp/modules/notification/services/notification_services.dart';

class NotificationBloc extends NotificationService {
  BehaviorSubject<GetNotifState> _subjectNotifList =
  BehaviorSubject<GetNotifState>();

  Stream<GetNotifState> get getNotif => _subjectNotifList.stream;

  BehaviorSubject<bool> _stanby = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get getStanby => _stanby.stream;

  requestNotifList(BuildContext context, int limit, int page) {
    FeedListPayload payload = new FeedListPayload(
      limit: limit.toString(),
      page: page.toString(),
    );

    try {
      _subjectNotifList.sink
          .add(GetNotifState.onLoading("Loading get list ..."));

      NotificationService().getNotifList(context, payload).then((response) {
        if (response.code == "success") {
          _subjectNotifList.sink.add(GetNotifState.onSuccess(response));
        } else {
          _subjectNotifList.sink
              .add(GetNotifState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectNotifList.sink.add(GetNotifState.onError(e.toString()));
    }
  }

//  requestFCM(BuildContext context, String token) async {
//    try {
//      AuthServices().requestFCM(token);
//    } catch (e) {
//      print(e);
//    }
//  }

  unStandBy() async {
    _stanby.sink.add(false);
    _subjectNotifList.sink.add(GetNotifState.unStanby());
  }

  void dispose() {
    _subjectNotifList?.close();
    _stanby?.drain(false);
  }
}
