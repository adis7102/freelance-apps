import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:soedja_freelance/old_ver/components/button.dart';
import 'package:soedja_freelance/old_ver/constants/assets.dart';
import 'package:soedja_freelance/old_ver/constants/strings.dart';
import 'package:soedja_freelance/old_ver/models/feeds.dart';
import 'package:soedja_freelance/old_ver/models/portfolio.dart';
import 'package:soedja_freelance/old_ver/models/user.dart';
import 'package:soedja_freelance/old_ver/screens/dashboard/dashboard.dart';
import 'package:soedja_freelance/old_ver/screens/feeds/detail_screen.dart';
import 'package:soedja_freelance/old_ver/screens/portfolio/create_screen.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';
// import 'package:soedja_freelance/old_ver/utils/helpers.dart';
import 'package:soedja_freelance/old_ver/utils/keyboard.dart';
import 'package:soedja_freelance/old_ver/utils/navigation.dart';
import 'package:soedja_freelance/revamp/modules/contact/bloc/contact_bloc.dart';
import 'package:soedja_freelance/revamp/modules/contact/bloc/contact_state.dart';
import 'package:soedja_freelance/revamp/modules/contact/models/contact_models.dart';
import 'package:soedja_freelance/revamp/modules/invoice/bloc/invoice_state.dart';
import 'package:soedja_freelance/revamp/modules/payment/components/payment_confirmation.dart';
import 'package:intl/intl.dart';
import 'package:soedja_freelance/revamp/modules/payment/components/payment_success.dart';
import '../../revamp/helpers/helper.dart';
import '../../revamp/modules/payment/bloc/payment_bloc.dart';
import '../../revamp/modules/payment/bloc/payment_state.dart';
import '../../revamp/modules/payment/components/payment_component.dart';
import '../../revamp/modules/portfolio/components/portfolio_components.dart';
import '../../revamp/modules/profile/models/profile_models.dart';

Future<dynamic> showLoading(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () => Navigation().navigateBack(context),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(5.0)),
                height: 100.0,
                width: 100.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    LottieBuilder.asset(
                      Lotties.loading,
                      height: 50.0,
                      width: 50.0,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      Strings.loading,
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
//        return SimpleDialog(
//          children: <Widget>[
//            LottieBuilder.asset(
//              Lotties.loading,
//              height: 100.0,
//              width: 100.0,
//            ),
//          ],
//        );
      });
}

void dismissDialog(BuildContext context) {
  return Navigation().navigateBack(context);
}

Future<dynamic> showPortfolio({
  BuildContext context,
  Portfolio item,
  String type = 'create',
}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: AppColors.black,
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 24.0),
            Align(
              alignment: Alignment.centerRight,
              child: ButtonPrimary(
                  width: 50.0,
                  height: 50.0,
                  context: context,
                  onTap: () => Navigation().navigateBack(context),
                  buttonColor: AppColors.black,
                  borderRadius: BorderRadius.circular(30.0),
                  padding: EdgeInsets.all(0),
                  child: Icon(
                    Icons.close,
                    color: AppColors.white,
                  )),
            ),
            LottieBuilder.asset(
              Lotties.successIcon,
              height: 170.0,
              repeat: false,
            ),
            Text(
              Strings.portfolio.toUpperCase(),
              style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0),
            ),
            SizedBox(height: 4.0),
            Text(
              type == 'create'
                  ? Strings.successCreateSubtitle
                  : Strings.successUpdateSubtitle,
              style: TextStyle(color: AppColors.white, fontSize: 20.0),
            ),
            Expanded(
              child: Container(),
            ),
            dividerLine(height: 32.0, color: AppColors.white),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    Strings.portfolioTitle + ' :',
                    style: TextStyle(color: AppColors.white, fontSize: 12.0),
                  ),
                ),
                SizedBox(
                  width: 32.0,
                ),
                Expanded(
                    flex: 2,
                    child: Text(
                      item.title,
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    Strings.portfolioType + ' :',
                    style: TextStyle(color: AppColors.white, fontSize: 12.0),
                  ),
                ),
                SizedBox(
                  width: 32.0,
                ),
                Expanded(
                    flex: 2,
                    child: Text(
                      item.typeCategory +
                          ' - ' +
                          item.subCategory +
                          ' - ' +
                          item.category,
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            dividerLine(height: 32.0, color: AppColors.white),
            Row(
              children: <Widget>[
                Text(
                  Strings.timeCreate + ' :',
                  style: TextStyle(
                      color: AppColors.white.withOpacity(.5), fontSize: 10.0),
                ),
                SizedBox(
                  width: 16.0,
                ),
                Expanded(
                    child: Text(
                  dateFormat(date: item.createdAt),
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: AppColors.white.withOpacity(.5), fontSize: 10.0),
                )),
              ],
            ),
            Expanded(child: SizedBox(height: 8.0)),
            ButtonPrimary(
                buttonColor: AppColors.black,
                border: Border.all(color: AppColors.white, width: 1.0),
                height: 50.0,
                onTap: () => createAgain(context),
                child: Text(
                  type == 'create'
                      ? Strings.createAgain.toUpperCase()
                      : Strings.createPortfolio.toUpperCase(),
                  style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                )),
            SizedBox(height: 8.0),
            ButtonPrimary(
                buttonColor: AppColors.black,
                height: 50.0,
                onTap: () => Navigation().navigateBack(context),
                child: Text(
                  Strings.backHome.toUpperCase(),
                  style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                )),
            SizedBox(height: 16.0),
          ],
        ),
      );
    },
  );
}

