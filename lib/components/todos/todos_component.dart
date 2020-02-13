import 'package:flutter/widgets.dart';
import 'package:flutter_awesome_app/components/todos/bloc/bloc.dart';
import 'package:flutter_awesome_app/components/todos/entity/todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:key_value_store_flutter/key_value_store_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'repository/impl/local_todos_repository_impl.dart';

class TodoComponent extends StatelessWidget {
  final Widget child;

  TodoComponent({@required this.child});

  @override
  Widget build(BuildContext context) {
    return _TodosManager(child: child);
  }
}

class _TodosManager extends StatefulWidget {
  final Widget child;

  _TodosManager({@required this.child});

  @override
  State<StatefulWidget> createState() {
    return _TodosManagerState();
  }
}

class _TodosManagerState extends State<_TodosManager> {
  SharedPreferences _sharedPreferences;

  List<TodoEntity> _todos = [];
  List<TodoEntity> _initTodos = [
    TodoEntity(id: '1', note: '标记啦', task: '任务1', complete: false),
    TodoEntity(id: '2', note: '标记啦222', task: '任务2', complete: true),
  ];

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((sprf) {
      setState(() {
        _sharedPreferences = sprf;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_sharedPreferences != null) {
      return BlocProvider<TodosBloc>(
        create: (BuildContext context) => TodosBloc(
          repository: LocalTodosRepository('todos', FlutterKeyValueStore(_sharedPreferences)),
          seedValue: _initTodos,
        ),
        child: BlocBuilder<TodosBloc, TodosState>(
          builder: (BuildContext context, TodosState state) {
            print('xxx state $state');
            if (state is TodosListAwareState) {
              _todos = state.todos;
            }
            return TodosInheritedModel(
              todos: _todos,
              child: widget.child,
            );
          },
        ),
      );
    } else {
      return Container();
    }
  }
}

enum TodosAspect {
  todos,
}

///此类主要是存储todos数据，供其他地方直接使用
class TodosInheritedModel extends InheritedModel<TodosAspect> {
  final List<TodoEntity> todos;

  TodosInheritedModel({Widget child, this.todos}) : super(child: child);

  static TodosInheritedModel of(BuildContext context, {String aspect}) {
    return InheritedModel.inheritFrom<TodosInheritedModel>(context, aspect: aspect);
  }

  @override
  bool updateShouldNotify(TodosInheritedModel oldWidget) {
    return (todos != oldWidget.todos);
  }

  @override
  bool updateShouldNotifyDependent(TodosInheritedModel oldWidget, Set<TodosAspect> dependencies) {
    return (todos != oldWidget.todos && dependencies.contains(TodosAspect.todos));
  }
}
