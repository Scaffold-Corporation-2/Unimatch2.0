

import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:uni_match/app/models/user_model.dart';
import 'package:uni_match/app/modules/chat/view/chat_screen.dart';
import 'package:uni_match/constants/constants.dart';
import 'package:uni_match/widgets/chat_message.dart';
import 'package:uni_match/widgets/my_circular_progress.dart';


class showMessages extends StatelessWidget {

  final Stream<QuerySnapshot> messages;
  showMessages({Key? key, required this.messages}) : super(key: key);

  //variables
  final replyMessage = '';

  //final
  final _messagesController = ScrollController();
  final focusNode = FocusNode();

  //Funcões
  void showKeyboard(BuildContext context){

    final focusScope = FocusScope.of(context);
    focusScope.requestFocus(FocusNode());
    Future.delayed(Duration.zero, ()=> focusScope.requestFocus(focusNode));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: messages,
        builder: (context, snapshot) {
          // Check data
          if (!snapshot.hasData)
            return MyCircularProgress();
          else {
            return ListView.builder(
                controller: _messagesController,
                reverse: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  // Get message list
                  final List<DocumentSnapshot> messages =
                  snapshot.data!.docs.reversed.toList();
                  // Get message doc map
                  final Map<dynamic, dynamic> msg = messages[index].data()! as Map;

                  /// Variables
                  bool isUserSender;
                  String userPhotoLink;

                  final bool isImage = msg[MESSAGE_TYPE] == 'image';
                  final String textMessage = msg[MESSAGE_TEXT];
                  final String? imageLink = msg[MESSAGE_IMG_LINK];
                  final String timeAgo =
                  timeago.format(msg[TIMESTAMP].toDate(), locale: 'pt_BR');
                  final ValueChanged<String> onSwipedMessage;


                  /// Check user id to get info
                  if (msg[USER_ID] == UserModel().user.userId) {
                    isUserSender = true;
                    userPhotoLink = UserModel().user.userProfilePhoto;
                  } else {
                    isUserSender = false;
                    userPhotoLink = UserModel().user.userProfilePhoto;
                  }

                  // Show chat bubble
                  return SwipeTo(
                    iconColor: Colors.transparent,
                    offsetDx: 0.2,

                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                      child:ChatMessage(
                        isUserSender: isUserSender,
                        isImage: isImage,
                        userPhotoLink: userPhotoLink,
                        textMessage: textMessage,
                        imageLink: imageLink,
                        timeAgo: timeAgo,
                      ),
                    ),
                    onRightSwipe: (){
                      print(textMessage);
                      if(window.viewInsets.bottom <= 0.0 ){
                        showKeyboard(context);
                      }
                      //replyToMessage(textMessage);
                      print("foco");
                    },
                  );
                });
          }
        });
  }
  // void replyToMessage(String message){
  //   replyMessage = message;
  //   print(replyMessage);
  // }
}