void createAgain(BuildContext context) {
  Navigation().navigateScreen(context, PortfolioCreateScreen());
}

Future<dynamic> showInterest(BuildContext context) {
  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: AppColors.black,
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 24.0),
            Align(
              alignment: Alignment.centerRight,
              child: ButtonPrimary(
                  width: 50.0,
                  height: 50.0,
                  context: context,
                  onTap: () => Navigation().navigateBack(context),
                  buttonColor: AppColors.black,
                  borderRadius: BorderRadius.circular(30.0),
                  padding: EdgeInsets.all(0),
                  child: Icon(
                    Icons.close,
                    color: AppColors.white,
                  )),
            ),
            LottieBuilder.asset(
              Lotties.successIcon,
              height: 170.0,
              repeat: false,
            ),
            Text(
              Strings.interest.toUpperCase(),
              style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0),
            ),
            SizedBox(height: 4.0),
            Text(
              Strings.successSubtitle,
              style: TextStyle(color: AppColors.white, fontSize: 20.0),
            ),
            Expanded(child: SizedBox(height: 8.0)),
            ButtonPrimary(
                buttonColor: AppColors.black,
                border: Border.all(color: AppColors.white, width: 1.0),
                height: 50.0,
                onTap: () => Navigation().navigateBack(context),
                child: Text(
                  Strings.back.toUpperCase(),
                  style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                )),
            SizedBox(height: 8.0),
            ButtonPrimary(
                buttonColor: AppColors.black,
                height: 50.0,
                onTap: () =>
                    Navigation().navigateScreen(context, DashboardScreen()),
                child: Text(
                  Strings.backHome.toUpperCase(),
                  style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                )),
            SizedBox(height: 16.0),
          ],
        ),
      );
    },
  );
}

