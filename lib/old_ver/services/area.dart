import 'package:flutter/material.dart';
import 'package:soedja_freelance/old_ver/constants/urls.dart';
import 'package:soedja_freelance/old_ver/models/area.dart';
import 'package:soedja_freelance/old_ver/utils/http_request.dart';

class AreaService {
  Future<List<Province>> getProvince(BuildContext context) async {
    try {
      List<Province> list = new List<Province>();

      final response = await HttpRequest.get(
          context: context, url: Url.provinceList, useAuth: true);

      response['payload']['rows'].forEach((data) {
        list.add(Province.fromJson(data));
      });

      return list;
    } catch (err) {
      return [];
    }
  }

  Future<List<Regency>> getRegency(
      BuildContext context, String provinceId) async {
    try {
      List<Regency> list = new List<Regency>();

      final response = await HttpRequest.get(
          context: context,
          url: Url.regencyList + '?province_id=$provinceId',
          useAuth: true);

      response['payload']['rows'].forEach((data) {
        list.add(Regency.fromJson(data));
      });

      return list;
    } catch (err) {
      return [];
    }
  }

  Future<List<District>> getDistrict(
      BuildContext context, String provinceId, String regencyId) async {
    try {
      List<District> list = new List<District>();

      final response = await HttpRequest.get(
          context: context,
          url: Url.districtList +
              '?province_id=$provinceId&regency_id=$regencyId',
          useAuth: true);

      response['payload']['rows'].forEach((data) {
        list.add(District.fromJson(data));
      });

      return list;
    } catch (err) {
      return [];
    }
  }

  Future<List<Village>> getVillage(BuildContext context, String provinceId,
      String regencyId, String districtId) async {
    try {
      List<Village> list = new List<Village>();

      final response = await HttpRequest.get(
          context: context,
          url: Url.villageList +
              '?province_id=$provinceId'
                  '&regency_id=$regencyId'
                  '&district_id=$districtId',
          useAuth: true);

      response['payload']['rows'].forEach((data) {
        list.add(Village.fromJson(data));
      });

      return list;
    } catch (err) {
      return [];
    }
  }
}
