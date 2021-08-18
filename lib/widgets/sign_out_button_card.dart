import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/app/models/user_model.dart';
import 'package:uni_match/widgets/default_card_border.dart';

class SignOutButtonCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppController i18n = Modular.get();

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 4.0,
      shape: defaultCardBorder(),
      child: ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text(i18n.translate("sign_out")!, style: TextStyle(fontSize: 18)),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          // Log out button
          UserModel().signOut().then((_) {
            /// Go to login screen
            Future(() {
              Modular.to.navigate('/login/signIn');
              // Navigator.of(context).popUntil((route) => route.isFirst);
              // Navigator.of(context).pushReplacement(
              //     MaterialPageRoute(builder: (context) => SignInScreen()));
            });
          });
        },
      ),
    );
  }
}
