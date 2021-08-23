import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/app/models/app_model.dart';
import 'package:uni_match/constants/constants.dart';
import 'package:uni_match/helpers/app_helper.dart';

class AboutScreen extends StatelessWidget {
  // Variables
  final AppHelper _appHelper = AppHelper();
  final AppController i18n = Modular.get();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(i18n.translate('about_us')!),
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 65),
        child: Center(
          child: Column(
            children: <Widget>[
              /// App icon
              Center(
                child: Image.asset(
                  "assets/images/app_logo.png",
                  width: 120,
                  height:120,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),

              /// App name
              Text(
                APP_NAME,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5),
              // slogan
              Text(i18n.translate('app_short_description')!,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  )),
              SizedBox(height: 15),
              // App description
              Text(i18n.translate('about_us_description')!,
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                  ),
                  textAlign: TextAlign.justify),
              // Share app button
              SizedBox(height: 10),
              TextButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor)
                ),
                icon: Icon(Icons.share, color: Colors.white),
                label: Text(i18n.translate('share_app')!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    )),
                onPressed: () async {
                  /// Share app
                  _appHelper.shareApp();
                },
              ),
              SizedBox(height: 10),
              // App version name
              Text(APP_VERSION_NAME,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              Divider(height: 30, thickness: 1),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Contact
                  Text(i18n.translate('do_you_have_a_question')!,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(i18n.translate('send_your_message_to_our_email_address')!,
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center),
                  Text(AppModel().appInfo.appEmail,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
