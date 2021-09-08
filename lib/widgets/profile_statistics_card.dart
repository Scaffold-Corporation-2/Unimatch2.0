import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/app/models/user_model.dart';
import 'package:uni_match/widgets/default_card_border.dart';
import 'package:uni_match/widgets/svg_icon.dart';

class ProfileStatisticsCard extends StatelessWidget {

  final AppController i18n = Modular.get();

  // Text style
  TextStyle _textStyle(context){
    return GoogleFonts.nunito(
      color: Theme.of(context).primaryColorDark.withOpacity(0.9),
      fontSize: 16.0,
      fontWeight: FontWeight.w700,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Observer(
      builder:(_) => Card(
        elevation: 4.0,
        color: i18n.isDark ? Theme.of(context).cardColor : Colors.grey[100],
        shape: defaultCardBorder(),

        child: Column(
          children: [
            ListTile(
              leading: SvgIcon("assets/icons/heart_icon.svg",
                  width: 22, height: 22, color: i18n.isDark ? Colors.grey : Theme.of(context).primaryColor),
              title: Text(i18n.translate("LIKES")!, style: _textStyle(context)),
              trailing: _counter(context, UserModel().user.userTotalLikes),
              onTap: () {
                /// Go to profile likes screen
               Modular.to.pushNamed('/profile/likes');
              },
            ),
            Divider(height: 0),
            ListTile(
              leading: SvgIcon("assets/icons/eye_icon.svg",
                  width: 28, height: 28, color: i18n.isDark ? Colors.grey : Theme.of(context).primaryColor),
              title: Text(i18n.translate("VISITS")!, style: _textStyle(context)),
              trailing: _counter(context, UserModel().user.userTotalVisits),
              onTap: () {
                Modular.to.pushNamed('/profile/visits');
              },
            ),
            Divider(height: 0),
            ListTile(
              leading: SvgIcon("assets/icons/close_icon.svg",
                  width: 25, height: 25, color: i18n.isDark ? Colors.grey : Theme.of(context).primaryColor),
              title: Text(i18n.translate("DISLIKED_PROFILES")!, style: _textStyle(context)),
              trailing: _counter(context, UserModel().user.userTotalDisliked),
              onTap: () {
                /// Go to disliked profile screen
                Modular.to.pushNamed('/profile/dislikes');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _counter(BuildContext context, int value) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor, //.withAlpha(85),
          shape: BoxShape.circle),
      padding: EdgeInsets.all(value > 999 ? 9 : 6.0),
      child: Text( value > 999 ? "999+": value.toString(),
          style: TextStyle(color: Colors.white)
      )
    );
  }
}
