import 'package:flutter/material.dart';

class Navigation {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState.pushNamed(routeName);
  }

//  Future<dynamic> navigateReplacement(String routeName) {
//    return navigatorKey.currentState.pushReplacementNamed(routeName);
//  }

  Future<dynamic> navigateRoute(BuildContext context, String routeName) {
    return Navigator.pushNamed(context, routeName);
  }

  Future<dynamic> navigateScreen(BuildContext context, Widget screen) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => screen));
  }

  Future<dynamic> navigateReplacement(BuildContext context, Widget screen) {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
      ModalRoute.withName(''),
    );
  }

  void navigateBack(BuildContext context) {
    Navigator.of(context).pop();
  }
}

class SlideNavigation extends PageRouteBuilder {
  final Widget page;
  SlideNavigation({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
  );
}