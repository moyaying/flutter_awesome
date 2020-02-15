import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_awesome_app/config/const.dart';
import 'package:key_value_store_flutter/key_value_store_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model.dart';
import './bloc.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final BuildContext context;

  SettingBloc({this.context});

  @override
  SettingState get initialState => InitialSettingState();

  @override
  Stream<SettingState> mapEventToState(SettingEvent event) async* {
    if (event is UpdateLanguageEvent) {
      _saveLanguage(event.languageModel);
      yield UpdateLanguageState(languageModel: event.languageModel);
    } else if (event is UpdateAreaEvent) {
      _saveAreaModel(event.areaModel);
      yield UpdateAreaState(areaModel: event.areaModel);
    }
  }

  Future<bool> _saveLanguage(LanguageModel languageModel) async {
    var modelStr = json.encode(languageModel.toJson());
    var sprf = await SharedPreferences.getInstance();
    return FlutterKeyValueStore(sprf).setString(PrefsKey.SETTING_LANGUAGE, modelStr);
  }

  Future<bool> _saveAreaModel(AreaModel areaModel) async {
    var modelStr = json.encode(areaModel.toJson());
    var sprf = await SharedPreferences.getInstance();
    return FlutterKeyValueStore(sprf).setString(PrefsKey.SETTING_AREA, modelStr);
  }
}
