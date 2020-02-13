// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoEntity _$TodoEntityFromJson(Map<String, dynamic> json) {
  return TodoEntity(
    complete: json['complete'] as bool,
    id: json['id'] as String,
    note: json['note'] as String,
    task: json['task'] as String,
  );
}

Map<String, dynamic> _$TodoEntityToJson(TodoEntity instance) =>
    <String, dynamic>{
      'complete': instance.complete,
      'id': instance.id,
      'note': instance.note,
      'task': instance.task,
    };
