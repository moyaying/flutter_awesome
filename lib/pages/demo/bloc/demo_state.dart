import 'package:meta/meta.dart';

@immutable
abstract class DemoState {}

class InitialDemoState extends DemoState {}

class PongState extends DemoState {}

class LoadingDataState extends DemoState {}
class LoadedDataState extends DemoState {}
class CancelledDataState extends DemoState {}
