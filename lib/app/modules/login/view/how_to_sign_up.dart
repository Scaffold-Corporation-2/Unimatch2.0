import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uni_match/app/modules/login/widgets/custom_animated_button.dart';

class HowToSignUpScreen extends StatelessWidget {
  const HowToSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          height: MediaQuery.of(context).size.height,
          color: Colors.pinkAccent,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                    margin: const EdgeInsets.only(top: 5.0, left: 5.0),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8)),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back, color: Colors.white70,)
                    )
                ),
              ),
              Expanded(
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification overscroll) {
                    overscroll.disallowGlow();
                    return true; // or false
                  },
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                              "Apenas universitários",
                              style: GoogleFonts.montserrat(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Apenas universitários convidados e verificados podem fazer cadastro no Unimatch.",
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          RichText(
                            textAlign: TextAlign.justify,
                            softWrap: true,
                            text:TextSpan(
                              text:"Fale para sua Atletica ou C.A entrar em contato conosco em nosso instagram",
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                              children: [
                              TextSpan(
                              text:" @unimatch.app",
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                              ),
                                TextSpan(
                                  text:" para fecharmos parcerias e disponibilizar convite para você e seus amigos!",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                              ]
                            ),
                          ),
                          SizedBox(height: 10),
                          RichText(
                            textAlign: TextAlign.justify,
                            softWrap: true,
                            text:TextSpan(
                                text:"Você ainda pode preencher nosso ",
                                style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                                children: [
                                  TextSpan(
                                    text:" formulário de interesse,",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextSpan(
                                    text:" por meio dele apresentaremos o real interesse dos universitários para as Atleticas e C.A's.",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white,
                                    ),
                                  ),
                                ]
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: CustomAnimatedButton(
                  onTap: () async {
                    Modular.to.pushNamed("/registration");
                  },
                  widhtMultiply: 0.8,
                  height: 53,
                  color: Colors.white,
                  text: "Acesso ao Formulário",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
