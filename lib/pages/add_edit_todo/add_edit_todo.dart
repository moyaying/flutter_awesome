import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_awesome_app/components/todos/bloc/bloc.dart';
import 'package:flutter_awesome_app/components/todos/entity/todo.dart';
import 'package:flutter_awesome_app/utils/fluro_convert_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app_core/todos_app_core.dart';

class AddEditTodoPage extends StatefulWidget {
  final TodoEntity todoEntity;

  AddEditTodoPage({@required String todo})
      : todoEntity =
            todo != null ? TodoEntity.fromJson(json.decode(FluroConvertUtils.fluroCnParamsDecode(todo))) : null;

  @override
  State<StatefulWidget> createState() {
    return _AddEditTodoPageState();
  }
}

class _AddEditTodoPageState extends State<AddEditTodoPage> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _task;
  String _note;

  @override
  Widget build(BuildContext context) {
    final todo = widget.todoEntity ?? TodoEntity(id: 'todo_${DateTime.now().millisecondsSinceEpoch}', complete: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? '编辑任务' : '新加任务'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          autovalidate: false,
          onWillPop: () {
            return Future(() => true);
          },
          child: ListView(
            children: [
              TextFormField(
                initialValue: todo?.task ?? '',
                key: ArchSampleKeys.taskField,
                autofocus: isEditing ? false : true,
                style: Theme.of(context).textTheme.headline,
                decoration: InputDecoration(hintText: '需要完成什么任务？'),
                validator: (val) => val.trim().isEmpty ? '该项不能为空' : null,
                onSaved: (value) => _task = value,
              ),
              TextFormField(
                initialValue: todo?.note ?? '',
                key: ArchSampleKeys.noteField,
                maxLines: 10,
                style: Theme.of(context).textTheme.subhead,
                decoration: InputDecoration(
                  hintText: 'Additional Notes...',
                ),
                onSaved: (value) => _note = value,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: isEditing ? ArchSampleKeys.saveTodoFab : ArchSampleKeys.saveNewTodo,
        tooltip: isEditing ? 'Save changes' : 'Add Todo',
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          final form = formKey.currentState;
          if (form.validate()) {
            form.save();
            todo.task = _task;
            todo.note = _note;
            if (isEditing) {
              BlocProvider.of<TodosBloc>(context).add(UpdateTodoEvent(todo));
            } else {
              BlocProvider.of<TodosBloc>(context).add(AddTodoEvent(todo));
            }
            Navigator.pop(context, todo);
          }
        },
      ),
    );
  }

  bool get isEditing => widget.todoEntity != null;
}
