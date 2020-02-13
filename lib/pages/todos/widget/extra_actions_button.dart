// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';

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
          print('todo xxx all complete');
        } else if (action == ExtraAction.clearCompleted) {
          /// The View nor the Conttoller need not know what's involved.
          print('todo xxx clear completed tasks');
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<ExtraAction>>[
        PopupMenuItem<ExtraAction>(
          value: ExtraAction.toggleAllComplete,
          child: Text(allCompleted == true ? '标记全部完成' : '标记全部没完成'),
        ),
        PopupMenuItem<ExtraAction>(
          value: ExtraAction.clearCompleted,
          child: Text('清除已完成的任务'),
        ),
      ],
    );
  }
}
