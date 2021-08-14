import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uni_match/app/modules/login/store/login_store.dart';
import 'package:uni_match/app/modules/login/widgets/InputCustomizado.dart';
import 'package:uni_match/app/modules/login/widgets/custom_animated_button.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/widgets/app_logo.dart';

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
  bool visualizar = true;

  void boolVisualizar() => setState(() => visualizar = !visualizar);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.deepPurpleAccent,
                Colors.purpleAccent,
                Colors.pinkAccent,
                Colors.pink,
              ],
            ),
          ),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowGlow();
              return true;
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: AppLogo(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.8,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 22),
                      child: Text(
                        _i18n.translate("app_short_description")!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),

                    ///Sign with E-mail
                    InputCustomizado(
                      icon: Icons.mail,
                      hintText: "E-mail",
                      hintStyle: TextStyle(color: Colors.grey[700]),
                      fillColor: Colors.white,
                      enableColor: Colors.white,
                      keyboardType: TextInputType.emailAddress,
                      controller: _email,
                    ),
                    SizedBox(height: 20),

                    InputCustomizado(
                      icon: Icons.lock,
                      hintText: "Senha",
                      hintStyle: TextStyle(color: Colors.grey[700]),
                      fillColor: Colors.white,
                      enableColor: Colors.white,
                      suffixIcon: GestureDetector(
                        onTap: boolVisualizar,
                        child: Icon(
                          visualizar ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey[700],
                        ),
                      ),
                      controller: _password,
                      obscure: visualizar,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          child: Text(
                            'Esqueci minha senha',
                            style: GoogleFonts.eczar(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            if (_email.text.isNotEmpty) {
                              if (EmailValidator.validate(_email.text)) {
                                await _loginStore.passwordRecover(_email.text);
                              } else
                                Fluttertoast.showToast(msg: 'Insira um e-mail válido');
                            } else
                              Fluttertoast.showToast(msg: 'Digite um e-mail a ser recuperado');
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.transparent),
                            foregroundColor: MaterialStateProperty.all(Colors.transparent),
                            overlayColor: MaterialStateProperty.all(Colors.white24),
                            shadowColor: MaterialStateProperty.all(Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),

                    CustomAnimatedButton(
                      onTap: () async {
                        if (_email.text.isEmpty || _password.text.isEmpty)
                          Fluttertoast.showToast(msg: 'Preencha todos os campos!');
                        else
                          await _loginStore.emailLogin(_email.text, _password.text);
                      },
                      widhtMultiply: 1,
                      height: 53,
                      color: Colors.white,
                      text: "Entrar",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
