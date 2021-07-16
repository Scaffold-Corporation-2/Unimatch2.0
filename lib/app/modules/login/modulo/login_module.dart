import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/modules/login/store/login_store.dart';
import 'package:uni_match/app/modules/login/view/sign_in/enable_location_screen.dart';
import 'package:uni_match/app/modules/login/view/sign_in/phone_screen.dart';
import 'package:uni_match/app/modules/login/view/sign_in/verification_code_screen.dart';
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
    ChildRoute('/update', child: (_, args) => UpdateAppScreen()),
    ChildRoute('/block',  child: (_, args) => BlockedAccountScreen()),

    ChildRoute('/signIn/phone', child: (_, args) => PhoneNumberScreen()),
    ChildRoute('/signIn/phone/enable', child: (_, args) => EnableLocationScreen(action: args.data,)),
    ChildRoute('/signIn/phone/verification', child: (_, args) => VerificationCodeScreen(verificationId: args.data,)),
  ];

}