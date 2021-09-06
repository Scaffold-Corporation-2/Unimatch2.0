import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/modules/life/store/life_store.dart';
import 'package:uni_match/app/modules/life/view/bares_screen.dart';
import 'package:uni_match/app/modules/life/view/cafe_screen.dart';
import 'package:uni_match/app/modules/life/view/details_screen.dart';
import 'package:uni_match/app/modules/life/view/life_page.dart';
import 'package:uni_match/app/modules/life/view/movies_page.dart';
import 'package:uni_match/app/modules/life/view/movies_screen.dart';
import 'package:uni_match/app/modules/life/view/restaurants_screen.dart';

class LifeModule extends Module{
  @override
  List<Bind> get binds => [
    Bind.lazySingleton((i) => LifeStore()),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (_, args) => LifePage()),
    ChildRoute('/movies', child: (_, args) => MoviePage()),
    ChildRoute('/cafes', child: (_, args) => CafeScreen()),
    ChildRoute('/bares', child: (_, args) => BaresScreen()),
    ChildRoute('/rest', child: (_, args) => RestScreen()),
    ChildRoute('/details', child: (_, args) => DetailsScreen(lifeStyleModel: args.data,)),
    ChildRoute('/moviesScreen', child: (_, args) => MoviesScreen(tipoFilme: args.data,)),
  ];
}