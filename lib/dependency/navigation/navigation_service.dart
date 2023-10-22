import 'package:flutter/material.dart';

import 'navigator_routes.dart';

abstract class NavigationService {
  Future<dynamic> navigateTo(String routeName, {dynamic arguments});

  Future<dynamic> replaceWith(String routeName, {dynamic arguments});

  void pop();

  Future<dynamic> replaceUntil({required String routeName});
}

class NavigationServiceImpl extends NavigationService {
  final GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  @override
  void pop() => Navigator.pop(buildContext);

  @override
  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  @override
  Future<dynamic> replaceWith(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  @override
  Future replaceUntil({required String routeName, dynamic arguments}) async {
    return _navigationKey.currentState!.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: arguments);
  }
}
