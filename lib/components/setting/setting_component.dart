import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_awesome_app/config/const.dart';
import 'package:flutter_awesome_app/config/keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:key_value_store_flutter/key_value_store_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/bloc.dart';
import 'model.dart';

class SettingComponent extends StatelessWidget {
  final Widget child;

  SettingComponent({@required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingBloc>(
      create: (ctx) => SettingBloc(),
      child: _SettingManager(child: child),
    );
  }
}

class _SettingManager extends StatefulWidget {
  final Widget child;

  _SettingManager({@required this.child});

  @override
  State<StatefulWidget> createState() {
    return _SettingManagerState();
  }
}

class _SettingManagerState extends State<_SettingManager> {
  LanguageModel languageModel;
  AreaModel areaModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        if (state is UpdateAreaState) {
          areaModel = state.areaModel;
        } else if (state is UpdateLanguageState) {
          languageModel = state.languageModel;
        }

        return SettingInheritedModel(
          areaModel: areaModel,
          languageModel: languageModel,
          child: widget.child,
        );
      },
    );
  }
}

enum SettingAspect { language, area, sign }

class SettingInheritedModel extends InheritedModel<SettingAspect> {
  final LanguageModel languageModel;
  final AreaModel areaModel;

  SettingInheritedModel({
    @required this.languageModel,
    @required this.areaModel,
    Key key,
    @required Widget child,
  }) : super(key: key, child: child);

  String get languageCode {
    return languageModel?.locale?.languageCode;
  }

  @override
  bool updateShouldNotify(SettingInheritedModel oldWidget) {
    return languageModel != oldWidget.languageModel || areaModel != oldWidget.areaModel;
  }

  static SettingInheritedModel of(BuildContext context, {SettingAspect aspect}) {
    return InheritedModel.inheritFrom<SettingInheritedModel>(context, aspect: aspect);
  }

  @override
  bool updateShouldNotifyDependent(SettingInheritedModel oldWidget, Set<SettingAspect> dependencies) {
    return (languageModel != oldWidget.languageModel && dependencies.contains(SettingAspect.language) ||
        areaModel != oldWidget.areaModel && dependencies.contains(SettingAspect.area));
  }
}
