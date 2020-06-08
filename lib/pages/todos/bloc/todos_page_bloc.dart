import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_awesome_app/components/todos/bloc/bloc.dart';
import 'package:flutter_awesome_app/components/todos/entity/todo.dart';
import '../model.dart';
import './bloc.dart';

class TodosPageBloc extends Bloc<TodosPageEvent, TodosPageState> {
  final TodosBloc todosBloc;

  StreamSubscription _todosSubscription;

  TodosPageBloc({@required this.todosBloc}) {
    _todosSubscription = todosBloc.listen((state) {
      if (state is TodosListAwareState) {
        add(UpdateTodosPageEvent());
      }
    });
  }

  @override
  TodosPageState get initialState {
    return todosBloc.state is TodosListAwareState
        ? FilteredTodosLoadedPageState(
            (todosBloc.state as TodosListAwareState).todos,
            VisibilityFilter.all,
          )
        : LoadingTodosPageState();
  }

  @override
  Stream<TodosPageState> mapEventToState(TodosPageEvent event) async* {
    if (event is UpdateFilterPageEvent) {
      yield* _mapUpdateFilterToState(event);
    } else if (event is UpdateTodosPageEvent) {
      yield* _mapTodosUpdatedToState(event);
    }
  }

  Stream<TodosPageState> _mapUpdateFilterToState(UpdateFilterPageEvent event) async* {
    if (todosBloc.state is TodosListAwareState) {
      yield FilteredTodosLoadedPageState(
        _mapTodosToFilteredTodos(
          (todosBloc.state as TodosListAwareState).todos,
          event.filter,
        ),
        event.filter,
      );
    }
  }

  Stream<TodosPageState> _mapTodosUpdatedToState(UpdateTodosPageEvent event) async* {
    final visibilityFilter = state is FilteredTodosLoadedPageState
        ? (state as FilteredTodosLoadedPageState).activeFilter
        : VisibilityFilter.all;
    if (todosBloc.state is TodosListAwareState) {
      yield FilteredTodosLoadedPageState(
        _mapTodosToFilteredTodos((todosBloc.state as TodosListAwareState).todos, visibilityFilter),
        visibilityFilter,
      );
    }
  }

  List<TodoEntity> _mapTodosToFilteredTodos(List<TodoEntity> todos, VisibilityFilter filter) {
    return todos.where((todo) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !todo.complete;
      } else {
        return todo.complete;
      }
    }).toList();
  }

  @override
  Future<void> close() {
    _todosSubscription.cancel();
    return super.close();
  }
}
