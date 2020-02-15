import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_awesome_app/components/todos/bloc/bloc.dart';
import 'package:flutter_awesome_app/components/todos/todos_component.dart';
import 'package:flutter_awesome_app/config/application.dart';
import 'package:flutter_awesome_app/pages/todos/bloc/bloc.dart';
import 'package:flutter_awesome_app/pages/todos/widget/todo_list.dart';
import 'package:flutter_awesome_app/routes/routes.dart';
import 'package:flutter_awesome_app/widgets/fail_view.dart';
import 'package:flutter_awesome_app/widgets/loading_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'model.dart';
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
    return BlocBuilder<TodosPageBloc, TodosPageState>(builder: (BuildContext context, TodosPageState state) {
      VisibilityFilter activeFilter =
          (state is FilteredTodosLoadedPageState) ? state.activeFilter : VisibilityFilter.all;

      var allCompleted = true;
      if (state is FilteredTodosLoadedPageState) {
        for(var todo in state.todos) {
          if(todo.complete != true) {
            allCompleted = false;
          }
        }
      }

      return Scaffold(
        appBar: AppBar(
          title: Text('任务列表'),
          actions: [
            FilterButton(
                all: activeFilter == VisibilityFilter.all,
                completed: activeFilter == VisibilityFilter.completed,
                active: activeFilter == VisibilityFilter.active),
            ExtraActionsButton(
              allCompleted: allCompleted,
            )
          ],
        ),
        body: Builder(
          builder: (BuildContext context) {
            if (state is LoadingTodosPageState) {
              return LoadingView();
            } else if (state is LoadTodosFailPageState) {
              return FailView();
            } else if (state is FilteredTodosLoadedPageState) {
              return TodoList(todos: state.todos);
            } else {
              return Container();
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Application.router.navigateTo(context, Routes.add_edit_todo);
          },
        ),
      );
    });
  }
}
