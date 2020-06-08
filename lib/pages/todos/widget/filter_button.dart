// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_awesome_app/generated/l10n.dart';
import 'package:flutter_awesome_app/pages/todos/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model.dart';

class FilterButton extends StatelessWidget {
  final bool all;
  final bool active;
  final bool completed;

  FilterButton({Key key, this.all, this.completed, this.active}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//    var model = TodoListModel.of(context, rebuildOnChange: true);
    return PopupMenuButton<VisibilityFilter>(
      tooltip: '过滤任务',
      onSelected: (filter) {
        BlocProvider.of<TodosPageBloc>(context).add(UpdateFilterPageEvent(filter));
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
          S.of(context).show_all,
          style: all ? activeStyle : defaultStyle,
        ),
      ),
      PopupMenuItem<VisibilityFilter>(
        value: VisibilityFilter.active,
        child: Text(
          S.of(context).show_active,
          style: active ? activeStyle : defaultStyle,
        ),
      ),
      PopupMenuItem<VisibilityFilter>(
        value: VisibilityFilter.completed,
        child: Text(
          S.of(context).show_completed,
          style: completed ? activeStyle : defaultStyle,
        ),
      ),
    ];
  }
}
