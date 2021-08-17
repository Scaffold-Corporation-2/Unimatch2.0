import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/models/app_model.dart';
import 'package:uni_match/app/models/user_model.dart';
import 'package:uni_match/constants/constants.dart';
import 'package:mobx/mobx.dart';
import 'package:uni_match/app/app_controller.dart';
part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store{
  final _firestore = FirebaseFirestore.instance;
  final AppController appController = Modular.get();

  Future getAppStoreVersion() async {
    appController.load();
    int storeVersion;

    final DocumentSnapshot appInfo =
    await _firestore.collection(C_APP_INFO).doc('settings').get();
    // Update AppInfo object
    AppModel().setAppInfo(appInfo.data()! as Map);
    // Check Platform
    if (Platform.isAndroid) {
      storeVersion = (appInfo.data()! as Map)[ANDROID_APP_CURRENT_VERSION] ?? 1;
    } else if (Platform.isIOS) {
      storeVersion = (appInfo.data()! as Map)[IOS_APP_CURRENT_VERSION] ?? 1;
    }else{
      storeVersion = 1;
    }

    print('storeVersão: $storeVersion');

    // Obtenha a versão atual do aplicativo codificado
    int appCurrentVersion = 1;
    // Verificar plataforma
    if (Platform.isAndroid) {
      // Pegar o número da versão do Android
      appCurrentVersion = ANDROID_APP_VERSION_NUMBER;
    } else if (Platform.isIOS) {
      // Pegar o número da versão do Ios
      appCurrentVersion = IOS_APP_VERSION_NUMBER;
    }

    /// Comparar as duas versões
    if (storeVersion > appCurrentVersion) {
      /// Vá para atualizar app screen
      _navegarPaginas("/login/update");
      print("Ir para a tela de atualização");

    } else {
      /// Autenticar conta de usuário
      UserModel().authUserAccount(
          signInScreen: () => _navegarPaginas("/login/signIn"),
          signUpScreen: () => _navegarPaginas("/login/intro"),
          blockedScreen:() => _navegarPaginas("/login/block"),
          homeScreen:   () => _navegarPaginas("/home")
      );
    }
  }

  void _navegarPaginas(String nomeRota){
    Modular.to.navigate(nomeRota);
  }
}
