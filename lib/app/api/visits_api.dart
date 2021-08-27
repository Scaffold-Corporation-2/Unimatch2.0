import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uni_match/app/models/user_model.dart';
import 'package:uni_match/constants/constants.dart';
import 'package:uni_match/app/api/notifications_api.dart';

class VisitsApi {
  /// FINAL VARIABLES
  ///
  final _firestore = FirebaseFirestore.instance;
  final _notificationsApi = NotificationsApi();

  /// Save visit in database
  Future<void> _saveVisit({
    required String visitedUserId,
    required String userDeviceToken,
    required String nMessage,
  }) async {
    _firestore.collection(C_VISITS).add({
      VISITED_USER_ID: visitedUserId,
      VISITED_BY_USER_ID: UserModel().user.userId,
      TIMESTAMP: FieldValue.serverTimestamp()
    }).then((_) async {
      /// Update user total visits
      await UserModel().updateUserData(
          userId: visitedUserId,
          data: {USER_TOTAL_VISITS: FieldValue.increment(1)});

      /// Save notification in database
      await _notificationsApi.saveNotification(
        nReceiverId: visitedUserId,
        nType: 'visit',
        nMessage: nMessage,
      );

      /// Send push notification
      await _notificationsApi.sendPushNotification(
          nTitle: UserModel().user.userFullname.split(' ')[0],
          nBody: nMessage,
          nType: 'visit',
          nSenderId: UserModel().user.userId,
          nUserDeviceToken: userDeviceToken);
    });
  }

  /// View user profile and increment visits
  Future<void> visitUserProfile(
      {required String visitedUserId,
      required String userDeviceToken,
      required String nMessage}) async {
    /// Check visit profile id: if current user does not record
    if (visitedUserId == UserModel().user.userId) return;

    /// Check if current user already visited profile
    _firestore
        .collection(C_VISITS)
        .where(VISITED_BY_USER_ID, isEqualTo: UserModel().user.userId)
        .where(VISITED_USER_ID, isEqualTo: visitedUserId)
        .get()
        .then((QuerySnapshot snapshot) async {
      if (snapshot.docs.isEmpty) {
        _saveVisit(
            visitedUserId: visitedUserId,
            userDeviceToken: userDeviceToken,
            nMessage: nMessage);
        debugPrint('visitUserProfile() -> success');
      } else {
        print('Você já visitou o usuário');
      }
    }).catchError((e) {
      print('visitUserProfile() -> error: $e');
    });
  }

  /// Get users who visited current user profile
  Future<List<DocumentSnapshot>> getUserVisits(
      {bool loadMore = false, DocumentSnapshot? userLastDoc}) async {
    /// Build query
    Query usersQuery = _firestore
        .collection(C_VISITS)
        .where(VISITED_USER_ID, isEqualTo: UserModel().user.userId);

    /// Check loadMore
    if (loadMore) {
      usersQuery = usersQuery.startAfterDocument(userLastDoc!);
    }

    /// Finalize query and limit data
    usersQuery = usersQuery.orderBy(TIMESTAMP, descending: true);
    usersQuery = usersQuery.limit(20);

    final QuerySnapshot querySnapshot = await usersQuery.get().catchError((e) {
      print('getUserVisits() -> error: $e');
    });

    return querySnapshot.docs;
  }

  Future<void> deleteVisitedUsers() async {
    _firestore
        .collection(C_VISITS)
        .where(VISITED_BY_USER_ID, isEqualTo: UserModel().user.userId)
        .get()
        .then((QuerySnapshot snapshot) async {
      /// Check docs
      if (snapshot.docs.isNotEmpty) {
        // Loop docs to be deleted
        snapshot.docs.forEach((doc) async {
          await doc.reference.delete();
        });
        debugPrint('deleteVisitedUsers() -> deleted');
      } else
        debugPrint('deleteVisitedUsers() -> not deleted');
    });
  }
}
