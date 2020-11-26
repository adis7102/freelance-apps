import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soedja_freelance/old_ver/components/button.dart';
import 'package:soedja_freelance/old_ver/components/dialog.dart';
import 'package:soedja_freelance/old_ver/constants/assets.dart';
import 'package:soedja_freelance/old_ver/constants/strings.dart';
import 'package:soedja_freelance/old_ver/constants/urls.dart';
import 'package:soedja_freelance/old_ver/models/area.dart';
import 'package:soedja_freelance/old_ver/models/user.dart';
import 'package:soedja_freelance/old_ver/screens/dashboard/dashboard.dart';
import 'package:soedja_freelance/old_ver/screens/feeds/detail_screen.dart';
import 'package:soedja_freelance/old_ver/services/area.dart';
import 'package:soedja_freelance/old_ver/services/user.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';
import 'package:soedja_freelance/old_ver/utils/helpers.dart';
import 'package:soedja_freelance/old_ver/utils/keyboard.dart';
import 'package:soedja_freelance/old_ver/components/text_input.dart' as EditText;
import 'package:soedja_freelance/old_ver/components/text_input.dart';
import 'package:soedja_freelance/old_ver/utils/navigation.dart';

class ProfileInfoScreen extends StatefulWidget {
  final Profile profile;

  ProfileInfoScreen({
    this.profile,
  });

  @override
  State<StatefulWidget> createState() {
    return _ProfileInfoScreen();
  }
}

class _ProfileInfoScreen extends State<ProfileInfoScreen> {
  String phone = '';

  bool isEditable = false;
  bool isLoading = false;
  bool isEmailRegistered = false;

  // bool isPhoneRegistered = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController aboutController = TextEditingController();

  final FocusNode nameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();

  final formKey = GlobalKey<FormState>();
  bool validateError = false;

  List<Province> provinceList = new List<Province>();
  List<Regency> regencyList = new List<Regency>();
  List<District> districtList = new List<District>();
  List<Village> villageList = new List<Village>();
  List<Profession> professionList = new List<Profession>();

  bool isSelectedProvince = false;
  bool isSelectedRegency = false;
  bool isSelectedDistrict = false;
  bool isSelectedVillage = false;
  bool isSelectedProfession = false;

  Province provinceSelected = new Province();
  Regency regencySelected = new Regency();
  District districtSelected = new District();
  Village villageSelected = new Village();
  Profession professionSelected = new Profession();

  Profile profile = new Profile();
  File imgAvatar;

  void fetchProfile() {
    UserService().getProfile(context).then((value) async {
      setState(() {
        profile = value;
      });
      setProfile();
    });
  }

  void fetchProvince() async {
    AreaService().getProvince(context).then((response) {
      if (response.length > 0) {
        setState(() {
          provinceList.addAll(response);
        });
        if (profile.province.length > 0) {
          setProvince();
        }
      }
    });
  }

  void fetchRegency() async {
    AreaService()
        .getRegency(context, provinceSelected.id.toString())
        .then((response) {
      if (response.length > 0) {
        setState(() {
          regencyList.addAll(response);
        });

        if (profile.regency.length > 0) {
          setRegency();
        }
      }
    });
  }

  void fetchDistrict() async {
    AreaService()
        .getDistrict(context, provinceSelected.id.toString(),
            regencySelected.id.toString())
        .then((response) {
      if (response.length > 0) {
        setState(() {
          districtList.addAll(response);
        });

        if (profile.district.length > 0) {
          setDistrict();
        }
      }
    });
  }

  void fetchVillage() async {
    AreaService()
        .getVillage(context, provinceSelected.id.toString(),
            regencySelected.id.toString(), districtSelected.id.toString())
        .then((response) {
      if (response.length > 0) {
        setState(() {
          villageList.addAll(response);
        });

        if (profile.village.length > 0) {
          setVillage();
        }
      }
    });
  }

  void fetchProfession() async {
    UserService().getProfession(context).then((response) {
      if (response.length > 0) {
        setState(() {
          professionList.addAll(response);
        });
        if (profile.profession.length > 0) {
          setProfession();
        }
      }
    });
  }

  void setProvince() async {
    if (provinceList.length > 0) {
      for (int i = 0; i < provinceList.length; i++) {
        if (provinceList[i].province == profile.province) {
          setState(() {
            isSelectedProvince = true;
            provinceSelected = provinceList[i];
          });
        }
      }
    }
    if (provinceSelected.id != null) {
      fetchRegency();
    }
  }

