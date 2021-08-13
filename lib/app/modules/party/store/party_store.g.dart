// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PartyStore on _PartyStore, Store {
  final _$listaFestasAtom = Atom(name: '_PartyStore.listaFestas');

  @override
  ObservableList<DocumentSnapshot<Object?>> get listaFestas {
    _$listaFestasAtom.reportRead();
    return super.listaFestas;
  }

  @override
  set listaFestas(ObservableList<DocumentSnapshot<Object?>> value) {
    _$listaFestasAtom.reportWrite(value, super.listaFestas, () {
      super.listaFestas = value;
    });
  }

  final _$carregandoValoresAtom = Atom(name: '_PartyStore.carregandoValores');

  @override
  bool get carregandoValores {
    _$carregandoValoresAtom.reportRead();
    return super.carregandoValores;
  }

  @override
  set carregandoValores(bool value) {
    _$carregandoValoresAtom.reportWrite(value, super.carregandoValores, () {
      super.carregandoValores = value;
    });
  }

  final _$valueSharedAtom = Atom(name: '_PartyStore.valueShared');

  @override
  dynamic get valueShared {
    _$valueSharedAtom.reportRead();
    return super.valueShared;
  }

  @override
  set valueShared(dynamic value) {
    _$valueSharedAtom.reportWrite(value, super.valueShared, () {
      super.valueShared = value;
    });
  }

  final _$getPartiesAsyncAction = AsyncAction('_PartyStore.getParties');

  @override
  Future getParties() {
    return _$getPartiesAsyncAction.run(() => super.getParties());
  }

  final _$dadosCacheAsyncAction = AsyncAction('_PartyStore.dadosCache');

  @override
  Future dadosCache() {
    return _$dadosCacheAsyncAction.run(() => super.dadosCache());
  }

  @override
  String toString() {
    return '''
listaFestas: ${listaFestas},
carregandoValores: ${carregandoValores},
valueShared: ${valueShared}
    ''';
  }
}
