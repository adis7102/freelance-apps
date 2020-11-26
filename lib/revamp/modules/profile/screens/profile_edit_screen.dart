import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:soedja_freelance/revamp/assets/fonts.dart';
import 'package:soedja_freelance/revamp/assets/images.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:soedja_freelance/revamp/helpers/keyboard_helper.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/account/components/interest_select_screen.dart';
import 'package:soedja_freelance/revamp/modules/area/bloc/area_bloc.dart';
import 'package:soedja_freelance/revamp/modules/area/bloc/area_state.dart';
import 'package:soedja_freelance/revamp/modules/area/models/area_models.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_state.dart';
import 'package:soedja_freelance/revamp/modules/auth/models/auth_models.dart';
import 'package:soedja_freelance/revamp/modules/category/bloc/category_bloc.dart';
import 'package:soedja_freelance/revamp/modules/profile/bloc/profile_bloc.dart';
import 'package:soedja_freelance/revamp/modules/profile/bloc/profile_state.dart';
import 'package:soedja_freelance/revamp/modules/profile/models/profile_models.dart';
import 'package:soedja_freelance/revamp/themes/colors.dart';

class ProfileEditScreen extends StatefulWidget {
  final AuthBloc authBloc;
  final ProfileDetail profileDetail;

  const ProfileEditScreen({Key key, this.authBloc, this.profileDetail})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProfileEditScreen();
  }
}

