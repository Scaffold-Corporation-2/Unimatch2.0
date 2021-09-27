// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppController on _AppController, Store {
  final _$localeAtom = Atom(name: '_AppController.locale');

  @override
  Locale get locale {
    _$localeAtom.reportRead();
    return super.locale;
  }

  @override
  set locale(Locale value) {
    _$localeAtom.reportWrite(value, super.locale, () {
      super.locale = value;
    });
  }

  final _$localizedStringsAtom = Atom(name: '_AppController.localizedStrings');

  @override
  Map<String, String>? get localizedStrings {
    _$localizedStringsAtom.reportRead();
    return super.localizedStrings;
  }

  @override
  set localizedStrings(Map<String, String>? value) {
    _$localizedStringsAtom.reportWrite(value, super.localizedStrings, () {
      super.localizedStrings = value;
    });
  }

  final _$virtualButtonAtom = Atom(name: '_AppController.virtualButton');

  @override
  bool get virtualButton {
    _$virtualButtonAtom.reportRead();
    return super.virtualButton;
  }

  @override
  set virtualButton(bool value) {
    _$virtualButtonAtom.reportWrite(value, super.virtualButton, () {
      super.virtualButton = value;
    });
  }

  final _$isDarkAtom = Atom(name: '_AppController.isDark');

  @override
  bool get isDark {
    _$isDarkAtom.reportRead();
    return super.isDark;
  }

  @override
  set isDark(bool value) {
    _$isDarkAtom.reportWrite(value, super.isDark, () {
      super.isDark = value;
    });
  }

  final _$loadAsyncAction = AsyncAction('_AppController.load');

  @override
  Future<dynamic> load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  final _$alterarVirtualButtonAsyncAction =
      AsyncAction('_AppController.alterarVirtualButton');

  @override
  Future alterarVirtualButton() {
    return _$alterarVirtualButtonAsyncAction
        .run(() => super.alterarVirtualButton());
  }

  final _$buscarVirtualButtonAsyncAction =
      AsyncAction('_AppController.buscarVirtualButton');

  @override
  Future buscarVirtualButton() {
    return _$buscarVirtualButtonAsyncAction
        .run(() => super.buscarVirtualButton());
  }

  final _$buscarThemeAsyncAction = AsyncAction('_AppController.buscarTheme');

  @override
  Future buscarTheme() {
    return _$buscarThemeAsyncAction.run(() => super.buscarTheme());
  }

  final _$alterarThemeAsyncAction = AsyncAction('_AppController.alterarTheme');

  @override
  Future alterarTheme() {
    return _$alterarThemeAsyncAction.run(() => super.alterarTheme());
  }

  final _$_AppControllerActionController =
      ActionController(name: '_AppController');

  @override
  dynamic mudarIdioma() {
    final _$actionInfo = _$_AppControllerActionController.startAction(
        name: '_AppController.mudarIdioma');
    try {
      return super.mudarIdioma();
    } finally {
      _$_AppControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
locale: ${locale},
localizedStrings: ${localizedStrings},
virtualButton: ${virtualButton},
isDark: ${isDark}
    ''';
  }
}
