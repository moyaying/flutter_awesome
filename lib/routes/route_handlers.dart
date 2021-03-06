import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_awesome_app/config/keys.dart';
import 'package:flutter_awesome_app/pages/add_edit_todo/add_edit_todo.dart';
import 'package:flutter_awesome_app/pages/login/page/login_page.dart';
import 'package:flutter_awesome_app/pages/login/user_repository/user_repository.dart';
import 'package:flutter_awesome_app/pages/root_page_control/bloc/bloc.dart';
import 'package:flutter_awesome_app/pages/root_page_control/root_page_control.dart';
import 'package:flutter_awesome_app/pages/todo_detail/todo_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var rootHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//  return TabBarsFrame();
  return BlocProvider<RootPageControlBloc>(
    create: (context) => RootPageControlBloc(),
    child: RootPageControl(
      key: Keys.rootPageKey,
    ),
  );
});

//----------------
//todos
//----------------

//detail
var todoDetailHandler = Handler(handlerFunc: (context, params) {
  return TodoDetailPage(todoId: params['todoId']?.first);
});

//add_edit_todo
var addEditTodoHandler = Handler(handlerFunc: (context, params) {
  return AddEditTodoPage(todo: params['todo']?.first);
});

//var demoRouteHandler = Handler(
//    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//      String message = params["message"]?.first;
//      String colorHex = params["color_hex"]?.first;
//      String result = params["result"]?.first;
//      Color color = Color(0xFFFFFFFF);
//      if (colorHex != null && colorHex.length > 0) {
//        color = Color(ColorHelpers.fromHexString(colorHex));
//      }
//      return DemoSimpleComponent(message: message, color: color, result: result);
//    });
//
//var demoFunctionHandler = Handler(
//    type: HandlerType.function,
//    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//      String message = params["message"]?.first;
//      showDialog(
//        context: context,
//        builder: (context) {
//          return AlertDialog(
//            title: Text(
//              "Hey Hey!",
//              style: TextStyle(
//                color: const Color(0xFF00D6F7),
//                fontFamily: "Lazer84",
//                fontSize: 22.0,
//              ),
//            ),
//            content: Text("$message"),
//            actions: <Widget>[
//              Padding(
//                padding: EdgeInsets.only(bottom: 8.0, right: 8.0),
//                child: FlatButton(
//                  onPressed: () {
//                    Navigator.of(context).pop(true);
//                  },
//                  child: Text("OK"),
//                ),
//              ),
//            ],
//          );
//        },
//      );
//    });
//
///// Handles deep links into the app
///// To test on Android:
/////
///// `adb shell am start -W -a android.intent.action.VIEW -d "fluro://deeplink?path=/message&mesage=fluro%20rocks%21%21" com.theyakka.fluro`
//var deepLinkHandler = Handler(
//    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//      String colorHex = params["color_hex"]?.first;
//      String result = params["result"]?.first;
//      Color color = Color(0xFFFFFFFF);
//      if (colorHex != null && colorHex.length > 0) {
//        color = Color(ColorHelpers.fromHexString(colorHex));
//      }
//      return DemoSimpleComponent(
//          message: "DEEEEEP LINK!!!", color: color, result: result);
//    });
