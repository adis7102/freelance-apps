import 'package:flutter/material.dart';
import 'package:soedja_freelance/revamp/assets/urls.dart';
import 'package:soedja_freelance/revamp/helpers/http_helper.dart';
import 'package:soedja_freelance/revamp/modules/contact/models/contact_models.dart';

abstract class KontakAPI {
  Future<ListKontakResponse> getContact(BuildContext context, String payload);
  Future<CreateContactResponse> createContact(BuildContext context, CreateContactPayload payload);
  Future<DeleteContactResponse> deleteContact(BuildContext context, String id);
  Future<EditContactResponse> editContact(BuildContext context, CreateContactPayload payload, String id);
}

class KontakService extends KontakAPI {
  @override
  Future<ListKontakResponse> getContact(BuildContext context, String payload) async {
    String url = Urls.getListContact + '?keyword=$payload';
    try {
      var response =
          await HttpRequest.get(context: context, useAuth: true, url: url);
      if (response['code'] == "success") {
        print(response);
        return ListKontakResponse.fromJson(response);
      } else {
        return ListKontakResponse(code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return ListKontakResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<CreateContactResponse> createContact(
      BuildContext context, CreateContactPayload payload) async {
    String url = Urls.createContact;

    try {
      var response = await HttpRequest.post(
          context: context,
          useAuth: true,
          url: url,
          bodyJson: payload.toJson());
      if (response['code'] == "success") {
        return CreateContactResponse.fromJson(response);
      } else {
        return CreateContactResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return CreateContactResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<DeleteContactResponse> deleteContact(
      BuildContext context, String id) async {
    String url = Urls.deleteContact + id;

    try {
      var response = await HttpRequest.delete(
          context: context,
          useAuth: true,
          url: url);
      if (response['code'] == "success") {
        return DeleteContactResponse.fromJson(response);
      } else {
        return DeleteContactResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return DeleteContactResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<EditContactResponse> editContact(
      BuildContext context, CreateContactPayload payload, String id) async {
    String url = Urls.editContact + id;
    try {
      var response = await HttpRequest.put(
          context: context,
          url: url,
          useAuth: true,
          bodyJson: payload.toJson());

      if (response['code'] == "success") {
        return EditContactResponse.fromJson(response);
      } else {
        return EditContactResponse(
            code: "false", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return EditContactResponse(code: "false", message: e.toString());
    }
  }
}
