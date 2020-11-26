import 'package:flutter/material.dart';
import 'package:soedja_freelance/revamp/assets/urls.dart';
import 'package:soedja_freelance/revamp/helpers/http_helper.dart';
import 'package:soedja_freelance/revamp/modules/area/models/area_models.dart';

abstract class AreaAPI {
  Future<ProvinceListResponse> getProvince(BuildContext context);

  Future<RegencyListResponse> getRegency(
      BuildContext context, String provinceId);

  Future<DistrictListResponse> getDistrict(
      BuildContext context, String provinceId, String regencyId);

  Future<VillageListResponse> getVillage(BuildContext context,
      String provinceId, String regencyId, String districtId);
}

class AreaService extends AreaAPI {
  @override
  Future<ProvinceListResponse> getProvince(BuildContext context) async {
    String url = Urls.getProvince;
    try {
      var response =
          await HttpRequest.get(context: context, useAuth: true, url: url);
      if (response['code'] == "success") {
        return ProvinceListResponse.fromJson(response);
      } else {
        return ProvinceListResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return ProvinceListResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<RegencyListResponse> getRegency(
      BuildContext context, String provinceId) async {
    String url = Urls.getRegency + "?province_id=$provinceId";
    try {
      var response =
          await HttpRequest.get(context: context, useAuth: true, url: url);
      if (response['code'] == "success") {
        return RegencyListResponse.fromJson(response);
      } else {
        return RegencyListResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return RegencyListResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<DistrictListResponse> getDistrict(
      BuildContext context, String provinceId, String regencyId) async {
    String url = Urls.getDistrict +
        "?province_id=$provinceId"
            "&regency_id=$regencyId";
    try {
      var response =
          await HttpRequest.get(context: context, useAuth: true, url: url);
      if (response['code'] == "success") {
        return DistrictListResponse.fromJson(response);
      } else {
        return DistrictListResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return DistrictListResponse(code: "failed", message: e.toString());
    }
  }

  @override
  Future<VillageListResponse> getVillage(BuildContext context,
      String provinceId, String regencyId, String districtId) async {
    String url = Urls.getVillage +
        "?province_id=$provinceId"
            "&regency_id=$regencyId"
            "&district_id=$districtId";
    try {
      var response =
          await HttpRequest.get(context: context, useAuth: true, url: url);
      if (response['code'] == "success") {
        return VillageListResponse.fromJson(response);
      } else {
        return VillageListResponse(
            code: "failed", message: response['message']);
      }
    } catch (e) {
      print(e.toString());
      return VillageListResponse(code: "failed", message: e.toString());
    }
  }
}
