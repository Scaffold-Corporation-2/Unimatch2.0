import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'app/app_module.dart';
import 'app/app_widget.dart';
// import 'package:in_app_purchase_android/in_app_purchase_android.dart';

void main()async{

  if (defaultTargetPlatform == TargetPlatform.android) {
    // InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
    InAppPurchaseConnection.enablePendingPurchases();
  }

  WidgetsFlutterBinding.ensureInitialized();
  timeago.setLocaleMessages('pt_BR', timeago.PtBrMessages());

  // Initialize firebase app
  await Firebase.initializeApp();
  // Initialize Google Mobile Ads SDK
  await MobileAds.instance.initialize();

  if (Platform.isIOS) {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  var resultadoTheme = sharedPreferences.get('dark');
  print(resultadoTheme);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(
        ModularApp(
          module: AppModule(),
          child: AppWidget(isDark: resultadoTheme == null ? false : resultadoTheme as bool,),
        )
    );
  });
}
