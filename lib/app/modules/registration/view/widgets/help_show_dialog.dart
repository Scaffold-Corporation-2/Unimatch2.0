import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpShowDialog extends StatelessWidget {
  const HelpShowDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Align(
        alignment: Alignment.topRight,
          child: IconButton(
              onPressed: (){
                Modular.to.pop();
              },
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              icon: Icon(Icons.close, size: 25, color: Colors.pinkAccent,)
          )
      ),
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 0),
      backgroundColor: Colors.black.withOpacity(0.6),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Documentos aceitos:",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0,),
            Text(
              "* Delcaração\n* ID Estudantil\n* Boleto Bancário\n* Comprovante de Matrícula",
              style: GoogleFonts.nunito(
                color: Colors.white.withOpacity(0.7),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 25.0,),

            Text(
              "Problema ao enviar a foto?",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0,),
            Text(
              "* Renicie o seu aparelho e tente novamente.\n\n* Se o problema persistir, contate-nos: suporte@unimatch.com.br ",
              style: GoogleFonts.nunito(
                color: Colors.white.withOpacity(0.7),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
