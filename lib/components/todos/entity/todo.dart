import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable()
class TodoEntity {
  bool complete;
  String id;
  String note;
  String task;

  TodoEntity({this.complete, this.id, this.note, this.task});

  Map<String, Object> toJson() => _$TodoEntityToJson(this);

  factory TodoEntity.fromJson(Map<String, Object> json) => _$TodoEntityFromJson(json);

  @override
  String toString() {
    return toJson().toString();
  }
}
