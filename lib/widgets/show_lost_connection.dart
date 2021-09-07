import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/api/messages_api.dart';
import 'package:uni_match/app/app_controller.dart';

import 'default_card_border.dart';

final _messagesApi = MessagesApi();
final AppController i18n = Modular.get();

class ShowDialogLostConnection extends StatelessWidget {


  const ShowDialogLostConnection();


  @override
  Widget build(BuildContext context) => AlertDialog(
    shape: defaultCardBorder(),
    title: Row(
      children: [
        Icon(
          Icons.info_outline,
          color: Colors.pink,
        ),
        SizedBox(width: 10),
        Expanded(child: Text(i18n.translate("Alert")!, style: TextStyle(fontSize: 22))),
      ],

    ),
    content: Padding(
      padding: const EdgeInsets.only(top:10),
      child: Text(
        i18n.translate("Check_your_internet_connection")!+'!',
        style: TextStyle(fontSize: 18),
      ),
    ),
    actions: [
      /// Negative button
      TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
          },
          child: Text(("OK"),
              style: TextStyle(fontSize: 18, color: Colors.pinkAccent))),
    ],
  );
}