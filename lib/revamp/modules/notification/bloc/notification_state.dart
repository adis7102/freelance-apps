
import 'package:soedja_freelance/revamp/modules/notification/models/notification_models.dart';

class GetNotifState<T> {
  bool isSuccess;
  bool hasError;
  bool standby;
  bool isLoading;
  bool isInit;
  String message;
  NotificationListResponse data;

  GetNotifState(
      {this.data,
        this.hasError,
        this.isSuccess,
        this.message,
        this.standby,
        this.isInit,
        this.isLoading});

  factory GetNotifState.onSuccess(NotificationListResponse data) {
    return GetNotifState(
        data: data,
        isLoading: false,
        isSuccess: true,
        hasError: false,
        standby: true,
        message: "success");
  }

  factory GetNotifState.onError(String message) {
    return GetNotifState(
        data: null,
        isSuccess: false,
        isLoading: false,
        hasError: true,
        standby: true,
        message: message);
  }

  factory GetNotifState.unStanby() {
    return GetNotifState(
        data: null,
        isLoading: false,
        isSuccess: false,
        hasError: false,
        standby: false,
        message: "");
  }

  factory GetNotifState.onLoading(String message) {
    return GetNotifState(
        data: null,
        isLoading: true,
        isSuccess: false,
        hasError: false,
        standby: true,
        message: "");
  }

  factory GetNotifState.setInit() {
    return GetNotifState(
        isLoading: false,
        isSuccess: false,
        hasError: false,
        isInit: true,
        message: "");
  }
}
