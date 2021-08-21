import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uni_match/app/modules/login/widgets/custom_animated_button.dart';
import 'package:url_launcher/url_launcher.dart';

class HowToSignUpScreen extends StatelessWidget {
  const HowToSignUpScreen({Key? key}) : super(key: key);
  Future<void> OpenUrl() async {
    const url = "https://docs.google.com/forms/d/1VC-zGmikCJEGK3Xxm3MWvgCXlgr6uTrP8Eml2wXco_A/viewform?edit_requested=true";
    if (await canLaunch(url)) {
          await launch(url);
    } else {
    print("Não Foi possivel abrir a URL");
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
        color: Colors.pinkAccent,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: RichText(
                  textScaleFactor: 0.9,
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style:GoogleFonts.eczar(
                     fontSize: 50,
                    ) ,
                    text: "Entre em contato com sua Atletica ou C.A e faça parte do Unimatch",
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            CustomAnimatedButton(
              onTap: () async {
                OpenUrl();
              },
              widhtMultiply: 0.8,
              height: 53,
              color: Colors.white,
              text: "Formulário de Inscrição",
            ),
          ],
        ),
      ),

    );
  }
}
