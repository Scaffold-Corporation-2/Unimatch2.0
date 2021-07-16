import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/api/dislikes_api.dart';
import 'package:uni_match/app/api/visits_api.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/app/datas/user.dart';
import 'package:uni_match/app/models/user_model.dart';
import 'package:uni_match/app/modules/profile/view/profile_screen.dart';
import 'package:uni_match/constants/constants.dart';
import 'package:uni_match/dialogs/vip_dialog.dart';
import 'package:uni_match/widgets/build_title.dart';
import 'package:uni_match/widgets/loading_card.dart';
import 'package:uni_match/widgets/no_data.dart';
import 'package:uni_match/widgets/processing.dart';
import 'package:uni_match/widgets/profile_card.dart';
import 'package:uni_match/widgets/users_grid.dart';

class DislikedProfilesScreen extends StatefulWidget {
  @override
  _DislikedProfilesScreenState createState() => _DislikedProfilesScreenState();
}

class _DislikedProfilesScreenState extends State<DislikedProfilesScreen> {
  // Variables
  final ScrollController _gridViewController = new ScrollController();
  final DislikesApi _dislikesApi = DislikesApi();
  final VisitsApi _visitsApi = VisitsApi();
  AppController _i18n = Modular.get();
  List<DocumentSnapshot>? _dislikedUsers;
  late DocumentSnapshot _userLastDoc;
  bool _loadMore = true;

  /// Load more users
  void _loadMoreUsersListener() async {
    _gridViewController.addListener(() {
      if (_gridViewController.position.pixels ==
          _gridViewController.position.maxScrollExtent) {
        /// Load more users
        if (_loadMore) {
          _dislikesApi
              .getDislikedUsers(
                  withLimit: true, loadMore: true, userLastDoc: _userLastDoc)
              .then((users) {
            /// Update user list
            if (users.isNotEmpty) {
              _updateUserList(users);
            } else {
              setState(() => _loadMore = false);
            }
            print('load more users: ${users.length}');
          });
        } else {
          print('No more users');
        }
      }
    });
  }

  /// Update list
  void _updateUserList(List<DocumentSnapshot> users) {
    if (mounted) {
      setState(() {
        _dislikedUsers!.addAll(users);
        if (users.isNotEmpty) {
          _userLastDoc = users.last;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _dislikesApi.getDislikedUsers(withLimit: true).then((users) {
      // Check result
      if (users.isNotEmpty) {
        if (mounted) {
          setState(() {
            _dislikedUsers = users;
            _userLastDoc = users.last;
          });
        }
      } else {
        setState(() => _dislikedUsers = []);
      }
    });

    /// Listener
    _loadMoreUsersListener();
  }

  @override
  void dispose() {
    _gridViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Initialization

    return Scaffold(
        appBar: AppBar(
          title: Text(_i18n.translate("disliked_profiles")!),
        ),
        body: Column(
          children: [
            /// Header Title
            BuildTitle(
              svgIconName: "close_icon",
              title: _i18n.translate("profiles_you_rejected")!,
            ),

            /// Matches
            Expanded(child: _showProfiles())
          ],
        ));
  }

  /// Show profiles
  Widget _showProfiles() {
    if (_dislikedUsers == null) {
      return Processing(text: _i18n.translate("loading"));
    } else if (_dislikedUsers!.isEmpty) {
      // No data
      return NoData(svgName: 'close_icon', text: _i18n.translate("no_dislike")!);
    } else {
      /// Show users
      return UsersGrid(
        gridViewController: _gridViewController,
        itemCount: _dislikedUsers!.length + 1,

        /// Workaround for loading more
        itemBuilder: (context, index) {
          /// Validate fake index
          if (index < _dislikedUsers!.length) {
            /// Get user id
            final userId = _dislikedUsers![index][DISLIKED_USER_ID];

            /// Load profile
            return FutureBuilder<DocumentSnapshot>(
                future: UserModel().getUser(userId),
                builder: (context, snapshot) {
                  /// Chech result
                  if (!snapshot.hasData) return LoadingCard();

                  /// Get user object
                  final Usuario user = Usuario.fromDocument(snapshot.data!.data()!  as Map);

                  /// Show user card
                  return GestureDetector(
                    child: ProfileCard(user: user, page: 'require_vip'),
                    onTap: () {
                      /// Check vip account
                      if (UserModel().userIsVip) {
                        /// Go to profile screen - using showDialog to
                        /// prevents reloading getUser FutureBuilder
                        showDialog(context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return ProfileScreen(
                                user: user,
                                hideDislikeButton: true,
                                fromDislikesScreen: true
                              );
                            }
                        );
                        /// Increment user visits an push notification
                        _visitsApi.visitUserProfile(
                          visitedUserId: user.userId,
                          userDeviceToken: user.userDeviceToken,
                          nMessage: "${UserModel().user.userFullname.split(' ')[0]}, "
                              "${_i18n.translate("visited_your_profile_click_and_see")}",
                        );
                      } else {
                        /// Show VIP dialog
                        showDialog(context: context, 
                          builder: (context) => VipDialog());
                      }
                    },
                  );
                });
          } else {
            return Container();
          }
        },
      );
    }
  }
}
