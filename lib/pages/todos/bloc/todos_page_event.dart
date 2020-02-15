import 'package:flutter_awesome_app/pages/todos/model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TodosPageEvent {}

class UpdateFilterPageEvent extends TodosPageEvent {
  final VisibilityFilter filter;

  UpdateFilterPageEvent(this.filter);
}

class UpdateTodosPageEvent extends TodosPageEvent {}
