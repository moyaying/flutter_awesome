import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_awesome_app/pages/not_found_page.dart';

import 'route_handlers.dart';

class Routes {
  static const String root = "/";

  static const String todo_detail = '/todo/detail';
  static const String add_edit_todo = '/todo/add_edit';

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
      return NotFoundPage();
    });

    router.define(root, handler: rootHandler, transitionType: TransitionType.fadeIn);
    router.define(todo_detail, handler: todoDetailHandler, transitionType: TransitionType.inFromRight);
    router.define(add_edit_todo, handler: addEditTodoHandler, transitionType: TransitionType.inFromRight);
  }
}

class MyRouter extends Router {
  @override
  RouteMatch matchRoute(BuildContext buildContext, String path,
      {RouteSettings routeSettings,
      TransitionType transitionType,
      Duration transitionDuration = const Duration(milliseconds: 250),
      transitionsBuilder}) {
    RouteSettings settingsToUse = routeSettings;
    if (routeSettings == null) {
      settingsToUse = RouteSettings(name: path, arguments: Map());
    }
    return super.matchRoute(
      buildContext,
      path,
      routeSettings: settingsToUse,
      transitionType: transitionType,
      transitionDuration: transitionDuration,
      transitionsBuilder: transitionsBuilder,
    );
  }
}
