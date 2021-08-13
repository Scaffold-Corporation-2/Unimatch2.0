// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStore, Store {
  final _$formKeyAtom = Atom(name: '_LoginStore.formKey');

  @override
  GlobalKey<FormState>? get formKey {
    _$formKeyAtom.reportRead();
    return super.formKey;
  }

  @override
  set formKey(GlobalKey<FormState>? value) {
    _$formKeyAtom.reportWrite(value, super.formKey, () {
      super.formKey = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_LoginStore.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$initialDateTimeAtom = Atom(name: '_LoginStore.initialDateTime');

  @override
  DateTime get initialDateTime {
    _$initialDateTimeAtom.reportRead();
    return super.initialDateTime;
  }

  @override
  set initialDateTime(DateTime value) {
    _$initialDateTimeAtom.reportWrite(value, super.initialDateTime, () {
      super.initialDateTime = value;
    });
  }

  final _$agreeTermsAtom = Atom(name: '_LoginStore.agreeTerms');

  @override
  bool get agreeTerms {
    _$agreeTermsAtom.reportRead();
    return super.agreeTerms;
  }

  @override
  set agreeTerms(bool value) {
    _$agreeTermsAtom.reportWrite(value, super.agreeTerms, () {
      super.agreeTerms = value;
    });
  }

  final _$selectedGenderAtom = Atom(name: '_LoginStore.selectedGender');

  @override
  String? get selectedGender {
    _$selectedGenderAtom.reportRead();
    return super.selectedGender;
  }

  @override
  set selectedGender(String? value) {
    _$selectedGenderAtom.reportWrite(value, super.selectedGender, () {
      super.selectedGender = value;
    });
  }

  final _$selectedOrientationAtom =
      Atom(name: '_LoginStore.selectedOrientation');

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

  final _$birthdayAtom = Atom(name: '_LoginStore.birthday');

  @override
  String? get birthday {
    _$birthdayAtom.reportRead();
    return super.birthday;
  }

  @override
  set birthday(String? value) {
    _$birthdayAtom.reportWrite(value, super.birthday, () {
      super.birthday = value;
    });
  }

  final _$imageFileAtom = Atom(name: '_LoginStore.imageFile');

  @override
  File? get imageFile {
    _$imageFileAtom.reportRead();
    return super.imageFile;
  }

  @override
  set imageFile(File? value) {
    _$imageFileAtom.reportWrite(value, super.imageFile, () {
      super.imageFile = value;
    });
  }

  final _$emailLoginAsyncAction = AsyncAction('_LoginStore.emailLogin');

  @override
  Future<void> emailLogin(String userEmail, String userPassword) {
    return _$emailLoginAsyncAction
        .run(() => super.emailLogin(userEmail, userPassword));
  }

  final _$getImageAsyncAction = AsyncAction('_LoginStore.getImage');

  @override
  Future getImage(BuildContext context) {
    return _$getImageAsyncAction.run(() => super.getImage(context));
  }

  final _$_LoginStoreActionController = ActionController(name: '_LoginStore');

  @override
  dynamic nameBirthday() {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.nameBirthday');
    try {
      return super.nameBirthday();
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic selecionarGenero(String gender) {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.selecionarGenero');
    try {
      return super.selecionarGenero(gender);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic selecionarOrientacao(String orient) {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.selecionarOrientacao');
    try {
      return super.selecionarOrientacao(orient);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setAgreeTerms(bool value) {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.setAgreeTerms');
    try {
      return super.setAgreeTerms(value);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateUserBithdayInfo(DateTime date) {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.updateUserBithdayInfo');
    try {
      return super.updateUserBithdayInfo(date);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic showDatePicker(dynamic context) {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.showDatePicker');
    try {
      return super.showDatePicker(context);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
formKey: ${formKey},
isLoading: ${isLoading},
initialDateTime: ${initialDateTime},
agreeTerms: ${agreeTerms},
selectedGender: ${selectedGender},
selectedOrientation: ${selectedOrientation},
birthday: ${birthday},
imageFile: ${imageFile}
    ''';
  }
}
