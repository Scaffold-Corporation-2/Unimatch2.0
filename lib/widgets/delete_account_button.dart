import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/app/models/user_model.dart';
import 'package:uni_match/widgets/default_button.dart';
import 'package:uni_match/dialogs/common_dialogs.dart';

class DeleteAccountButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppController i18n = Modular.get();

    return Center(
      child: DefaultButton(
        child: Text(i18n.translate("delete_account")!,
            style: TextStyle(fontSize: 18)),
        onPressed: () {
          /// Delete account
          ///
          /// Confirm dialog
          infoDialog(context,
              icon: CircleAvatar(
                backgroundColor: Colors.red,
                child: Icon(Icons.close, color: Colors.white),
              ),
              title: '${i18n.translate("delete_account")} ?',
              message: i18n.translate(
                  'all_your_profile_data_will_be_permanently_deleted')!,
              negativeText: i18n.translate("CANCEL"),
              positiveText: i18n.translate("DELETE"),
              negativeAction: () => Navigator.of(context).pop(),
              positiveAction: () async {
                // Close confirm dialog
                Navigator.of(context).pop();

                // Log out first
                UserModel().signOut().then((_) {
                  /// Go to delete account screen
                  Future(() {
                    Modular.to.navigate('/profile/delete');
                  });
                });
              });
        },
      ),
    );
  }
}
