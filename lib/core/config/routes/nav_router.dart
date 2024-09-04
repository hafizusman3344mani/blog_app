import 'package:flutter/material.dart';

class NavRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<dynamic> push(
    BuildContext context,
    Widget route, {
    dynamic arguments,
    bool bottomToTop = false,
  }) {
    return Navigator.push(
      context,
      MaterialPageRoute(
          fullscreenDialog: bottomToTop,
          builder: (context) => route,
          settings: RouteSettings(arguments: arguments)),
    );
  }

  static Future<void> pushReplacement(BuildContext context, Widget route,
      {dynamic argument, bool bottomToTop = false}) {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          fullscreenDialog: bottomToTop,
          builder: (context) => route,
          settings: RouteSettings(arguments: argument)),
    );
  }

  static Future pushReplacementUntil(BuildContext context, Widget route,
      {dynamic argument, bool bottomToTop = false}) {
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            fullscreenDialog: bottomToTop,
            builder: (context) => route,
            settings: RouteSettings(arguments: argument)),
        (Route<dynamic> route) => false);
  }

  static Future pushReplacementUntilFirst(BuildContext context, Widget route,
      {dynamic argument, bool bottomToTop = false}) {
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            fullscreenDialog: bottomToTop,
            builder: (context) => route,
            settings: RouteSettings(arguments: argument)),
        (Route<dynamic> route) => route.isFirst);
  }

  static void pop(BuildContext context, [dynamic result]) {
    Navigator.pop(context, result);
  }
}
