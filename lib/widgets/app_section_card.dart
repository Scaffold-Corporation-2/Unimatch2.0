import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/helpers/app_helper.dart';
import 'package:uni_match/widgets/default_card_border.dart';
import 'package:uni_match/widgets/svg_icon.dart';

class AppSectionCard extends StatelessWidget {

  final AppHelper _appHelper = AppHelper();
  final AppController i18n = Modular.get();

  TextStyle _textStyle(context){
    return GoogleFonts.nunito(
      color: Theme.of(context).primaryColorDark.withOpacity(0.9),
      fontSize: 16.0,
      fontWeight: FontWeight.w700,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 4.0,
      shape: defaultCardBorder(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(i18n.translate("application")!,
                style: TextStyle(fontSize: 20, color: Colors.grey),
                textAlign: TextAlign.left),
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text(i18n.translate("about_us")!, style: _textStyle(context)),
            onTap: () {
              /// Go to About us screen
              Modular.to.pushNamed('/profile/about');
            },
          ),
          Divider(height: 0),
          ListTile(
            leading: Icon(Icons.share),
            title:
                Text(i18n.translate("share_with_friends")!, style: _textStyle(context)),
            onTap: () async {
              /// Share app
              _appHelper.shareApp();
            },
          ),
          Divider(height: 0),
          ListTile(
            leading:
                SvgIcon("assets/icons/star_icon.svg", width: 22, height: 22),
            title: Text(
                i18n.translate(Platform.isAndroid
                    ? "rate_on_play_store"
                    : "rate_on_app_store")!,
                style: _textStyle(context)),
            onTap: () async {
              /// Rate app
              _appHelper.reviewApp();
            },
          ),
          Divider(height: 0),
          ListTile(
            leading:
                SvgIcon("assets/icons/lock_icon.svg", width: 22, height: 22),
            title: Text(i18n.translate("privacy_policy")!, style: _textStyle(context)),
            onTap: () async {
              /// Go to privacy policy
              _appHelper.openPrivacyPage();
            },
          ),
          Divider(height: 0),
          ListTile(
            leading: Icon(Icons.copyright_outlined, color: Colors.grey),
            title: Text(i18n.translate("terms_of_service")!, style: _textStyle(context)),
            onTap: () async {
              /// Go to privacy policy
              _appHelper.openTermsPage();
            },
          ),
        ],
      ),
    );
  }
}
