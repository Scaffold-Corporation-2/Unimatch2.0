import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/app/datas/lifeStyle.dart';
import 'package:uni_match/app/datas/movie.dart';
import 'package:uni_match/app/models/app_model.dart';
import 'package:uni_match/app/models/user_model.dart';
import 'package:uni_match/constants/constants.dart';
import 'package:mobx/mobx.dart';
part 'life_store.g.dart';

class LifeStore = _LifeStore with _$LifeStore;

abstract class _LifeStore with Store{

  final AppController i18n = Modular.get();
  final _firestore = FirebaseFirestore.instance;

  @observable
  ObservableList <Movie> listaFilmes = ObservableList();

  @observable
  ObservableList <Movie> listaFilmesFiltrados = ObservableList();

  @observable
  ObservableList <LifeStyleModel> listaCafes = ObservableList();

  @observable
  ObservableList <LifeStyleModel> listaBares = ObservableList();

  @observable
  ObservableList <LifeStyleModel> listaRest = ObservableList();

  @observable
  bool carregandoValores = false;

  @action
  filtrarFilmes(String tipoFilme){
    listaFilmesFiltrados.clear();
    carregandoValores = true;

    for(var filme in listaFilmes){
      if(filme.tipoFilme == tipoFilme){
        listaFilmesFiltrados.add(filme);
      }
    }
    carregandoValores = false;
  }

  @action
  getMovies()async{
    QuerySnapshot<Map<String, dynamic>> movieQuery = await _firestore
        .collection(C_MOVIES)
        .orderBy(DATE_MOVIE, descending: false).get();

    for(var dados in movieQuery .docs){
      listaFilmes.add(Movie.fromDoc(dados.data()));
    }
  }

  @action
  getPlaces() async {
    carregandoValores = true;
    // Instance of Geoflutterfire
    final Geoflutterfire geo = new Geoflutterfire();

    // // Get user geo center
    final GeoFirePoint center = geo.point(
        latitude: UserModel().user.userGeoPoint.latitude,
        longitude: UserModel().user.userGeoPoint.longitude);

    QuerySnapshot<Map<String, dynamic>> placesQuery = await _firestore
        .collection(C_LIFESTYLE)
        .orderBy(DATE_LIFESTYLE, descending: false).get();

    print("Max distance: ${AppModel().appInfo.lifeStyleMaxDistance}");

    for(var dados in placesQuery.docs){
      GeoPoint geoPoint = dados.data()[LIFESTYLE_GEO_POINT];

      if(center.distance(lat: geoPoint.latitude, lng: geoPoint.longitude) <= AppModel().appInfo.lifeStyleMaxDistance){

        if(dados[TYPE_LIFESTYLE] == "Cafes"){
            listaCafes.add(LifeStyleModel.fromDoc(dados.data()));
        }
        else if (dados[TYPE_LIFESTYLE] == "Bares"){
          listaBares.add(LifeStyleModel.fromDoc(dados.data()));
        }

        else if ( dados[TYPE_LIFESTYLE] == "Rest"){
          listaRest.add(LifeStyleModel.fromDoc(dados.data()));
        }
      }
    }
    carregandoValores = false;
  }

}
