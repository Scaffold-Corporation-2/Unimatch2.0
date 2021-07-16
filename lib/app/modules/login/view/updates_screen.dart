import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/app/modules/login/store/login_store.dart';
import 'package:uni_match/constants/constants.dart';
import 'package:uni_match/widgets/app_logo.dart';

/// View para informar que há atualizações para o app
// ignore: must_be_immutable
class UpdateAppScreen extends StatelessWidget {

  AppController _i18n = Modular.get();
  LoginStore _controller = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_i18n.translate('update_application')!),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /// App logo
              AppLogo(),
              SizedBox(height: 10),

              /// App name
              Text(APP_NAME,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Text(_i18n.translate('app_new_version')!,
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              SizedBox(height: 10),
              Text(_i18n.translate("please_install_it_now")!,
                  style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
              SizedBox(height: 5),
              Text(_i18n.translate("don_worry_your_data_will_not_be_lost")!,
                  style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
              Divider(thickness: 1),
              Text(_i18n.translate("click_this_button_to_install")!,
                  style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
              GestureDetector(
                child: Image.asset(Platform.isAndroid
                    ? "assets/images/google_play_badge.png"
                    : "assets/images/apple_store_badge.png"),
                onTap: () {
                  /// Open app store - Google Play / Apple Store
                  _controller.openAppStore();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
