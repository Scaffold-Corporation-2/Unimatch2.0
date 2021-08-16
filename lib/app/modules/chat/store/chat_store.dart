import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'chat_store.g.dart';

class ChatStore = _ChatStore  with _$ChatStore;

abstract class _ChatStore  with Store {

  final focusNode = FocusNode();
  final focusKeyboardEmoji = FocusNode();

  @observable
  String replyMessage = '';

  @observable
  bool userSend = false;

  @observable
  String? replyImage = '';

  @observable
  bool isImage = false;

  @observable
  bool showEmoji = false;

  @observable
  bool likeMsg = false;

  @action
  msgLiked(){
    likeMsg=!likeMsg;
  }


@action
  void replyToMessage(String message, bool user,String? image, bool imageBool) {
  isImage = imageBool;
  if(imageBool == true){
    replyMessage = image.toString();
    replyImage = image;
    userSend = user;
  }else{
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
      return
        user;
    } else
      return
        otheruser;
  }
  //EMOJIS

  final textController = TextEditingController();

  @action
  onEmojiSelected(Emoji emoji) {
    textController.text = textController.text + emoji.emoji;
  }
  @action
  showEmojiKeyboard(){
    showEmoji = !showEmoji;
  }

  @action
  changedEmojiState(bool state) {
    showEmoji = state;
  }

}