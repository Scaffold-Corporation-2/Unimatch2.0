import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_match/constants/constants.dart';

class LifeStyleModel {
  final String lifeStyleNome;
  final String lifeStyleLocal;
  final String lifeStyleTipo;
  final String lifeStyleDate;
  final String lifeStyleDescricao;
  final String lifeStylePreco;
  final GeoPoint lifeStyleGeoPoint;
  final List<String> imagens;
  final List<String> cardapio;
  final Map horarioAberto;

  LifeStyleModel(
      {
      required this.lifeStyleNome,
      required this.lifeStyleLocal,
      required this.lifeStyleTipo,
      required this.lifeStyleDate,
      required this.lifeStyleDescricao,
      required this.lifeStylePreco,
      required this.lifeStyleGeoPoint,
      required this.imagens,
      required this.cardapio,
      required this.horarioAberto,
      });

  factory LifeStyleModel.fromDoc(Map<dynamic, dynamic> dados){
    return LifeStyleModel(
        lifeStyleNome: dados[NAME_LIFESTYLE] == null ? "" :dados[NAME_LIFESTYLE],
        lifeStyleLocal: dados[LOCAL_LIFESTYLE] == null ? "" :dados[LOCAL_LIFESTYLE],
        lifeStyleTipo: dados[TYPE_LIFESTYLE] == null ? "" :dados[TYPE_LIFESTYLE],
        lifeStyleDate: dados[DATE_LIFESTYLE] == null ? "" :dados[DATE_LIFESTYLE],
        lifeStyleDescricao: dados[DESC_LIFESTYLE] == null ? "" :dados[DESC_LIFESTYLE],
        lifeStyleGeoPoint: dados[LIFESTYLE_GEO_POINT] == null ? [] : dados[LIFESTYLE_GEO_POINT],
        imagens: dados[IMAGES_LIFESTYLE].cast<String>()  ?? [],
        cardapio: dados[MENU_LIFESTYLE].cast<String>()  ?? [],
        horarioAberto: dados[OPEN_LIFESTYLE] == null ? {} : dados[OPEN_LIFESTYLE],
        lifeStylePreco: dados[PRICE_LIFESTYLE] == null ? "--" : dados[PRICE_LIFESTYLE],
    );
  }
}
