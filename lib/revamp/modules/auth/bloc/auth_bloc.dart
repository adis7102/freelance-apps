import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:soedja_freelance/revamp/assets/sharedpref_keys.dart';
import 'package:soedja_freelance/revamp/helpers/sharedpref_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_state.dart';
import 'package:soedja_freelance/revamp/modules/auth/models/login_models.dart';
import 'package:soedja_freelance/revamp/modules/auth/models/otp_models.dart';
import 'package:soedja_freelance/revamp/modules/auth/models/pin_models.dart';
import 'package:soedja_freelance/revamp/modules/auth/models/register_models.dart';
import 'package:soedja_freelance/revamp/modules/auth/services/auth_service.dart';

class AuthBloc extends AuthServices {
  BehaviorSubject<GetProfileState> _subjectGetProfile =
      BehaviorSubject<GetProfileState>();
  BehaviorSubject<RegisterStatusState> _subjectRegister =
      BehaviorSubject<RegisterStatusState>();
  BehaviorSubject<ValidateOtpState> _subjectValidateOtp =
      BehaviorSubject<ValidateOtpState>();
  BehaviorSubject<ResendOtpState> _subjectResendOtp =
      BehaviorSubject<ResendOtpState>();
  BehaviorSubject<ResetPinState> _subjectResetPin =
      BehaviorSubject<ResetPinState>();

  Stream<GetProfileState> get getProfile => _subjectGetProfile.stream;

  Stream<RegisterStatusState> get getRegisterStatus => _subjectRegister.stream;

  Stream<ValidateOtpState> get getValidateStatus => _subjectValidateOtp.stream;

  Stream<ResendOtpState> get getResendOtpStatus => _subjectResendOtp.stream;

  Stream<ResetPinState> get getResetPinStatus => _subjectResetPin.stream;

  BehaviorSubject<bool> _stanby = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get getStanby => _stanby.stream;

  requestLogin(BuildContext context, String email, String pin) {
    LoginPayload payload = LoginPayload(
      email: email,
      pin: pin,
    );

    try {
      _subjectGetProfile.sink
          .add(GetProfileState.onLoading("Loading Login ..."));

      AuthServices().postLogin(context, payload).then((response) async {
        if (response.code == "success") {
          SharedPreference.set(SharedPrefKey.AuthToken, response.payload.jwt)
              .then((response) {
            requestGetProfile(context);
          });
        } else {
          _subjectGetProfile.sink
              .add(GetProfileState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectGetProfile.sink.add(GetProfileState.onError(e.toString()));
    }
  }

  requestRegister(
      BuildContext context, String name, String phone, String email) {
    RegisterPayload payload = RegisterPayload(
        name: name, phone: "+62" + phone, email: email, type: 'freelance');

    try {
      _subjectRegister.sink
          .add(RegisterStatusState.onLoading("Loading Register ..."));

      AuthServices().postRegister(context, payload).then((response) async {
        if (response.code == "success") {
          _subjectRegister.sink.add(RegisterStatusState.onSuccess(response));
        } else {
          _subjectRegister.sink
              .add(RegisterStatusState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectRegister.sink.add(RegisterStatusState.onError(e.toString()));
    }
  }

  requestValidate(BuildContext context, String otp, String email) {
    ValidateOtpPayload payload = ValidateOtpPayload(
      otp: otp,
      email: email,
    );

    try {
      _subjectValidateOtp.sink
          .add(ValidateOtpState.onLoading("Loading Register ..."));

      AuthServices().postValidate(context, payload).then((response) async {
        if (response.code == "success") {
          _subjectValidateOtp.sink.add(ValidateOtpState.onSuccess(response));
        } else {
          _subjectValidateOtp.sink
              .add(ValidateOtpState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectValidateOtp.sink.add(ValidateOtpState.onError(e.toString()));
    }
  }

  requestResend(BuildContext context, String email, type) {
    ResendOtpPayload payload = ResendOtpPayload(
      email: email,
    );

    try {
      _subjectResendOtp.sink
          .add(ResendOtpState.onLoading("Loading Register ..."));

      AuthServices().resendOtp(context, payload, type).then((response) async {
        if (response.code == "success") {
          _subjectResendOtp.sink.add(ResendOtpState.onSuccess(response));
        } else {
          _subjectResendOtp.sink.add(ResendOtpState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectResendOtp.sink.add(ResendOtpState.onError(e.toString()));
    }
  }

  requestResetPin(BuildContext context, String email, String pin, String token) {
    ResetPinPayload payload = ResetPinPayload(
      email: email,
      pin: pin,
    );

    try {
      _subjectResetPin.sink
          .add(ResetPinState.onLoading("Loading Register ..."));

      AuthServices().resetPin(context, payload, token).then((response) async {
        if (response.code == "success") {
          _subjectResetPin.sink.add(ResetPinState.onSuccess(response));
        } else {
          _subjectResetPin.sink.add(ResetPinState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectResetPin.sink.add(ResetPinState.onError(e.toString()));
    }
  }

  requestGetProfile(BuildContext context) {
    try {
      _subjectGetProfile.sink
          .add(GetProfileState.onLoading("Loading Get Profile ..."));
      AuthServices().getProfileAuth(context).then((response) {
        if (response.code == "success") {
          _subjectGetProfile.sink.add(GetProfileState.onSuccess(response));
        } else {
          _subjectGetProfile.sink
              .add(GetProfileState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectGetProfile.sink.add(GetProfileState.onError(e.toString()));
    }
  }

  requestUpdateTokenFCM(BuildContext context, String token, String userId, String version) async {
    try {
      AuthServices().requestFCM(context,token, userId, version);
    } catch (e) {
      print(e);
    }
  }

  unStandBy() async {
    _stanby.sink.add(false);
    _subjectGetProfile.sink.add(GetProfileState.unStanby());
    _subjectRegister.sink.add(RegisterStatusState.unStanby());
    _subjectValidateOtp.sink.add(ValidateOtpState.unStanby());
    _subjectResendOtp.sink.add(ResendOtpState.unStanby());
    _subjectResetPin.sink.add(ResetPinState.unStanby());
  }

  void dispose() {
    _subjectGetProfile?.close();
    _subjectRegister?.close();
    _subjectValidateOtp?.close();
    _subjectResendOtp?.close();
    _subjectResetPin?.close();
    _stanby?.drain(false);
  }
}
