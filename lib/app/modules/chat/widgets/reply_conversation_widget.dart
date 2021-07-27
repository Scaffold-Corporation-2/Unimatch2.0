import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uni_match/app/models/user_model.dart';
class ReplyConversationWidget extends StatelessWidget {
  final String message;
  final String otherUser;
  final bool userSend;

  const ReplyConversationWidget({
    required this.message,
    required this.otherUser,
    required this.userSend,

  });
  @override
  Widget build(BuildContext context) =>

      IntrinsicHeight(
    child: Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: otherUser.isEmpty ?Colors.white60  :Colors.white24,
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
      child: Row(
        children: [
          Container(
            color: otherUser.isEmpty ?Colors.pinkAccent  :Colors.white60,
            width: 4,
          ),
          const SizedBox(width: 8),
          Expanded(child: buildReplyMessage()),
        ],
      ),
    ),
  );
  Widget buildReplyMessage() => Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            userSend == true ? 'Eu': 'outra pessoa',
            style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold),
            textAlign: TextAlign.end,
          ),
        ],
      ),
      const SizedBox(height: 8),
      Text(this.message, style: TextStyle(color: Colors.black,
      fontSize: 17,
      ),
        textAlign: TextAlign.end,
      ),
    ],
  );
}