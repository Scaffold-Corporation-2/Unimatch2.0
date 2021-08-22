import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ReplyMessageWidget extends StatelessWidget {
  final String message;
  final String otherUser;
  final VoidCallback onCancelReply;
  final bool isImage;
  const ReplyMessageWidget({
    required this.message,
    required this.otherUser,
    required  this.onCancelReply,
    required this.isImage,
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
  Widget buildReplyMessage() => SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              otherUser,
              style: GoogleFonts.nunito(fontWeight: FontWeight.bold,fontSize: 18,
              ),
              textAlign: TextAlign.start,
            ),
              GestureDetector(
                child: Icon(Icons.close, size: 16),
                onTap: onCancelReply,
              )
          ],
        ),
        const SizedBox(height: 4),
        isImage == false  ?

        Text(this.message, style: GoogleFonts.nunito(color: Colors.black,
        fontSize: 17),
        maxLines: 4,
        textAlign: TextAlign.start,
        ):
        Card(
          /// Image
          semanticContainer: true,
          margin: const EdgeInsets.all(0),
          color: Colors.grey.withAlpha(70),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            height: 70,
              width: 70,
              child: Image.network(message))),
      ],
    ),
  );
}