import 'package:flutter/widgets.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigationKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigationKey.currentState.pushNamed(routeName);
  }
}
