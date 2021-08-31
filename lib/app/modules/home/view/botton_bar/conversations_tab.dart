import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:uni_match/app/api/matches_api.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/app/api/conversations_api.dart';
import 'package:uni_match/app/datas/user.dart';
import 'package:uni_match/app/models/user_model.dart';
import 'package:uni_match/constants/constants.dart';
import 'package:uni_match/dialogs/progress_dialog.dart';
import 'package:uni_match/helpers/app_ad_helper.dart';
import 'package:uni_match/widgets/badge.dart';
import 'package:uni_match/widgets/build_title.dart';
import 'package:uni_match/widgets/connectivity_rede.dart';
import 'package:uni_match/widgets/no_data.dart';
import 'package:uni_match/widgets/processing.dart';
import 'package:uni_match/widgets/show_dialog_undo_match.dart';

class ConversationsTab extends StatefulWidget {
  // Variables
  @override
  _ConversationsTabState createState() => _ConversationsTabState();
}

class _ConversationsTabState extends State<ConversationsTab> {
  final AppController i18n = Modular.get();

  final _conversationsApi = ConversationsApi();
  final _matchesApi = MatchesApi();
  var subscription;
  String status = "teste";

  @override
  void initState() {
    super.initState();
    AppAdHelper.showInterstitialAd();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        setState(() {
          status = "Offiline";
        });
      }
      if (result == ConnectivityResult.wifi) {
        setState(() {
          status = "wi-fi";
        });
      }
      if (result == ConnectivityResult.mobile) {
        setState(() {
          status = "moblie";
        });
      }
    });
  }

  @override
  void dispose() {
    AppAdHelper.disposeInterstitialAd();
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    /// Initialization
    final pr = ProgressDialog(context);

    return Column(
      children: [
        /// Header
        BuildTitle(
          svgIconName: 'message_icon',
          title: i18n.translate("conversations")!,
        ),

        /// Conversations stream
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
              stream: _conversationsApi.getConversations(),
              builder: (context, snapshot) {
                /// Check data
                if (!snapshot.hasData) {
                  return Processing(text: i18n.translate("loading"));
                } else if (snapshot.data!.docs.isEmpty) {
                  /// No conversation
                  return NoData(
                      svgName: 'message_icon',
                      text: i18n.translate("no_conversation")!);
                } else {
                  return ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => Divider(height: 10),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: ((context, index) {
                      /// Get conversation DocumentSnapshot
                      final DocumentSnapshot conversation =
                          snapshot.data!.docs[index];

                      /// Show conversation
                      return Container(
                        color: !conversation[MESSAGE_READ]
                            ? Theme.of(context).primaryColor.withAlpha(40)
                            : null,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: Theme.of(context).primaryColor,
                            backgroundImage:
                                NetworkImage(conversation[USER_PROFILE_PHOTO]),
                          ),
                          title: Text(conversation[USER_FULLNAME].split(" ")[0],
                              style: TextStyle(fontSize: 18)),
                          subtitle: conversation[MESSAGE_TYPE] == 'text'
                              ? Text(conversation[LAST_MESSAGE]
                                          .toString()
                                          .length <=
                                      25
                                  ? "${conversation[LAST_MESSAGE]}\n" +
                                      "${timeago.format(conversation[TIMESTAMP].toDate(), locale: 'pt_BR')}"
                                  : "${conversation[LAST_MESSAGE].toString().substring(0, 22)}...\n" +
                                      "${timeago.format(conversation[TIMESTAMP].toDate(), locale: 'pt_BR')}")
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(Icons.photo_camera,
                                        color: Theme.of(context).primaryColor),
                                    SizedBox(width: 5),
                                    Text(i18n.translate("photo")!),
                                  ],
                                ),
                          trailing: !conversation[MESSAGE_READ]
                              ? Badge(text: i18n.translate("new"))
                              : null,
                          onTap: () async {
                            print(status);

                            if (status == 'wi-fi' || status == 'moblie') {
                              /// Show progress dialog
                              pr.show(i18n.translate("processing")!);

                              /// 1.) Set conversation read = true
                              await conversation.reference
                                  .update({MESSAGE_READ: true});

                              /// 2.) Get updated user info
                              final DocumentSnapshot userDoc = await UserModel()
                                  .getUser(conversation[USER_ID]);

                              /// 3.) Get user object
                              final Usuario user =
                                  Usuario.fromDocument(userDoc.data()! as Map);

                              /// Hide progrees
                              pr.hide();

                              /// Go to chat screen

                              await _matchesApi.checkMatch(
                                  onMatchResult: (result) {
                                    if (result) {
                                      Modular.to
                                          .pushNamed('/chat', arguments: user);
                                    } else {
                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) {
                                            return ShowDialogUndoMatch(
                                              userFullName: user.userFullname,
                                              userId: user.userId,
                                            );
                                          });
                                    }
                                  },
                                  userId: user.userId);
                              print('Conctado');
                            }
                            if (status == 'Offiline') {
                              print('Sem Conexão');
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title:
                                      Text('Verifique Sua conexão a internet'),
                                ),
                              );
                            }
                          }, //await _messagesApi.deleteChat(user.userId);
                        ),
                      );
                    }),
                  );
                }
              }),
        ),
      ],
    );
  }
}
