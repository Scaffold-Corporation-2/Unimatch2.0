import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/widgets/default_card_border.dart';

class RegistrationShowDialog extends StatelessWidget {
  final String email;
  RegistrationShowDialog({Key? key, required this.email}) : super(key: key);

  final AppController i18n = Modular.get();
  @override
  Widget build(BuildContext context) => AlertDialog(
    shape: defaultCardBorder(),
    title: Row(
      children: [
        Icon(
          Icons.check,
          color: Colors.pink,
        ),
        SizedBox(width: 10),
        Expanded(child: Text(i18n.translate("Congratulations")!, style: TextStyle(fontSize: 22)))
      ],
    ),
    content: Text(
        i18n.translate("Registration completed successfully")!,
      style: TextStyle(fontSize: 18),
    ),
    actions: [
      /// Negative button
      TextButton(
          onPressed: () async {
            Modular.to.navigate("/registration/furaFila");
          },
          child: Text(("OK"),
              style: TextStyle(fontSize: 18, color: Colors.pinkAccent))),
    ],
  );
}