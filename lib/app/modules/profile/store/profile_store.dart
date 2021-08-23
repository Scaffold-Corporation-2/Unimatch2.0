import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:uni_match/app/app_controller.dart';
part 'profile_store.g.dart';

class ProfileStore = _ProfileStore with _$ProfileStore;

abstract class _ProfileStore with Store{
  final AppController i18n = Modular.get();

  @observable
  String? selectedOrientation;

  List<String> sexualOrientation = [
    'Heterossexual',
    'Gay',
    'Lésbica',
    'Bissexual',
    'Assexual',
    'Pansexual',
    'Demissexual',
    'Queer',
    'Questionado'
  ];

  @action
  selecionarOrientacao(String orient) => selectedOrientation = orient;
}

