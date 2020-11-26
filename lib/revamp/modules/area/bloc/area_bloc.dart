import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:soedja_freelance/revamp/modules/area/bloc/area_state.dart';
import 'package:soedja_freelance/revamp/modules/area/services/area_services.dart';
import 'package:soedja_freelance/revamp/modules/category/bloc/category_state.dart';

class AreaBloc {
  BehaviorSubject<ProvinceListState> _subjectProvince =
      BehaviorSubject<ProvinceListState>();
  BehaviorSubject<RegencyListState> _subjectRegency =
      BehaviorSubject<RegencyListState>();
  BehaviorSubject<DistrictListState> _subjectDistrict =
      BehaviorSubject<DistrictListState>();
  BehaviorSubject<VillageListState> _subjectVillage =
      BehaviorSubject<VillageListState>();

  Stream<ProvinceListState> get getProvince => _subjectProvince.stream;

  Stream<RegencyListState> get getRegency => _subjectRegency.stream;

  Stream<DistrictListState> get getDistrict => _subjectDistrict.stream;

  Stream<VillageListState> get getVillage => _subjectVillage.stream;

  BehaviorSubject<bool> _stanby = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get getStanby => _stanby.stream;

  requestGetProvince(BuildContext context) {
    try {
      _subjectProvince.sink.add(ProvinceListState.onLoading("Loading get ..."));
      AreaService().getProvince(context).then((response) {
        if (response.code == 'success') {
          _subjectProvince.sink.add(ProvinceListState.onSuccess(response));
        } else {
          _subjectProvince.sink
              .add(ProvinceListState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectProvince.sink.add(ProvinceListState.onError(e.toString()));
    }
  }

  requestGetRegency(BuildContext context, String provinceId) {
    try {
      _subjectRegency.sink.add(RegencyListState.onLoading("Loading get ..."));
      AreaService().getRegency(context, provinceId).then((response) {
        if (response.code == 'success') {
          _subjectRegency.sink.add(RegencyListState.onSuccess(response));
        } else {
          _subjectRegency.sink.add(RegencyListState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectRegency.sink.add(RegencyListState.onError(e.toString()));
    }
  }

  requestGetDistrict(
      BuildContext context, String provinceId, String regencyId) {
    try {
      _subjectDistrict.sink.add(DistrictListState.onLoading("Loading get ..."));
      AreaService()
          .getDistrict(context, provinceId, regencyId)
          .then((response) {
        if (response.code == 'success') {
          _subjectDistrict.sink.add(DistrictListState.onSuccess(response));
        } else {
          _subjectDistrict.sink
              .add(DistrictListState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectDistrict.sink.add(DistrictListState.onError(e.toString()));
    }
  }

  requestGetVillage(
    BuildContext context,
    String provinceId,
    String regencyId,
    String districtId,
  ) {
    try {
      _subjectVillage.sink.add(VillageListState.onLoading("Loading get ..."));
      AreaService()
          .getVillage(context, provinceId, regencyId, districtId)
          .then((response) {
        if (response.code == 'success') {
          _subjectVillage.sink.add(VillageListState.onSuccess(response));
        } else {
          _subjectVillage.sink.add(VillageListState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectVillage.sink.add(VillageListState.onError(e.toString()));
    }
  }

  unStandBy() async {
    _stanby.sink.add(false);
    _subjectProvince.sink.add(ProvinceListState.unStanby());
    _subjectRegency.sink.add(RegencyListState.unStanby());
    _subjectDistrict.sink.add(DistrictListState.unStanby());
    _subjectVillage.sink.add(VillageListState.unStanby());
  }

  void dispose() {
    _subjectProvince?.close();
    _subjectRegency?.close();
    _subjectDistrict?.close();
    _subjectVillage?.close();
    _stanby?.drain(false);
  }
}
