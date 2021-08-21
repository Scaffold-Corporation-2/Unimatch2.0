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
  TextEditingController _emailRecover = TextEditingController();
  bool visualizar = true;
  bool _emailFocus = false;
  bool _emailRecoverFocus = false;
  bool _passwordFocus = false;

  void boolVisualizar() => setState(() => visualizar = !visualizar);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        _emailFocus = false;
        _emailRecoverFocus = false;
        _passwordFocus = false;
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
                      Expanded(child: Container(), flex: 3),
                      Center(
                        child: AppLogo(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.8,
                        ),
                      ),
                      Expanded(
                        child: Container(),
                        flex: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 22),
                        child: Text(
                          _i18n.translate("app_short_description")!,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),

                      /// E-mail
                      TextFormField(
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(fontSize: 18, color: Colors.grey[900]),
                        textAlign: TextAlign.start,
                        cursorColor: Colors.grey[700],
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.grey[700]),
                          labelText: _emailFocus == true ? '' : 'E-mail',
                          filled: true,
                          fillColor: Colors.white,
                          alignLabelWithHint: true,
                          prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Icon(
                              Icons.mail,
                              color: Colors.grey[700],
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            borderSide: BorderSide(
                              width: 1.18,
                              color: Color(0xff1a1919),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            borderSide: BorderSide(
                              width: 1.2,
                              color: Colors.white,
                            ), //Color(0xff1a1919)
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _emailFocus = true;
                            _passwordFocus = false;
                            _emailRecoverFocus = false;
                          });
                        },
                      ),
                      SizedBox(height: 20),

                      ///Password
                      TextFormField(
                        controller: _password,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        style: TextStyle(fontSize: 18, color: Colors.grey[900]),
                        textAlign: TextAlign.start,
                        cursorColor: Colors.grey[700],
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.grey[700]),
                          labelText: _passwordFocus == true ? '' : 'Senha',
                          filled: true,
                          fillColor: Colors.white,
                          alignLabelWithHint: true,
                          prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Icon(
                              Icons.lock,
                              color: Colors.grey[700],
                            ),
                          ),
                          suffixIcon: Icon(
                            visualizar ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey[700],
                          ),
                          contentPadding: visualizar == false
                              ? EdgeInsets.fromLTRB(18, 18, 12, 18)
                              : EdgeInsets.fromLTRB(0, 18, 0, 18),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            borderSide: BorderSide(
                              width: 1.18,
                              color: Color(0xff1a1919),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            borderSide: BorderSide(
                              width: 1.2,
                              color: Colors.white,
                            ), //Color(0xff1a1919)
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _passwordFocus = true;
                            _emailFocus = false;
                            _emailRecoverFocus = false;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      Align(
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
                            if (EmailValidator.validate(_email.text))
                              _emailRecover.text = _email.text;

                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                content: Container(
                                  height: 220,
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Recuperação de senha',
                                            style: GoogleFonts.nunito(
                                              fontSize: 20,
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.close,
                                              color: Colors.red,
                                            ),
                                            onPressed: () {
                                              Modular.to.pop();
                                            },
                                          )
                                        ],
                                      ),
                                      Container(
                                        height: 15,
                                      ),
                                      TextFormField(
                                        controller: _emailRecover,
                                        keyboardType: TextInputType.emailAddress,
                                        style: TextStyle(fontSize: 18, color: Colors.grey[900]),
                                        textAlign: TextAlign.start,
                                        cursorColor: Colors.grey[700],
                                        decoration: InputDecoration(
                                          labelStyle: TextStyle(color: Colors.grey[700]),
                                          labelText: _emailRecoverFocus == true ? '' : 'E-mail',
                                          filled: true,
                                          fillColor: Colors.white,
                                          alignLabelWithHint: true,
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 15),
                                            child: Icon(
                                              Icons.mail,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(25),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(18)),
                                            borderSide: BorderSide(
                                              width: 1.18,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(18)),
                                            borderSide: BorderSide(
                                              width: 1.2,
                                              color: Colors.grey.shade700,
                                            ), //Color(0xff1a1919)
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            _emailRecoverFocus = true;
                                            _emailFocus = false;
                                            _passwordFocus = false;
                                          });
                                        },
                                      ),
                                      Container(
                                        height: 25,
                                      ),
                                      CustomAnimatedButton(
                                        onTap: () async {
                                          if (EmailValidator.validate(_emailRecover.text)) {
                                            if (await _loginStore
                                                .passwordRecover(_emailRecover.text)) {
                                              _email.text = _emailRecover.text;
                                              _emailRecover.clear();
                                              Modular.to.pop();
                                              Fluttertoast.showToast(
                                                  msg:
                                                      'E-mail enviado. Verifique sua caixa de entrada.');
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
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.transparent),
                            foregroundColor: MaterialStateProperty.all(Colors.transparent),
                            overlayColor: MaterialStateProperty.all(Colors.white24),
                            shadowColor: MaterialStateProperty.all(Colors.transparent),
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
                      Expanded(child: Container()),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                            child: Text(
                              'Como me inscrever?',
                              style: GoogleFonts.eczar(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () async {
                              Modular.to.pushNamed("/login/information");
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.transparent),
                              foregroundColor: MaterialStateProperty.all(Colors.transparent),
                              overlayColor: MaterialStateProperty.all(Colors.white10),
                              shadowColor: MaterialStateProperty.all(Colors.transparent),
                            ),
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
