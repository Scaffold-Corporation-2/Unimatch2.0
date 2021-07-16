import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:place_picker/entities/localization_item.dart';
import 'package:place_picker/place_picker.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/app/models/user_model.dart';
import 'package:uni_match/constants/constants.dart';

class PassportScreen extends StatelessWidget {

  // Get Google Maps API KEY
  String _getGoogleMapsAPIkey() {
    // Check the current Platform
    if (Platform.isAndroid) {
      // For Android
      return ANDROID_MAPS_API_KEY;
    } else if (Platform.isIOS) {
       // For iOS
       return IOS_MAPS_API_KEY;
    } else {
      return "Unknown platform";
    }

  }
  final AppController _i18n = Modular.get();

  @override
  Widget build(BuildContext context) {
   /// Initialization

    return Scaffold(
      appBar: AppBar(
        title: Text(_i18n.translate('travel_to_any_country_or_city')!),
      ),
      body: PlacePicker(
          _getGoogleMapsAPIkey(),
          displayLocation: LatLng(
            UserModel().user.userGeoPoint.latitude,
            UserModel().user.userGeoPoint.longitude,
          ),
          localizationItem: LocalizationItem(
            languageCode: _i18n.translate('lang')!,
            nearBy: _i18n.translate('nearby_places')!,
            findingPlace: _i18n.translate('finding_place')!,
            noResultsFound: _i18n.translate('no_results_found')!,
            unnamedLocation: _i18n.translate('unnamed_location')!,
            tapToSelectLocation:
                _i18n.translate('tap_here_to_select_this_location')!,
          ),
        ),
    );
  }
}