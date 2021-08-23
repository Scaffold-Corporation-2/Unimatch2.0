// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileStore on _ProfileStore, Store {
  final _$selectedOrientationAtom =
      Atom(name: '_ProfileStore.selectedOrientation');

  @override
  String? get selectedOrientation {
    _$selectedOrientationAtom.reportRead();
    return super.selectedOrientation;
  }

  @override
  set selectedOrientation(String? value) {
    _$selectedOrientationAtom.reportWrite(value, super.selectedOrientation, () {
      super.selectedOrientation = value;
    });
  }

  final _$_ProfileStoreActionController =
      ActionController(name: '_ProfileStore');

  @override
  dynamic selecionarOrientacao(String orient) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction(
        name: '_ProfileStore.selecionarOrientacao');
    try {
      return super.selecionarOrientacao(orient);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedOrientation: ${selectedOrientation}
    ''';
  }
}
