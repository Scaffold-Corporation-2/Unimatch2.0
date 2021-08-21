import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class ItemData{
  final Color color;
  final String image;
  final String text1;
  final String text2;
  final String text3;

  ItemData(this.color, this.image, this.text1, this.text2, this.text3);
}

class IntroRules extends StatefulWidget {
  @override
  _WithBuilder createState() => _WithBuilder();
}

class _WithBuilder extends State<IntroRules> {
  int page = 0;
  LiquidController? liquidController;
  UpdateType? updateType;

  List<ItemData> data = [
    ItemData(Color(0XFFE91E63), "assets/images/logo.png", "Unimatch", "Seja bem vindx!",
        "Por favor, leia com atenção as nossas diretrizes."),

    ItemData(Color(0XFFd81b77), "assets/images/logo.png", "1", "Respeito",
        "O respeito começa com você! Tenha respeito com os usuários do sistema, "
            "trate-os como gostaria de ser tratado e coloque-se no lugar do outro."),

    ItemData(Color(0XFFFF4081), "assets/images/logo.png", "2", "Assédio",
        "É inaceitável qualquer tipo de assédio/violência dentro do nosso aplicativo. Se você for a vítima, denuncie para o nosso suporte! "
            "Nos prontificaremos a ajudar e tomar as devidas providências."),

    ItemData(Color(0XFFdf448e), "assets/images/logo.png", "3", "Segurança",
        "Não forneça informações pessoais a outros usuários, permaneça sempre seguro. "
            "O Unimatch garante a privacidade e segurança dos dados enviados ao sistema."),

    ItemData(Color(0XFF9c4691), "assets/images/logo.png", "4", "Seja proativo",
        "Ajude o Unimatch a se tornar a rede social do universitário, seja proativo, "
            "engajado e sempre sinalize mau comportamento dentro do app."),

    ItemData(Color(0XFF871f78), "assets/images/logo.png", "5", "Divirta-se",
        "Conheça pessoas novas, encontre festas, faça amizades, "
            "relacionamentos e quem sabe até parceiros de breja, conte com o "
            "Unimatch para te ajudar nisso, entre nesse mundo e faça sua "
            "história conosco!"),
  ];

  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return new Container(
      width: 25.0,
      child: new Center(
        child: new Material(
          color: Colors.white,
          type: MaterialType.circle,
          child: new Container(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          LiquidSwipe.builder(
            itemCount: data.length,
            itemBuilder: (context, index){
              return Container(
                height: MediaQuery.of(context).size.height,
                color: data[index].color,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Image.asset(
                        data[index].image,
                        fit: BoxFit.cover,
                        height: 300,
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            data[index].text1,
                            style: GoogleFonts.fredokaOne(
                                fontSize: 45,
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                            ),
                          ),
                          SizedBox(height: 10,),

                          Text(
                            data[index].text2,
                            style: GoogleFonts.eczar(
                                fontSize: 35,
                                fontWeight: FontWeight.w200,
                                color: Colors.white
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              data[index].text3,
                              style: GoogleFonts.openSans(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            positionSlideIcon: 0.8,
            slideIconWidget: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.black.withOpacity(0.3),
              size: 35,
            ),
            onPageChangeCallback: pageChangeCallback,
            waveType: WaveType.liquidReveal,
            liquidController: liquidController,
            ignoreUserGestureWhileAnimating: true,
            enableLoop: false,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Expanded(child: SizedBox()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(data.length, _buildDot),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextButton(
                onPressed: () {
                  if(liquidController!.currentPage == 5){
                    Modular.to.navigate('/login/signUp');
                  }
                  else{
                    liquidController!.jumpToPage(
                        page:
                        liquidController!.currentPage + 1 > data.length - 1
                            ? 0
                            : liquidController!.currentPage + 1);
                  }
                },
                child: liquidController!.currentPage == 5
                    ? Text("Partiu", style: TextStyle(fontSize: 16),)
                    : Text("Próximo", style: TextStyle(fontSize: 16),),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
    });
  }
}