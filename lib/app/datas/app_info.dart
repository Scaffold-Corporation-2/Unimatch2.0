import 'package:uni_match/constants/constants.dart';

class AppInfo {
  /// Variables
  final int androidAppCurrentVersion;
  final int iosAppCurrentVersion;
  final int freeAccountSwipes;
  final int vipAccountSwipes;
  final int partiesMaxDistance;
  final int lifeStyleMaxDistance;
  final String androidPackageName;
  final String iOsAppId;
  final String appEmail;
  final String privacyPolicyUrl;
  final String termsOfServicesUrl;
  final String firebaseServerKey;
  final List<String> subscriptionIds;
  final double freeAccountMaxDistance;
  final double vipAccountMaxDistance;

  /// Constructor
  AppInfo(
      {
      required this.androidAppCurrentVersion,
      required this.iosAppCurrentVersion,
      required this.androidPackageName,
      required this.iOsAppId,
      required this.appEmail,
      required this.privacyPolicyUrl,
      required this.termsOfServicesUrl,
      required this.firebaseServerKey,
      required this.subscriptionIds,
      required this.freeAccountMaxDistance,
      required this.vipAccountMaxDistance,
      required this.freeAccountSwipes,
      required this.vipAccountSwipes,
      required this.partiesMaxDistance,
      required this.lifeStyleMaxDistance,
      });

  /// factory AppInfo object
  factory AppInfo.fromDocument(Map<dynamic, dynamic> doc) {
    return AppInfo(
        androidAppCurrentVersion: doc[ANDROID_APP_CURRENT_VERSION] ?? 1,
        iosAppCurrentVersion: doc[IOS_APP_CURRENT_VERSION] ?? 1,
        androidPackageName: doc[ANDROID_PACKAGE_NAME] ?? '',
        iOsAppId: doc[IOS_APP_ID] ?? '',
        appEmail: doc[APP_EMAIL] ?? '',
        privacyPolicyUrl: doc[PRIVACY_POLICY_URL] ?? '',
        termsOfServicesUrl: doc[TERMS_OF_SERVICE_URL] ?? '',
        firebaseServerKey: doc[FIREBASE_SERVER_KEY] ?? '',
        subscriptionIds: List<String>.from(doc[STORE_SUBSCRIPTION_IDS] ?? []),
        freeAccountMaxDistance: doc[FREE_ACCOUNT_MAX_DISTANCE] == null
            ? 100
            : doc[FREE_ACCOUNT_MAX_DISTANCE].toDouble(),
        vipAccountMaxDistance: doc[VIP_ACCOUNT_MAX_DISTANCE] == null
            ? 200
            : doc[VIP_ACCOUNT_MAX_DISTANCE].toDouble(),
        freeAccountSwipes: doc[FREE_ACCOUNT_SWIPES] == null
            ? 15
            : doc[FREE_ACCOUNT_SWIPES],
      vipAccountSwipes: doc[VIP_ACCOUNT_SWIPES] == null
            ? 10
            : doc[VIP_ACCOUNT_SWIPES],
      lifeStyleMaxDistance: doc[LIFESTYLE_MAX_DISTANCE] == null
          ? 60
          : doc[LIFESTYLE_MAX_DISTANCE],
      partiesMaxDistance: doc[PARTIES_MAX_DISTANCE] == null
          ? 60
          : doc[PARTIES_MAX_DISTANCE],
    );
  }
}
