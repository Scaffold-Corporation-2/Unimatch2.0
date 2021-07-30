import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uni_match/app/models/user_model.dart';
class ReplyConversationWidget extends StatelessWidget {
  final String message;
  final String userName;
  final bool userSend;

  const ReplyConversationWidget({
    required this.message,
    required this.userName,
    required this.userSend,

  });
  @override
  Widget build(BuildContext context) =>

      IntrinsicHeight(
    child: Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: userName.isEmpty ?Colors.white60  :Colors.white24,
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
      child: Row(
        children: [
          Container(
            color: userName.isEmpty ?Colors.pinkAccent  :Colors.white60,
            width: 4,
          ),
          const SizedBox(width: 8),
          Expanded(child: buildReplyMessage()),
        ],
      ),
    ),
  );
  Widget buildReplyMessage() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            userName,
            style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
        ],
      ),
      const SizedBox(height: 8),
      Text(this.message, style: TextStyle(color: Colors.black,
      fontSize: 17,
      ),
        textAlign: TextAlign.start,
      ),
    ],
  );
}