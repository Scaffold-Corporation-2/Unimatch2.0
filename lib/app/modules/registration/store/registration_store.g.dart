// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RegistrationStore on _RegistrationStore, Store {
  final _$dadosAtom = Atom(name: '_RegistrationStore.dados');

  @override
  bool get dados {
    _$dadosAtom.reportRead();
    return super.dados;
  }

  @override
  set dados(bool value) {
    _$dadosAtom.reportWrite(value, super.dados, () {
      super.dados = value;
    });
  }

  final _$_RegistrationStoreActionController =
      ActionController(name: '_RegistrationStore');

  @override
  dynamic dateRegistrationpage1() {
    final _$actionInfo = _$_RegistrationStoreActionController.startAction(
        name: '_RegistrationStore.dateRegistrationpage1');
    try {
      return super.dateRegistrationpage1();
    } finally {
      _$_RegistrationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dados: ${dados}
    ''';
  }
}