showDialogNotification({
  BuildContext context,
  String title,
  String subtitle,
  Function onTap,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return MaterialApp(
        theme: ThemeData(
          primaryColor: AppColors.primary,
          buttonColor: AppColors.primary,
          bottomAppBarColor: AppColors.white,
          canvasColor: AppColors.white,
          fontFamily: Fonts.ubuntu,
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 20.0),
                margin: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        iconNotification,
                        GestureDetector(
                          onTap: () => Navigation().navigateBack(context),
                          child: Container(
                            child: Icon(
                              Icons.close,
                              color: AppColors.black,
                              size: 14.0,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 14.0),
                    Text(
                      title ?? '',
                      style: TextStyle(color: AppColors.black, fontSize: 12.0),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      subtitle ?? '',
                      style: TextStyle(
                          color: AppColors.grey707070, fontSize: 12.0),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => onTap ?? Navigation().navigateBack(context),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Row iconNotification = Row(
  children: <Widget>[
    Image.asset(
      Assets.imgNotification,
      height: 14.0,
      width: 14.0,
    ),
    SizedBox(
      width: 8.0,
    ),
    Text(
      Strings.soedjaNotification,
      style: TextStyle(fontSize: 10.0, color: AppColors.grey707070),
    ),
  ],
);

showSuccessSendOtp({
  BuildContext context,
  bool isTop = true,
}) {
  return showDialogNotification(
    context: context,
    title: Strings.otpSendEmailTitle,
    subtitle: Strings.otpSendEmailSubTitle,
  );
}

showConfirm({
  BuildContext context,
  String title,
  String subtitle,
  String labelPrimary,
  String labelGhost,
  String image,
  Function onPrimary,
  Function onGhost,
}) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return GestureDetector(
        onVerticalDragStart: (_) {},
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          padding: EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 12.0),
              Text(
                title,
                style: TextStyle(
                    color: AppColors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.0),
              Text(
                subtitle,
                style: TextStyle(
                    color: AppColors.dark.withOpacity(.7),
                    height: 1.5,
                    fontSize: 12.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ButtonPrimary(
                      height: 54.0,
                      buttonColor: AppColors.white,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(
                          color: AppColors.dark.withOpacity(.7), width: 1.0),
                      child: Text(
                        labelGhost.toUpperCase(),
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () => onGhost(),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: ButtonPrimary(
                      height: 56.0,
                      borderRadius: BorderRadius.zero,
                      buttonColor: AppColors.black,
                      child: Text(
                        labelPrimary.toUpperCase(),
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () => onPrimary(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

showLeave({
  BuildContext context,
  Function onPrimary,
  Function onGhost,
}) {
  return showConfirm(
    context: context,
    title: Strings.leaveTitle,
    subtitle: Strings.leaveSubtitle,
    labelPrimary: Strings.cancelLeave,
    labelGhost: Strings.leave,
    onPrimary: onPrimary,
    onGhost: onGhost,
  );
}

showSuccessResendOtp({
  BuildContext context,
  bool isTop = true,
}) {
  return showDialogNotification(
    context: context,
    title: Strings.otpResendEmailTitle,
    subtitle: Strings.otpResendEmailSubTitle,
  );
}

showLogout({
  BuildContext context,
  Function onPrimary,
  Function onGhost,
}) {
  return showConfirm(
    context: context,
    title: Strings.logoutTitle,
    subtitle: Strings.logoutSubtitle,
    labelPrimary: Strings.cancelLeave,
    labelGhost: Strings.leave,
    onPrimary: onPrimary,
    onGhost: onGhost,
  );
}

ShowConfirmNew({
  BuildContext context,
  String title,
  String subtitle,
  String labelPrimary,
  String labelGhost,
  String image,
  Function onPrimary,
  Function onGhost,
  bloc,
}) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      Size size = MediaQuery.of(context).size;
      return GestureDetector(
        onVerticalDragStart: (_) {},
        child: Container(
          height: MediaQuery.of(context).size.height / 2.2,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          padding: EdgeInsets.fromLTRB(20.0, 32.0, 20.0, 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Text(
                      title,
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 28.0),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(30)),
                      child: Text(
                        subtitle,
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: AppColors.dark.withOpacity(.7),
                            height: 1.5,
                            fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder<CreateInvoiceState>(
                  stream: bloc.postCreateInvoice,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.isLoading) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(15)),
                          child: FlatButtonLoading(
                              context: context,
                              size: size,
                              color: Colors.black,
                              margin: EdgeInsets.zero),
                        );
                      } else if (snapshot.data.hasError) {
                        onWidgetDidBuild(() {
                          if (snapshot.data.standby) {
                            showDialogMessage(context, snapshot.data.message,
                                "Terjadi Kesalahan, silahkan coba lagi.");
                            bloc.unStandBy();
                          }
                        });
                      } else if (snapshot.data.isSuccess) {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          SuccessCreateInvoice(
                            context: context,
                            title: 'INVOICE',
                            nominal: 0,
                          );
                        });
                        bloc.unStandBy();
                        // print(snapshot.data.data.payload.toJson().toString());
                      }
                    }
                    return Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(10)),
                          child: ButtonPrimary(
                            height: 56.0,
                            borderRadius: BorderRadius.circular(
                                ScreenUtil().setHeight(5)),
                            buttonColor: AppColors.black,
                            child: Text(
                              labelPrimary.toUpperCase(),
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () => onPrimary(),
                          ),
                        ),
                        Container(
                          child: ButtonPrimary(
                            height: 54.0,
                            buttonColor: Colors.transparent,
                            child: Text(
                              labelGhost.toUpperCase(),
                              style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () => onGhost(),
                          ),
                        ),
                      ],
                    );
                  })
            ],
          ),
        ),
      );
    },
  );
}

