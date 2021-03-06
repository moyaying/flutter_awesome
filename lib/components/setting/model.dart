import 'dart:ui';
import 'package:flutter_awesome_app/generated/l10n.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'model.g.dart';

@JsonSerializable()
class AreaModel extends Equatable {
  final String id;
  final String name;

  AreaModel({this.id, this.name});

  @override
  List<Object> get props => [id, name];

  Map<String, Object> toJson() => _$AreaModelToJson(this);

  factory AreaModel.fromJson(Map<String, Object> json) => _$AreaModelFromJson(json);

  bool get isChinaMainland {
    return id == 'mainland_china_area';
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class LanguageModel extends Equatable {
  final Locale locale;
  final String name;

  LanguageModel({this.name, this.locale});

  @override
  List<Object> get props => [locale, name];

  Map<String, Object> toJson() {
    return <String, dynamic>{
      'name': name,
      'local': {'languageCode': locale?.languageCode, 'countryCode': locale?.countryCode}
    };
  }

  factory LanguageModel.fromJson(Map<String, Object> json) {
    var localMap = json['local'] as Map;
    return LanguageModel(
      name: json['name'] as String,
      locale: Locale(localMap['languageCode'], localMap['countryCode']),
    );
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class SupportedArea {
  static AreaModel defaultModel(BuildContext context) =>
      AreaModel(id: 'mainland_china_area', name: S.of(context).mainland_china);

  static List<AreaModel> all(BuildContext context) {
    return [
      AreaModel(id: 'mainland_china_area', name: S.of(context).mainland_china),
      AreaModel(id: 'other_area', name: S.of(context).other_area)
    ];
  }
}

class SupportedLanguage {
  static LanguageModel defaultLanguage(BuildContext context) {
    var systemLocale = Localizations.localeOf(context);
    var allLocales = all;
    for (var locale in allLocales) {
      if (locale.locale.languageCode == systemLocale.languageCode) {
        return locale;
      }
    }
    //default english
    return LanguageModel(name: 'English', locale: Locale('en'));
  }

  static List<LanguageModel> all = [
    LanguageModel(name: '简体中文', locale: Locale("zh", "CN")),
    LanguageModel(name: 'English', locale: Locale('en')),
  ];
}
