import 'dart:convert';

import 'package:flutter_awesome_app/components/todos/entity/todo.dart';
import 'package:flutter_awesome_app/components/todos/repository/todos_repository.dart';
import 'package:key_value_store/key_value_store.dart';

class LocalTodosRepository implements TodosRepository {
  final String key;
  final KeyValueStore store;
  final JsonCodec codec;

  const LocalTodosRepository(this.key, this.store, [this.codec = json]);

  @override
  Future<List<TodoEntity>> loadTodos() async {
    var data = store.getString(key);
    if (data == null) {
      return [];
    }

    return codec
        .decode(store.getString(key))['todos']
        .cast<Map<String, Object>>()
        .map<TodoEntity>((value) => TodoEntity.fromJson(value))
        .toList(growable: false);
  }

  @override
  Future saveTodos(List<TodoEntity> todos) {
    return store.setString(
      key,
      codec.encode({
        'todos': todos.map((todo) => todo.toJson()).toList(),
      }),
    );
  }
}
