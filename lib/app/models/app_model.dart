import 'package:uni_match/app/datas/app_info.dart';

class AppModel{
  // Variables
  late AppInfo appInfo;

  /// Create Singleton factory for [AppModel]
  ///
  static final AppModel _appModel = new AppModel._internal();
  factory AppModel() {
    return _appModel;
  }
  AppModel._internal();
  // End

  /// Set data to AppInfo object
  void setAppInfo(Map<dynamic, dynamic> appDoc) {
    this.appInfo = AppInfo.fromDocument(appDoc);
    print('AppInfo object -> updated!');
  }
}
