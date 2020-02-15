import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_awesome_app/components/todos/bloc/bloc.dart';
import 'package:flutter_awesome_app/components/todos/entity/todo.dart';
import 'package:flutter_awesome_app/components/todos/todos_component.dart';
import 'package:flutter_awesome_app/config/application.dart';
import 'package:flutter_awesome_app/routes/routes.dart';
import 'package:flutter_awesome_app/utils/fluro_convert_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app_core/todos_app_core.dart';

class TodoDetailPage extends StatefulWidget {
  final String todoId;

  TodoDetailPage({@required this.todoId});

  @override
  State<StatefulWidget> createState() {
    return _TodoDetailPageState();
  }
}

class _TodoDetailPageState extends State<TodoDetailPage> {
  TodoEntity _todo;

  @override
  Widget build(BuildContext context) {
    TodoEntity todo = TodosInheritedModel.of(context).getTodoById(widget.todoId);
    _todo = todo?? _todo;

    return Scaffold(
      appBar: AppBar(
        title: Text('任务详情'),
        actions: [
          IconButton(
            key: ArchSampleKeys.deleteTodoButton,
            tooltip: '删除任务',
            icon: Icon(Icons.delete),
            onPressed: () {
              BlocProvider.of<TodosBloc>(context).add(RemoveTodoEvent(_todo.id));
              Navigator.pop(context, _todo);
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Checkbox(
                    value: _todo?.complete == true,
                    key: ArchSampleKeys.detailsTodoItemCheckbox,
                    onChanged: (complete) {
                      _todo.complete = complete;
                      BlocProvider.of<TodosBloc>(context).add(UpdateTodoEvent(_todo));
                    },
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 8.0,
                          bottom: 16.0,
                        ),
                        child: Text(
                          _todo.task,
                          key: ArchSampleKeys.detailsTodoItemTask,
                          style: Theme.of(context).textTheme.headline,
                        ),
                      ),
                      Text(
                        _todo.note,
                        key: ArchSampleKeys.detailsTodoItemNote,
                        style: Theme.of(context).textTheme.subhead,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Edit Todo',
        child: Icon(Icons.edit),
        key: ArchSampleKeys.editTodoFab,
        onPressed: () {
          Application.router.navigateTo(context,
              Routes.add_edit_todo + '?todo=${FluroConvertUtils.fluroCnParamsEncode(json.encode(_todo.toJson()))}');
        },
      ),
    );
  }
}
