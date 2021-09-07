import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'chat_store.g.dart';

class ChatStore = _ChatStore with _$ChatStore;

abstract class _ChatStore with Store {
  final focusNode = FocusNode();
  final textController = TextEditingController();

  @observable
  String statusConnection = 'online';

  @observable
  String replyMessage = '';

  @observable
  bool userSend = false;

  @observable
  String? replyImage = '';

  @observable
  bool isImage = false;

  //Reply Message
  @action
  void replyToMessage(
      String message, bool user, String? image, bool imageBool) {
    isImage = imageBool;
    if (imageBool == true) {
      replyMessage = image.toString();
      replyImage = image;
      userSend = user;
    } else {
      replyMessage = message;
      userSend = user;
    }
  }

  @action
  void cancelReply() {
    replyMessage = '';
  }

  String comparationWhoSendM(String user, String otheruser) {
    if (userSend == true) {
      return user;
    } else
      return otheruser;
  }
  //Emoji

  @observable
  bool showEmoji = false;

  @action
  onEmojiSelected(Emoji emoji) {
    textController.text = textController.text + emoji.emoji;
  }

  @action
  showEmojiKeyboard() {
    showEmoji = !showEmoji;
  }

  //Like Msg
  @observable
  bool likeMsg = false;

  @action
  msgLiked() {
    likeMsg = !likeMsg;
  }
}
