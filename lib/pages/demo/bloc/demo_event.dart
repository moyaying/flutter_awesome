import 'package:meta/meta.dart';

@immutable
abstract class DemoEvent {}

class PingEvent extends DemoEvent {}

class LoadDataEvent extends DemoEvent {}

class CancelLoadDataEvent extends DemoEvent {}
