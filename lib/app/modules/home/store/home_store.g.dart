// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStore, Store {
  final _$contAtom = Atom(name: '_HomeStore.cont');

  @override
  int get cont {
    _$contAtom.reportRead();
    return super.cont;
  }

  @override
  set cont(int value) {
    _$contAtom.reportWrite(value, super.cont, () {
      super.cont = value;
    });
  }

  final _$checkUserVipStatusAsyncAction =
      AsyncAction('_HomeStore.checkUserVipStatus');

  @override
  Future<void> checkUserVipStatus() {
    return _$checkUserVipStatusAsyncAction
        .run(() => super.checkUserVipStatus());
  }

  @override
  String toString() {
    return '''
cont: ${cont}
    ''';
  }
}
