import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locazshopper/constants/route_paths.dart';
import 'package:locazshopper/ui/screens/home/home_screen.dart';
import 'package:locazshopper/ui/screens/place_order/place_order_screen.dart';
import 'package:locazshopper/ui/screens/product/product_screen.dart';
import 'package:locazshopper/ui/screens/sign_in/sign_in_screen.dart';
import 'package:locazshopper/ui/screens/splash/splash_screen.dart';
import 'package:locazshopper/ui/screens/user_orders/user_order_screen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.splashScreen:
        return CupertinoPageRoute(builder: (_) => SplashScreen());
        break;
      case RoutePaths.homeScreen:
        return CupertinoPageRoute(builder: (_) => HomeScreen());
        break;
      case RoutePaths.productScreen:
        String argument = settings.arguments;
        return CupertinoPageRoute(
            builder: (_) => ProductScreen(
                  documentId: argument,
                ));
        break;
      case RoutePaths.placeOrderScreen:
        final arguments = settings.arguments;
        return CupertinoPageRoute(
            builder: (_) => PlaceOrderScreen(
                  cartItemList: arguments,
                ));
        break;
      case RoutePaths.signInScreen:
        return CupertinoPageRoute(builder: (_) => SignInScreen());
        break;
      case RoutePaths.userOrdersScreen:
        return CupertinoPageRoute(builder: (_) => UserOrdersScreen());
        break;
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
