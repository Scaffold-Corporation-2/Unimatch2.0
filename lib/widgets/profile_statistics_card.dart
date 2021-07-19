import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/app/models/user_model.dart';
import 'package:uni_match/app/modules/profile/view/profile_likes_screen.dart';
import 'package:uni_match/widgets/default_card_border.dart';
import 'package:uni_match/widgets/svg_icon.dart';

class ProfileStatisticsCard extends StatelessWidget {
  // Text style
  final _textStyle = TextStyle(
    color: Colors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    /// Initialization
    final AppController i18n = Modular.get();

    return Card(
      elevation: 4.0,
      color: Colors.grey[100],
      shape: defaultCardBorder(),
      child: Column(
        children: [
          ListTile(
            leading: SvgIcon("assets/icons/heart_icon.svg",
                width: 22, height: 22, color: Theme.of(context).primaryColor),
            title: Text(i18n.translate("LIKES")!, style: _textStyle),
            trailing: _counter(context, UserModel().user.userTotalLikes),
            onTap: () {
              /// Go to profile likes screen
             // Modular.to.pushNamed('/profile/likes');
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => ProfileLikesScreen()));
            },
          ),
          Divider(height: 0),
          ListTile(
            leading: SvgIcon("assets/icons/eye_icon.svg",
                width: 31, height: 31, color: Theme.of(context).primaryColor),
            title: Text(i18n.translate("VISITS")!, style: _textStyle),
            trailing: _counter(context, UserModel().user.userTotalVisits),
            onTap: () {
              /// Go to profile visits screen
              Modular.to.pushNamed('/profile/visits');
            },
          ),
          Divider(height: 0),
          ListTile(
            leading: SvgIcon("assets/icons/close_icon.svg",
                width: 25, height: 25, color: Theme.of(context).primaryColor),
            title: Text(i18n.translate("DISLIKED_PROFILES")!, style: _textStyle),
            trailing: _counter(context, UserModel().user.userTotalDisliked),
            onTap: () {
              /// Go to disliked profile screen
              Modular.to.pushNamed('/profile/dislikes');
              // Navigator.of(context).push(
              //     MaterialPageRoute(
              //         builder: (context) => DislikedProfilesScreen()));
            },
          ),
        ],
      ),
    );
  }

  Widget _counter(BuildContext context, int value) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor, //.withAlpha(85),
          shape: BoxShape.circle),
      padding: const EdgeInsets.all(6.0),
      child: Text(value.toString(), style: TextStyle(color: Colors.white)));
  }
}
