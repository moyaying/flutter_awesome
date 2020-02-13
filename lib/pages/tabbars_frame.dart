import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_awesome_app/pages/mine/mine.dart';
import 'package:flutter_awesome_app/pages/todos/todos.dart';

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
          BottomNavigationBarItem(title: Text('TODOS'), icon: Icon(Icons.home)),
          BottomNavigationBarItem(title: Text('我的'), icon: Icon(Icons.person)),
        ],
      ),
      body: _getTabView(_currentTabIndex),
    );
  }

  Widget _getTabView(int currentTabIndex) {
    return IndexedStack(
      index: currentTabIndex,
      children: <Widget>[
        TodosPage(),
        MinePage(),
      ],
    );
  }
}
