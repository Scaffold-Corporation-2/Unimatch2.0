import 'package:flutter/material.dart';
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
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
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
              otherUser,
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,
              ),
              textAlign: TextAlign.start,
            ),
          ),
            GestureDetector(
              child: Icon(Icons.close, size: 16),
              onTap: onCancelReply,
            )
        ],
      ),
      const SizedBox(height: 8),
      Text(this.message, style: TextStyle(color: Colors.black,
      fontSize: 18),
      textAlign: TextAlign.start,
      ),
    ],
  );
}