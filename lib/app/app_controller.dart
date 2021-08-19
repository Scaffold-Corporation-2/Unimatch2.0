import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:uni_match/constants/constants.dart';
part 'app_controller.g.dart';

class AppController = _AppController with _$AppController;

abstract class _AppController with Store{

  @observable
  Locale locale = SUPPORTED_LOCALES.first;

  @action
  mudarIdioma(){}

  @observable
  Map<String, String>? localizedStrings;

  @action
  Future load() async {
    final String jsonLang = await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    final Map<String, dynamic> langMap = json.decode(jsonLang);
    localizedStrings = langMap.map((key, value) => MapEntry(key, value.toString()));
  }

  String? translate(String key) {
    return localizedStrings![key] ==  null ? '' : localizedStrings![key];
  }

}