  void setRegency() {
    if (regencyList.length > 0) {
      for (int i = 0; i < regencyList.length; i++) {
        if (regencyList[i].regency == profile.regency) {
          setState(() {
            isSelectedRegency = true;
            regencySelected = regencyList[i];
          });
        }
      }
    }
    if (regencySelected.id != null) {
      fetchDistrict();
    }
  }

  void setDistrict() {
    if (districtList.length > 0) {
      for (int i = 0; i < districtList.length; i++) {
        if (districtList[i].district == profile.district) {
          setState(() {
            isSelectedDistrict = true;
            districtSelected = districtList[i];
          });
        }
      }
    }

    if (districtSelected.id != null) {
      fetchVillage();
    }
  }

  void setVillage() {
    if (villageList.length > 0) {
      for (int i = 0; i < villageList.length; i++) {
        if (villageList[i].village == profile.village) {
          setState(() {
            isSelectedVillage = true;
            villageSelected = villageList[i];
          });
        }
      }
    }
  }

  void setProfession() {
    if (professionList.length > 0) {
      for (int i = 0; i < professionList.length; i++) {
        if (professionList[i].profession == profile.profession) {
          setState(() {
            isSelectedProfession = true;
            professionSelected = professionList[i];
          });
        }
      }
    }
  }

  void showConfirmation(String val) {
    if (profile.name != nameController.text) {
      showLeave(
        context: context,
        onPrimary: () {
          onChangeEditable();
          Navigation().navigateBack(context);
          val != 'edit' ? Navigation().navigateBack(context) : null;
        },
        onGhost: () => Navigation().navigateBack(context),
      );
    } else {
      val == 'edit' ? onChangeEditable() : Navigation().navigateBack(context);
    }
  }

  void onChangeEditable() {
    setState(() {
      isEditable = !isEditable;
      nameController.text = profile.name;
    });
  }

  void setProfile() {
    if (profile != null) {
      setState(() {
        nameController.text = profile.name;
        phoneController.text = profile.phone.substring(3, profile.phone.length);
        emailController.text = profile.email;
        phone = phoneController.text;
        aboutController.text = profile.about;
        addressController.text = profile.address;
      });
    }
  }

  void onChangePhone(String value) {
    String val = '';
    if (value.contains('+62')) {
      val = value.substring(3, value.length);
    } else if (value[0] == '0') {
      val = value.substring(1, value.length);
    } else {
      val = value;
    }

    setState(() {
      phone = val;
    });
  }

  void onUpdateProfile() {
    showLoading(context);

    UpdateProfilePayload payload = new UpdateProfilePayload(
      email: emailController.text,
      phone: '+62' + phone,
      name: nameController.text,
      address: addressController.text,
      province: provinceSelected.province,
      regency: regencySelected.regency,
      district: districtSelected.district,
      village: villageSelected.village,
      profession: professionSelected.profession,
      about: aboutController.text,
      skills: profile.skills,
    );

    UserService().updateProfile(context, payload).then((response) {
      if (response.userId != null) {
        if (imgAvatar != null) {
          uploadPicture();
        } else {
          Navigation().navigateReplacement(context, DashboardScreen(index: 4));
          showUpdateProfile(context: context);
        }
      }
    });
  }

