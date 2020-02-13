import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_awesome_app/components/todos/repository/todos_repository.dart';
import 'package:flutter_awesome_app/components/todos/entity/todo.dart';
import './bloc.dart';

/// bloc 是业务中心，包含了数据和业务逻辑
class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodosRepository _repository;

  //业务数据
  List<TodoEntity> _todos;

  TodosBloc({@required TodosRepository repository, List<TodoEntity> seedValue})
      : _repository = repository,
        _todos = seedValue ?? [];

  @override
  TodosState get initialState => InitialTodosState();

  @override
  Stream<TodosState> mapEventToState(TodosEvent event) async* {
    if (event is LoadTodosEvent) {
      yield LoadingTodosState();
      try {
        var todos = await _repository.loadTodos();
        if (todos != null && todos.length > 0) {
          _todos = todos;
        }
        yield LoadTodosSuccessState(_todos);
      } catch (e) {
        print(e);
        yield LoadTodosFailState();
      }
    } else if (event is RemoveTodoEvent) {
      yield RemovingTodoState(event.id);

      try {
        _todos = List<TodoEntity>.unmodifiable(_todos.fold<List<TodoEntity>>(
          <TodoEntity>[],
          (prev, entity) {
            return event.id == entity.id ? prev : (prev..add(entity));
          },
        ));

        await _repository.saveTodos(_todos);

        yield RemoveTodoSuccessState(_todos);
      } catch (e) {
        print(e);
        yield RemoveTodoFailState();
      }
    } else if (event is UpdateTodoEvent) {
      yield UpdatingTodoState(event.entity);

      try {
        _todos = List<TodoEntity>.unmodifiable(_todos.fold<List<TodoEntity>>(
          <TodoEntity>[],
          (prev, entity) => prev..add(entity.id == event.entity.id ? event.entity : entity),
        ));

        await _repository.saveTodos(_todos);

        yield UpdateTodoSuccessState(_todos);
      } catch (e) {
        print(e);
        yield UpdateTodoFailState();
      }
    } else if (event is AddTodoEvent) {
      yield AddingTodoState(event.entity);

      try {
        _todos = [..._todos, event.entity];
        await _repository.saveTodos(_todos);

        yield AddTodoSuccessState(_todos);
      } catch (e) {
        print(e);
        yield AddTodoFailState();
      }
    }
  }
}
