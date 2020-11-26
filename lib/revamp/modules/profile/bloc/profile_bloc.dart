import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:soedja_freelance/revamp/modules/auth/models/auth_models.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';
import 'package:soedja_freelance/revamp/modules/profile/bloc/profile_state.dart';
import 'package:soedja_freelance/revamp/modules/profile/services/profile_services.dart';

class ProfileBloc extends ProfileService {
  ProfileService profileService = new ProfileService();
  BehaviorSubject<ProfileDetailState> _subjectProfileDetail =
      BehaviorSubject<ProfileDetailState>();
  BehaviorSubject<SearchProfileListState> _subjectSearchProfile =
      BehaviorSubject<SearchProfileListState>();
  BehaviorSubject<ProfileFollowState> _subjectProfileFollow =
      BehaviorSubject<ProfileFollowState>();
  BehaviorSubject<GetFollowingState> _subjectFollowing =
      BehaviorSubject<GetFollowingState>();
  BehaviorSubject<GetFollowerState> _subjectFollower =
      BehaviorSubject<GetFollowerState>();
  BehaviorSubject<ProfessionListState> _subjectProfession =
      BehaviorSubject<ProfessionListState>();
  BehaviorSubject<UpdateProfileState> _subjectUpdateProfile =
      BehaviorSubject<UpdateProfileState>();

  Stream<ProfileDetailState> get getDetail => _subjectProfileDetail.stream;

  Stream<ProfileFollowState> get getFollow => _subjectProfileFollow.stream;

  Stream<GetFollowingState> get getProfileFollowing => _subjectFollowing.stream;

  Stream<GetFollowerState> get getProfileFollower => _subjectFollower.stream;

  Stream<SearchProfileListState> get getSearchProfile =>
      _subjectSearchProfile.stream;

  Stream<ProfessionListState> get getProfessionList =>
      _subjectProfession.stream;

  Stream<UpdateProfileState> get getUpdate => _subjectUpdateProfile.stream;

  BehaviorSubject<bool> _stanby = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get getStanby => _stanby.stream;

  requestProfileDetail(BuildContext context, String userId) {
    try {
      _subjectProfileDetail.sink
          .add(ProfileDetailState.onLoading("Loading get list ..."));

      ProfileService().getProfileDetail(context, userId).then((response) {
        if (response.code == "success") {
          _subjectProfileDetail.sink
              .add(ProfileDetailState.onSuccess(response));
        } else {
          _subjectProfileDetail.sink
              .add(ProfileDetailState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectProfileDetail.sink.add(ProfileDetailState.onError(e.toString()));
    }
  }

  requestProfileFollow(BuildContext context, String userId) {
    try {
      _subjectProfileFollow.sink
          .add(ProfileFollowState.onLoading("Loading get list ..."));

      ProfileService().getProfileFollow(context, userId).then((response) {
        if (response.code == "success") {
          _subjectProfileFollow.sink
              .add(ProfileFollowState.onSuccess(response));
        } else {
          _subjectProfileFollow.sink
              .add(ProfileFollowState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectProfileFollow.sink.add(ProfileFollowState.onError(e.toString()));
    }
  }

  requestProfileFollowing(
      BuildContext context, String userId, int limit, int page) {
    FeedListPayload payload = new FeedListPayload(
      limit: limit.toString(),
      page: page.toString(),
    );

    try {
      _subjectFollowing.sink
          .add(GetFollowingState.onLoading("Loading get list ..."));

      ProfileService().getFollowing(context, userId, payload).then((response) {
        if (response.code == "success") {
          _subjectFollowing.sink.add(GetFollowingState.onSuccess(response));
        } else {
          _subjectFollowing.sink
              .add(GetFollowingState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectFollowing.sink.add(GetFollowingState.onError(e.toString()));
    }
  }

  requestProfileFollower(
      BuildContext context, String userId, int limit, int page) {
    FeedListPayload payload = new FeedListPayload(
      limit: limit.toString(),
      page: page.toString(),
    );

    try {
      _subjectFollower.sink
          .add(GetFollowerState.onLoading("Loading get list ..."));

      ProfileService().getFollower(context, userId, payload).then((response) {
        if (response.code == "success") {
          _subjectFollower.sink.add(GetFollowerState.onSuccess(response));
        } else {
          _subjectFollower.sink.add(GetFollowerState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectFollower.sink.add(GetFollowerState.onError(e.toString()));
    }
  }

  requestSearchProfile(
      BuildContext context, int limit, int page, String title) {
    FeedListPayload payload = new FeedListPayload(
      title: title,
      limit: limit.toString(),
      page: page.toString(),
    );

    try {
      _subjectSearchProfile.sink
          .add(SearchProfileListState.onLoading("Loading get list ..."));

      ProfileService().getProfileList(context, payload).then((response) {
        if (response.code == "success") {
          _subjectSearchProfile.sink
              .add(SearchProfileListState.onSuccess(response));
        } else {
          _subjectSearchProfile.sink
              .add(SearchProfileListState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectSearchProfile.sink
          .add(SearchProfileListState.onError(e.toString()));
    }
  }

  requestGetProfession(BuildContext context) {
    try {
      _subjectProfession.sink
          .add(ProfessionListState.onLoading("Loading get list ..."));

      ProfileService().getProfession(context).then((response) {
        if (response.code == "success") {
          _subjectProfession.sink.add(ProfessionListState.onSuccess(response));
        } else {
          _subjectProfession.sink
              .add(ProfessionListState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectProfession.sink.add(ProfessionListState.onError(e.toString()));
    }
  }

  requestUpdateProfile(BuildContext context, UpdateProfilePayload payload) {
    try {
      _subjectUpdateProfile.sink
          .add(UpdateProfileState.onLoading("Loading ..."));

      ProfileService().updateProfile(context, payload).then((response) {
        if (response.code == "success") {
          _subjectUpdateProfile.sink.add(UpdateProfileState.onSuccess(response));
        } else {
          _subjectUpdateProfile.sink
              .add(UpdateProfileState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectUpdateProfile.sink.add(UpdateProfileState.onError(e.toString()));
    }
  }

  unStandBy() async {
    _stanby.sink.add(false);
    _subjectProfileDetail.sink.add(ProfileDetailState.unStanby());
    _subjectProfileFollow.sink.add(ProfileFollowState.unStanby());
    _subjectSearchProfile.sink.add(SearchProfileListState.unStanby());
    _subjectFollowing.sink.add(GetFollowingState.unStanby());
    _subjectFollower.sink.add(GetFollowerState.unStanby());
    _subjectProfession.sink.add(ProfessionListState.unStanby());
    _subjectUpdateProfile.sink.add(UpdateProfileState.unStanby());
  }

  void dispose() {
    _subjectSearchProfile?.close();
    _subjectProfileFollow?.close();
    _subjectProfileDetail?.close();
    _subjectFollowing?.close();
    _subjectFollower?.close();
    _subjectProfession?.close();
    _subjectUpdateProfile?.close();
    _stanby?.drain(false);
  }
}
