import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/api/messages_api.dart';
import 'package:uni_match/app/app_controller.dart';

import 'default_card_border.dart';

final _messagesApi = MessagesApi();
final AppController i18n = Modular.get();

class ShowDialogUndoMatch extends StatelessWidget {
  final String userFullName;
  final String userId;

  const ShowDialogUndoMatch({
    required this.userFullName,
    required this.userId,
  });


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
        Expanded(child: Text(i18n.translate("Too_bad")!, style: TextStyle(fontSize: 22)))
      ],
    ),
    content: Text(
      userFullName +' '+ i18n.translate("deleted_the_match_with_you")!,
      style: TextStyle(fontSize: 18),
    ),
    actions: [
      /// Negative button
      TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            await _messagesApi.deleteChat(userId);
          },
          child: Text(("OK"),
              style: TextStyle(fontSize: 18, color: Colors.pinkAccent))),
    ],
  );
}
