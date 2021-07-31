import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:uni_match/app/api/likes_api.dart';
import 'package:uni_match/app/api/matches_api.dart';
import 'package:uni_match/app/api/messages_api.dart';
import 'package:uni_match/app/api/notifications_api.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/app/datas/user.dart';
import 'package:uni_match/app/models/user_model.dart';
import 'package:uni_match/app/modules/chat/store/chat_store.dart';
import 'package:uni_match/app/modules/chat/widgets/reply_message_widget.dart';
import 'package:uni_match/app/modules/profile/view/profile_screen.dart';
import 'package:uni_match/constants/constants.dart';
import 'package:uni_match/dialogs/common_dialogs.dart';
import 'package:uni_match/dialogs/progress_dialog.dart';
import 'package:uni_match/widgets/chat_message.dart';
import 'package:uni_match/widgets/image_source_sheet.dart';
import 'package:uni_match/widgets/my_circular_progress.dart';
import 'package:uni_match/widgets/svg_icon.dart';

class ChatScreen extends StatefulWidget {
  /// Get user object
  final Usuario user;

  ChatScreen({required this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends ModularState<ChatScreen, ChatStore> {
  // Variables
  final _textController = TextEditingController();
  final _messagesController = ScrollController();
  final _messagesApi = MessagesApi();
  final _matchesApi = MatchesApi();
  final _likesApi = LikesApi();
  final _notificationsApi = NotificationsApi();

  final focusNode = FocusNode();
  final String replyMessage = '';

  void dismissKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  void showKeyboard(BuildContext context) {
    final focusScope = FocusScope.of(context);
    focusScope.requestFocus(FocusNode());
    Future.delayed(Duration.zero, () => focusScope.requestFocus(focusNode));
  }

  late final VoidCallback onCancelReply;

  late bool sendFor = false;

  //
  late Stream<QuerySnapshot> _messages;
  bool _isComposing = false;
  AppController _i18n = Modular.get();
  late ProgressDialog _pr;

  void _scrollMessageList() {
    /// Scroll to button
    _messagesController.animateTo(0.0,
        duration: Duration(milliseconds: 500), curve: Curves.easeOut);
  }

  ///build of the ReplyMessage layout
  Widget buildReply() => ReplyMessageWidget(
        message: controller.replyMessage,
        otherUser: controller.comparationWhoSendM(
            UserModel().user.userFullname, widget.user.userFullname),
        onCancelReply: controller.cancelReply,
      );

  ///Comparação de quem enviou a mensagem
  // comparationWhoSendM(String userFullname) {
  //   if (controller.userSend == true) {
  //     return UserModel().user.userFullname;
  //   } else
  //     return
  //       widget.user.userFullname;
  // }
  ///Função para deixar a variavel de resposta vazia
  // void cancelReply() {
  //     controller.replyMessage = '';
  // }

  ///
  // void replyToMessage(String message, bool user) {
  //   setState(() {
  //     controller.replyMessage = message;
  //     sendFor = user;
  //     print(replyMessage);
  //   });
  // }

  /// Get image from camera / gallery
  Future<void> _getImage() async {
    await showModalBottomSheet(
        context: context,
        builder: (context) => ImageSourceSheet(
              onImageSelected: (image) async {
                if (image != null) {
                  await _sendMessage(
                      type: 'image',
                      imgFile: image,
                      replyText: controller.replyMessage,
                      userReplyMsg: controller.comparationWhoSendM(
                          UserModel().user.userFullname,
                          widget.user.userFullname));
                  // close modal
                  Navigator.of(context).pop();
                }
              },
            ));
  }

  // Send message
  Future<void> _sendMessage(
      {required String type,
      String? text,
      File? imgFile,
      required replyText,
      required userReplyMsg}) async {
    String textMsg = '';
    String imageUrl = '';

    // Check message type
    switch (type) {
      case 'text':
        textMsg = text!;
        break;

      case 'image':
        // Show processing dialog
        _pr.show(_i18n.translate("sending")!);

        /// Upload image file
        imageUrl = await UserModel().uploadFile(
            file: imgFile!,
            path: 'uploads/messages',
            userId: UserModel().user.userId);

        _pr.hide();
        break;
    }

    /// Save message for current user
    await _messagesApi.saveMessage(
        type: type,
        fromUserId: UserModel().user.userId,
        senderId: UserModel().user.userId,
        receiverId: widget.user.userId,
        userPhotoLink: widget.user.userProfilePhoto, // other user photo
        userFullName: widget.user.userFullname, // other user ful name
        textMsg: textMsg,
        imgLink: imageUrl,
        replyMsg: replyText,
        userReplyMsg: userReplyMsg,
        isRead: true);

    /// Save copy message for receiver
    await _messagesApi.saveMessage(
        type: type,
        fromUserId: UserModel().user.userId,
        senderId: widget.user.userId,
        receiverId: UserModel().user.userId,
        userPhotoLink: UserModel().user.userProfilePhoto, // current user photo
        userFullName: UserModel().user.userFullname, // current user ful name
        textMsg: textMsg,
        replyMsg: replyText,
        imgLink: imageUrl,
        userReplyMsg: userReplyMsg,
        isRead: false);

    /// Send push notification
    await _notificationsApi.sendPushNotification(
        nTitle: APP_NAME,
        nBody: '${UserModel().user.userFullname}, '
            '${_i18n.translate("sent_a_message_to_you")}',
        nType: 'message',
        nSenderId: UserModel().user.userId,
        nUserDeviceToken: widget.user.userDeviceToken);
  }

  @override
  void initState() {
    super.initState();
    _messages = _messagesApi.getMessages(widget.user.userId);
  }

  @override
  void dispose() {
    _messages.drain();
    _textController.dispose();
    _messagesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Initialization
    _pr = ProgressDialog(context);

    return Scaffold(
      ///AppBar.
      appBar: AppBar(
        // Show User profile info
        title: GestureDetector(
          child: ListTile(
            contentPadding: const EdgeInsets.only(left: 0),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.user.userProfilePhoto),
            ),
            title:
                Text(widget.user.userFullname, style: TextStyle(fontSize: 18)),
          ),
          onTap: () {
            /// Go to profile screen
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ProfileScreen(user: widget.user, showButtons: false)));
          },
        ),
        actions: <Widget>[
          /// Actions list
          PopupMenuButton<String>(
            initialValue: "",
            itemBuilder: (context) => <PopupMenuEntry<String>>[
              /// Delete Chat
              PopupMenuItem(
                  value: "delete_chat",
                  child: Row(
                    children: <Widget>[
                      SvgIcon("assets/icons/trash_icon.svg",
                          width: 20,
                          height: 20,
                          color: Theme.of(context).primaryColor),
                      SizedBox(width: 5),
                      Text(_i18n.translate("delete_conversation")!),
                    ],
                  )),

              /// Delete Match
              PopupMenuItem(
                  value: "delete_match",
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.highlight_off,
                          color: Theme.of(context).primaryColor),
                      SizedBox(width: 5),
                      Text(_i18n.translate("delete_match")!)
                    ],
                  )),
            ],
            onSelected: (val) {
              /// Control selected value
              switch (val) {
                case "delete_chat":

                  /// Delete chat
                  confirmDialog(context,
                      title: _i18n.translate("delete_conversation"),
                      message: _i18n.translate("conversation_will_be_deleted")!,
                      negativeAction: () => Navigator.of(context).pop(),
                      positiveText: _i18n.translate("DELETE"),
                      positiveAction: () async {
                        // Close the confirm dialog
                        Navigator.of(context).pop();

                        // Show processing dialog
                        _pr.show(_i18n.translate("processing")!);

                        /// Delete chat
                        await _messagesApi.deleteChat(widget.user.userId);

                        // Hide progress
                        await _pr.hide();
                      });
                  break;

                case "delete_match":
                  errorDialog(context,
                      title: _i18n.translate("delete_match"),
                      message:
                          "${_i18n.translate("are_you_sure_you_want_to_delete_your_match_with")}: "
                          "${widget.user.userFullname}?\n\n"
                          "${_i18n.translate("this_action_cannot_be_reversed")}",
                      positiveText: _i18n.translate("DELETE"),
                      negativeAction: () => Navigator.of(context).pop(),
                      positiveAction: () async {
                        // Show processing dialog
                        _pr.show(_i18n.translate("processing")!);

                        /// Delete match
                        await _matchesApi.deleteMatch(widget.user.userId);

                        /// Delete chat
                        await _messagesApi.deleteChat(widget.user.userId);

                        /// Delete like
                        await _likesApi.deleteLike(widget.user.userId);

                        // Hide progress
                        _pr.hide();
                        // Hide dialog
                        Navigator.of(context).pop();
                        // Close chat screen
                        Navigator.of(context).pop();
                      });
                  break;
              }
              print("Selected action: $val");
            },
          ),
        ],
      ),

      ///FimAppBar.

      ///Column das mensagens.
      body: Column(
        children: <Widget>[
          /// how message list
          Expanded(
              child: Container(color: Colors.white10, child: _showMessages())),

          /// Text Composer
          Observer(
            builder: (_) => ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        if (controller.replyMessage != '') buildReply(),
                        TextField(
                          focusNode: focusNode,
                          controller: _textController,
                          minLines: 1,
                          maxLines: 4,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(bottom: 0),
                              child: IconButton(
                                  iconSize: 30,
                                  icon: Icon(Icons.insert_emoticon),
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  color: Colors.grey,
                                  onPressed: () async {
                                    /// Send image file
                                    await _getImage();

                                    /// Update scroll
                                    _scrollMessageList();
                                  }),
                            ),
                            suffixIcon: IconButton(
                                icon: SvgIcon("assets/icons/camera_icon.svg",
                                    width: 20, height: 20),
                                onPressed: () async {
                                  /// Send image file
                                  await _getImage();

                                  /// Update scroll
                                  _scrollMessageList();
                                }),
                            filled: true,
                            fillColor: Colors.grey[100],
                            hintText: _i18n.translate("type_a_message"),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.only(
                                topLeft: controller.replyMessage != ''
                                    ? Radius.zero
                                    : Radius.circular(25),
                                topRight: controller.replyMessage != ''
                                    ? Radius.zero
                                    : Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              ),
                            ),
                          ),
                          onChanged: (text) {
                            setState(() {
                              _isComposing = text.isNotEmpty;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: IconButton(
                        icon: Icon(Icons.send,
                            color: _isComposing
                                ? Theme.of(context).primaryColor
                                : Colors.grey),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: _isComposing
                            ? () async {
                                /// Get text
                                final text = _textController.text.trim();
                                final replyText = controller.replyMessage;

                                /// clear input text
                                _textController.clear();
                                setState(() {
                                  controller.cancelReply();
                                  _isComposing = false;
                                });

                                /// Send text message
                                await _sendMessage(
                                    type: 'text',
                                    text: text,
                                    replyText: replyText,
                                    userReplyMsg:
                                        controller.comparationWhoSendM(
                                            UserModel().user.userFullname,
                                            widget.user.userFullname));

                                /// Update scroll

                                _scrollMessageList();
                              }
                            : null),
                  )
                ],
              ),
            ),
          ),
        ],
      ),

      ///Column das mensagens.
    );
  }

  /// Responder mensagem

  /// _showMessages
  Widget _showMessages() {
    return //showMessages( messages: _messages);
        StreamBuilder<QuerySnapshot>(
            stream: _messages,
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
                    final Map<dynamic, dynamic> msg =
                        messages[index].data()! as Map;

                    /// Variables
                    bool isUserSender;
                    String userPhotoLink;

                    final bool isImage = msg[MESSAGE_TYPE] == 'image';
                    final String textMessage =
                        msg[MESSAGE_TEXT] == null ? '' : msg[MESSAGE_TEXT];
                    final String replyMsg =
                        msg[REPLY_TEXT] == null ? '' : msg[REPLY_TEXT];
                    final String userReply = msg[USER_REPLY_TEXT] == null
                        ? ''
                        : msg[USER_REPLY_TEXT];
                    final String? imageLink = msg[MESSAGE_IMG_LINK];
                    final String timeAgo = timeago
                        .format(msg[TIMESTAMP].toDate(), locale: 'pt_BR');

                    /// Check user id to get info
                    if (msg[USER_ID] == UserModel().user.userId) {
                      isUserSender = true;
                      userPhotoLink = UserModel().user.userProfilePhoto;
                    } else {
                      isUserSender = false;
                      userPhotoLink = widget.user.userProfilePhoto;
                    }

                    // Show chat bubble
                    return GestureDetector(
                      onDoubleTap: () {
                        print("curtiu");
                      },
                      child: SwipeTo(
                        iconColor: Colors.transparent,
                        offsetDx: 0.2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 8.0),
                          child: ChatMessage(
                            isUserSender: isUserSender,
                            isImage: isImage,
                            userPhotoLink: userPhotoLink,
                            textMessage: textMessage,
                            imageLink: imageLink,
                            timeAgo: timeAgo,
                            replyMessage: replyMsg,
                            userReply: userReply,
                          ),
                        ),
                        onRightSwipe: () {
                          print(textMessage);
                          if (window.viewInsets.bottom <= 0.0) {
                            showKeyboard(context);
                          }
                          controller.replyToMessage(textMessage, isUserSender);
                        },
                      ),
                    );
                  },
                );
              }
            });
  }

  /// showMessages
}
