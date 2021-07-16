import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:uni_match/app/modules/auth/store/auth_store.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ModularState<SplashScreen, AuthStore> {
  @override
  void initState() {
    controller.getAppStoreVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                      child: Image.asset("assets/images/app_logo.png",
                          width: 120, height: 120)),
                  SizedBox(height: 10),
                  Text("Uni Match",
                      style:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text("Match com universitários ao seu redor",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.grey)),
                  SizedBox(height: 20),
                  SpinKitPumpingHeart(
                    color: Theme.of(context).primaryColor,
                    size: 45,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
