import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/app/models/app_model.dart';

class BlockedAccountScreen extends StatelessWidget {
  final AppController i18n = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(Icons.lock_outline, size: 60, color: Colors.white),
              ),
              Text(i18n.translate("oops")!),
              Text(i18n.translate("your_account_was_blocked")!,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(i18n.translate("please_contact_support_to_active_it")!),
              SizedBox(height: 10),
              Text(AppModel().appInfo.appEmail,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 18),
                  textAlign: TextAlign.center),
            ],
          ),
        ));
  }
}
