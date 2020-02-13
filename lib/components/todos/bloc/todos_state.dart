import 'package:flutter_awesome_app/components/todos/entity/todo.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TodosState {}

class InitialTodosState extends TodosState {}

abstract class TodosListAwareState extends TodosState {
  final List<TodoEntity> todos;

  TodosListAwareState(this.todos);
}

//load todos
class LoadingTodosState extends TodosState {}

class LoadTodosSuccessState extends TodosListAwareState {
  LoadTodosSuccessState(List<TodoEntity> todos) : super(todos);
}

class LoadTodosFailState extends TodosState {
  final int code;
  final String message;

  LoadTodosFailState({this.code, this.message});
}

//remove todo_item
class RemovingTodoState extends TodosState {
  final String id;

  RemovingTodoState(this.id);
}

class RemoveTodoFailState extends TodosState {
  final int code;
  final String message;

  RemoveTodoFailState({this.code, this.message});
}

class RemoveTodoSuccessState extends TodosListAwareState {
  RemoveTodoSuccessState(List<TodoEntity> todos) : super(todos);
}

//update todo_item
class UpdatingTodoState extends TodosState {
  final TodoEntity entity;

  UpdatingTodoState(this.entity);
}

class UpdateTodoFailState extends TodosState {
  final int code;
  final String message;

  UpdateTodoFailState({this.code, this.message});
}

class UpdateTodoSuccessState extends TodosListAwareState {
  UpdateTodoSuccessState(List<TodoEntity> todos) : super(todos);
}

//add todo_item
class AddingTodoState extends TodosState {
  final TodoEntity entity;

  AddingTodoState(this.entity);
}

class AddTodoSuccessState extends TodosListAwareState {
  AddTodoSuccessState(List<TodoEntity> todos) : super(todos);
}

class AddTodoFailState extends TodosState {
  final int code;
  final String message;

  AddTodoFailState({this.code, this.message});
}
