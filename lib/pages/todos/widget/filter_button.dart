// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';

import '../model.dart';

class FilterButton extends StatelessWidget {
  final bool activeAll;
  final bool activeUnCompleted;
  final bool activeCompleted;

  FilterButton({Key key, this.activeAll, this.activeCompleted, this.activeUnCompleted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//    var model = TodoListModel.of(context, rebuildOnChange: true);
    return PopupMenuButton<VisibilityFilter>(
      tooltip: '过滤任务',
      onSelected: (filter) {
        print('xxx TODO filter todos');
      },
      itemBuilder: (BuildContext context) => _items(context),
      icon: Icon(Icons.filter_list),
    );
  }

  List<PopupMenuItem<VisibilityFilter>> _items(BuildContext context) {
    final activeStyle = Theme.of(context).textTheme.body1.copyWith(color: Theme.of(context).accentColor);
    final defaultStyle = Theme.of(context).textTheme.body1;

    return [
      PopupMenuItem<VisibilityFilter>(
        value: VisibilityFilter.all,
        child: Text(
          '全部显示',
          style: activeAll ? activeStyle : defaultStyle,
        ),
      ),
      PopupMenuItem<VisibilityFilter>(
        value: VisibilityFilter.active,
        child: Text(
          '显示未完成的',
          style: activeUnCompleted ? activeStyle : defaultStyle,
        ),
      ),
      PopupMenuItem<VisibilityFilter>(
        value: VisibilityFilter.completed,
        child: Text(
          '显示已完成的',
          style: activeCompleted ? activeStyle : defaultStyle,
        ),
      ),
    ];
  }
}
