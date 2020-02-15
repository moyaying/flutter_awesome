import 'package:flutter_awesome_app/components/todos/entity/todo.dart';
import 'package:meta/meta.dart';

import '../model.dart';

@immutable
abstract class TodosPageState {}

class LoadingTodosPageState extends TodosPageState {}

class LoadTodosFailPageState extends TodosPageState {
  final int code;
  final String message;

  LoadTodosFailPageState({this.code, this.message});
}

class FilteredTodosLoadedPageState extends TodosPageState {
  final List<TodoEntity> todos;
  final VisibilityFilter activeFilter;

  FilteredTodosLoadedPageState(
    this.todos,
    this.activeFilter,
  );
}
