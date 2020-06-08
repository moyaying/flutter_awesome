// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

class S {
  S();
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return S();
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  String get page_not_found {
    return Intl.message(
      'page not found',
      name: 'page_not_found',
      desc: '',
      args: [],
    );
  }

  String get todos {
    return Intl.message(
      'TODOS',
      name: 'todos',
      desc: '',
      args: [],
    );
  }

  String get mainland_china {
    return Intl.message(
      'China mainland',
      name: 'mainland_china',
      desc: '',
      args: [],
    );
  }

  String get other_area {
    return Intl.message(
      'Other area',
      name: 'other_area',
      desc: '',
      args: [],
    );
  }

  String get area {
    return Intl.message(
      'Area',
      name: 'area',
      desc: '',
      args: [],
    );
  }

  String get person_setting {
    return Intl.message(
      'App Setting',
      name: 'person_setting',
      desc: '',
      args: [],
    );
  }

  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  String get what_region_use_app {
    return Intl.message(
      'What region use app',
      name: 'what_region_use_app',
      desc: '',
      args: [],
    );
  }

  String get enter_app {
    return Intl.message(
      'Enter APP',
      name: 'enter_app',
      desc: '',
      args: [],
    );
  }

  String get mine {
    return Intl.message(
      'Mine',
      name: 'mine',
      desc: '',
      args: [],
    );
  }

  String get tasks_list {
    return Intl.message(
      'tasks',
      name: 'tasks_list',
      desc: '',
      args: [],
    );
  }

  String get show_all {
    return Intl.message(
      'show all',
      name: 'show_all',
      desc: '',
      args: [],
    );
  }

  String get show_active {
    return Intl.message(
      'show active',
      name: 'show_active',
      desc: '',
      args: [],
    );
  }

  String get show_completed {
    return Intl.message(
      'show completed',
      name: 'show_completed',
      desc: '',
      args: [],
    );
  }

  String get mark_all_complete {
    return Intl.message(
      'mark all complete',
      name: 'mark_all_complete',
      desc: '',
      args: [],
    );
  }

  String get mark_all_active {
    return Intl.message(
      'mark all active',
      name: 'mark_all_active',
      desc: '',
      args: [],
    );
  }

  String get delete_all_completed {
    return Intl.message(
      'delete all completed',
      name: 'delete_all_completed',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}