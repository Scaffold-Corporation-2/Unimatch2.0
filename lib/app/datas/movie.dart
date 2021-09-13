import 'package:uni_match/constants/constants.dart';

class Movie {
  final String nomeFilme;
  final String urlFilme;
  final String tipoFilme;
  final String tipoLifeStyle;
  final String localFilme;

  Movie({
      required this.nomeFilme,
      required this.urlFilme,
      required this.tipoFilme,
      required this.localFilme,
      required this.tipoLifeStyle});

  factory Movie.fromDoc(Map dados){
    return Movie(
        nomeFilme: dados[NAME_MOVIE] == null ? "" :dados[NAME_MOVIE],
        urlFilme: dados[URL_MOVIE] == null ? "" :dados[URL_MOVIE],
        tipoFilme: dados[TYPE_MOVIE] == null ? "" :dados[TYPE_MOVIE],
        localFilme: dados[LOCAL_MOVIE] == null ? "" :dados[LOCAL_MOVIE],
        tipoLifeStyle: dados[TYPE_LIFESTYLE] == null ? "" :dados[TYPE_LIFESTYLE],
    );
  }
}
