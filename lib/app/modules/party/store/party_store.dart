import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/app/models/app_model.dart';
import 'package:uni_match/app/models/user_model.dart';
import 'package:uni_match/constants/constants.dart';
part 'party_store.g.dart';

class PartyStore = _PartyStore with _$PartyStore;

abstract class _PartyStore with Store{

  final AppController i18n = Modular.get();
  final _firestore = FirebaseFirestore.instance;

  @observable
  int valorVisualizacao = 0;

  @action
  adicionarValor(int val) => valorVisualizacao = val;

  @observable
  ObservableList <DocumentSnapshot> listaFestas = ObservableList();

  @observable
  bool carregandoValores = false;

  @action
  getParties() async {
    carregandoValores = true;

    // Instance of Geoflutterfire
    final Geoflutterfire geo = new Geoflutterfire();

    // // Get user geo center
    final GeoFirePoint center = geo.point(
        latitude: UserModel().user.userGeoPoint.latitude,
        longitude: UserModel().user.userGeoPoint.longitude);


    QuerySnapshot<Map<String, dynamic>> partiesQuery = await _firestore
        .collection(C_PARTY).orderBy(DATE_PARTY, descending: false).get();

    for(var dados in partiesQuery.docs){
      GeoPoint geoPoint = dados.data()[PARTY_GEO_POINT];
      if(center.distance(lat: geoPoint.latitude, lng: geoPoint.longitude) <= AppModel().appInfo.partiesMaxDistance){
        listaFestas.add(dados);
      }
    }

    carregandoValores = false;
  }

  @observable
  var valueShared;

  @action
  dadosCache() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    valueShared = sharedPreferences.get("tutorial");
    print(valueShared);

    if(valueShared == null){
      valueShared = false;
    }
  }

  mudarPreferencias(String tipo, String key, var value) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if(tipo == "bool") sharedPreferences.setBool(key, value);
    if(tipo == "string") sharedPreferences.setString(key, value);
    if(tipo == "int") sharedPreferences.setInt(key, value);
    if(tipo == "double") sharedPreferences.setDouble(key, value);
  }

  Future atualizarVisualizacoes({required String partyId, required Map<String, dynamic> data}) async {
    await _firestore.collection(C_PARTY).doc(partyId).update(data);
  }
}
