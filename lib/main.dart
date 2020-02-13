import 'package:flutter/material.dart';
import 'package:flutter_awesome_app/components/todos/todos_component.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'config/application.dart';
import 'generated/i18n.dart';
import 'routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp() {
    var router = MyRouter();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return TodoComponent(
      child: MaterialApp(
        title: 'Flutter Awesome Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        navigatorObservers: [Application.routeObserver],
        onGenerateRoute: Application.router.generator,
      ),
    );
  }
}
