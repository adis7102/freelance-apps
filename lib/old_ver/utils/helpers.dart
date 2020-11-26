import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:soedja_freelance/old_ver/constants/lists.dart';
import 'package:soedja_freelance/old_ver/constants/local_storage.dart';
import 'package:soedja_freelance/old_ver/constants/strings.dart';

import 'local_storage.dart';

Color ColorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

Future<bool> isLogin() async {
  final jwt = await LocalStorage.get(LocalStorageKey.AuthToken);

  if (jwt == null) {
    return false;
  }

  return true;
}

Future<bool> isFirstTime() async {
  final firstTime = await LocalStorage.get(LocalStorageKey.FirstTime);

  if (firstTime == null) {
    return true;
  }

  return false;
}

String validateEmpty(String value) {
  if (value.isEmpty) return Strings.formEmpty;
}

String validateEmail(String value) {
  if (value.isEmpty) return Strings.emailEmpty;

  final RegExp nameExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!nameExp.hasMatch(value)) return Strings.emailNotValid;
  return null;
}

String validateEmailRegister(String value) {
  return Strings.emailIsRegister;
}

String validatePhoneRegister(String value) {
  return Strings.phoneIsRegister;
}

String validateLogin(String value) {
  if (value.isEmpty) return Strings.emailEmpty;

  final RegExp nameExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!nameExp.hasMatch(value)) return Strings.emailNotValid;
  return null;
}

String validateEmailNotRegister(String value) {
  return Strings.emailNotRegister;
}

String validateName(String value) {
  if (value.isEmpty) return Strings.nameEmpty;
  if (value.length < 3) return Strings.nameNotValid;
  return null;
}

String validatePhone(String value) {
  if (value.isEmpty) return Strings.phoneEmpty;
  if (value.length < 8) return Strings.phoneNotValid;
  return null;
}

void onClick() {
  print('Clicked');
}

final currencyIDR = NumberFormat('Rp #,###', 'ID');
final currency = NumberFormat('#,###', 'ID');

class MoneyMaskedTextController extends TextEditingController {
  MoneyMaskedTextController({
    double initialValue = 0.0,
    this.decimalSeparator = ',',
    this.thousandSeparator = '.',
    this.rightSymbol = '',
    this.leftSymbol = '',
    this.precision = 2,
  }) {
    _validateConfig();

    this.addListener(() {
      this.updateValue(this.numberValue);
      this.afterChange(this.text, this.numberValue);
    });

    this.updateValue(initialValue);
  }

  final String decimalSeparator;
  final String thousandSeparator;
  final String rightSymbol;
  final String leftSymbol;
  final int precision;

  Function afterChange = (String maskedValue, double rawValue) {};

  double _lastValue = 0.0;

  void updateValue(double value) {
    double valueToUse = value;

    if (value.toStringAsFixed(0).length > 12) {
      valueToUse = _lastValue;
    } else {
      _lastValue = value;
    }

    String masked = this._applyMask(valueToUse);

    if (rightSymbol.length > 0) {
      masked += rightSymbol;
    }

    if (leftSymbol.length > 0) {
      masked = leftSymbol + masked;
    }

    if (masked != this.text) {
      this.text = masked;

      var cursorPosition = super.text.length - this.rightSymbol.length;
      this.selection = new TextSelection.fromPosition(
          new TextPosition(offset: cursorPosition));
    }
  }

  double get numberValue {
    if (this.text.isEmpty) return 0.0;
    if ((this.text.length - 1) < leftSymbol.length) return 0.0;

    List<String> parts =
        _getOnlyNumbers(this.text).split('').toList(growable: true);

    parts.insert(parts.length - precision, '.');

    return double.parse(parts.join());
  }

  _validateConfig() {
    bool rightSymbolHasNumbers = _getOnlyNumbers(this.rightSymbol).length > 0;

    if (rightSymbolHasNumbers) {
      throw new ArgumentError("rightSymbol must not have numbers.");
    }
  }

  String _getOnlyNumbers(String text) {
    String cleanedText = text;

    var onlyNumbersRegex = new RegExp(r'[^\d]');

    cleanedText = cleanedText.replaceAll(onlyNumbersRegex, '');

    return cleanedText;
  }

  String _applyMask(double value) {
    List<String> textRepresentation = value
        .toStringAsFixed(precision)
        .replaceAll('.', '')
        .split('')
        .reversed
        .toList(growable: true);

    textRepresentation.insert(precision, decimalSeparator);

    for (var i = precision + 4; true; i = i + 4) {
      if (textRepresentation.length > i) {
        textRepresentation.insert(i, thousandSeparator);
      } else {
        break;
      }
    }

    return textRepresentation.reversed.join('');
  }
}

