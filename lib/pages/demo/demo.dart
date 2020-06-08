import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_awesome_app/pages/demo/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DemoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DemoPageState();
  }
}

class DemoPageState extends State<DemoPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DemoBloc, DemoState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text('demo'),),
          body: Center(
            child: Column(
              children: <Widget>[
                Text('state: $state'),
                RaisedButton(
                    onPressed: () {
                      BlocProvider.of<DemoBloc>(context).add(PingEvent());
                    },
                    child: Text('ping')),
                RaisedButton(
                    onPressed: () {
                      BlocProvider.of<DemoBloc>(context).add(LoadDataEvent());
                    },
                    child: Text('load data')),
                RaisedButton(
                    onPressed: () {
                      BlocProvider.of<DemoBloc>(context).add(CancelLoadDataEvent());
                    },
                    child: Text('cancel')),
              ],
            ),
          ),
        );
      },
    );
  }
}
