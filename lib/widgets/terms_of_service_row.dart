import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/app/models/app_model.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsOfServiceRow extends StatelessWidget {
  // Params
  final Color color;

  TermsOfServiceRow({this.color = Colors.white});

  final  AppController i18n = Modular.get();

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          child: Text(
            i18n.translate("terms_of_service")!,
            style: TextStyle(
                color: color,
                fontSize: 17,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold),
          ),
          onTap: () {
            // Open terms of service page in browser
            openTermsPage();
          },
        ),
        Text(
          ' | ',
          style: TextStyle(
              color: color, fontSize: 17, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          child: Text(
            i18n.translate("privacy_policy")!,
            style: TextStyle(
                color: color,
                fontSize: 17,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold),
          ),
          onTap: () {
            // Open privacy policy page in browser
            openPrivacyPage();
          },
        ),
      ],
    );
  }
  /// Open Terms of Services in Browser
  Future<void> openTermsPage() async {
    // Try to launch
    if (await canLaunch(AppModel().appInfo.termsOfServicesUrl)) {
      await launch(AppModel().appInfo.termsOfServicesUrl);
    } else {
      throw "Não foi possível abrir url";
    }
  }

  /// Open Privacy Policy Page in Browser
  Future<void> openPrivacyPage() async {
    if (await canLaunch(AppModel().appInfo.privacyPolicyUrl)) {
      await launch(AppModel().appInfo.privacyPolicyUrl);
    } else {
      throw "Could not launch url";
    }
  }
}
