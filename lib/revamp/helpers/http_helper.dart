import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:soedja_freelance/revamp/assets/sharedpref_keys.dart';
import 'package:soedja_freelance/revamp/assets/urls.dart';
import 'package:soedja_freelance/revamp/helpers/sharedpref_helper.dart';
import 'package:soedja_freelance/revamp/modules/auth/screens/auth_screen.dart';
import 'package:soedja_freelance/old_ver/utils/local_storage.dart';
import 'package:soedja_freelance/old_ver/utils/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';

class HttpRequest {
  static Client _httpClient = Client();

  static Future<Map<String, dynamic>> get(
      {BuildContext context,
      String url,
      bool useAuth,
      List<Map<String, String>> headers}) async {
    Response response;

    final Map<String, String> _headers = {"Content-type": "application/json"};

    if (useAuth == null || useAuth) {
      String jwt;
      await SharedPreference.get(SharedPrefKey.AuthToken).then((value) {
        jwt = value;
      });

      if (jwt == null) {
        throw Exception('jwt auth not found');
      }

      _headers['Authorization'] = 'bearer ' + jwt;
    }

    print('[LOG GET] Header: $_headers');
    print("[LOG GET] Url: " + BaseUrl.SoedjaAPI + url);

    response =
        await _httpClient.get(BaseUrl.SoedjaAPI + url, headers: _headers);

    print("[LOG GET] Response: $url " + json.decode(response.body).toString());

    return _handleResponse(context, response);
  }

  static Future<Map<String, dynamic>> post(
      {BuildContext context,
      String url,
      bool useAuth,
      Map<String, dynamic> bodyJson,
      List<Map<String, String>> headers}) async {
    Response response;

    final Map<String, String> _headers = {"Content-type": "application/json"};

    if (headers != null) {
      headers.forEach((f) => {_headers[f.keys.first] = f.values.first});
    }

    if (useAuth == null || useAuth) {
      String jwt = await LocalStorage.get(SharedPrefKey.AuthToken);

      if (jwt == null) {
        throw Exception('jwt auth not found');
      }
      _headers['Authorization'] = 'bearer ' + jwt;
    }

    print('[LOG POST] Header: $_headers');
    print("[LOG POST] Url: " + BaseUrl.SoedjaAPI + url);
    print("[LOG POST] Body: " + bodyJson.toString());

    try {
      response = await _httpClient
          .post(BaseUrl.SoedjaAPI + url,
              headers: _headers, body: jsonEncode(bodyJson))
          .timeout(Duration(seconds: 10));
    } catch (err) {
      throw TimeoutException('Request Timeout');
    }

    print("[LOG POST] Response: $url " + json.decode(response.body).toString());

    return _handleResponse(context, response);
  }


  static Future<Map<String, dynamic>> postToken(
      {BuildContext context,
        String url,
        String token,
        Map<String, dynamic> bodyJson,
        List<Map<String, String>> headers}) async {
    Response response;

    final Map<String, String> _headers = {"Content-type": "application/json"};

    if (headers != null) {
      headers.forEach((f) => {_headers[f.keys.first] = f.values.first});
    }

    String jwt = token;
    if (jwt == null) {
      throw Exception('jwt pin not found');
    }
    _headers['Authorization'] = 'bearer ' + token;

    print('[LOG POST] Header: $_headers');
    print("[LOG POST] Url: " + BaseUrl.SoedjaAPI + url);
    print("[LOG POST] Body: " + bodyJson.toString());

    try {
      response = await _httpClient
          .post(BaseUrl.SoedjaAPI + url,
          headers: _headers, body: jsonEncode(bodyJson))
          .timeout(Duration(seconds: 10));
    } catch (err) {
      throw TimeoutException('Request Timeout');
    }

    print("[LOG POST] Response: $url " + json.decode(response.body).toString());

    return _handleResponse(context, response);
  }

