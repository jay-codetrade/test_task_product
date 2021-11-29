import 'package:flutter/material.dart';
import '../ui/add_product/add_product_screen.dart';
import '../ui/dashboard/dashboard_screen.dart';
import '../ui/auth/splash_screen.dart';

import 'constants/route_constants.dart';

class NavigationUtils {
  static Route<dynamic> generateRoute(RouteSettings? settings) {
    var args = settings!.arguments as Map<String, dynamic>?;
    switch (settings.name) {
      case routeSplash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case routeDashboard:
        return MaterialPageRoute(builder: (_) => DashBoardScreen());
      case routeAddProduct:
        return MaterialPageRoute(
            builder: (_) => AddProductScreen(
                  productList: args!["productList"],
                  pageType: args["pageType"],
              productModel: args["productModel"],
                ));
      default:
        return _errorRoute("Coming soon...");
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          appBar: AppBar(title: Text('Error')),
          body: Center(child: Text(message)));
    });
  }

  static void pushReplacement(BuildContext context, String routeName,
      {Object? arguments}) {
    Navigator.of(context).pushReplacementNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> push(BuildContext context, String routeName,
      {Object? arguments}) {
    return Navigator.of(context).pushNamed(routeName, arguments: arguments);
  }

  static void pop(BuildContext context, {dynamic args}) {
    Navigator.of(context).pop(args);
  }

  static Future<dynamic> pushAndRemoveUntil(
      BuildContext context, String routeName,
      {Object? arguments}) {
    return Navigator.of(context).pushNamedAndRemoveUntil(
        routeName, (route) => false,
        arguments: arguments);
  }

  static void popUntil(BuildContext context, String routeName,
      {Object? arguments}) {
    return Navigator.of(context).popUntil(
      ModalRoute.withName(routeName),
    );
  }
}
