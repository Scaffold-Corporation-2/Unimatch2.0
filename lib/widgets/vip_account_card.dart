import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/dialogs/vip_dialog.dart';
import 'package:uni_match/widgets/default_card_border.dart';

class VipAccountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Initialization
    final AppController i18n = Modular.get();

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 4.0,
      shape: defaultCardBorder(),
      child: ListTile(
        leading: Image.asset("assets/images/crow_badge_small.png",
            width: 35, height: 35),
        title: Text(i18n.translate("vip_account")!,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          /// Show VIP dialog
          showDialog(context: context,
            builder: (context) => VipDialog());
        },
      ),
    );
  }
}
