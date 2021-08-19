import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_match/constants/constants.dart';
import 'package:flutter/material.dart';

class PartyModel {

  final List<String> stories;
  final String partyName;
  final String partyLocal;
  final String partyTime;
  final String partyDate;
  final String partyDescricao;
  final String partyUrlIngresso;
  final Color  corFundo;
  final GeoPoint partyGeoPoint;
  final String nomeAtletica;
  final String siglaAtletica;
  final String imagemAtletica;
  final String cidadeAtletica;
  final String universidadeAtletica;
  final String cursoAtletica;

  PartyModel(
      {
        required this.stories,
        required this.partyName,
        required this.partyLocal,
        required this.partyTime,
        required this.partyDate,
        required this.corFundo,
        required this.partyUrlIngresso,
        required this.partyDescricao,
        required this.partyGeoPoint,
        required this.nomeAtletica,
        required this.siglaAtletica,
        required this.imagemAtletica,
        required this.cidadeAtletica,
        required this.universidadeAtletica,
        required this.cursoAtletica
      });

  factory PartyModel.fromDoc(QueryDocumentSnapshot dados, List<String> listaImgagens){

    return PartyModel(
        stories: listaImgagens,
        partyName: dados[NAME_PARTY] == "" ? "" :dados[NAME_PARTY],
        partyDescricao: dados[DESC_PARTY] == "" ? "" :dados[DESC_PARTY],
        partyLocal: dados[LOCAL_PARTY] == "" ? "" :dados[LOCAL_PARTY],
        partyTime: dados[TIME_PARTY] == "" ? "" : dados[TIME_PARTY],
        partyDate: dados[DATE_PARTY] == "" ? "" :dados[DATE_PARTY] ,
        corFundo: dados[COR_PARTY] == "" ? Colors.pinkAccent : Color(int.parse(dados[COR_PARTY])),
        partyGeoPoint: dados[PARTY_GEO_POINT] == "" ? [] : dados[PARTY_GEO_POINT],
        partyUrlIngresso: dados[BUY_PARTY] == "" ? "" :dados[BUY_PARTY],
        nomeAtletica: dados[NOME_ATHLETIC] == "" ? "" :dados[NOME_ATHLETIC],
        siglaAtletica: dados[SIGLA_ATHLETIC] == "" ? "" :dados[SIGLA_ATHLETIC],
        cursoAtletica: dados[CURSO_ATHLETIC] == "" ? "" :dados[CURSO_ATHLETIC],
        universidadeAtletica: dados[UNIVER_ATHLETIC] == "" ? "" :dados[UNIVER_ATHLETIC],
        imagemAtletica: dados[IMAGE_ATHLETIC] == "" ? "" :dados[IMAGE_ATHLETIC],
        cidadeAtletica: dados[CIDADE_ATHLETIC] == "" ? "" :dados[CIDADE_ATHLETIC],
    );
  }
}
