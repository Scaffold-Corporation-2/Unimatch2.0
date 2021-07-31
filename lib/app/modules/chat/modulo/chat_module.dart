import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/modules/chat/store/chat_store.dart';
import 'package:uni_match/app/modules/chat/view/chat_screen.dart';

class ChatModule extends Module{
  @override
  List<Bind> get binds => [
    Bind.lazySingleton((i) => ChatStore()),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (_, args) => ChatScreen(user: args.data)),
  ];
}
