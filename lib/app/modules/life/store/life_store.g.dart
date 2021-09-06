// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'life_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LifeStore on _LifeStore, Store {
  final _$listaFilmesAtom = Atom(name: '_LifeStore.listaFilmes');

  @override
  ObservableList<Movie> get listaFilmes {
    _$listaFilmesAtom.reportRead();
    return super.listaFilmes;
  }

  @override
  set listaFilmes(ObservableList<Movie> value) {
    _$listaFilmesAtom.reportWrite(value, super.listaFilmes, () {
      super.listaFilmes = value;
    });
  }

  final _$listaFilmesFiltradosAtom =
      Atom(name: '_LifeStore.listaFilmesFiltrados');

  @override
  ObservableList<Movie> get listaFilmesFiltrados {
    _$listaFilmesFiltradosAtom.reportRead();
    return super.listaFilmesFiltrados;
  }

  @override
  set listaFilmesFiltrados(ObservableList<Movie> value) {
    _$listaFilmesFiltradosAtom.reportWrite(value, super.listaFilmesFiltrados,
        () {
      super.listaFilmesFiltrados = value;
    });
  }

  final _$listaCafesAtom = Atom(name: '_LifeStore.listaCafes');

  @override
  ObservableList<LifeStyleModel> get listaCafes {
    _$listaCafesAtom.reportRead();
    return super.listaCafes;
  }

  @override
  set listaCafes(ObservableList<LifeStyleModel> value) {
    _$listaCafesAtom.reportWrite(value, super.listaCafes, () {
      super.listaCafes = value;
    });
  }

  final _$listaBaresAtom = Atom(name: '_LifeStore.listaBares');

  @override
  ObservableList<LifeStyleModel> get listaBares {
    _$listaBaresAtom.reportRead();
    return super.listaBares;
  }

  @override
  set listaBares(ObservableList<LifeStyleModel> value) {
    _$listaBaresAtom.reportWrite(value, super.listaBares, () {
      super.listaBares = value;
    });
  }

  final _$listaRestAtom = Atom(name: '_LifeStore.listaRest');

  @override
  ObservableList<LifeStyleModel> get listaRest {
    _$listaRestAtom.reportRead();
    return super.listaRest;
  }

  @override
  set listaRest(ObservableList<LifeStyleModel> value) {
    _$listaRestAtom.reportWrite(value, super.listaRest, () {
      super.listaRest = value;
    });
  }

  final _$carregandoValoresAtom = Atom(name: '_LifeStore.carregandoValores');

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

  final _$getMoviesAsyncAction = AsyncAction('_LifeStore.getMovies');

  @override
  Future getMovies() {
    return _$getMoviesAsyncAction.run(() => super.getMovies());
  }

  final _$getPlacesAsyncAction = AsyncAction('_LifeStore.getPlaces');

  @override
  Future getPlaces() {
    return _$getPlacesAsyncAction.run(() => super.getPlaces());
  }

  final _$_LifeStoreActionController = ActionController(name: '_LifeStore');

  @override
  dynamic filtrarFilmes(String tipoFilme) {
    final _$actionInfo = _$_LifeStoreActionController.startAction(
        name: '_LifeStore.filtrarFilmes');
    try {
      return super.filtrarFilmes(tipoFilme);
    } finally {
      _$_LifeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listaFilmes: ${listaFilmes},
listaFilmesFiltrados: ${listaFilmesFiltrados},
listaCafes: ${listaCafes},
listaBares: ${listaBares},
listaRest: ${listaRest},
carregandoValores: ${carregandoValores}
    ''';
  }
}
