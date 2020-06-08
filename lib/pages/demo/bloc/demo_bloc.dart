import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class DemoBloc extends Bloc<DemoEvent, DemoState> {

  @override
  DemoState get initialState => InitialDemoState();

//  @override
//  Stream<DemoState> transformEvents(Stream<DemoEvent> events, Stream<DemoState> Function(DemoEvent) next) {
////    return super.transformEvents(events, next);
//    return events
////        .flatMap((event) {
////      print('xxx get event: $event');
////      if (event is CancelledDataState) {
////        print('xxx 11');
////        return Stream.value(event).asyncExpand(next);
////      } else {
////        print('xxx 22');
////        return Stream.value(event).switchMap(next);
////      }
////    })
////    .transform(streamTransformer)
////        .where((event) => event is LoadDataEvent)
////        .switchMap(next)
////        .where((event) => event is! LoadDataEvent)
////        .asyncExpand(next);
////    .asyncExpand((event) {
////      return next(event);
////    });
////    .flatMap(next);
////        .concatMap((event)  {
////          return next
////    })
//        .switchMap(next);
//  }

  @override
  Stream<Transition<DemoEvent, DemoState>> transformEvents(Stream<DemoEvent> events, transitionFn) {
    return events.asyncExpand((event) => transitionFn(event));
  }

  @override
  //this is the [next] fun of transformEvents second params.
  Stream<DemoState> mapEventToState(DemoEvent event) async* {
    if (event is PingEvent) {
      yield PongState();
    } else if (event is LoadDataEvent) {
      yield LoadingDataState();
      await Future.delayed(Duration(milliseconds: 2000));
      yield LoadedDataState();
    } else if (event is CancelLoadDataEvent) {
      yield CancelledDataState();
    }
  }
}
