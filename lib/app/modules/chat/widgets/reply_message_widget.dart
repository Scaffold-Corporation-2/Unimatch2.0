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
    child: Container(
      // width: MediaQuery.of(context).size.width*0.60,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              //color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
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
      Text(this.message, style: TextStyle(color: Colors.black)),
    ],
  );
}