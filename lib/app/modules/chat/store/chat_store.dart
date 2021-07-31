import 'package:mobx/mobx.dart';

part 'chat_store.g.dart';

class ChatStore = _ChatStore  with _$ChatStore;

abstract class _ChatStore  with Store {

  @observable
  String replyMessage = '';

  @observable
  bool userSend = false;

@action
  void replyToMessage(String message, bool user) {
    replyMessage = message;
    userSend = user;
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