class _ProfileEditScreen extends State<ProfileEditScreen> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController aboutController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();

  FocusNode nameFocus = new FocusNode();
  FocusNode phoneFocus = new FocusNode();
  FocusNode emailFocus = new FocusNode();
  FocusNode aboutFocus = new FocusNode();
  FocusNode addressFocus = new FocusNode();

  AreaBloc areaBloc = new AreaBloc();
  AreaData province = new AreaData();
  AreaData regency = new AreaData();
  AreaData district = new AreaData();
  AreaData village = new AreaData();

  List<AreaData> provinceList = new List<AreaData>();
  List<AreaData> regencyList = new List<AreaData>();
  List<AreaData> districtList = new List<AreaData>();
  List<AreaData> villageList = new List<AreaData>();

  ProfileBloc profileBloc = new ProfileBloc();
  Profession profession = new Profession();

  List<Profession> professionList = new List<Profession>();

  String avatarUrl = "";

  Future<Null> _pickImage() async {
    File image;
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _cropImage(image);
      });
    }
  }

  Future<Null> _cropImage(File image) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
              ]
            : [CropAspectRatioPreset.square],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Potong Gambar',
            toolbarColor: ColorApps.primary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          title: 'Potong Gambar',
        ));
    if (croppedFile != null) {
      widget.authBloc.uploadAvatar(context, croppedFile).then((response) {
        if (response.code == "success") {
          widget.authBloc.requestGetProfile(context);
          setState(() {});
        } else {
          showDialogMessage(context, response.message,
              "Terjadi kesalahan, silahkan coba lagi.");
        }
      });
    }
  }

  @override
  void initState() {
    setProfile();
    areaBloc.requestGetProvince(context);
    profileBloc.requestGetProfession(context);
    super.initState();
  }

  setProfile() {
    nameController.text = widget.profileDetail.name;
    phoneController.text = widget.profileDetail.phone;
    emailController.text = widget.profileDetail.email;
    aboutController.text = widget.profileDetail.about;
    addressController.text = widget.profileDetail.address;

    setState(() {});
    print(widget.profileDetail.toJson());
  }

  setProvince() {
    if (widget.profileDetail.province.length > 0) {
      for (AreaData prov in provinceList) {
        if (prov.province.contains(widget.profileDetail.province)) {
          province = prov;
          areaBloc.requestGetRegency(context, province.id.toString());
        }
      }
    }
  }

  setRegency() {
    if (widget.profileDetail.regency.length > 0) {
      for (AreaData city in regencyList) {
        if (city.regency.contains(widget.profileDetail.regency)) {
          regency = city;
          areaBloc.requestGetDistrict(
              context, province.id.toString(), regency.id.toString());
        }
      }
    }
  }

  setDistrict() {
    if (widget.profileDetail.district.length > 0) {
      for (AreaData dist in districtList) {
        if (dist.district.contains(widget.profileDetail.district)) {
          district = dist;
          areaBloc.requestGetVillage(context, province.id.toString(),
              regency.id.toString(), district.id.toString());
        }
      }
    }
  }

  setVillage() {
    if (widget.profileDetail.village.length > 0) {
      for (AreaData vill in villageList) {
        if (vill.village.contains(widget.profileDetail.village)) {
          village = vill;
        }
      }
    }
  }

  setProfession() {
    if (widget.profileDetail.profession.length > 0) {
      for (Profession prof in professionList) {
        if (prof.profession.contains(widget.profileDetail.profession)) {
          profession = prof;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        title: Text(
          Texts.myInformation,
          style: TextStyle(
            color: Colors.black,
            fontSize: ScreenUtil().setSp(15),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigation().navigateBack(context)),
      ),
      body: GestureDetector(
        onTap: () => Keyboard().closeKeyboard(context),
        child: ListView(
          children: <Widget>[
            DividerWidget(
              child: Text(
                "Informasi Diri",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(15),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: size.width,
              padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: ScreenUtil().setWidth(100),
                        child: Text(
                          Texts.photoProfile.toUpperCase(),
                          style: TextStyle(
                              color: Colors.black.withOpacity(.5),
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenUtil().setSp(10)),
                        ),
                      ),
                      Container(
                        child: Text(
                          Texts.fullName.toUpperCase(),
                          style: TextStyle(
                              color: Colors.black.withOpacity(.5),
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenUtil().setSp(10)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenUtil().setHeight(15)),
                  Row(
                    children: <Widget>[
                      Container(
                        width: ScreenUtil().setWidth(100),
                        child: Row(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                StreamBuilder<GetProfileState>(
                                    stream: widget.authBloc.getProfile,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data.isLoading) {
                                          return CircleLayoutLoading(context, Colors.black, ScreenUtil().setWidth(60));
                                        } else if (snapshot.data.hasError) {
                                          if (snapshot.data.standby) {
                                            onWidgetDidBuild(() {
                                              showDialogMessage(
                                                  context,
                                                  snapshot.data.message,
                                                  "Terjadi kesalahan, silahkan coba lagi");
                                            });
                                          }
                                        }
                                      }
                                      return GestureDetector(
                                        onTap: _pickImage,
                                        child: AvatarProfile(
                                            profile: snapshot.data.data.payload,
                                            size: ScreenUtil().setWidth(64)),
                                      );
                                    }),
                                Container(
                                  decoration: BoxDecoration(
                                      color: ColorApps.light,
                                      borderRadius: BorderRadius.circular(
                                          ScreenUtil().setSp(20))),
                                  width: ScreenUtil().setWidth(24),
                                  child: AspectRatio(
                                    aspectRatio: 1/1,
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                      size: ScreenUtil().setWidth(15),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TextFormFieldOutline(
                          controller: nameController,
                          focusNode: nameFocus,
                          keyboardType: TextInputType.text,
                          hint: Texts.hintFullName,
                          enabled: true,
                          suffixIcon: Container(
                            height: 1,
                            width: 1
                          ),
                          onFieldSubmitted: (val) =>
                              onFieldSubmitted(context, nameFocus, phoneFocus),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  Text(
                    Texts.labelPhone.toUpperCase(),
                    style: TextStyle(
                        color: Colors.black.withOpacity(.5),
                        fontWeight: FontWeight.w300,
                        fontSize: ScreenUtil().setSp(10)),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(15)),
                  Row(
                    children: <Widget>[
                      Container(
                        width: ScreenUtil().setWidth(80),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(ScreenUtil().setHeight(5))),
                          color: Colors.black,
                        ),
                        child: Stack(
                          children: <Widget>[
                            TextFormFieldAreaOutline(
                              enabled: false,
                              contentPadding: EdgeInsets.zero,
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(
                                      ScreenUtil().setHeight(5))),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: ScreenUtil().setHeight(20),
                                  horizontal: ScreenUtil().setWidth(12)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Image.asset(
                                    Images.imgFlagIdn,
                                    width: ScreenUtil().setWidth(20),
                                  ),
                                  SizedBox(width: ScreenUtil().setWidth(5)),
                                  Text(
                                    "+62",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: ScreenUtil().setSp(15)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TextFormFieldOutline(
                          focusNode: phoneFocus,
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          hint: Texts.hintPhone,
                          borderRadius: BorderRadius.horizontal(
                              right:
                                  Radius.circular(ScreenUtil().setHeight(5))),
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (val) =>
                              onFieldSubmitted(context, phoneFocus, emailFocus),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  Text(
                    Texts.labelEmail.toUpperCase(),
                    style: TextStyle(
                        color: Colors.black.withOpacity(.5),
                        fontWeight: FontWeight.w300,
                        fontSize: ScreenUtil().setSp(10)),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(15)),
                  TextFormFieldOutline(
                    controller: emailController,
                    focusNode: emailFocus,
                    keyboardType: TextInputType.emailAddress,
                    hint: Texts.hintEmail,
                    enabled: true,
                    onFieldSubmitted: (val) =>
                        onFieldSubmitted(context, emailFocus, aboutFocus),
                    textInputAction: TextInputAction.next,
                    validator: validateEmail,
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  Text(
                    Texts.about.toUpperCase(),
                    style: TextStyle(
                        color: Colors.black.withOpacity(.5),
                        fontWeight: FontWeight.w300,
                        fontSize: ScreenUtil().setSp(10)),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(15)),
                  TextFormFieldAreaOutline(
                    controller: aboutController,
                    focusNode: aboutFocus,
                    minLines: 5,
                    maxLines: 20,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    hint: Texts.tellYourStory,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(14),
                      height: 1.5,
                      fontWeight: FontWeight.normal,
                    ),
                    contentPadding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                    onFieldSubmitted: (val) =>
                        onFieldSubmitted(context, aboutFocus, addressFocus),
                    validator: validateEmail,
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                ],
              ),
            ),
            DividerWidget(
              child: Text(
                "Informasi Umum",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(15),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      text: Texts.fullAddressLabel.toUpperCase() + "  ",
                      style: TextStyle(
                          color: Colors.black.withOpacity(.5),
                          fontWeight: FontWeight.w300,
                          fontFamily: Fonts.ubuntu,
                          fontSize: ScreenUtil().setSp(10)),
                      children: <TextSpan>[
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: ColorApps.red,
                            fontWeight: FontWeight.normal,
                            fontSize: ScreenUtil().setSp(12),
                            fontFamily: Fonts.ubuntu,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(15)),
                  TextFormFieldOutline(
                    controller: addressController,
                    focusNode: addressFocus,
                    keyboardType: TextInputType.text,
                    hint: Texts.fullAddressHint,
                    onFieldSubmitted: (val) => Keyboard().closeKeyboard(context),
                    textInputAction: TextInputAction.next,
                    validator: validateEmail,
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  RichText(
                    text: TextSpan(
                      text: Texts.addressAdministration.toUpperCase() + "  ",
                      style: TextStyle(
                          color: Colors.black.withOpacity(.5),
                          fontWeight: FontWeight.w300,
                          fontFamily: Fonts.ubuntu,
                          fontSize: ScreenUtil().setSp(10)),
                      children: <TextSpan>[
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: ColorApps.red,
                            fontWeight: FontWeight.normal,
                            fontSize: ScreenUtil().setSp(12),
                            fontFamily: Fonts.ubuntu,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(15)),
                  ProvinceDropDown(),
                  RegencyDropDown(),
                  DistrictDropDown(),
                  VillageDropDown(),
                ],
              ),
            ),
            DividerWidget(
              child: Text(
                "Informasi Profesi",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(15),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      text: Texts.professionLabel.toUpperCase() + "  ",
                      style: TextStyle(
                          color: Colors.black.withOpacity(.5),
                          fontWeight: FontWeight.w300,
                          fontFamily: Fonts.ubuntu,
                          fontSize: ScreenUtil().setSp(10)),
                      children: <TextSpan>[
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: ColorApps.red,
                            fontWeight: FontWeight.normal,
                            fontSize: ScreenUtil().setSp(12),
                            fontFamily: Fonts.ubuntu,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(15)),
                  ProfessionDropDown(),
                ],
              ),
            ),
            DividerWidget(
              height: ScreenUtil().setHeight(42),
            ),
            Container(
              padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
              child: Container(
                height: ScreenUtil().setHeight(56),
                child: StreamBuilder<UpdateProfileState>(
                    stream: profileBloc.getUpdate,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.isLoading) {
                          return FlatButtonLoading(
                              context: context,
                              size: size,
                              color: Colors.black,
                              margin: EdgeInsets.zero);
                        } else if (snapshot.data.hasError) {
                          if (snapshot.data.standby) {
                            onWidgetDidBuild(() {
                              showDialogMessage(context, snapshot.data.message,
                                  "Terjadi Kesalahan, silahkan coba lagi.");
                            });
//                            profileBloc.unStandBy();
                          }
                        }
                        if (snapshot.data.isSuccess) {
                          if (snapshot.data.standby) {
                            onWidgetDidBuild(() {
                              showDialogMessage(context, snapshot.data.message,
                                  "Berhasil merubah profile, silahkan cek profile terbarumu.");
                            });
                            widget.authBloc.requestGetProfile(context);
                            profileBloc.unStandBy();
                          }
                        }
                      }
                      return FlatButtonText(
                        color: Colors.black,
                        text: "Simpan".toUpperCase(),
                        onPressed: () {
                          validateField(context);
                        },
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ProvinceDropDown() {
    return Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: ColorApps.light,
              borderRadius: BorderRadius.circular(ScreenUtil().setSp(20))),
          height: ScreenUtil().setHeight(36),
          width: ScreenUtil().setWidth(36),
          alignment: Alignment.center,
          child: Text(
            '1.',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: ScreenUtil().setSp(14),
              fontFamily: Fonts.ubuntu,
            ),
          ),
        ),
        SizedBox(width: ScreenUtil().setWidth(16)),
        Expanded(
          child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
            decoration: BoxDecoration(
                color: ColorApps.white,
                borderRadius: BorderRadius.circular(ScreenUtil().setSp(5)),
                border:
                    Border.all(color: Colors.black.withOpacity(.5), width: .2)),
            child: StreamBuilder<ProvinceListState>(
                stream: areaBloc.getProvince,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.isLoading) {
                      return DropdownButton<AreaData>(
                        isExpanded: true,
                        onChanged: (val) {},
                        icon: Icon(Icons.keyboard_arrow_down),
                        hint: Container(
                          height: ScreenUtil().setHeight(14),
                          width: ScreenUtil().setWidth(56),
                          child: LoadingIndicator(
                            indicatorType: Indicator.ballPulse,
                            color: Colors.black.withOpacity(.5),
                          ),
                        ),
                        underline: Container(),
                        items: provinceList.map((data) {
                          return DropdownMenuItem(
                            child: new Text(data.province),
                            value: data,
                          );
                        }).toList(),
                      );
                    } else if (snapshot.data.hasError) {
                      onWidgetDidBuild(() {
                        if (snapshot.data.standby) {
                          showDialogMessage(context, "Gagal Mengambil Data",
                              "Terjadi Kesalahan, silahkan coba lagi.");
                          areaBloc.unStandBy();
                        }
                      });
                    } else if (snapshot.data.isSuccess) {
                      if (snapshot.data.standby) {
                        provinceList = snapshot.data.data.payload.rows;
                        setProvince();
                      }
                      areaBloc.unStandBy();
                    }
                  }
                  return DropdownButton<AreaData>(
                    isExpanded: true,
                    icon: Icon(Icons.keyboard_arrow_down),
                    hint: Text(
                      "Pilih Provinsi",
                      style: TextStyle(
                        color: Colors.black.withOpacity(.5),
                        fontWeight: FontWeight.normal,
                        fontSize: ScreenUtil().setSp(14),
                        fontFamily: Fonts.ubuntu,
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: ScreenUtil().setSp(14),
                      fontFamily: Fonts.ubuntu,
                    ),
                    value: province.province != null ? province : null,
                    underline: Container(),
                    onChanged: (val) {
                      setState(() {
                        province = val;
                        regency = new AreaData();
                        district = new AreaData();
                        village = new AreaData();
                        regencyList.clear();
                        districtList.clear();
                        villageList.clear();
                        areaBloc.requestGetRegency(
                            context, province.id.toString());
                      });
                    },
                    items: provinceList.map((data) {
                      return DropdownMenuItem(
                        child: new Text(data.province),
                        value: data,
                      );
                    }).toList(),
                  );
                }),
          ),
        )
      ],
    );
  }

  Widget RegencyDropDown() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(20)),
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: ColorApps.light,
                borderRadius: BorderRadius.circular(ScreenUtil().setSp(20))),
            height: ScreenUtil().setHeight(36),
            width: ScreenUtil().setWidth(36),
            alignment: Alignment.center,
            child: Text(
              '2.',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: ScreenUtil().setSp(14),
                fontFamily: Fonts.ubuntu,
              ),
            ),
          ),
          SizedBox(width: ScreenUtil().setWidth(16)),
          Expanded(
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
              decoration: BoxDecoration(
                  color: ColorApps.white,
                  borderRadius: BorderRadius.circular(ScreenUtil().setSp(5)),
                  border: Border.all(
                      color: Colors.black.withOpacity(.5), width: .2)),
              child: StreamBuilder<RegencyListState>(
                  stream: areaBloc.getRegency,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.isLoading) {
                        return DropdownButton<AreaData>(
                          isExpanded: true,
                          onChanged: (val) {},
                          icon: Icon(Icons.keyboard_arrow_down),
                          hint: Container(
                            height: ScreenUtil().setHeight(14),
                            width: ScreenUtil().setWidth(56),
                            child: LoadingIndicator(
                              indicatorType: Indicator.ballPulse,
                              color: Colors.black.withOpacity(.5),
                            ),
                          ),
                          underline: Container(),
                          items: regencyList.map((data) {
                            return DropdownMenuItem(
                              child: new Text(data.regency),
                              value: data,
                            );
                          }).toList(),
                        );
                      } else if (snapshot.data.hasError) {
                        onWidgetDidBuild(() {
                          if (snapshot.data.standby) {
                            showDialogMessage(context, "Gagal Mengambil Data",
                                "Terjadi Kesalahan, silahkan coba lagi.");
                            areaBloc.unStandBy();
                          }
                        });
                      } else if (snapshot.data.isSuccess) {
                        if (snapshot.data.standby) {
                          regencyList = snapshot.data.data.payload.rows;
                          setRegency();
                        }
                        areaBloc.unStandBy();
                      }
                    }
                    return DropdownButton<AreaData>(
                      isExpanded: true,
                      icon: Icon(Icons.keyboard_arrow_down),
                      hint: Text(
                        "Pilih Kabupaten / Kota",
                        style: TextStyle(
                          color: Colors.black.withOpacity(.5),
                          fontWeight: FontWeight.normal,
                          fontSize: ScreenUtil().setSp(14),
                          fontFamily: Fonts.ubuntu,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: ScreenUtil().setSp(14),
                        fontFamily: Fonts.ubuntu,
                      ),
                      value: regency.regency != null ? regency : null,
                      underline: Container(),
                      onChanged: (val) {
                        setState(() {
                          regency = val;
                          district = new AreaData();
                          village = new AreaData();
                          districtList.clear();
                          villageList.clear();
                          areaBloc.requestGetDistrict(context,
                              province.id.toString(), regency.id.toString());
                        });
                      },
                      items: regencyList.map((data) {
                        return DropdownMenuItem(
                          child: new Text(data.regency),
                          value: data,
                        );
                      }).toList(),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }

  Widget DistrictDropDown() {
    return Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: ColorApps.light,
              borderRadius: BorderRadius.circular(ScreenUtil().setSp(20))),
          height: ScreenUtil().setHeight(36),
          width: ScreenUtil().setWidth(36),
          alignment: Alignment.center,
          child: Text(
            '3.',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: ScreenUtil().setSp(14),
              fontFamily: Fonts.ubuntu,
            ),
          ),
        ),
        SizedBox(width: ScreenUtil().setWidth(16)),
        Expanded(
          child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
            decoration: BoxDecoration(
                color: ColorApps.white,
                borderRadius: BorderRadius.circular(ScreenUtil().setSp(5)),
                border:
                    Border.all(color: Colors.black.withOpacity(.5), width: .2)),
            child: StreamBuilder<DistrictListState>(
                stream: areaBloc.getDistrict,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.isLoading) {
                      return DropdownButton<AreaData>(
                        isExpanded: true,
                        onChanged: (val) {},
                        icon: Icon(Icons.keyboard_arrow_down),
                        hint: Container(
                          height: ScreenUtil().setHeight(14),
                          width: ScreenUtil().setWidth(56),
                          child: LoadingIndicator(
                            indicatorType: Indicator.ballPulse,
                            color: Colors.black.withOpacity(.5),
                          ),
                        ),
                        underline: Container(),
                        items: districtList.map((data) {
                          return DropdownMenuItem(
                            child: new Text(data.district),
                            value: data,
                          );
                        }).toList(),
                      );
                    } else if (snapshot.data.hasError) {
                      onWidgetDidBuild(() {
                        if (snapshot.data.standby) {
                          showDialogMessage(context, "Gagal Mengambil Data",
                              "Terjadi Kesalahan, silahkan coba lagi.");
                          areaBloc.unStandBy();
                        }
                      });
                    } else if (snapshot.data.isSuccess) {
                      if (snapshot.data.standby) {
                        districtList = snapshot.data.data.payload.rows;
                        setDistrict();
                      }
                      areaBloc.unStandBy();
                    }
                  }
                  return DropdownButton<AreaData>(
                    isExpanded: true,
                    icon: Icon(Icons.keyboard_arrow_down),
                    hint: Text(
                      "Pilih Kecamatan",
                      style: TextStyle(
                        color: Colors.black.withOpacity(.5),
                        fontWeight: FontWeight.normal,
                        fontSize: ScreenUtil().setSp(14),
                        fontFamily: Fonts.ubuntu,
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: ScreenUtil().setSp(14),
                      fontFamily: Fonts.ubuntu,
                    ),
                    value: district.district != null ? district : null,
                    underline: Container(),
                    onChanged: (val) {
                      setState(() {
                        district = val;
                        village = new AreaData();
                        villageList.clear();
                        areaBloc.requestGetVillage(
                            context,
                            province.id.toString(),
                            regency.id.toString(),
                            district.id.toString());
                      });
                    },
                    items: districtList.map((data) {
                      return DropdownMenuItem(
                        child: new Text(data.district),
                        value: data,
                      );
                    }).toList(),
                  );
                }),
          ),
        )
      ],
    );
  }

  Widget VillageDropDown() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(20)),
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: ColorApps.light,
                borderRadius: BorderRadius.circular(ScreenUtil().setSp(20))),
            height: ScreenUtil().setHeight(36),
            width: ScreenUtil().setWidth(36),
            alignment: Alignment.center,
            child: Text(
              '4.',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: ScreenUtil().setSp(14),
                fontFamily: Fonts.ubuntu,
              ),
            ),
          ),
          SizedBox(width: ScreenUtil().setWidth(16)),
          Expanded(
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
              decoration: BoxDecoration(
                  color: ColorApps.white,
                  borderRadius: BorderRadius.circular(ScreenUtil().setSp(5)),
                  border: Border.all(
                      color: Colors.black.withOpacity(.5), width: .2)),
              child: StreamBuilder<VillageListState>(
                  stream: areaBloc.getVillage,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.isLoading) {
                        return DropdownButton<AreaData>(
                          isExpanded: true,
                          onChanged: (val) {},
                          icon: Icon(Icons.keyboard_arrow_down),
                          hint: Container(
                            height: ScreenUtil().setHeight(14),
                            width: ScreenUtil().setWidth(56),
                            child: LoadingIndicator(
                              indicatorType: Indicator.ballPulse,
                              color: Colors.black.withOpacity(.5),
                            ),
                          ),
                          underline: Container(),
                          items: villageList.map((data) {
                            return DropdownMenuItem(
                              child: new Text(data.district),
                              value: data,
                            );
                          }).toList(),
                        );
                      } else if (snapshot.data.hasError) {
                        onWidgetDidBuild(() {
                          if (snapshot.data.standby) {
                            showDialogMessage(context, "Gagal Mengambil Data",
                                "Terjadi Kesalahan, silahkan coba lagi.");
                            areaBloc.unStandBy();
                          }
                        });
                      } else if (snapshot.data.isSuccess) {
                        if (snapshot.data.standby) {
                          villageList = snapshot.data.data.payload.rows;
                          setVillage();
                        }
                        areaBloc.unStandBy();
                      }
                    }
                    return DropdownButton<AreaData>(
                      isExpanded: true,
                      icon: Icon(Icons.keyboard_arrow_down),
                      hint: Text(
                        "Pilih Kelurahan",
                        style: TextStyle(
                          color: Colors.black.withOpacity(.5),
                          fontWeight: FontWeight.normal,
                          fontSize: ScreenUtil().setSp(14),
                          fontFamily: Fonts.ubuntu,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: ScreenUtil().setSp(14),
                        fontFamily: Fonts.ubuntu,
                      ),
                      value: village.village != null ? village : null,
                      underline: Container(),
                      onChanged: (val) {
                        setState(() {
                          village = val;
                        });
                      },
                      items: villageList.map((data) {
                        return DropdownMenuItem(
                          child: new Text(data.village),
                          value: data,
                        );
                      }).toList(),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }

  Widget ProfessionDropDown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
      decoration: BoxDecoration(
          color: ColorApps.white,
          borderRadius: BorderRadius.circular(ScreenUtil().setSp(5)),
          border: Border.all(color: Colors.black.withOpacity(.5), width: .2)),
      child: StreamBuilder<ProfessionListState>(
          stream: profileBloc.getProfessionList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isLoading) {
                return DropdownButton<Profession>(
                  isExpanded: true,
                  onChanged: (val) {},
                  icon: Icon(Icons.keyboard_arrow_down),
                  hint: Container(
                    height: ScreenUtil().setHeight(14),
                    width: ScreenUtil().setWidth(56),
                    child: LoadingIndicator(
                      indicatorType: Indicator.ballPulse,
                      color: Colors.black.withOpacity(.5),
                    ),
                  ),
                  underline: Container(),
                  items: professionList.map((data) {
                    return DropdownMenuItem(
                      child: new Text(data.profession),
                      value: data,
                    );
                  }).toList(),
                );
              } else if (snapshot.data.hasError) {
                onWidgetDidBuild(() {
                  if (snapshot.data.standby) {
                    showDialogMessage(context, "Gagal Mengambil Data",
                        "Terjadi Kesalahan, silahkan coba lagi.");
                    areaBloc.unStandBy();
                  }
                });
              } else if (snapshot.data.isSuccess) {
                if (snapshot.data.standby) {
                  professionList = snapshot.data.data.payload.rows;
                  setProfession();
                }
                profileBloc.unStandBy();
              }
            }
            return DropdownButton<Profession>(
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down),
              hint: Text(
                "Pilih Profesi",
                style: TextStyle(
                  color: Colors.black.withOpacity(.5),
                  fontWeight: FontWeight.normal,
                  fontSize: ScreenUtil().setSp(14),
                  fontFamily: Fonts.ubuntu,
                ),
              ),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: ScreenUtil().setSp(14),
                fontFamily: Fonts.ubuntu,
              ),
              value: profession.profession != null ? profession : null,
              underline: Container(),
              onChanged: (val) {
                setState(() {
                  profession = val;
                });
              },
              items: professionList.map((data) {
                return DropdownMenuItem(
                  child: new Text(data.profession),
                  value: data,
                );
              }).toList(),
            );
          }),
    );
  }

  void validateField(BuildContext context) {
    Keyboard().closeKeyboard(context);

    if (validateName(nameController.text) != null) {
      showDialogMessage(context, validateName(nameController.text),
          "Silahkan isi Kolom Nama dengan lengkap dan benar");
      return null;
    }
    if (validatePhone(phoneController.text) != null) {
      showDialogMessage(context, validatePhone(phoneController.text),
          "Silahkan isi Kolom Nomor HP dengan lengkap dan benar");
      return null;
    }
    if (validateEmail(emailController.text) != null) {
      showDialogMessage(context, validateEmail(emailController.text),
          "Silahkan isi email kamu dengan benar");
      return null;
    }
    if (aboutController.text.length < 3) {
      showDialogMessage(context, "Kolom Tentang Belum Benar",
          "Silahkan isi kolom tentang minimal 3 huruf");
      return null;
    }
    if (addressController.text.length < 3) {
      showDialogMessage(context, "Kolom Alamat Belum Benar",
          "Silahkan isi kolom alamat tempat tinggal minimal 3 huruf");
      return null;
    }
    if (province.province == null) {
      showDialogMessage(context, "Provinsi Belum Dipilih",
          "Silahkan pilih Provinsi tempat tinggal kamu");
      return null;
    }
    if (regency.regency == null) {
      showDialogMessage(context, "Kabupaten / Kota Belum Dipilih",
          "Silahkan pilih Kabupaten / Kota tempat tinggal kamu");
      return null;
    }
    if (district.district == null) {
      showDialogMessage(context, "Kecamatan Belum Dipilih",
          "Silahkan pilih Kecamatan tempat tinggal kamu");
      return null;
    }
    if (village.village == null) {
      showDialogMessage(context, "Kelurahan Belum Dipilih",
          "Silahkan pilih Kelurahan tempat tinggal kamu");
      return null;
    }
    if (profession.profession == null) {
      showDialogMessage(context, "Profesi Belum Dipilih",
          "Silahkan pilih Profesi tempat tinggal kamu");
      return null;
    }
    UpdateProfilePayload payload = new UpdateProfilePayload(
      name: nameController.text,
      phone: phoneController.text,
      email: emailController.text,
      about: aboutController.text,
      address: addressController.text,
      province: province.province,
      regency: regency.regency,
      district: district.district,
      village: village.village,
      profession: profession.profession,
      skills: "-",
    );

    profileBloc.requestUpdateProfile(context, payload);
  }
}
