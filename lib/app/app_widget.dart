import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
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
              builder: (context, widget) => ResponsiveWrapper.builder(
                BouncingScrollWrapper.builder(context, widget!),
                maxWidth: 1200,
                minWidth: 400,
                defaultScale: true,
                breakpoints: [
                  ResponsiveBreakpoint.resize(400, name: MOBILE),
                  ResponsiveBreakpoint.autoScale(800, name: TABLET),
                  ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                  ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                  ResponsiveBreakpoint.autoScale(2460, name: "4K"),
                ],
                background: Container(color: Color(0xFFF5F5F5))),
              localizationsDelegates: [
                // AppLocalizations.delegate,
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
              ///
              return supportedLocales.first;
            },
              title: 'Unimatch',
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
        labelStyle: TextStyle(fontSize: 18, color: APP_PRIMARY_COLOR),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: APP_PRIMARY_COLOR,),
        ),
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
