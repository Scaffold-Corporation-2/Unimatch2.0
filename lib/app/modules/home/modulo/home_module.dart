import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/modules/home/store/home_store.dart';
import 'package:uni_match/app/modules/home/view/home_page.dart';
import 'package:uni_match/app/modules/home/view/notifications_screen.dart';

 
class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeStore()),
 ];

 @override
 final List<ModularRoute> routes = [
   ChildRoute('/', child: (_, args) => HomeScreen()),
   ChildRoute('/notification', child: (_, args) => NotificationsScreen()),
 ];
}