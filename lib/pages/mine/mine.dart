import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_awesome_app/components/setting/setting_component.dart';
import 'package:flutter_awesome_app/generated/l10n.dart';
import 'package:flutter_awesome_app/pages/demo/bloc/bloc.dart';
import 'package:flutter_awesome_app/pages/demo/demo.dart';
import 'package:flutter_awesome_app/pages/root_page_control/bloc/bloc.dart';
import 'package:flutter_awesome_app/pages/setting_on_launcher/setting_on_launcher_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MinePageState();
  }
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).mine),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(S.of(context).language + ': ' + SettingInheritedModel.of(context).languageModel.name),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(S.of(context).area + ': ' + SettingInheritedModel.of(context).areaModel.name),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: RaisedButton(
                onPressed: () {
                  BlocProvider.of<RootPageControlBloc>(context).add(SetRootPageEvent(page: SettingOnLauncherPage()));
                },
                child: Text('App Reseting'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider(create: (context) => DemoBloc(), child: DemoPage())),
                  );
                },
                child: Text('lancher demo page'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
