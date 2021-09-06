import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/modules/profile/store/profile_store.dart';
import 'package:uni_match/app/modules/profile/view/about_us_screen.dart';
import 'package:uni_match/app/modules/profile/view/disliked_profile_screen.dart';
import 'package:uni_match/app/modules/profile/view/edit_profile_screen.dart';
import 'package:uni_match/app/modules/profile/view/passaport/passport_screen.dart';
import 'package:uni_match/app/modules/profile/view/profile_likes_screen.dart';
import 'package:uni_match/app/modules/profile/view/profile_screen.dart';
import 'package:uni_match/app/modules/profile/view/profile_visits_screen.dart';
import 'package:uni_match/app/modules/profile/view/settings_screen.dart';

class ProfileModule extends Module{
  @override
  List<Bind> get binds => [
    Bind((i) => ProfileStore()),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (_, args) => ProfileScreen(user: args.data)),
    ChildRoute('/visits', child: (_, args) => ProfileVisitsScreen()),
    ChildRoute('/likes', child: (_, args) => ProfileLikesScreen()),
    ChildRoute('/dislikes', child: (_, args) => DislikedProfilesScreen()),
    ChildRoute('/about', child: (_, args) => AboutScreen()),
    ChildRoute('/passaport', child: (_, args) =>  PassportScreen()),
    ChildRoute('/edit', child: (_, args) =>  EditProfileScreen()),
    ChildRoute('/settings', child: (_, args) => SettingsScreen(),
      transition: TransitionType.noTransition, ),
  ];
}