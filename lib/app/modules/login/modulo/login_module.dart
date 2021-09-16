import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/modules/login/store/login_store.dart';
import 'package:uni_match/app/modules/login/view/interests.dart';
import 'package:uni_match/app/modules/login/view/intro_rules.dart';
import 'package:uni_match/app/modules/login/view/how_to_sign_up.dart';
import 'package:uni_match/app/modules/login/view/sign_in_page.dart';
import 'package:uni_match/app/modules/login/view/sign_up_page.dart';
import 'package:uni_match/app/modules/login/view/updates_screen.dart';
import 'package:uni_match/app/modules/login/view/block_account.dart';

class LoginModule extends Module{
  @override
  List<Bind> get binds => [
    Bind((i) => LoginStore()),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/signIn', child: (_, args) => SignInScreen()),
    ChildRoute('/signUp', child: (_, args) => SignUpScreen()),
    ChildRoute('/intro', child: (_, args) => IntroRules()),
    ChildRoute('/update', child: (_, args) => UpdateAppScreen()),
    ChildRoute('/block',  child: (_, args) => BlockedAccountScreen()),
    ChildRoute('/information',  child: (_, args) => HowToSignUpScreen()),
    ChildRoute('/interests',  child: (_, args) => InterestsChips()),
  ];

}