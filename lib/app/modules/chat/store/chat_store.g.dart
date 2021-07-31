// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatStore on _ChatStore, Store {
  final _$replyMessageAtom = Atom(name: '_ChatStore.replyMessage');

  @override
  String get replyMessage {
    _$replyMessageAtom.reportRead();
    return super.replyMessage;
  }

  @override
  set replyMessage(String value) {
    _$replyMessageAtom.reportWrite(value, super.replyMessage, () {
      super.replyMessage = value;
    });
  }

  final _$userSendAtom = Atom(name: '_ChatStore.userSend');

  @override
  bool get userSend {
    _$userSendAtom.reportRead();
    return super.userSend;
  }

  @override
  set userSend(bool value) {
    _$userSendAtom.reportWrite(value, super.userSend, () {
      super.userSend = value;
    });
  }

  final _$_ChatStoreActionController = ActionController(name: '_ChatStore');

  @override
  void replyToMessage(String message, bool user) {
    final _$actionInfo = _$_ChatStoreActionController.startAction(
        name: '_ChatStore.replyToMessage');
    try {
      return super.replyToMessage(message, user);
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void cancelReply() {
    final _$actionInfo = _$_ChatStoreActionController.startAction(
        name: '_ChatStore.cancelReply');
    try {
      return super.cancelReply();
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
replyMessage: ${replyMessage},
userSend: ${userSend}
    ''';
  }
}
