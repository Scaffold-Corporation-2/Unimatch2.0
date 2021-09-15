import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/app/models/user_model.dart';
import 'package:uni_match/app/modules/home/store/home_store.dart';
import 'package:uni_match/app/modules/home/view/botton_bar/discover_tab.dart';
import 'package:uni_match/app/modules/home/view/botton_bar/matches_tab.dart';
import 'package:uni_match/app/modules/home/view/botton_bar/conversations_tab.dart';
import 'package:uni_match/app/modules/home/view/botton_bar/profile_tab.dart';
import 'package:uni_match/constants/constants.dart';
import 'package:uni_match/dialogs/vip_dialog.dart';
import 'package:uni_match/widgets/notification_counter.dart';
import 'package:uni_match/widgets/svg_icon.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ModularState<HomeScreen, HomeStore> {

  AppController _i18n = Modular.get();
  int _selectedIndex = 0;

  /// Tab navigation
  Widget _showCurrentNavBar() {
    List<Widget> options = <Widget>[
      DiscoverTab(),
      MatchesTab(),
      ConversationsTab(),
      ProfileTab()
    ];

    return options.elementAt(_selectedIndex);
  }


  @override
  void initState() {
    super.initState();

    /// Check User VIP Status
    controller.checkUserVipStatus();

    /// Init streams
    controller.getCurrentUserUpdates();
    controller.handlePurchaseUpdates();
    controller.initFirebaseMessage(context);

    /// Request permission for IOS
    controller.requestPermissionForIOS();
  }

  @override
  void dispose() {
    super.dispose();
    // Close streams
    controller.userStream.drain();
    controller.inAppPurchaseStream.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
           Expanded(
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 IconButton(
                     splashColor: Colors.transparent,
                     highlightColor: Colors.transparent,
                     icon: SvgIcon("assets/icons/lifeStyle.svg",
                       width: 35, height: 35, color: Theme.of(context).iconTheme.color,),
                     onPressed: (){
                       Modular.to.pushNamed('/lifeStyle');
                     }),

                 IconButton(
                     splashColor: Colors.transparent,
                     highlightColor: Colors.transparent,
                     icon: SvgIcon("assets/icons/beer_icon.svg",
                       width: 30, height: 30, color: Theme.of(context).iconTheme.color,),
                     onPressed: (){
                       Modular.to.pushNamed('/party');
                     }),

                 IconButton(
                     splashColor: Colors.transparent,
                     highlightColor: Colors.transparent,
                     icon: SvgIcon("assets/icons/airplane_icon.svg",
                       width: 33, height: 33, color: Theme.of(context).iconTheme.color,),
                     onPressed: (){
                       if (UserModel().userIsVip) {
                         // Go to passport screen
                         controller.goToPassportScreen(context);
                       } else {
                         /// Show VIP dialog
                         // showDialog(context: context,
                         //     builder: (context) => VipDialog());
                         Navigator.of(context).push(MaterialPageRoute(
                             builder: (context) => VipDialog()));
                       }
                     }),

                 IconButton(
                     splashColor: Colors.transparent,
                     highlightColor: Colors.transparent,
                     icon: _getNotificationCounter(),
                     onPressed: () async {
                       Modular.to.pushNamed('/home/notification');
                     }),
               ],
             ),
           )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            elevation: Platform.isIOS ? 0 : 8,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.transparent,
            onTap: (int index) => setState(() => _selectedIndex = index),
            items: [
              /// Discover Tab
              BottomNavigationBarItem(
                  icon: SvgIcon("assets/icons/unimatch_icon.svg",
                      width: 31,
                      height: 31,
                      color: _selectedIndex == 0
                          ? Theme.of(context).primaryColor
                          : null),
                  label: _i18n.translate("discover"),
              ),

              /// Matches Tab
              BottomNavigationBarItem(
                  icon: SvgIcon(
                      _selectedIndex == 1
                          ? "assets/icons/heart_2_icon.svg"
                          : "assets/icons/heart_icon.svg",
                      color: _selectedIndex == 1
                          ? Theme.of(context).primaryColor
                          : null),
                  label: _i18n.translate("matches")
              ),

              /// Conversations Tab
              BottomNavigationBarItem(
                  icon: _getConversationCounter(),
                  label: _i18n.translate("conversations")),

              /// Profile Tab
              BottomNavigationBarItem(
                  icon: SvgIcon(
                      _selectedIndex == 3
                          ? "assets/icons/user_2_icon.svg"
                          : "assets/icons/user_icon.svg",
                      color: _selectedIndex == 3
                          ? Theme.of(context).primaryColor
                          : null),
                  label: _i18n.translate("profile")),
            ]),
        body: _showCurrentNavBar());
  }

  /// Count unread notifications
  Widget _getNotificationCounter() {
    // Set icon
    final icon = SvgIcon("assets/icons/bell_icon.svg", width: 30, height: 30, color: Theme.of(context).iconTheme.color,);

    /// Handle stream
    return  StreamBuilder<QuerySnapshot>(
        stream: controller.notificationsApi.getNotifications(),
        builder: (context, snapshot) {
          // Check result
          if (!snapshot.hasData) {
            return icon;
          } else {
            /// Get total counter to alert user
            final total = snapshot.data!.docs
                .where((doc) => (doc.data()! as Map)[N_READ] == false)
                .toList()
                .length;
            if (total == 0) return icon;
            return NotificationCounter(icon: icon, counter: total);
          }
        }
    );
  }

  /// Count unread conversations
  Widget _getConversationCounter() {
    // Set icon
    final icon = SvgIcon(
        _selectedIndex == 2
            ? "assets/icons/message_2_icon.svg"
            : "assets/icons/message_icon.svg",
        width: 30,
        height: 30,
        color: _selectedIndex == 2 ? Theme.of(context).primaryColor : null);

    /// Handle stream
    return StreamBuilder<QuerySnapshot>(
        stream: controller.conversationsApi.getConversations(),
        builder: (context, snapshot) {
          // Check result
          if (!snapshot.hasData) {
            return icon;
          } else {
            /// Get total counter to alert user
            final total = snapshot.data!.docs
                .where((doc) => (doc.data()! as Map)[MESSAGE_READ] == false)
                .toList()
                .length;
            if (total == 0) return icon;
            return NotificationCounter(icon: icon, counter: total);
          }
        });
  }
}