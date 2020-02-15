import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_awesome_app/components/setting/bloc/bloc.dart';
import 'package:flutter_awesome_app/components/setting/model.dart';
import 'package:flutter_awesome_app/config/const.dart';
import 'package:flutter_awesome_app/config/keys.dart';
import 'package:flutter_awesome_app/pages/setting_on_launcher/setting_on_launcher_page.dart';
import 'package:flutter_awesome_app/pages/tabbars_frame.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:key_value_store_flutter/key_value_store_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/bloc.dart';

class RootPageControl extends StatefulWidget {
  RootPageControl({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RootPageControlState();
  }
}

class _RootPageControlState extends State<RootPageControl> {
  @override
  void initState() {
    super.initState();

    _launchRootPage();
    _initSetting();
  }

  _initSetting() async {
    var sprf = await SharedPreferences.getInstance();
    var keyValueStore = FlutterKeyValueStore(sprf);
    var languageStr = keyValueStore.getString(PrefsKey.SETTING_LANGUAGE);
    if (languageStr != null) {
      var languageModel = LanguageModel.fromJson(json.decode(languageStr));
      BlocProvider.of<SettingBloc>(context).add(UpdateLanguageEvent(languageModel: languageModel));
    } else {
      var m = SupportedLanguage.defaultLanguage(context);
      BlocProvider.of<SettingBloc>(context).add(UpdateLanguageEvent(languageModel: m));
    }

    //hack..., flutter_bloc add two event simultaneously make state confusion???
    await Future.delayed(Duration(milliseconds: 100));
    var areaModelStr = keyValueStore.getString(PrefsKey.SETTING_AREA);
    if (areaModelStr != null) {
      var areaModel = AreaModel.fromJson(json.decode(areaModelStr));
      BlocProvider.of<SettingBloc>(context).add(UpdateAreaEvent(areaModel: areaModel));
    } else {
      BlocProvider.of<SettingBloc>(context).add(UpdateAreaEvent(areaModel: SupportedArea.defaultModel(context)));
    }
  }

  void _launchRootPage() async {
    var prefs = await SharedPreferences.getInstance();
    var keyValueStore = FlutterKeyValueStore(prefs);
    bool notFirstTimeLauncher = keyValueStore.getBool(PrefsKey.FIRST_TIME_LAUNCHER_KEY);
    if (notFirstTimeLauncher == true) {
//    if (false) {
      //launch dashboard
      BlocProvider.of<RootPageControlBloc>(context).add(SetRootPageEvent(page: TabBarsFrame()));
    } else {
      //launch setting
      BlocProvider.of<RootPageControlBloc>(context).add(SetRootPageEvent(page: SettingOnLauncherPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RootPageControlBloc, RootPageControlState>(
      builder: (ctx, state) {
        if (state is UpdateRootPageState) {
          return state.child;
        }
        return Scaffold();
      },
    );
  }
}
