import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:soedja_freelance/revamp/assets/urls.dart';
import 'package:soedja_freelance/revamp/helpers/http_helper.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/models/comment_model.dart';
import 'package:soedja_freelance/revamp/modules/portfolio/models/portfolio_models.dart';

abstract class PortfolioAPI {
  Future<CreatePortfolioResponse> createPortfolio(
      BuildContext context, PortfolioPayload payload);

  Future<CreatePortfolioResponse> updatePortfolio(
      BuildContext context, PortfolioPayload payload, String id);

  Future<CreatePortfolioResponse> deletePortfolio(
      BuildContext context, String id);

  Future<UploadPortfolioResponse> uploadPortfolioPictures(
      BuildContext context, List<File> files, String id);

  Future<PortfolioCommentResponse> getCommentFeed(
      BuildContext context, String id, CommentListPayload payload);

  Future<GiveCommentResponse> giveComment(
      BuildContext context, String id, GiveCommentPayload payload);
  Future<TotalSawerResponse> getTotalSawer(
      BuildContext context, String id,);

}

class PortfolioService extends PortfolioAPI {
  @override
  Future<CreatePortfolioResponse> createPortfolio(
      BuildContext context, PortfolioPayload payload) async {
    String url = Urls.createPortfolio;
    try {
      var response = await HttpRequest.post(
          context: context,
          url: url,
          useAuth: true,
          bodyJson: payload.toJson());

      if (response['code'] == "success") {
        return CreatePortfolioResponse.fromJson(response);
      } else {
        return CreatePortfolioResponse(
            code: "false", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return CreatePortfolioResponse(code: "false", message: e.toString());
    }
  }

  @override
  Future<CreatePortfolioResponse> deletePortfolio(
      BuildContext context, String id) async {
    String url = Urls.deletePortfolio + id;
    try {
      var response = await HttpRequest.delete(
        context: context,
        url: url,
        useAuth: true,
      );

      if (response['code'] == "success") {
        return CreatePortfolioResponse.fromJson(response);
      } else {
        return CreatePortfolioResponse(
            code: "false", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return CreatePortfolioResponse(code: "false", message: e.toString());
    }
  }

  @override
  Future<CreatePortfolioResponse> updatePortfolio(
      BuildContext context, PortfolioPayload payload, String id) async {
    String url = Urls.updatePortfolio + id;
    try {
      var response = await HttpRequest.put(
          context: context,
          url: url,
          useAuth: true,
          bodyJson: payload.toJson());

      if (response['code'] == "success") {
        return CreatePortfolioResponse.fromJson(response);
      } else {
        return CreatePortfolioResponse(
            code: "false", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return CreatePortfolioResponse(code: "false", message: e.toString());
    }
  }

  @override
  Future<UploadPortfolioResponse> uploadPortfolioPictures(
      BuildContext context, List<File> files, String id) async {
    String url = Urls.uploadPictures + id;
    try {
      final response = await HttpRequest.putFile(
          context: context, url: url, files: files, useAuth: true);
      if (response['code'] == 'success') {
        return UploadPortfolioResponse.fromJson(response);
      } else {
        return UploadPortfolioResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return UploadPortfolioResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<PortfolioCommentResponse> getCommentFeed(
      BuildContext context, String id, CommentListPayload payload) async {
    String url = Urls.commentList +
        id +
        "?limit=${payload.limit}"
            "&page=${payload.page}"
            "&is_sawer=${payload.isSawer}";

    print('[LOG PORTFOLIO] ${url}');

    try {
      var response =
          await HttpRequest.get(context: context, useAuth: true, url: url);
      if (response['code'] == "success") {
        return PortfolioCommentResponse.fromJson(response);
      } else {
        return PortfolioCommentResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return PortfolioCommentResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<GiveCommentResponse> giveComment(
      BuildContext context, String id, GiveCommentPayload payload) async {
    String url = Urls.feedComment;

    try {
      var response = await HttpRequest.post(
          context: context,
          useAuth: true,
          url: url,
          bodyJson: payload.toJson());
      if (response['code'] == "success") {
        return GiveCommentResponse.fromJson(response);
      } else {
        return GiveCommentResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return GiveCommentResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<TotalSawerResponse> getTotalSawer(BuildContext context, String id) async {
    String url = Urls.getTotalSawer+id;

    try {
      var response = await HttpRequest.get(
          context: context,
          useAuth: true,
          url: url,);
      if (response['code'] == "success") {
        return TotalSawerResponse.fromJson(response);
      } else {
        return TotalSawerResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return TotalSawerResponse(code: "failed", message: e.toString());
    }
  }
}
