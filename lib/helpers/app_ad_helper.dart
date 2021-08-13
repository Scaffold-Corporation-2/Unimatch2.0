import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:uni_match/app/models/user_model.dart';
import 'package:uni_match/constants/constants.dart';

class AppAdHelper {
  // Local Variables
  static InterstitialAd? _interstitialAd;
  //

  // Get Interstitial Ad ID
  static String get _interstitialID {
    if (Platform.isAndroid) {
      return ANDROID_INTERSTITIAL_ID;
    } else if (Platform.isIOS) {
      return IOS_INTERSTITIAL_ID;
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  // Ad Event Listener
  static final AdListener _adListener = AdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) {
      print('Anúncio carregado.');
      _interstitialAd?.show();
    },
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      ad.dispose();
      print('O anúncio falhou ao carregar: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Anúncio aberto.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) {
      ad.load();
      print('Anúncio fechado.');
    },
    // Called when an ad is in the process of leaving the application.
    onApplicationExit: (Ad ad) => print('Esquerda do aplicativo.'),
  );
  //
  // // Create Interstitial Ad
  static Future<void> _createInterstitialAd() async {
    _interstitialAd = InterstitialAd(
        adUnitId: _interstitialID,
        request: AdRequest(),
        listener: _adListener);
      // Load InterstitialAd Ad
      _interstitialAd?.load();
  }

  // Show Interstitial Ads for Non VIP Users
  static Future<void> showInterstitialAd() async {
    /// Check User VIP Status
    if (!UserModel().userIsVip) {
      print('Usuário comum');
      _createInterstitialAd();
    } else {
      print('Usuário VIP');
    }
  }

  // Dispose Interstitial Ad
  static void disposeInterstitialAd() {
    _interstitialAd?.dispose();
    _interstitialAd = null;
  }
}
