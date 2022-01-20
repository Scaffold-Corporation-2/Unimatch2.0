import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/modules/registration/store/registration_store.dart';
import 'package:uni_match/app/modules/registration/view/academic_registration.dart';
import 'package:uni_match/app/modules/registration/view/checkin_page.dart';
import 'package:uni_match/app/modules/registration/view/fura_fila_page.dart';
import 'package:uni_match/app/modules/registration/view/registration_page.dart';


class RegistrationModule extends Module{
  @override
  List<Bind> get binds => [
    Bind((i) => RegistrationStore()),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (_, args) => RegistrationPage()),
    ChildRoute('/registration2', child: (_, args) => AcademicRegistrationPage(controller: args.data,)),
    ChildRoute('/registration3', child: (_, args) => CheckinRegistrationPage(controller: args.data)),
    ChildRoute('/furaFila', child: (_, args) => FuraFilaPage()),
  ];

}