String dateFormat({int date, DateTime dateTime, String formatDate}) {
  var format = DateFormat(formatDate ?? 'dd/MM/yyyy HH:mm a');
  if (dateTime != null) {
    return format.format(dateTime);
  } else {
    var dates = DateTime.fromMillisecondsSinceEpoch(date * 1000);
    return format.format(dates);
  }
}

String countDown({int date, DateTime dateTime, String formatDate}) {
  var format = DateFormat(formatDate ?? 'dd/MM/yyyy HH:mm a');
  if (dateTime != null) {
    return format.format(dateTime);
  } else {
    var dates = DateTime.fromMillisecondsSinceEpoch(date * 1000);
    return format.format(dates);
  }
}

String typeProject({String type}) {
  if (type == 'creative') {
    return 'Project Kreatif';
  } else {
    return 'Bayar Perjam';
  }
}

String strDateOnly(String date) {
  var dates;
  if (date.contains('-')) {
    dates = date.split('-');
  } else {
    dates = date.split('/');
  }
  return '${dates[2]} ${monthId(dates[1])} ${dates[0]}';
}

String strDateTime(String date) {
  var dates;
  if (date.contains('-')) {
    dates = date.split('-');
  } else {
    dates = date.split('/');
  }
  return '${dates[2]} ${monthId(dates[1])} ${dates[0]}';
}

String monthId(String month) {
  if (month == '01') {
    return 'Januari';
  } else if (month == '02') {
    return 'Februari';
  } else if (month == '03') {
    return 'Maret';
  } else if (month == '04') {
    return 'April';
  } else if (month == '05') {
    return 'Mei';
  } else if (month == '06') {
    return 'Juni';
  } else if (month == '07') {
    return 'Juli';
  } else if (month == '08') {
    return 'Agustus';
  } else if (month == '09') {
    return 'September';
  } else if (month == '10') {
    return 'Oktober';
  } else if (month == '11') {
    return 'November';
  } else {
    return 'Desember';
  }
}

Map<String, dynamic> parseJwt(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('invalid token');
  }

  final payload = _decodeBase64(parts[1]);
  final payloadMap = json.decode(payload);
  if (payloadMap is! Map<String, dynamic>) {
    throw Exception('invalid payload');
  }

  return payloadMap;
}

String _decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

  return utf8.decode(base64Url.decode(output));
}

Future<dynamic> decodeToken() async {
  var data;

  await LocalStorage.get(LocalStorageKey.AuthToken).then((value) async {
    data = parseJwt(value);
  });

  return data;
}

Future<Map<String, dynamic>> initPlatformState(
    DeviceInfoPlugin deviceInfoPlugin) async {
  Map<String, dynamic> deviceData;

  try {
    if (Platform.isAndroid) {
      deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
    } else if (Platform.isIOS) {
      deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
    }
  } on PlatformException {
    deviceData = <String, dynamic>{'Error:': 'Failed to get platform version.'};
  }

  return deviceData;
}

Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
  return <String, dynamic>{
    'version.securityPatch': build.version.securityPatch,
    'version.sdkInt': build.version.sdkInt,
    'version.release': build.version.release,
    'version.previewSdkInt': build.version.previewSdkInt,
    'version.incremental': build.version.incremental,
    'version.codename': build.version.codename,
    'version.baseOS': build.version.baseOS,
    'board': build.board,
    'bootloader': build.bootloader,
    'brand': build.brand,
    'device': build.device,
    'display': build.display,
    'fingerprint': build.fingerprint,
    'hardware': build.hardware,
    'host': build.host,
    'id': build.id,
    'manufacturer': build.manufacturer,
    'model': build.model,
    'product': build.product,
    'supported32BitAbis': build.supported32BitAbis,
    'supported64BitAbis': build.supported64BitAbis,
    'supportedAbis': build.supportedAbis,
    'tags': build.tags,
    'type': build.type,
    'isPhysicalDevice': build.isPhysicalDevice,
    'androidId': build.androidId,
    'systemFeatures': build.systemFeatures,
  };
}

Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
  return <String, dynamic>{
    'name': data.name,
    'systemName': data.systemName,
    'systemVersion': data.systemVersion,
    'model': data.model,
    'localizedModel': data.localizedModel,
    'identifierForVendor': data.identifierForVendor,
    'isPhysicalDevice': data.isPhysicalDevice,
    'utsname.sysname:': data.utsname.sysname,
    'utsname.nodename:': data.utsname.nodename,
    'utsname.release:': data.utsname.release,
    'utsname.version:': data.utsname.version,
    'utsname.machine:': data.utsname.machine,
  };
}


String avatar(String name){
  if(name != null){
    for (int i =0; i<avatarList.length; i++){
      if(name[0] == avatarList[i]['name']){
        return avatarList[i]['value'];
      }
    }
  }
  return avatarList[0]['value'];
}