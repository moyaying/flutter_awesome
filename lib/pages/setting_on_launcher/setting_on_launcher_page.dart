import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_awesome_app/components/setting/bloc/bloc.dart';
import 'package:flutter_awesome_app/components/setting/model.dart';
import 'package:flutter_awesome_app/components/setting/setting_component.dart';
import 'package:flutter_awesome_app/config/const.dart';
import 'package:flutter_awesome_app/generated/i18n.dart';
import 'package:flutter_awesome_app/pages/root_page_control/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../tabbars_frame.dart';

class SettingOnLauncherPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingOnLauncherPageState();
  }
}

class SettingOnLauncherPageState extends State<SettingOnLauncherPage> {
  AreaModel _currentArea;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentArea = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).person_setting),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  S.of(context).language,
                  style: TextStyle(fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: DropdownButton(
                    items: SupportedLanguage.all.map<DropdownMenuItem<LanguageModel>>(((language) {
                      return DropdownMenuItem<LanguageModel>(
                        value: language,
                        child: Text(
                          language.name,
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                      );
                    })).toList(),
                    onChanged: (value) {
                      BlocProvider.of<SettingBloc>(context).add(UpdateLanguageEvent(languageModel: value));
                    },
                    value: SettingInheritedModel.of(context, aspect: SettingAspect.language).languageModel,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 56, bottom: 16),
              child: Text(
                S.of(context).what_region_use_app,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
              ),
            ),
            ListView(
              shrinkWrap: true,
              children: SupportedArea.all(context).map((area) {
                if (area == SettingInheritedModel.of(context, aspect: SettingAspect.area).areaModel) {
                  _currentArea = area;
                }
                return RadioListTile<AreaModel>(
                  title: Text(
                    area.name,
                    style: TextStyle(fontSize: 16),
                  ),
                  value: area,
                  onChanged: (AreaModel value) {
                    BlocProvider.of<SettingBloc>(context).add(UpdateAreaEvent(areaModel: value));
                    _currentArea = value;
                  },
                  groupValue: SettingInheritedModel.of(context, aspect: SettingAspect.area).areaModel,
                );
              }).toList(),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40, left: 24.0, right: 24, bottom: 16),
                    child: Builder(
                      builder: (context) {
                        return OutlineButton(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                          textColor: Theme.of(context).primaryColor,
                          borderSide: BorderSide(color: Theme.of(context).primaryColor),
                          onPressed: () async {
                            if (_currentArea == null) {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                action: SnackBarAction(
                                  label: '关闭',
                                  onPressed: () {
                                    Scaffold.of(context).hideCurrentSnackBar();
                                  },
                                ),
                                content: Text('请选择地区'),
                              ));
                            } else {
                              var prefs = await SharedPreferences.getInstance();
                              await prefs.setBool(PrefsKey.FIRST_TIME_LAUNCHER_KEY, true);
                              BlocProvider.of<RootPageControlBloc>(context).add(SetRootPageEvent(page: TabBarsFrame()));
                            }
                          },
                          child: Text(S.of(context).enter_app),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
