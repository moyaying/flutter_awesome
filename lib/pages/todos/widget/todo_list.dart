// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_awesome_app/components/todos/bloc/bloc.dart';
import 'package:flutter_awesome_app/components/todos/entity/todo.dart';
import 'package:flutter_awesome_app/config/application.dart';
import 'package:flutter_awesome_app/routes/routes.dart';
import 'package:flutter_awesome_app/utils/fluro_convert_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app_core/todos_app_core.dart';

import 'todo_item.dart';

class TodoList extends StatelessWidget {
  final List<TodoEntity> todos;

  TodoList({Key key, this.todos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildList();
  }

  Widget _buildList() {
    return ListView.builder(
      key: ArchSampleKeys.todoList,
      itemCount: todos?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        final todo = todos.elementAt(index);
        return TodoItem(
          todo: todo,
          onDismissed: (direction) {
            _removeTodo(context, todo);
          },
          onTap: () {
            Application.router
                .navigateTo(context, Routes.todo_detail + '?todoId=${todo.id}')
                .then((todo) {
              if (todo is TodoEntity) {
                _showUndoSnackbar(context, todo);
              }
            });
          },
          onCheckboxChanged: (complete) {
            todo.complete = complete;
            BlocProvider.of<TodosBloc>(context).add(UpdateTodoEvent(todo));
          },
        );
      },
    );
  }

  void _removeTodo(BuildContext context, TodoEntity todo) {
    BlocProvider.of<TodosBloc>(context).add(RemoveTodoEvent(todo.id));
    _showUndoSnackbar(context, todo);
  }

  void _showUndoSnackbar(BuildContext context, TodoEntity todo) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        key: ArchSampleKeys.snackbar,
        duration: Duration(seconds: 2),
        content: Text(
          '任务${todo.task}已经删除。',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        action: SnackBarAction(
          key: ArchSampleKeys.snackbarAction(todo.id),
          label: '撤销',
          onPressed: () {
            BlocProvider.of<TodosBloc>(context).add(AddTodoEvent(todo));
          },
        ),
      ),
    );
  }
}
