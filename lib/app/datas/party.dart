import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_match/constants/constants.dart';
import 'package:flutter/material.dart';

class PartyModel {
  // todo adicionar

  final List<String> stories;
  final String partyName;
  final String partyLocal;
  final String partyTime;
  final String partyDate;
  final String partyDescricao;
  final String imageAthletic;
  final Color  corFundo;
  final GeoPoint partyGeoPoint;

  PartyModel(
      {required this.stories,
        required this.partyName,
        required this.imageAthletic,
        required this.partyLocal,
        required this.partyTime,
        required this.partyDate,
        required this.corFundo,
        required this.partyDescricao,
        required this.partyGeoPoint
      });

  factory PartyModel.fromDoc(QueryDocumentSnapshot dados, List<String> listaImgagens){

    return PartyModel(
        stories: listaImgagens,
        partyName: dados[NAME_PARTY] == "" ? "" :dados[NAME_PARTY],
        partyDescricao: dados[DESC_PARTY] == "" ? "" :dados[DESC_PARTY],
        imageAthletic: listaImgagens.first, // todo mudar para dados[IMAGE_ATHLETIC]
        partyLocal: dados[LOCAL_PARTY] == "" ? "" :dados[LOCAL_PARTY],
        partyTime: dados[TIME_PARTY] == "" ? "" : dados[TIME_PARTY],
        partyDate: dados[DATE_PARTY] == "" ? "" :dados[DATE_PARTY] ,
        corFundo: dados[COR_PARTY] == "" ? Colors.pinkAccent : Color(int.parse(dados[COR_PARTY])),
        partyGeoPoint: dados[PARTY_GEO_POINT] == "" ? [] : dados[PARTY_GEO_POINT],
    );
  }
}
