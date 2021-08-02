import 'package:flutter/material.dart';

class ReplyConversationWidget extends StatelessWidget {
  final String message;
  final String userName;
  final bool userSend;
  final bool isImage;
  const ReplyConversationWidget({
    required this.message,
    required this.userName,
    required this.userSend,
    required this.isImage,

  });
  @override
  Widget build(BuildContext context) =>

      IntrinsicHeight(
    child: Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: userSend ?Colors.white70  :Colors.white54,
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
      child: Row(
        children: [
          Container(
            color: userSend ?Colors.pinkAccent  :Color (0xFF871F78),
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
    Text(this.message+'teste',
        style: TextStyle(color: Colors.black,
          fontWeight: FontWeight.bold,
      ),
        textAlign: TextAlign.start,
      )
    ],
  );
}