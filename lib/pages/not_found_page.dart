import 'package:flutter/material.dart';
import 'package:flutter_awesome_app/generated/l10n.dart';

class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('404'),
      ),
      body: Center(child: Text(S.of(context).page_not_found)),
    );
  }
}
