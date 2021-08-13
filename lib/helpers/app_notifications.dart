import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/datas/user.dart';
import 'package:uni_match/app/models/user_model.dart';
import 'package:uni_match/dialogs/common_dialogs.dart';

class AppNotifications {
  /// Handle notification click for push
  /// and database notifications
  Future<void> onNotificationClick(
      BuildContext context, {
        required String nType,
        required String nSenderId,
        required String nMessage,
        // Call Info object
        String? nCallInfo,
      }) async {
    /// Control notification type
    switch (nType) {
      case 'like':

      /// Check user VIP account
        if (UserModel().userIsVip) {
          /// Go direct to user profile
          _goToProfileScreen(context, nSenderId);
        } else {
          /// Go Profile Likes Screen
          print('/profile/likes');
          Modular.to.pushNamed('/profile/likes');
          // Navigator.of(context).push(
          //     MaterialPageRoute(builder: (context) => ProfileLikesScreen()));
        }
        break;
      case 'visit':

      /// Check user VIP account
        if (UserModel().userIsVip) {
          /// Go direct to user profile
          _goToProfileScreen(context, nSenderId);
        } else {
          /// Go Profile Visits Screen
          print('/profile/visits');
          Modular.to.pushNamed('/profile/visits');
          // Navigator.of(context).push(
          //     MaterialPageRoute(builder: (context) => ProfileVisitsScreen()));
        }
        break;

      case 'alert':

      /// Show dialog info
        Future(() {
          infoDialog(context, message: nMessage);
        });

        break;

    }
  }

  /// Navigate to profile screen
  void _goToProfileScreen(BuildContext context, userSenderId) async {
    /// Get updated user info
    final Usuario user = await UserModel().getUserObject(userSenderId);

    /// Go direct to profile
    Modular.to.pushNamed('/profile', arguments: user);
    // Navigator.of(context).push(
    //     MaterialPageRoute(builder: (context) => ProfileScreen(user: user)));
  }
}
