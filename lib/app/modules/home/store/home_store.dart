import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:mobx/mobx.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:uni_match/app/api/conversations_api.dart';
import 'package:uni_match/app/api/notifications_api.dart';
import 'package:uni_match/app/modules/profile/view/passaport/passport_screen.dart';
import 'package:uni_match/helpers/app_notifications.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/app/models/user_model.dart';
import 'package:uni_match/constants/constants.dart';
import 'package:uni_match/widgets/show_scaffold_msg.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store{

  AppController _i18n = Modular.get();

  final conversationsApi = ConversationsApi();
  final notificationsApi = NotificationsApi();
  final appNotifications = AppNotifications();

  late Stream<DocumentSnapshot> userStream;
  // ignore: cancel_subscriptions
  late StreamSubscription<List<PurchaseDetails>> inAppPurchaseStream;

  /// Get current User Real Time updates

  /// Get current User Real Time updates
  void getCurrentUserUpdates() {
    /// Get user stream
    userStream = UserModel().getUserStream();

    /// Subscribe to user updates
    userStream.listen((userEvent) {
      // Update user
      UserModel().updateUserObject(userEvent.data()!  as Map);
    });
  }

  /// Check current User VIP Account status
  Future<void> checkUserVipStatus() async {
    // Query past subscriptions
    InAppPurchaseConnection.instance
        .queryPastPurchases()
        .then((QueryPurchaseDetailsResponse pastPurchases) {
      // Chek past purchases result
      if (pastPurchases.pastPurchases.isNotEmpty) {
        for (var purchase in pastPurchases.pastPurchases) {
          /// Update User VIP Status to true
          UserModel().setUserVip();
          // Set Vip Subscription Id
          UserModel().setActiveVipId(purchase.productID);
          // Debug
          print('Active VIP SKU: ${purchase.productID}');
        }
      } else {
        print('No Active VIP Subscription');
      }
    });
  }

  /// Handle in-app purchases upates
  void handlePurchaseUpdates() {
    // listen purchase updates
    inAppPurchaseStream = InAppPurchaseConnection.instance.purchaseUpdatedStream
        .listen((purchases) async {

      // Loop incoming purchases
      for (var purchase in purchases) {
        // Control purchase status
        // ignore: missing_enum_constant_in_switch
        switch (purchase.status) {
          case PurchaseStatus.pending:
          // Handle this case.
            break;
          case PurchaseStatus.purchased:

          /// **** Deliver product to user **** ///
          ///
          /// Update User VIP Status to true
            UserModel().setUserVip();
            // Set Vip Subscription Id
            UserModel().setActiveVipId(purchase.productID);

            /// Update user verified status
            await UserModel().updateUserData(
                userId: UserModel().user.userId,
                data: {USER_IS_VERIFIED: true});

            // User first name
            final String userFirstname = UserModel().user.userFullname.split(' ')[0];

            /// Save notification in database for user
            notificationsApi.onPurchaseNotification(
              nMessage: '${_i18n.translate("hello")} $userFirstname, '
                  '${_i18n.translate("your_vip_account_is_active")}\n'
                  '${_i18n.translate("thanks_for_buying")}',
            );

            if (purchase.pendingCompletePurchase) {
              /// Complete pending purchase
              InAppPurchaseConnection.instance.completePurchase(purchase);
              print('Success pending purchase completed!');
            }
            break;
          case PurchaseStatus.error:
          // Handle this case.
            print('purchase error-> ${purchase.error?.message}');
            break;
        }
      }
    });
  }

  Future<void> handleNotificationClick(Map<String, dynamic>? data, context) async {
    /// Handle notification click
    await appNotifications.onNotificationClick(context,
        nType: data?[N_TYPE] ?? '',
        nSenderId: data?[N_SENDER_ID] ?? '',
        nMessage: data?[N_MESSAGE] ?? '',
        // CallInfo payload
        nCallInfo: data?['call_info'] ?? '');
  }

  /// Request permission for push notifications
  /// Only for iOS
  void requestPermissionForIOS() async {
    if (Platform.isIOS) {
      // Request permission for iOS devices
      await FirebaseMessaging.instance.requestPermission();
    }
  }

  ///
  /// Handle incoming notifications while the app is in the Foreground
  ///
  Future<void> initFirebaseMessage(context) async {
    // Get inicial message if the application
    // has been opened from a terminated state.
    final message = await FirebaseMessaging.instance.getInitialMessage();
    // Check notification data
    if (message != null) {
      // Debug
      print('getInitialMessage() -> data: ${message.data}');
      // Handle notification data
      await handleNotificationClick(message.data, context);
    }

    // Returns a [Stream] that is called when a user
    // presses a notification message displayed via FCM.
    // Note: A Stream event will be sent if the app has
    // opened from a background state (not terminated).
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      // Debug
      print('onMessageOpenedApp() -> data: ${message.data}');
      // Handle notification data
      await handleNotificationClick(message.data, context);
    });

    // Listen for incoming push notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
      // Debug
      print('onMessage() -> data: ${message?.data}');
      // Handle notification data
      await handleNotificationClick(message?.data, context);
    });
  }

//******************************************************************************
  /// Passaport
  ///
  Future<void> goToPassportScreen(context) async {
    // Get picked location result
    LocationResult? result = await Navigator.of(context).push<LocationResult?>(
        MaterialPageRoute(builder: (context) => PassportScreen()));
    // Handle the retur result
    if (result != null) {
      // Update current your location
      _updateUserLocation(context, true, locationResult: result);
      // Debug info
      print(
          '_goToPassportScreen() -> result: ${result.country!.name}, ${result.city!.name}');
    } else {
      print('_goToPassportScreen() -> result: empty');
    }
  }

  // Update User Location
  Future<void> _updateUserLocation(context, bool isPassport,
      {LocationResult? locationResult}) async {
    /// Update user location: Country & City an Geo Data

    /// Update user data
    await UserModel().updateUserLocation(
        isPassport: isPassport,
        locationResult: locationResult,
        onSuccess: () {
          // Show success message
          showScaffoldMessage(
              context: context,
              message: _i18n.translate("location_updated_successfully")!);
        },
        onFail: () {
          // Show error message
          showScaffoldMessage(
              context: context,
              message:
              _i18n.translate("we_were_unable_to_update_your_location")!);
        });
  }

}
