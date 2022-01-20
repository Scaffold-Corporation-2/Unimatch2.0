import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/modules/chat/modulo/chat_module.dart';
import 'package:uni_match/app/modules/life/modulo/life_module.dart';
import 'package:uni_match/app/modules/party/modulo/party_module.dart';
import 'package:uni_match/app/modules/profile/modulo/profile_module.dart';
import 'modules/home/modulo/home_module.dart';
import 'modules/login/modulo/login_module.dart';
import 'modules/auth/modulo/auth_module.dart';
import 'package:uni_match/app/app_controller.dart';
import 'modules/registration/modulo/registration_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AppController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: AuthModule()),
    ModuleRoute('/login', module: LoginModule()),
    ModuleRoute('/home', module: HomeModule()),
    ModuleRoute('/profile', module: ProfileModule()),
    ModuleRoute('/chat', module: ChatModule()),
    ModuleRoute('/party', module: PartyModule()),
    ModuleRoute('/lifeStyle', module: LifeModule()),
    ModuleRoute('/registration', module: RegistrationModule()),
  ];

}