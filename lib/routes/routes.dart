import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'route_handlers.dart';

class Routes {
  static const String root = "/";

  static const String todo_detail = '/todo/detail';
  static const String add_edit_todo = '/todo/add_edit';

  static const String login = '/login';

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
      return unknownPage();
    });

    router.define(root, handler: rootHandler, transitionType: TransitionType.fadeIn);
    router.define(todo_detail, handler: todoDetailHandler, transitionType: pushNewPageTransitionType);
    router.define(add_edit_todo, handler: addEditTodoHandler, transitionType: pushNewPageTransitionType);
  }

  static Widget unknownPage() => Scaffold(
      appBar: AppBar(
        title: Text('404'),
      ),
      body: Center(child: Text('page not found')));

  static TransitionType get pushNewPageTransitionType {
    if (Platform.isIOS) {
      return TransitionType.cupertino;
    } else {
      return TransitionType.inFromRight;
    }
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
    } else if (routeSettings.arguments == null) {
      settingsToUse = routeSettings.copyWith(arguments: Map());
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
