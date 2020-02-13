import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class TodosPageBloc extends Bloc<TodosPageEvent, TodosPageState> {
  @override
  TodosPageState get initialState => InitialTodosPageState();

  @override
  Stream<TodosPageState> mapEventToState(
    TodosPageEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
