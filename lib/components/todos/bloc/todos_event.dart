import 'package:flutter_awesome_app/components/todos/entity/todo.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TodosEvent {}

class LoadTodosEvent extends TodosEvent {}

class RemoveTodoEvent extends TodosEvent {
  final String id;

  RemoveTodoEvent(this.id);
}

class UpdateTodoEvent extends TodosEvent {
  final TodoEntity entity;

  UpdateTodoEvent(this.entity);
}

class AddTodoEvent extends TodosEvent {
  final TodoEntity entity;

  AddTodoEvent(this.entity);
}
