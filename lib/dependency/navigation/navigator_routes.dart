import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_moments/dependency/get_it.dart';

import 'navigation_service.dart';

BuildContext buildContext = globalContext();

BuildContext globalContext() =>
    getItInstance<NavigationServiceImpl>().navigationKey.currentContext!;

void globalNavigateTo({required String route, dynamic arguments}) =>
    getItInstance<NavigationServiceImpl>()
        .navigateTo(route, arguments: arguments);

void globalReplaceWith({required String route, dynamic arguments}) =>
    getItInstance<NavigationServiceImpl>()
        .replaceWith(route, arguments: arguments);

void globalNavigateUntil({required String route, dynamic arguments}) =>
    getItInstance<NavigationServiceImpl>()
        .replaceUntil(routeName: route, arguments: arguments);

void globalPop() => getItInstance<NavigationServiceImpl>().pop();
