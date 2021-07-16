import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/app_controller.dart';

import 'my_circular_progress.dart';

class Processing extends StatelessWidget {
  final String? text;

  const Processing({this.text});

  @override
  Widget build(BuildContext context) {
    AppController _i18n = Modular.get();

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          MyCircularProgress(),
          SizedBox(height: 10),
          Text(text ?? _i18n.translate("processing")!, style: TextStyle(fontSize: 18,
          fontWeight: FontWeight.w500)),
          SizedBox(height: 5),
          Text(_i18n.translate("please_wait")!, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
