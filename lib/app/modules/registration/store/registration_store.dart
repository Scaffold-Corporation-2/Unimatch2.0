import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'registration_store.g.dart';

class RegistrationStore = _RegistrationStore with _$RegistrationStore;

abstract class _RegistrationStore with Store {
  //Crontroller Registro Nome
  final nameController = TextEditingController();
  //Crontroller Registro Email
  final emailController = TextEditingController();
  //Crontroller Registro Insta
  final instaController = TextEditingController();
  //Crontroller Registro Universidade
  final universidadeController = TextEditingController();
  //Crontroller Registro Curso
  final cursoControler = TextEditingController();
  //Crontroller Registro Ano de inicio
  final anoiController = TextEditingController();
  //Crontroller Registro Ano de saida
  final anofController = TextEditingController();
  //Crontroller Registro Codigo da Atletica
  final codigoAtleticaController = TextEditingController();

  //Controle de dados Resgistro
  @observable
  bool dados = false;

  @action
  dateRegistrationpage1() {
    if (nameController.text != '' &&
        emailController.text != '' &&
        instaController.text != '') {
      dados = true;
    } else
      dados = false;
  }

}
