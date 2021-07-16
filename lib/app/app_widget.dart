import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:uni_match/constants/constants.dart';

class AppWidget extends StatelessWidget {
  final Future<FirebaseApp> _inicializacao = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _inicializacao,
        builder: (_, snapshot){
          if(snapshot.hasError){
            return Center(
                child: Text("Error: ${snapshot.hasError}",
                  style: TextStyle(fontSize: 22),
                  textDirection: TextDirection.ltr,
                )
            );
          }
          if(snapshot.connectionState == ConnectionState.done){
            return MaterialApp(
              localizationsDelegates: [
                // AppLocalizations.delegate,
                CountryLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: [
                const Locale('pt', 'BR'), // portugues
              ],
              /// Retorna uma localidade que será usada pelo aplicativo
            localeResolutionCallback: (locale, supportedLocales) {
              // Verifique se o local do dispositivo atual é compatível
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale!.languageCode) {
                  return supportedLocale;
                }
              }

              /// Se a localidade do dispositivo não for compatível, use o primeiro
              /// da lista (inglês, neste caso).
              ///
              return supportedLocales.first;
            },
              title: 'Uni Match',
              theme: _appTheme(),
              initialRoute: '/',

              debugShowCheckedModeBanner: false,
            ).modular();
          }

          return CircularProgressIndicator();
        }
    );
  }
}


ThemeData _appTheme() {
  return ThemeData(
    primaryColor: APP_PRIMARY_COLOR,
    accentColor: APP_ACCENT_COLOR,
    scaffoldBackgroundColor: Colors.white,
    inputDecorationTheme: InputDecorationTheme(
        errorStyle: TextStyle(fontSize: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
        )),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      elevation: Platform.isIOS ? 0 : 4.0,
      iconTheme: IconThemeData(color: Colors.black),
      brightness: Brightness.light,
      textTheme: TextTheme(
        headline6: TextStyle(color: Colors.grey, fontSize: 18),
      ),
    ),
  );
}
