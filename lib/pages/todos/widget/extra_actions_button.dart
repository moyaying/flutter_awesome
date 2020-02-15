// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_awesome_app/components/todos/bloc/bloc.dart';
import 'package:flutter_awesome_app/generated/i18n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model.dart';

class ExtraActionsButton extends StatelessWidget {
  final bool allCompleted;

  ExtraActionsButton({
    Key key,
    this.allCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ExtraAction>(
      onSelected: (action) {
        if (action == ExtraAction.toggleAllComplete) {
          if (allCompleted) {
            BlocProvider.of<TodosBloc>(context).add(UpdateAllTodosEvent(false));
          } else {
            BlocProvider.of<TodosBloc>(context).add(UpdateAllTodosEvent(true));
          }
        } else if (action == ExtraAction.clearCompleted) {
          /// The View nor the Conttoller need not know what's involved.
          BlocProvider.of<TodosBloc>(context).add(RemoveCompletedTodosEvent());
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<ExtraAction>>[
        PopupMenuItem<ExtraAction>(
          value: ExtraAction.toggleAllComplete,
          child: Text(allCompleted != true ? S.of(context).mark_all_complete : S.of(context).mark_all_active),
        ),
        PopupMenuItem<ExtraAction>(
          value: ExtraAction.clearCompleted,
          child: Text(S.of(context).delete_all_completed),
        ),
      ],
    );
  }
}
