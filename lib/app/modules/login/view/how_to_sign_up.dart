import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uni_match/app/modules/login/widgets/custom_animated_button.dart';
import 'package:url_launcher/url_launcher.dart';

class HowToSignUpScreen extends StatelessWidget {
  const HowToSignUpScreen({Key? key}) : super(key: key);

  Future<void> openUrl() async {
    const url =
        "https://docs.google.com/forms/d/1VC-zGmikCJEGK3Xxm3MWvgCXlgr6uTrP8Eml2wXco_A/viewform?edit_requested=true";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Fluttertoast.showToast(msg: 'Link indisponível');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.pinkAccent,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.pinkAccent,
        child: Column(
          children: [
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
                            "Apenas universitários convidados",
                            style: GoogleFonts.montserrat(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
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
                  openUrl();
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
    );
  }
}