  static Future<Map<String, dynamic>> put(
      {BuildContext context,
      String url,
      bool useAuth,
      Map<String, dynamic> bodyJson,
      List<Map<String, String>> headers}) async {
    Response response;

    final Map<String, String> _headers = {"Content-type": "application/json"};

    if (headers != null) {
      headers.forEach((f) => {_headers[f.keys.first] = f.values.first});
    }

    if (useAuth == null || useAuth) {
      final jwt = await LocalStorage.get(SharedPrefKey.AuthToken);

      if (jwt == null) {
        throw Exception('jwt auth not found');
      }

      _headers['Authorization'] = 'bearer ' + jwt;
    }

    print('[LOG PUT] Header: $_headers');
    print("[LOG PUT] Url: " + BaseUrl.SoedjaAPI + url);
    print("[LOG PUT] Body: " + bodyJson.toString());

    try {
      response = await _httpClient
          .put(BaseUrl.SoedjaAPI + url,
              headers: _headers,
              body: jsonEncode(bodyJson != null ? bodyJson : {}))
          .timeout(Duration(seconds: 10));
    } catch (err) {
      throw TimeoutException('Request Timeout');
    }

    print("[LOG PUT] Response: $url " + json.decode(response.body).toString());

    return _handleResponse(context, response);
  }

  static Future<Map<String, dynamic>> putFile({
    BuildContext context,
    String url,
    bool useAuth,
    List<File> files,
    dynamic params,
    List<Map<String, String>> headers,
  }) async {
    var uri = Uri.https(BaseUrl.SoedjaUrl, url, params);
    var request = MultipartRequest("PUT", uri);

    Response response;

    for (File file in files) {
      if (file is File) {
        print(file.path);
        request.files.add(
          await MultipartFile.fromPath(
            'picture',
            file.path,
            contentType: MediaType('image', 'jpg'),
          ),
        );
      }
    }

    print("[LOG PUT] Url: " + BaseUrl.SoedjaAPI + url);

    await LocalStorage.get(SharedPrefKey.AuthToken).then((value) {
      request.headers.addAll({
        "authorization": "bearer $value",
      });
    });

    print("[LOG PUT] Headers: " + request.headers.toString());

    try {
      StreamedResponse streamedResponse = await request.send();
      response = await Response.fromStream(streamedResponse)
          .timeout(Duration(seconds: 10));
    } catch (err) {
      throw TimeoutException('Request Timeout');
    }
    print(
        "[LOG PUT] Response: : $url " + json.decode(response.body).toString());

    return _handleResponse(context, response);
  }

  static Future<Map<String, dynamic>> delete(
      {BuildContext context,
      String url,
      bool useAuth,
      Map<String, dynamic> bodyJson,
      List<Map<String, String>> headers}) async {
    Response response;

    final Map<String, String> _headers = {"Content-type": "application/json"};

    if (headers != null) {
      headers.forEach((f) => {_headers[f.keys.first] = f.values.first});
    }

    if (useAuth == null || useAuth) {
      final jwt = await LocalStorage.get(SharedPrefKey.AuthToken);

      if (jwt == null) {
        throw Exception('jwt auth not found');
      }

      _headers['Authorization'] = 'bearer ' + jwt;
    }

    print('[LOG DELETE] Header: $_headers');
    print("[LOG DELETE] Url: " + BaseUrl.SoedjaAPI + url);
    print("[LOG DELETE] Body: " + bodyJson.toString());

    try {
      response = await _httpClient
          .delete(BaseUrl.SoedjaAPI + url, headers: _headers)
          .timeout(Duration(seconds: 10));
    } catch (err) {
      throw TimeoutException('Request Timeout');
    }

    print("[LOG DELETE] Response: " + json.decode(response.body).toString());

    return _handleResponse(context, response);
  }

  static Future<Map<String, dynamic>> _handleResponse(
      BuildContext context, Response response) async {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }

    if (response.statusCode == 400) {
      return json.decode(response.body);
    }

    if (response.statusCode == 401) {
      await LocalStorage.remove(SharedPrefKey.AuthToken);
      Navigation().navigateReplacement(context, AuthScreen());
    }

    throw Exception('Cannot Request');
  }
}
