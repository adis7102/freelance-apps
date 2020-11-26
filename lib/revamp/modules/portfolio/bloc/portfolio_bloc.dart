import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/bloc/portfolio_state.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/models/comment_model.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/models/portfolio_models.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/services/portfolio_service.dart';

class PortfolioBloc extends PortfolioService {
  BehaviorSubject<CreatePortfolioState> _subjectCreateState =
      BehaviorSubject<CreatePortfolioState>();
  BehaviorSubject<UpdatePortfolioState> _subjectUpdateState =
      BehaviorSubject<UpdatePortfolioState>();
  BehaviorSubject<DeletePortfolioState> _subjectDeleteState =
      BehaviorSubject<DeletePortfolioState>();
  BehaviorSubject<UploadPortfolioState> _subjectUploadState =
      BehaviorSubject<UploadPortfolioState>();
  BehaviorSubject<CommentListState> _subjectComment =
      BehaviorSubject<CommentListState>();
  BehaviorSubject<GiveCommentState> _subjectGiveComment =
      BehaviorSubject<GiveCommentState>();

  Stream<CreatePortfolioState> get getCreateStatus =>
      _subjectCreateState.stream;
  Stream<UpdatePortfolioState> get getUpdateStatus =>
      _subjectUpdateState.stream;
  Stream<DeletePortfolioState> get getDeleteStatus =>
      _subjectDeleteState.stream;

  Stream<UploadPortfolioState> get getUploadStatus =>
      _subjectUploadState.stream;

  Stream<CommentListState> get getComment => _subjectComment.stream;

  Stream<GiveCommentState> get getGiveComment => _subjectGiveComment.stream;

  BehaviorSubject<bool> _stanby = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get getStanby => _stanby.stream;

  requestCreate(
      BuildContext context,
      String title,
      String description,
      String category,
      String subCategory,
      String typeCategory,
      int amount,
      int duration,
      String youtubeUrl) {
    PortfolioPayload payload = PortfolioPayload(
      title: title,
      description: description,
      category: category,
      subCategory: subCategory,
      typeCategory: typeCategory,
      amount: amount,duration: duration,
      youtubeUrl: youtubeUrl,
    );
    print(payload.toJson());

    try {
      _subjectCreateState.sink
          .add(CreatePortfolioState.onLoading("Loading Create ..."));

      PortfolioService()
          .createPortfolio(context, payload)
          .then((response) async {
        if (response.code == "success") {
          _subjectCreateState.sink
              .add(CreatePortfolioState.onSuccess(response));
        } else {
          _subjectCreateState.sink
              .add(CreatePortfolioState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectCreateState.sink.add(CreatePortfolioState.onError(e.toString()));
    }
  }

  requestUpdate(
      BuildContext context,
      String id,
      String title,
      String description,
      String category,
      String subCategory,
      String typeCategory,
      int amount,
      int duration,
      String youtubeUrl) {
    PortfolioPayload payload = PortfolioPayload(
      title: title,
      description: description,
      category: category,
      subCategory: subCategory,
      typeCategory: typeCategory,
      amount: amount,
      duration: amount,
      youtubeUrl: youtubeUrl,
    );
    print(payload.toJson());

    try {
      _subjectUpdateState.sink
          .add(UpdatePortfolioState.onLoading("Loading Create ..."));

      PortfolioService()
          .updatePortfolio(context, payload, id)
          .then((response) async {
        if (response.code == "success") {
          _subjectUpdateState.sink
              .add(UpdatePortfolioState.onSuccess(response));
        } else {
          _subjectUpdateState.sink
              .add(UpdatePortfolioState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectUpdateState.sink.add(UpdatePortfolioState.onError(e.toString()));
    }
  }
  requestDelete(
      BuildContext context,
      String id,) {
    try {
      _subjectDeleteState.sink
          .add(DeletePortfolioState.onLoading("Loading Create ..."));

      PortfolioService()
          .deletePortfolio(context, id)
          .then((response) async {
        if (response.code == "success") {
          _subjectDeleteState.sink
              .add(DeletePortfolioState.onSuccess(response));
        } else {
          _subjectDeleteState.sink
              .add(DeletePortfolioState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectDeleteState.sink.add(DeletePortfolioState.onError(e.toString()));
    }
  }

  requestUpload(BuildContext context, String id, List<File> files) {
    try {
      _subjectUploadState.sink
          .add(UploadPortfolioState.onLoading("Loading Register ..."));

      PortfolioService()
          .uploadPortfolioPictures(context, files, id)
          .then((response) async {
        if (response.code == "success") {
          _subjectUploadState.sink
              .add(UploadPortfolioState.onSuccess(response));
        } else {
          _subjectUploadState.sink
              .add(UploadPortfolioState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectUploadState.sink.add(UploadPortfolioState.onError(e.toString()));
    }
  }

  requestGetComment(
      {BuildContext context, String id, int limit, int page, String isSawer}) {
    CommentListPayload payload = new CommentListPayload(
      limit: limit.toString(),
      page: page.toString(),
      isSawer: isSawer,
    );

    try {
      _subjectComment.sink
          .add(CommentListState.onLoading("Loading get list ..."));

      PortfolioService().getCommentFeed(context, id, payload).then((response) {
        if (response.code == "success") {
          _subjectComment.sink.add(CommentListState.onSuccess(response));
        } else {
          _subjectComment.sink.add(CommentListState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectComment.sink.add(CommentListState.onError(e.toString()));
    }
  }

  requestGiveComment(BuildContext context, String id, String comment) {
    GiveCommentPayload payload = new GiveCommentPayload(
      parentId: id,
      comment: comment,
    );

    try {
      _subjectGiveComment.sink.add(GiveCommentState.onLoading("Loading ..."));

      PortfolioService().giveComment(context, id, payload).then((response) {
        if (response.code == "success") {
          _subjectGiveComment.sink.add(GiveCommentState.onSuccess(response));
        } else {
          _subjectGiveComment.sink
              .add(GiveCommentState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectGiveComment.sink.add(GiveCommentState.onError(e.toString()));
    }
  }

  unStandBy() async {
    _stanby.sink.add(false);
    _subjectCreateState.sink.add(CreatePortfolioState.unStanby());
    _subjectUpdateState.sink.add(UpdatePortfolioState.unStanby());
    _subjectDeleteState.sink.add(DeletePortfolioState.unStanby());
    _subjectUploadState.sink.add(UploadPortfolioState.unStanby());
    _subjectComment.sink.add(CommentListState.unStanby());
    _subjectGiveComment.sink.add(GiveCommentState.unStanby());
  }

  void dispose() {
    _subjectCreateState?.close();
    _subjectUpdateState?.close();
    _subjectDeleteState?.close();
    _subjectUploadState?.close();
    _subjectComment?.close();
    _subjectGiveComment?.close();
    _stanby?.drain(false);
  }
}
