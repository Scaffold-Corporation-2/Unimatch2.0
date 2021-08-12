import 'package:flutter/material.dart';
import 'package:uni_match/app/datas/user.dart';
import 'package:uni_match/app/models/user_model.dart';
import 'package:uni_match/helpers/app_helper.dart';
import 'package:uni_match/widgets/badge.dart';
import 'package:uni_match/widgets/show_like_or_dislike.dart';
import 'package:uni_match/widgets/svg_icon.dart';
import 'package:uni_match/plugins/swipe_stack/swipe_stack.dart';
import 'package:uni_match/dialogs/flag_user_dialog.dart';

import 'default_card_border.dart';

class ProfileCard extends StatelessWidget {
  /// User object
  final Usuario user;

  /// Screen to be checked
  final String? page;

  /// Swiper position
  final SwiperPosition? position;

  ProfileCard({Key? key, this.page, this.position, required this.user})
      : super(key: key);

  // Local variables
  final AppHelper _appHelper = AppHelper();

  @override
  Widget build(BuildContext context) {
    // Variables
    final bool requireVip =
        this.page == 'require_vip' && !UserModel().userIsVip;
    late ImageProvider userPhoto;
    // Check user vip status
    if (requireVip) {
       userPhoto = AssetImage('assets/images/crow_badge.png');
    } else {
       userPhoto = NetworkImage(user.userProfilePhoto);
    }

    //
    // Get User Birthday
    final DateTime userBirthday = DateTime(
        UserModel().user.userBirthYear,
        UserModel().user.userBirthMonth,
        UserModel().user.userBirthDay);
    // Get User Current Age
    final int userAge = UserModel().calculateUserAge(userBirthday);

    // Build profile card
    return Padding(
      key: UniqueKey(),
      padding: const EdgeInsets.all(9.0),
      child: Stack(
        children: [
          /// User Card
          Card(
            clipBehavior: Clip.antiAlias,
            elevation: 4.0,
            margin: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(28.0))),
            child: Container(
              decoration: BoxDecoration(
                /// User profile image
                image: DecorationImage(
                    /// Show VIP icon if user is not vip member
                    image: userPhoto,
                    fit: requireVip ? BoxFit.contain : BoxFit.cover),
              ),
              child: Container(
                /// BoxDecoration to make user info visible
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).primaryColor,
                        Colors.transparent
                      ]),
                ),

                /// User info container
                child: Container(
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// User fullname
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${user.userFullname.split(' ')[0]}, '
                              '${userAge.toString()}',
                              style: TextStyle(
                                  fontSize: this.page == 'discover' ? 25 : 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),

                      /// User education
                      Row(
                        children: [
                          SvgIcon("assets/icons/university_icon.svg",
                              color: Colors.white, width: 22, height: 22),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              user.userSchool,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: this.page == 'discover' ? 18 : 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),

                      Row(
                        children: [
                          SvgIcon("assets/icons/gender_icon.svg",
                              color: Colors.white, width: 20, height: 20),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              user.userOrientation,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: this.page == 'discover' ? 18 : 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      this.page == 'discover'
                          ? SizedBox(height: 70)
                          : Container(width: 0, height: 0),
                    ],
                  ),
                ),
              ),
            ),
          ),

          /// Show location distance
          Positioned(
            top: 10,
            left: this.page == 'discover' ? 8 : 5,
            child: Badge(
                icon: this.page == 'discover'
                    ? SvgIcon("assets/icons/location_point_icon.svg",
                        color: Colors.white, width: 15, height: 15)
                    : null,
                text:
                    '${_appHelper.getDistanceBetweenUsers(userLat: user.userGeoPoint.latitude, userLong: user.userGeoPoint.longitude)}km'),
          ),

          /// Show Like or Dislike
          this.page == 'discover'
              ? ShowLikeOrDislike(position: position!)
              : Container(width: 0, height: 0),

          /// Show message icon
          // Todo verificar se matem ou retira
          /// icone de msg na TAB Matches
          // this.page == 'matches'
          //     ? Positioned(
          //         bottom: 5,
          //         right: 5,
          //         child: Container(
          //             padding: EdgeInsets.all(7),
          //             decoration: BoxDecoration(
          //               color: Theme.of(context).primaryColor,
          //               shape: BoxShape.circle,
          //             ),
          //             child: SvgIcon("assets/icons/message_icon.svg",
          //                 color: Colors.white, width: 30, height: 30)
          //         ),
          //       )
          //     : Container(width: 0, height: 0),

          /// Show flag profile icon
          this.page == 'discover'
              ? Positioned(
                  right: 0,
                  child: IconButton(
                      icon: Icon(Icons.flag,
                          color: Theme.of(context).primaryColor),
                      onPressed: () {
                        /// Flag user profile
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return FlagUserDialog(flaggedUserId: user.userId);
                            });
                      }))
              : Container(width: 0, height: 0),
        ],
      ),
    );
  }
}
