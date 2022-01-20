import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/app/models/user_model.dart';
import 'package:uni_match/app/modules/registration/store/registration_store.dart';
import 'package:uni_match/app/modules/registration/view/widgets/registration_show_dialog.dart';
import 'package:uni_match/dialogs/progress_dialog.dart';
import 'package:uni_match/widgets/image_source_sheet.dart';

import 'widgets/help_show_dialog.dart';

class CheckinRegistrationPage extends StatefulWidget {
  final RegistrationStore controller;
  const CheckinRegistrationPage({Key? key, required this.controller})
      : super(key: key);

  @override
  _CheckinRegistrationPageState createState() =>
      _CheckinRegistrationPageState();
}

class _CheckinRegistrationPageState extends State<CheckinRegistrationPage> {
  late ProgressDialog _pr;
  AppController _i18n = Modular.get();
  File? imagemSelecionada;

  @override
  Widget build(BuildContext context) {
    _pr = ProgressDialog(context, isDismissible: false);

    return Scaffold(
      body: Container(
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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                          margin: const EdgeInsets.only(top: 5.0, left: 5.0),
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(8)),
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back, color: Colors.white70,))),
                    ),
                    Text(
                      "Pré Cadastro",
                      style: GoogleFonts.montserrat(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Colors.white60,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: const Radius.circular(40.0),
                                    topLeft: const Radius.circular(40.0),
                                  )),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check,
                                    size: 25.0,
                                    color: Colors.pinkAccent,
                                  ),
                                  Flexible(
                                    child: Text(
                                      "",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      maxLines: 3,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              height: 45,
                              color: Colors.white60,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check,
                                    size: 25.0,
                                    color: Colors.pinkAccent,
                                  ),
                                  Flexible(
                                    child: Text(
                                      "",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: const Radius.circular(40.0),
                                    topRight: const Radius.circular(40.0),
                                  )),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.description,
                                    size: 20.0,
                                  ),
                                  Flexible(
                                    child: Text(
                                      "Comprovante",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                if (imagemSelecionada == null)
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _selectImage(context: context, path: 'profile');
                        },
                      child: SizedBox(
                        width: 350,
                        child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                color: Colors.transparent,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(padding: const EdgeInsets.only(top: 20, bottom: 20),
                                      child: Text(
                                        "Comprovante de Matrícula",
                                        style: GoogleFonts.nunito(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.file_download,
                                      color: Colors.white,
                                      size: 27,
                                    ),

                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                        ),
                      ),
                      SizedBox(height: 10.0,),

                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.white.withOpacity(0.2))
                        ),
                        child: Icon(Icons.help_outline_rounded, color: Colors.black54,),
                        onPressed: (){
                          showDialog(context: context, builder: (_)=> HelpShowDialog());
                        },
                      )
                    ],
                  )
                else Expanded(
                        child: Container(
                          width: 350,
                          color: Colors.transparent,
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              color: Colors.transparent,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.file(
                                  imagemSelecionada!,
                                  fit: BoxFit.cover,
                                ),
                              )),
                        ),
                      ),
                if (imagemSelecionada != null)
                  FadeInDown(
                    delay: Duration(milliseconds: 200),
                    child: TextButton(
                      child: Text(
                        "Finalizar",
                        style: GoogleFonts.nunito(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        _pr.show(_i18n.translate("processing")!);
                        String imageLink = "";
                        if(imagemSelecionada != null){
                          imageLink = await UserModel().uploadFile(file: imagemSelecionada!, path: 'formulario', userId: widget.controller.emailController.text);
                          await UserModel().newInterested(
                              emailId: widget.controller.emailController.text,
                              data: {
                                "nome":widget.controller.nameController.text,
                                "email":widget.controller.emailController.text,
                                "instagram":widget.controller.instaController.text,
                                "universidade":widget.controller.universidadeController.text,
                                "curso":widget.controller.cursoControler.text,
                                "anoIngresso":widget.controller.anoiController.text,
                                "anoConclusao":widget.controller.anofController.text,
                                "codigoAtletica":widget.controller.codigoAtleticaController.text,
                                "comprovante": imageLink,
                              }
                          );
                          _pr.hide().whenComplete(() {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return RegistrationShowDialog(
                                    email: widget.controller.emailController.text,
                                  );
                                });
                          });
                        }
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _selectImage({required String path, required context}) async {
    await showModalBottomSheet(
        context: context,
        builder: (context) => ImageSourceSheet(
              tipoImagem: "chat",
              onImageSelected: (image) async {
                if (image != null) {
                  // if (Platform.isAndroid) {
                    _pr.show(_i18n.translate("processing")!);

                    setState(() {
                      imagemSelecionada = image;
                    });

                    _pr.hide();
                    Navigator.of(context).pop();
                    if(Navigator.of(context).canPop()){
                      Navigator.of(context).pop();
                    }
                // }
                }
              },
            ));
  }
}
