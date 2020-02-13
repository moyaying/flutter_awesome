import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_awesome_app/components/todos/bloc/bloc.dart';
import 'package:flutter_awesome_app/components/todos/todos_component.dart';
import 'package:flutter_awesome_app/pages/todos/widget/todo_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/extra_actions_button.dart';
import 'widget/filter_button.dart';

class TodosPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TodosPageState();
  }
}

class _TodosPageState extends State<TodosPage> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<TodosBloc>(context).add(LoadTodosEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('任务列表'),
        actions: [
          FilterButton(activeAll: true, activeCompleted: false, activeUnCompleted: false),
          ExtraActionsButton(
            allCompleted: false,
          )
        ],
      ),
      body: TodoList(
        todos: TodosInheritedModel.of(context).todos,
      ),
    );
  }
}
