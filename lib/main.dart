import 'package:flutter/material.dart';
import 'package:flutter_awesome_app/components/todos/todos_component.dart';
import 'package:flutter_awesome_app/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'components/setting/setting_component.dart';
import 'config/app_bloc_delegate.dart';
import 'config/application.dart';
import 'config/keys.dart';
import 'routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp() {
    var router = MyRouter();
    Routes.configureRoutes(router);
    Application.router = router;

    BlocSupervisor.delegate = AppBlocDelegate();
  }

  @override
  Widget build(BuildContext context) {
    return SettingComponent(
      child: TodoComponent(
        child: Builder(
          builder: (context) {
            return MaterialApp(
              key: Keys.materialAppKey,
              title: 'Flutter Awesome Demo',
              locale: SettingInheritedModel.of(context, aspect: SettingAspect.language)?.languageModel?.locale,
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
            );
          },
        ),
      ),
    );
  }
}
