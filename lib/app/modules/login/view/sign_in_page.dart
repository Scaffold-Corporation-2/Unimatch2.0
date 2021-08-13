import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/modules/login/store/login_store.dart';
import 'package:uni_match/app/modules/login/widgets/customGenericTFF.dart';
import 'package:uni_match/app/modules/login/widgets/customPasswordTFF.dart';
import 'package:uni_match/constants/constants.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/widgets/app_logo.dart';
import 'package:uni_match/widgets/terms_of_service_row.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  AppController _i18n = Modular.get();
  LoginStore _loginStore = Modular.get();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              colors: [
                Colors.black26,
                Theme.of(context).primaryColor,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: AppLogo(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 30),
                child: Text(
                  APP_NAME,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              Text(
                _i18n.translate("welcome_back")!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 22),
                child: Text(
                  _i18n.translate("app_short_description")!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),

              ///Sign with E-mail
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: CustomGenericTextFormField(
                  controller: _email,
                  labelText: 'E-mail',
                  textFontSize: 16,
                  captionFontSize: 16,
                  borderColor: Colors.white,
                  fontColor: Colors.white,
                  fillColor: Colors.white,
                  type: TextInputType.emailAddress,
                  validation: (text) {},
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
                child: CustomPasswordTextFormField(
                  controller: _password,
                  labelText: 'Senha',
                  captionFontSize: 16,
                  fontSize: 16,
                  borderColor: Colors.white,
                  fontColor: Colors.white,
                  fillColor: Colors.white,
                  iconColor: Colors.white,
                  validation: (text) {},
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Container(
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
                    onPressed: () async {
                      await _loginStore.emailLogin(_email.text, _password.text);
                    },
                  ),
                ),
              ),

              Expanded(
                child: SizedBox(),
              ),
              // Terms of Service section
              Padding(
                padding: const EdgeInsets.only(top: 7),
                child: Text(
                  _i18n.translate("by_tapping_log_in_you_agree_with_our")!,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 7, bottom: 50),
                child: TermsOfServiceRow(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
