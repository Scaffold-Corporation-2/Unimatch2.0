import 'package:flutter/material.dart';
import 'package:uni_match/app/models/user_model.dart';
import 'package:uni_match/app/datas/user.dart';
import 'package:uni_match/app/models/user_model.dart';
class ReplyMessageWidget extends StatelessWidget {
  final String message;
  final String otherUser;
  final VoidCallback onCancelReply;
  const ReplyMessageWidget({
    required this.message,
    required this.otherUser,
    required  this.onCancelReply,
  });

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
    child: Row(
      children: [
        Container(
          color: Colors.pinkAccent,
          width: 4,
        ),
        const SizedBox(width: 8),
        Expanded(child: buildReplyMessage()),
      ],
    ),
  );
  Widget buildReplyMessage() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Expanded(
            child: Text(
              '${otherUser}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
            GestureDetector(
              child: Icon(Icons.close, size: 16),
              onTap: onCancelReply,
            )
        ],
      ),
      const SizedBox(height: 8),
      Text(this.message, style: TextStyle(color: Colors.black54)),
    ],
  );
}