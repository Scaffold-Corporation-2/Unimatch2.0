import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'app/app_module.dart';
import 'app/app_widget.dart';

//Não apagar
// import 'package:in_app_purchase_android/in_app_purchase_android.dart';

void main()async{

  // InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
  InAppPurchaseConnection.enablePendingPurchases();
  WidgetsFlutterBinding.ensureInitialized();

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

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]).then((_) {

    runApp(
        ModularApp(
          module: AppModule(),
          child: AppWidget(),
        )
    );
  });

}
