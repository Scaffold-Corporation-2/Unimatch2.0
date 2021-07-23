import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/modules/party/store/party_store.dart';
import 'package:uni_match/app/modules/party/view/party_page.dart';
import 'package:uni_match/app/modules/party/view/party_screen.dart';

class PartyModule extends Module{
  @override
  List<Bind> get binds => [
    Bind.lazySingleton((i) => PartyStore()),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (_, args) => PartyPage()),
    ChildRoute('/partyScreen', child: (_, args) => PartyScreen(party: args.data,)),
  ];
}