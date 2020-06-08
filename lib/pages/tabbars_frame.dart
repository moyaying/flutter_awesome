import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_awesome_app/components/todos/bloc/bloc.dart';
import 'package:flutter_awesome_app/generated/l10n.dart';
import 'package:flutter_awesome_app/pages/mine/mine.dart';
import 'package:flutter_awesome_app/pages/todos/bloc/bloc.dart';
import 'package:flutter_awesome_app/pages/todos/todos.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabBarsFrame extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TabBarsFrameState();
  }
}

class _TabBarsFrameState extends State<TabBarsFrame> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black38,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentTabIndex = index;
          });
        },
        currentIndex: _currentTabIndex,
        items: [
          BottomNavigationBarItem(title: Text(S.of(context).todos), icon: Icon(Icons.home)),
          BottomNavigationBarItem(title: Text(S.of(context).mine), icon: Icon(Icons.person)),
        ],
      ),
      body: _getTabView(_currentTabIndex),
    );
  }

  Widget _getTabView(int currentTabIndex) {
    return IndexedStack(
      index: currentTabIndex,
      children: <Widget>[
        BlocProvider<TodosPageBloc>(
          create: (context) => TodosPageBloc(todosBloc: BlocProvider.of<TodosBloc>(context)),
          child: TodosPage(),
        ),
        MinePage(),
      ],
    );
  }
}
