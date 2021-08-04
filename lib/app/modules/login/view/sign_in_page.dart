import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/modules/login/store/login_store.dart';
import 'package:uni_match/constants/constants.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/widgets/app_logo.dart';
import 'package:uni_match/widgets/default_button.dart';
import 'package:uni_match/widgets/terms_of_service_row.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // Variables
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  AppController _i18n = Modular.get();
  LoginStore _loginStore = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      body: Container(
        // decoration: BoxDecoration(
        // image: DecorationImage(
        //     image: AssetImage("assets/images/background_image.jpg"),
        //     fit: BoxFit.fill,
        //     repeat: ImageRepeat.repeatY),
        // ),
        color: Colors.pinkAccent,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
            Theme.of(context).primaryColor,
            Colors.black.withOpacity(.4)
          ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AppLogo(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.8,
              ),

              SizedBox(height: 20),
              Text(
                APP_NAME,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Text(_i18n.translate("welcome_back")!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              SizedBox(height: 5),
              Text(_i18n.translate("app_short_description")!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              SizedBox(height: 22),

              ///Sign with E-mail
              Form(
                child: Column(
                  children: [
                    TextFormField(),
                  ],
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: SizedBox(
                  width: double.maxFinite,
                  height: 45,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(10),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      overlayColor: MaterialStateProperty.all(
                        Color.fromRGBO(41, 51, 60, 0.2),
                      ),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                    ),
                    child: Text(
                      'Entrar',
                      style: TextStyle(fontSize: 18, color: Colors.pinkAccent),
                    ),
                    onPressed: () async {},
                  ),
                ),
              ),
              SizedBox(height: 15),

              // Terms of Service section
              Text(
                _i18n.translate("by_tapping_log_in_you_agree_with_our")!,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 7,
              ),
              TermsOfServiceRow(),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
