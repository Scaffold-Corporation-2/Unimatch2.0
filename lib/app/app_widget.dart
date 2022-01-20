import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:uni_match/constants/constants.dart';

class AppWidget extends StatelessWidget {
  final bool isDark;
  AppWidget({Key? key, required this.isDark}) : super(key: key);

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
            return  MaterialApp(
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
              theme: isDark ? _appThemeDark() : _appTheme(),
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
    primaryColorDark: Colors.black,
    primaryColorLight: Colors.white,
    colorScheme: ColorScheme.light(),
    iconTheme: IconThemeData(color: Colors.grey[600]),

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
ThemeData _appThemeDark() {
  return ThemeData(
    primaryColor: APP_PRIMARY_COLOR,
    accentColor: APP_ACCENT_COLOR,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: ColorScheme.dark(),
    primaryColorDark: Colors.white,
    primaryColorLight: Colors.black,


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

    iconTheme: IconThemeData(color: Colors.grey.shade400),

    appBarTheme: AppBarTheme(
      color: Color(0XFF363636),
      brightness: Brightness.dark,
      elevation: Platform.isIOS ? 0 : 4.0,
      iconTheme: IconThemeData(color: Colors.white),
      // brightness: Brightness.light,
      textTheme: TextTheme(
        headline6: TextStyle(color: Colors.grey, fontSize: 18),
      ),
    ),
  );
}