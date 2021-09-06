import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_match/constants/constants.dart';
import 'package:flutter/material.dart';

class PartyModel {

  final List<String> stories;
  final String partyId;
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
  final int quantidadeVisualizacao;

  PartyModel(
      {
        required this.stories,
        required this.partyId,
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
        required this.cursoAtletica,
        required this.quantidadeVisualizacao,
      });

  factory PartyModel.fromDoc(QueryDocumentSnapshot dados, List<String> listaImagens){
    return PartyModel(
        stories: listaImagens,
        partyId: dados[ID_PARTY] == null ? "" :dados[ID_PARTY],
        partyName: dados[NAME_PARTY] == null ? "" :dados[NAME_PARTY],
        partyDescricao: dados[DESC_PARTY] == null ? "" :dados[DESC_PARTY],
        partyLocal: dados[LOCAL_PARTY] == null ? "" :dados[LOCAL_PARTY],
        partyTime: dados[TIME_PARTY] == null ? "" : dados[TIME_PARTY],
        partyDate: dados[DATE_PARTY] == null ? "" :dados[DATE_PARTY] ,
        corFundo: dados[COR_PARTY] == null ? Colors.pinkAccent : Color(int.parse(dados[COR_PARTY])),
        partyGeoPoint: dados[PARTY_GEO_POINT] == null ? [] : dados[PARTY_GEO_POINT],
        partyUrlIngresso: dados[BUY_PARTY] == null ? "" :dados[BUY_PARTY],
        nomeAtletica: dados[NOME_ATHLETIC] == null ? "" :dados[NOME_ATHLETIC],
        siglaAtletica: dados[SIGLA_ATHLETIC] == null ? "" :dados[SIGLA_ATHLETIC],
        cursoAtletica: dados[CURSO_ATHLETIC] == null ? "" :dados[CURSO_ATHLETIC],
        universidadeAtletica: dados[UNIVER_ATHLETIC] == null ? "" :dados[UNIVER_ATHLETIC],
        imagemAtletica: dados[IMAGE_ATHLETIC] == null ? "" :dados[IMAGE_ATHLETIC],
        cidadeAtletica: dados[CIDADE_ATHLETIC] == null ? "" :dados[CIDADE_ATHLETIC],
        quantidadeVisualizacao: dados[QUANT_PARTY] == null ? 0 : dados[QUANT_PARTY],
    );
  }
}
