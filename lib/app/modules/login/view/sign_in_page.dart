import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uni_match/app/modules/login/store/login_store.dart';
import 'package:uni_match/app/modules/login/widgets/custom_animated_button.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/app/modules/login/widgets/custom_text_field.dart';
import 'package:uni_match/app/modules/login/widgets/custom_text_field_password.dart';
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
  TextEditingController _emailRecover = TextEditingController();
  bool visualizar = true;

  void _boolVisualizar() => setState(() => visualizar = !visualizar);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
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
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Spacer(flex: 2,),

                      Center(
                        child: AppLogo(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.8,
                        ),
                      ),
                      Spacer(flex: 1,),

                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 22),
                        child: Text(
                          _i18n.translate("app_short_description")!,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),

                      /// E-mail
                      CustomTextField(
                          hintText: 'E-mail',
                          icon: Icon(
                            Icons.mail,
                            color: Colors.grey[700],
                          ),
                          textInputType: TextInputType.emailAddress,
                          controller: _email
                      ),
                      SizedBox(height: 20),

                      ///Password
                      CustomTextFieldPassword(
                          hintText: 'Senha',
                          icon: Icon(
                            Icons.lock,
                            color: Colors.grey[700],
                          ),
                          onTapPassword: (){
                            _boolVisualizar();
                          },
                          visualizar: visualizar,
                          password: true,
                          obscureText: visualizar,
                          textInputType: TextInputType.visiblePassword,
                          controller: _password
                      ),
                      SizedBox(height: 10),

                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Text(
                              'Esqueci minha senha',
                              style: GoogleFonts.eczar(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onTap: () async {
                            if (EmailValidator.validate(_email.text))
                              _emailRecover.text = _email.text;

                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                content: Container(
                                  height: 230,
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.close,
                                              color: Colors.red,
                                              size: 30,
                                            ),
                                            onPressed: () {
                                              Modular.to.pop();
                                            },
                                          ),
                                        ),
                                        Text(
                                          'Recuperação de senha',
                                          style: GoogleFonts.nunito(
                                            fontSize: 20,
                                          ),
                                        ),
                                        SizedBox(height: 15,),
                                        CustomTextField(
                                            hintText: 'E-mail',
                                            icon: Icon(
                                              Icons.mail,
                                              color: Colors.grey[700],
                                            ),
                                            textInputType: TextInputType.emailAddress,
                                            controller: _emailRecover
                                        ),
                                        SizedBox(height: 25,),

                                        CustomAnimatedButton(
                                          onTap: () async {
                                            if (EmailValidator.validate(_emailRecover.text)) {
                                              if (await _loginStore
                                                  .passwordRecover(_emailRecover.text)) {
                                                _email.text = _emailRecover.text;
                                                _emailRecover.clear();
                                                Modular.to.pop();
                                                Fluttertoast.showToast(msg: 'E-mail enviado. Verifique sua caixa de entrada.');
                                              }
                                            } else
                                              Fluttertoast.showToast(msg: 'Digite um e-mail válido');
                                          },
                                          widhtMultiply: 0.4,
                                          height: 53,
                                          color: Colors.white,
                                          text: "Recuperar",
                                          fontSize: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 35),

                      CustomAnimatedButton(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          if (_email.text.isEmpty || _password.text.isEmpty)
                            Fluttertoast.showToast(msg: 'Preencha todos os campos!');
                          else
                            await _loginStore.emailLogin(_email.text.trim(), _password.text.trim());
                        },
                        widhtMultiply: 1,
                        height: 53,
                        color: Colors.white,
                        text: "Entrar",
                      ),
                      Spacer(),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            child: Text(
                              'Como me inscrever?',
                              style: GoogleFonts.eczar(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            onTap: () async {
                              Modular.to.pushNamed("/login/information");
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
