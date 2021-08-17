import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/api/conversations_api.dart';
import 'package:uni_match/app/api/dislikes_api.dart';
import 'package:uni_match/app/api/likes_api.dart';
import 'package:uni_match/app/api/matches_api.dart';
import 'package:uni_match/app/api/messages_api.dart';
import 'package:uni_match/app/api/notifications_api.dart';
import 'package:uni_match/app/api/visits_api.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/app/models/user_model.dart';
import 'package:uni_match/constants/constants.dart';
import 'package:uni_match/widgets/processing.dart';

class DeleteAccountScreen extends StatefulWidget {
  @override
  _DeleteAccountScreenState createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  // Variables
  final _firestore = FirebaseFirestore.instance;
  final _storageRef = FirebaseStorage.instance;

  /// Api instances
  final _notificationsApi = NotificationsApi();
  final _conversationsApi = ConversationsApi();
  final _messagesApi = MessagesApi();
  final _matchesApi = MatchesApi();
  final _likesApi = LikesApi();
  final _dislikesApi = DislikesApi();
  final _visitsApi = VisitsApi();

  /// DELETE USER ACCOUNT
  ///
  Future<void> _deleteUserAccount() async {
    ///
    /// DELETE ALL USER TRANSACTIONS FROM DATABASE AND STORAGE
    ///
    /// DELETE CURRENT USER PROFILE
    debugPrint('Iniciar delete');

    await _firestore.collection(C_USERS).doc(UserModel().user.userId).delete();
    debugPrint('Profile account -> deleted...');

    // Get user uploaded profile image links
    final List<String> _userImagesRef =
        UserModel().getUserProfileImages(UserModel().user);

    /// DELETE PROFILE IMAGE AND GALLERY
    ///
    /// Loop user profile images to be deleted from storage
    _userImagesRef.forEach((imgUrl) async {
      // Delete profile image and gallery
      await _storageRef.refFromURL(imgUrl).delete();
    });
    debugPrint('Profile images -> deleted...');

    /// DELETE USER MATCHES
    ///
    // Get user matches
    final List<DocumentSnapshot> _matches = await _matchesApi.getMatches();
    // Check matches
    if (_matches.isNotEmpty) {
      // Loop matches to be deleted
      _matches.forEach((match) async {
        await _matchesApi.deleteMatch(match.id);
      });
    }
    debugPrint('Matches -> deleted...');

    /// DELETE USER CONVERSATIONS AND CHAT MESSAGES
    ///
    /// Get user conversations
    final List<DocumentSnapshot> _conversations =
        (await _conversationsApi.getConversations().first).docs;
    // Check conversations
    if (_conversations.isNotEmpty) {
      // Loop conversations to be deleted
      _conversations.forEach((converse) async {
        await _conversationsApi.deleteConverce(converse.id, isDoubleDel: true);
        // Delete chat for current user and for other users
        await _messagesApi.deleteChat(converse.id, isDoubleDel: true);
      });
    }
    debugPrint('Conversations -> deleted...');

    /// DELETE USER ID FROM LIKES
    ///
    await _likesApi.deleteLikedUsers();

    await _likesApi.deleteLikedMeUsers();

    /// DELETE USER ID FROM DISLIKES
    ///
    await _dislikesApi.deleteDislikedUsers();

    await _dislikesApi.deleteDislikedMeUsers();

    /// DELETE VISITED USERS
    await _visitsApi.deleteVisitedUsers();

    /// DELETE NOTIFICATIONS RECEIVED BY USER
    ///
    await _notificationsApi.deleteUserNotifications();

    /// DELETE NOTIFICATIONS SENT BY USER
    ///
    await _notificationsApi.deleteUserSentNotifications();
  }

  @override
  void initState() {
    super.initState();
    // Start deleting user account
    _deleteUserAccount().then((_) {
      // Go to sign in screen
      Future(() {
        Modular.to.navigate('/login/signIn');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppController i18n = Modular.get();
    return Scaffold(
      body: Processing(
        text: i18n.translate("deleting_your_account")!,
      ),
    );
  }
}
