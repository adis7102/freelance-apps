import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:soedja_freelance/old_ver/constants/urls.dart';
import 'package:soedja_freelance/old_ver/models/portfolio.dart';
import 'package:soedja_freelance/old_ver/utils/http_request.dart';

class PortfolioService {
  Future<Portfolio> create(BuildContext context, PortfolioPayload payload) async {
    try {
      Portfolio portfolio = new Portfolio();

      final response = await HttpRequest.post(context: context,
          url: Url.createPortfolio, bodyJson: payload.toJson(), useAuth: true);

      portfolio = Portfolio.fromJson(response['payload']);

      return portfolio;
    } catch (err) {
      return Portfolio.withError(err.toString());
    }
  }

  Future<Portfolio> update(BuildContext context, PortfolioPayload payload, String portfolioId) async {
    try {
      Portfolio portfolio = new Portfolio();

      final response = await HttpRequest.put(context: context,
          url: Url.updatePortfolio + portfolioId,
          bodyJson: payload.toJson(),
          useAuth: true);

      portfolio = Portfolio.fromJson(response['payload']);

      return portfolio;
    } catch (err) {
      return Portfolio.withError(err.toString());
    }
  }

  Future<Portfolio> uploadPictures(BuildContext context, List<File> files, String portfolioId) async {
    try {
      Portfolio portfolio = new Portfolio();

      final response = await HttpRequest.putFile(context: context,
          url: Url.uploadPictures + portfolioId, files: files, useAuth: true);

      portfolio = Portfolio.fromJson(response['payload']);

      return portfolio;
    } catch (err) {
      return Portfolio.withError(err.toString());
    }
  }

  Future<bool> deletePictures(BuildContext context, String portfolioId, String pictureId) async {
    try {
      final response = await HttpRequest.delete(context: context,
          url: Url.removePictures + portfolioId + '/' + pictureId,
          useAuth: true);

      if (response['code'] == 'success') {
        return true;
      }
      return false;
    } catch (err) {
      return false;
    }
  }

  Future<List<Portfolio>> getPortfolio(BuildContext context,
      String userId, PortfolioListPayload payload) async {
    try {
      List<Portfolio> list = new List<Portfolio>();

      String params = '?limit=${payload.limit}'
          '&page=${payload.page}'
          '&title=${payload.title ?? ''}';

      final response = await HttpRequest.get(context: context,
          url: Url.portfolioList + userId + params, useAuth: true);

      response['payload']['rows'].forEach((data) {
        list.add(Portfolio.fromJson(data));
      });
      return list;
    } catch (err) {
      return [];
    }
  }
}