Future<dynamic> showUpdateProfile({
  BuildContext context,
  Profile profile,
}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: AppColors.black,
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 24.0),
            Align(
              alignment: Alignment.centerRight,
              child: ButtonPrimary(
                  width: 50.0,
                  height: 50.0,
                  context: context,
                  onTap: () => Navigation().navigateBack(context),
                  buttonColor: AppColors.black,
                  borderRadius: BorderRadius.circular(30.0),
                  padding: EdgeInsets.all(0),
                  child: Icon(
                    Icons.close,
                    color: AppColors.white,
                  )),
            ),
            LottieBuilder.asset(
              Lotties.successIcon,
              height: 170.0,
              repeat: false,
            ),
            Text(
              Strings.myInformation.toUpperCase(),
              style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0),
            ),
            SizedBox(height: 4.0),
            Text(
              Strings.successUpdateSubtitle,
              style: TextStyle(color: AppColors.white, fontSize: 20.0),
            ),
            Expanded(
              child: Container(),
            ),
            dividerLine(height: 32.0, color: AppColors.white),
            Expanded(child: SizedBox(height: 8.0)),
            ButtonPrimary(
                buttonColor: AppColors.black,
                border: Border.all(color: AppColors.white, width: 1.0),
                height: 50.0,
                onTap: () => Navigation().navigateBack(context),
                child: Text(
                  Strings.back.toUpperCase(),
                  style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                )),
            SizedBox(height: 8.0),
            ButtonPrimary(
                buttonColor: AppColors.black,
                height: 50.0,
                onTap: () => Navigation().navigateReplacement(
                    context,
                    DashboardScreen(
                      index: 4,
                    )),
                child: Text(
                  Strings.backHome.toUpperCase(),
                  style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                )),
            SizedBox(height: 16.0),
          ],
        ),
      );
    },
  );
}

showNotifications({
  @required BuildContext context,
  @required String title,
  @required String description,
  Function onClose,
}) {
  showGeneralDialog(
          barrierColor: null,
          transitionBuilder: (context, a1, a2, widget) {
            final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
            return Transform(
              transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
              child: Opacity(
                opacity: a1.value,
                child: Dialog(
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.black.withOpacity(.2),
                            blurRadius: 5,
                            offset: Offset(0.0, 4.0))
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image.asset(
                              Assets.imgLogoOnly,
                              height: 15,
                              width: 15,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              Strings.soedjaNotification,
                              style: TextStyle(
                                  color: AppColors.grey9F9F9F, fontSize: 10.0),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            ButtonPrimary(
                                padding: EdgeInsets.all(2.0),
                                buttonColor: AppColors.white,
                                onTap: () {
                                  onClose();
                                  Navigation().navigateBack(context);
                                },
                                child: Icon(
                                  Icons.close,
                                  size: 13,
                                )),
                          ],
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          title,
                          style:
                              TextStyle(color: AppColors.dark, fontSize: 15.0),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          description,
                          style: TextStyle(
                              color: AppColors.grey9F9F9F, fontSize: 12.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          transitionDuration: Duration(milliseconds: 200),
          barrierDismissible: true,
          barrierLabel: '',
          context: context,
          pageBuilder: (context, animation1, animation2) {})
      .then((value) {
    onClose();
  });
}

const EdgeInsets _defaultInsetPadding =
    EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0);

class Dialog extends StatelessWidget {
  const Dialog({
    Key key,
    this.backgroundColor,
    this.elevation,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
    this.insetPadding = _defaultInsetPadding,
    this.clipBehavior = Clip.none,
    this.shape,
    this.child,
  })  : assert(clipBehavior != null),
        super(key: key);
  final Color backgroundColor;
  final double elevation;
  final Duration insetAnimationDuration;
  final Curve insetAnimationCurve;
  final EdgeInsets insetPadding;
  final Clip clipBehavior;
  final ShapeBorder shape;
  final Widget child;

  // TODO(johnsonmh): Update default dialog border radius to 4.0 to match material spec.
  static const RoundedRectangleBorder _defaultDialogShape =
      RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2.0)));
  static const double _defaultElevation = 24.0;

  @override
  Widget build(BuildContext context) {
    final DialogTheme dialogTheme = DialogTheme.of(context);
    final EdgeInsets effectivePadding = MediaQuery.of(context).viewInsets +
        (insetPadding ?? const EdgeInsets.all(0.0));
    return AnimatedPadding(
      padding: effectivePadding,
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeRight: true,
        removeTop: true,
        removeBottom: true,
        context: context,
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 280.0),
              child: Material(
                color: backgroundColor ??
                    dialogTheme.backgroundColor ??
                    Theme.of(context).dialogBackgroundColor,
                elevation:
                    elevation ?? dialogTheme.elevation ?? _defaultElevation,
                shape: shape ?? dialogTheme.shape ?? _defaultDialogShape,
                type: MaterialType.card,
                clipBehavior: clipBehavior,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