  void uploadPicture() {
    UserService().updateAvatar(context, [imgAvatar]).then((response) {
      if (response) {
        Navigation().navigateReplacement(context, DashboardScreen(index: 4));
        showUpdateProfile(context: context);
      }
    });
  }

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
            toolbarColor: AppColors.primary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          title: 'Potong Gambar',
        ));
    if (croppedFile != null) {
      setState(() {
        imgAvatar = croppedFile;
      });
    }
  }

  @override
  void initState() {
    profile = widget.profile;
    fetchProfile();

    Future.delayed(
      const Duration(seconds: 1),
      () {
        fetchProvince();
        fetchProfession();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBarSection(),
      body: GestureDetector(
        onTap: () => Keyboard().closeKeyboard(context),
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              dividerText(
                padding:
                    EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Text(
                  Strings.profileScreenHeading,
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
              ),

              /// Informasi Diri
              Container(
                padding: EdgeInsets.all(24.0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          flex: 3,
                          child: Text(
                            Strings.photoProfile.toUpperCase(),
                            style: TextStyle(
                                color: AppColors.dark.withOpacity(.5),
                                fontSize: 10.0),
                          ),
                        ),
                        SizedBox(width: 24.0),
                        Flexible(
                          flex: 6,
                          child: Text(
                            Strings.fullName.toUpperCase(),
                            style: TextStyle(
                                color: AppColors.dark.withOpacity(.5),
                                fontSize: 10.0),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: <Widget>[
                        Flexible(
                          flex: 3,
                          child: ButtonPrimary(
                            onTap: isEditable ? () => _pickImage() : null,
                            buttonColor: AppColors.white,
                            borderRadius: BorderRadius.circular(35.0),
                            padding: EdgeInsets.all(0.0),
                            child: avatarAccount(
                              imgAvatar: profile.picture,
                              file: imgAvatar,
                              height: 64.0,
                              width: 64.0,
                              borderRadius: 32.0,
                            ),
                          ),
                        ),
                        SizedBox(width: 24.0),
                        Flexible(
                          flex: 10,
                          child: EditText.TextInput(
                            enabled: isEditable,
                            padding: EdgeInsets.all(16.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            props: TextInputProps(
                                controller: nameController,
                                hintText: Strings.hintFullName,
                                validator: validateEmpty,
                                keyboardType: TextInputType.text,
                                onFieldSubmitted: (val) {}),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      Strings.labelPhone.toUpperCase(),
                      style: TextStyle(
                          color: AppColors.dark.withOpacity(.5),
                          fontSize: 10.0),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: <Widget>[
                        Container(
                          height: 48.0,
                          width: 110.0,
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              bottomLeft: Radius.circular(4.0),
                            ),
                            color: AppColors.black,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Image.asset(
                                Assets.imgFlagIdn,
                                width: 18.0,
                                fit: BoxFit.fitWidth,
                              ),
                              Text(
                                '+62',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: EditText.TextInput(
                            padding: EdgeInsets.all(16.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(5.0))),
                            props: new TextInputProps(
                                hintText: Strings.hintPhone,
                                keyboardType: TextInputType.number,
                                validator: validatePhone,
                                focusNode: phoneFocus,
                                controller: phoneController,
                                onFieldSubmitted: (val) {}),
                            enabled: isEditable,
                            onChanged: (val) {
                              onChangePhone(val);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      Strings.emailAddress.toUpperCase(),
                      style: TextStyle(
                          color: AppColors.dark.withOpacity(.5),
                          fontSize: 10.0),
                    ),
                    SizedBox(height: 8.0),
                    EditText.TextInput(
                      enabled: isEditable,
                      padding: EdgeInsets.all(16.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      props: TextInputProps(
                          controller: emailController,
                          hintText: Strings.hintEmail,
                          validator: validateEmpty,
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (val) {}),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      Strings.about.toUpperCase(),
                      style: TextStyle(
                          color: AppColors.dark.withOpacity(.5),
                          fontSize: 10.0),
                    ),
                    SizedBox(height: 8.0),
                    EditText.TextInput(
                      enabled: isEditable,
                      minLines: 5,
                      maxLines: 5,
                      padding: EdgeInsets.all(16.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      props: TextInputProps(
                          controller: aboutController,
                          hintText: Strings.tellYourStory,
                          validator: validateEmpty,
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (val) {}),
                    ),
                  ],
                ),
              ),

              dividerText(
                padding:
                    EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Text(Strings.generalInfo,
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold)),
              ),

              /// Informasi Umum
              Container(
                padding: EdgeInsets.all(24.0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      Strings.fullAddressLabel.toUpperCase(),
                      style: TextStyle(
                          color: AppColors.dark.withOpacity(.5),
                          fontSize: 10.0),
                    ),
                    SizedBox(height: 8.0),
                    EditText.TextInput(
                      enabled: isEditable,
                      padding: EdgeInsets.all(16.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      props: TextInputProps(
                          controller: addressController,
                          hintText: Strings.fullAddressHint,
                          validator: validateEmpty,
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (val) {}),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      Strings.addressAdministration.toUpperCase(),
                      style: TextStyle(
                          color: AppColors.dark.withOpacity(.5),
                          fontSize: 10.0),
                    ),
                    SizedBox(height: 8.0),
                    Stack(
                      children: <Widget>[
                        Positioned(
                          top: 12.0,
                          bottom: 12.0,
                          left: 14.0,
                          child: Container(
                            width: 4.0,
                            color: AppColors.light,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 32.0,
                                  width: 32.0,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColors.light,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(16.0)),
                                  ),
                                  child: Text(
                                    '1.',
                                    style: TextStyle(
                                        color: AppColors.dark,
                                        fontSize: 12.0),
                                  ),
                                ),
                                SizedBox(width: 16.0),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 2.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        border: Border.all(
                                          color: isEditable
                                              ? AppColors.grey707070
                                              : AppColors.lighter,
                                        )),
                                    child: DropdownButton<Province>(
                                      isExpanded: true,
                                      hint: Text(
                                        isSelectedProvince
                                            ? provinceSelected.province
                                            : Strings.provinceHint,
                                        style: TextStyle(
                                            color: isEditable
                                                ? AppColors.grey707070
                                                : AppColors.lighter,
                                            fontSize: 15.0,
                                            fontFamily: Fonts.ubuntu),
                                      ),
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 15.0,
                                          fontFamily: Fonts.ubuntu),
                                      value: isSelectedProvince
                                          ? provinceSelected
                                          : null,
                                      underline: Container(),
                                      onChanged: isEditable &&
                                              provinceList.length > 0
                                          ? (val) {
                                              setState(() {
                                                isSelectedProvince = true;
                                                provinceSelected = val;

                                                isSelectedRegency = false;
                                                regencyList.clear();

                                                isSelectedDistrict = false;
                                                districtList.clear();

                                                isSelectedVillage = false;
                                                villageList.clear();
                                              });
                                              fetchRegency();
                                            }
                                          : null,
                                      items: provinceList.map((province) {
                                        return DropdownMenuItem(
                                          child: new Text(province.province),
                                          value: province,
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.0),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 32.0,
                                  width: 32.0,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColors.light,
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Text(
                                    '2.',
                                    style: TextStyle(
                                        color: AppColors.dark,
                                        fontSize: 12.0),
                                  ),
                                ),
                                SizedBox(width: 16.0),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 2.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        border: Border.all(
                                          color: isEditable
                                              ? AppColors.grey707070
                                              : AppColors.lighter,
                                        )),
                                    child: DropdownButton<Regency>(
                                      isExpanded: true,
                                      hint: Text(
                                        isSelectedRegency
                                            ? regencySelected.regency
                                            : Strings.regencyHint,
                                        style: TextStyle(
                                            color: isEditable
                                                ? AppColors.grey707070
                                                : AppColors.lighter,
                                            fontSize: 15.0,
                                            fontFamily: Fonts.ubuntu),
                                      ),
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 15.0,
                                          fontFamily: Fonts.ubuntu),
                                      value: isSelectedRegency
                                          ? regencySelected
                                          : null,
                                      underline: Container(),
                                      onChanged: isEditable &&
                                              regencyList.length > 0
                                          ? (val) {
                                              setState(() {
                                                isSelectedRegency = true;
                                                regencySelected = val;

                                                isSelectedDistrict = false;
                                                districtList.clear();

                                                isSelectedVillage = false;
                                                villageList.clear();
                                              });
                                              fetchDistrict();
                                            }
                                          : null,
                                      items: regencyList.map((regency) {
                                        return DropdownMenuItem(
                                          child: new Text(regency.regency),
                                          value: regency,
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.0),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 32.0,
                                  width: 32.0,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColors.light,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(16.0)),
                                  ),
                                  child: Text(
                                    '3.',
                                    style: TextStyle(
                                        color: AppColors.dark,
                                        fontSize: 12.0),
                                  ),
                                ),
                                SizedBox(width: 16.0),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 2.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        border: Border.all(
                                          color: isEditable
                                              ? AppColors.grey707070
                                              : AppColors.lighter,
                                        )),
                                    child: DropdownButton<District>(
                                      isExpanded: true,
                                      hint: Text(
                                        isSelectedDistrict
                                            ? districtSelected.district
                                            : Strings.districtHint,
                                        style: TextStyle(
                                            color: isEditable
                                                ? AppColors.grey707070
                                                : AppColors.lighter,
                                            fontSize: 15.0,
                                            fontFamily: Fonts.ubuntu),
                                      ),
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 15.0,
                                          fontFamily: Fonts.ubuntu),
                                      value: isSelectedDistrict
                                          ? districtSelected
                                          : null,
                                      underline: Container(),
                                      onChanged: isEditable &&
                                              districtList.length > 0
                                          ? (val) {
                                              setState(() {
                                                isSelectedDistrict = true;
                                                districtSelected = val;

                                                isSelectedVillage = false;
                                                villageList.clear();
                                              });
                                              fetchVillage();
                                            }
                                          : null,
                                      items: districtList.map((district) {
                                        return DropdownMenuItem(
                                          child: new Text(district.district),
                                          value: district,
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.0),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 32.0,
                                  width: 32.0,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColors.light,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(16.0)),
                                  ),
                                  child: Text(
                                    '4.',
                                    style: TextStyle(
                                        color: AppColors.dark,
                                        fontSize: 12.0),
                                  ),
                                ),
                                SizedBox(width: 16.0),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 2.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        border: Border.all(
                                          color: isEditable
                                              ? AppColors.grey707070
                                              : AppColors.lighter,
                                        )),
                                    child: DropdownButton<Village>(
                                      isExpanded: true,
                                      hint: Text(
                                        isSelectedVillage
                                            ? villageSelected.village
                                            : Strings.villageHint,
                                        style: TextStyle(
                                            color: isEditable
                                                ? AppColors.grey707070
                                                : AppColors.lighter,
                                            fontSize: 15.0,
                                            fontFamily: Fonts.ubuntu),
                                      ),
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 15.0,
                                          fontFamily: Fonts.ubuntu),
                                      value: isSelectedVillage
                                          ? villageSelected
                                          : null,
                                      underline: Container(),
                                      onChanged:
                                          isEditable && villageList.length > 0
                                              ? (val) {
                                                  setState(() {
                                                    isSelectedVillage = true;
                                                    villageSelected = val;
                                                  });
                                                }
                                              : null,
                                      items: villageList.map((village) {
                                        return DropdownMenuItem(
                                          child: new Text(village.village),
                                          value: village,
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              dividerText(
                padding:
                    EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Text(
                  Strings.professionInfo,
                  style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                ),
              ),

              /// Informasi Profesi

              Padding(
                padding:
                    const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
                child: Text(
                  Strings.professionLabel.toUpperCase(),
                  style: TextStyle(
                      color: AppColors.dark.withOpacity(.5), fontSize: 10.0),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                margin: const EdgeInsets.only(
                    top: 8.0, left: 24.0, right: 24.0, bottom: 24.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    border: Border.all(
                      color: isEditable
                          ? AppColors.grey707070
                          : AppColors.lighter,
                    )),
                child: DropdownButton<Profession>(
                  isExpanded: true,
                  hint: Text(
                    isSelectedProfession
                        ? professionSelected.profession
                        : Strings.professionHint,
                    style: TextStyle(
                        color: isEditable
                            ? AppColors.grey707070
                            : AppColors.lighter,
                        fontSize: 15.0,
                        fontFamily: Fonts.ubuntu),
                  ),
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 15.0,
                      fontFamily: Fonts.ubuntu),
                  value: isSelectedProfession ? professionSelected : null,
                  underline: Container(),
                  onChanged: isEditable && professionList.length > 0
                      ? (val) {
                          setState(() {
                            isSelectedProfession = true;
                            professionSelected = val;
                          });
                        }
                      : null,
                  items: professionList.map((profession) {
                    return DropdownMenuItem(
                      child: new Text(profession.profession),
                      value: profession,
                    );
                  }).toList(),
                ),
              ),
              dividerColor(),

              Visibility(
                visible: isEditable,
                child: Container(
                  padding: EdgeInsets.all(24.0),
                  color: Colors.white,
                  child: ButtonPrimary(
                    height: 56.0,
                    child: Text(
                      Strings.save.toUpperCase(),
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: emailController.text.isNotEmpty &&
                            phone.length > 0 &&
                            nameController.text.isNotEmpty &&
                            addressController.text.isNotEmpty &&
                            isSelectedProvince &&
                            isSelectedRegency &&
                            isSelectedDistrict &&
                            isSelectedVillage &&
                            isSelectedProfession
                        ? () => onUpdateProfile()
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBarSection() {
    return AppBar(
      title: Text(
        Strings.myInformation,
        style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15.0),
      ),
      backgroundColor: AppColors.white,
      elevation: .5,
      leading: IconButton(
        onPressed: () => Navigation().navigateBack(context),
        icon: Icon(
          Icons.arrow_back_ios,
          color: AppColors.black,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => showConfirmation('edit'),
          icon: Icon(
            Icons.edit,
            color: isEditable ? AppColors.yellow : AppColors.black,
          ),
        ),
      ],
    );
  }

  Widget avatarAccount({
    String imgAvatar,
    File file,
    double height = 40.0,
    double width = 40.0,
    double borderRadius = 20.0,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 20.0),
        color: AppColors.light,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? 20.0),
        child: imgAvatar.length > 0
            ? FadeInImage.assetNetwork(
                placeholder: avatar(profile.name),
                image:
                    imgAvatar != null ? BaseUrl.SoedjaAPI + '/$imgAvatar' : '',
                width: width,
                height: height,
                fit: BoxFit.contain,
              )
            : file != null
                ? Image.file(
                    file,
                    width: width,
                    height: height,
                  )
                : Image.asset(
                    avatar(profile.name),
                    width: width,
                    height: height,
                  ),
      ),
    );
  }
}
