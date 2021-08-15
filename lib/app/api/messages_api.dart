import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uni_match/app/models/user_model.dart';
import 'package:uni_match/constants/constants.dart';
import 'package:uni_match/app/api/conversations_api.dart';

class MessagesApi {
  /// FINAL VARIABLES
  ///
  final _firestore = FirebaseFirestore.instance;
  final _conversationsApi = ConversationsApi();

  /// Get stream messages for current user
  Stream<QuerySnapshot> getMessages(String withUserId) {
    return _firestore
        .collection(C_MESSAGES)
        .doc(UserModel().user.userId)
        .collection(withUserId)
        .orderBy(TIMESTAMP)
        .snapshots();
  }

  String getId({
    required String senderId,
    required String receiverId,
  }) {
    return _firestore
        .collection(C_MESSAGES)
        .doc(senderId)
        .collection(receiverId)
        .doc()
        .id;
  }

  /// Save chat message
  Future<void> saveMessage({
    required String type,
    required String replyType,
    required String senderId,
    required String receiverId,
    required String fromUserId,
    required String userPhotoLink,
    required String userFullName,
    required String textMsg,
    required String replyMsg,
    required String userReplyMsg,
    required String idDoc,
    required String imgLink,
    required bool isRead,
    required bool likeMsg,

  }) async {
    /// Save message
    print("Date " + DateTime.now().toString());

    await _firestore
        .collection(C_MESSAGES)
        .doc(senderId)
        .collection(receiverId)
        .doc(idDoc)
        .set(<String, dynamic>{
      ID_DOC: idDoc,
      USER_ID: fromUserId,
      MESSAGE_TYPE: type,
      MESSAGE_TEXT: textMsg,
      REPLY_TEXT: replyMsg,
      MESSAGE_IMG_LINK: imgLink,
      USER_REPLY_TEXT: userReplyMsg,
      REPLY_TYPE: replyType,
      LIKE_MSG: likeMsg,
      TIMESTAMP: Timestamp.now(),
    });

    /// Save last conversation
    await _conversationsApi.saveConversation(
        idDoc: idDoc,
        type: type,
        senderId: senderId,
        receiverId: receiverId,
        userPhotoLink: userPhotoLink,
        userFullName: userFullName,
        textMsg: textMsg,
        replyMsg: replyMsg,
        replyType: replyType,
        likeMsg: likeMsg,
        userReplyMsg: userReplyMsg,
        isRead: isRead);
  }

  ///UpdateMessage
  Future<void> updateMessage({
    required String senderId,
    required String receiverId,
    required bool likeMsg,
    required String idDoc,
  }) async {

    await _firestore
        .collection(C_MESSAGES)
        .doc(senderId)
        .collection(receiverId)
        .doc(idDoc)
        .update({
      LIKE_MSG:likeMsg,
    });
  }

  /// Delete current user chat
  Future<void> deleteChat(String withUserId, {bool isDoubleDel = false}) async {
    /// Get Chat for current user
    ///
    final List<DocumentSnapshot> _messages01 = (await _firestore
            .collection(C_MESSAGES)
            .doc(UserModel().user.userId)
            .collection(withUserId)
            .get())
        .docs;

    // Check messages sent by current user to be deleted
    if (_messages01.isNotEmpty) {
      // Loop messages to be deleted
      _messages01.forEach((msg) async {
        // Check msg type
        if (msg[MESSAGE_TYPE] == 'image' &&
            msg[USER_ID] == UserModel().user.userId) {
          /// Delete uploaded images by current user
          await FirebaseStorage.instance
              .refFromURL(msg[MESSAGE_IMG_LINK])
              .delete();
        }
        await msg.reference.delete();
      });

      // Delete current user conversation
      if (!isDoubleDel) {
        _conversationsApi.deleteConverce(withUserId);
      }
    }

    /// Check param
    if (isDoubleDel) {
      /// Get messages sent by onother user to be deleted
      final List<DocumentSnapshot> _messages02 = (await _firestore
              .collection(C_MESSAGES)
              .doc(withUserId)
              .collection(UserModel().user.userId)
              .get())
          .docs;

      // Check messages
      if (_messages02.isNotEmpty) {
        // Loop messages to be deleted
        _messages02.forEach((msg) async {
          // Check msg type
          if (msg[MESSAGE_TYPE] == 'image' && msg[USER_ID] == withUserId) {
            /// Delete uploaded images by onother user
            await FirebaseStorage.instance
                .refFromURL(msg[MESSAGE_IMG_LINK])
                .delete();
          }
          await msg.reference.delete();
        });
      }
    }
  }
}
