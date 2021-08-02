import 'package:mobx/mobx.dart';

part 'chat_store.g.dart';

class ChatStore = _ChatStore  with _$ChatStore;

abstract class _ChatStore  with Store {

  @observable
  String replyMessage = '';

  @observable
  bool userSend = false;

  @observable
  String? replyImage = '';

  @observable
  bool isImage = false;

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


    print(replyMessage);
}
@action
  void cancelReply() {
    replyMessage = '';
  }

  @action
  comparationWhoSendM(String user, String otheruser) {
    if (userSend == true) {
      return user;
    } else
      return
        otheruser;
  }
}