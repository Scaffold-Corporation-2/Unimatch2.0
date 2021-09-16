import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uni_match/app/modules/login/widgets/custom_animated_button.dart';

class InterestsChips extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _InterestsChipsState();
}

class _InterestsChipsState extends State<InterestsChips> {


  List<String> _titles = <String>[
    "Cinema", "Festas", "Sextou", "Futebol", "Jogos Online", "Instagram",
    "Netflix", "Happy hour", "Podcasts", "Viajar/Passear", "Cozinhar",
    "Sair para um café", "Músicas e shows", "Fazer trilhas", "Praticar esportes",
    "Jantar fora", "Gibis", "Informática", "Política", "Sneakers",
    "Jogos de tabuleiro", "Religião", "Negócios", "Artes cênicas", "Dança",
    "Voluntário", "Acampar", "Antiguidades", "Ciclismo", "BBB", "Carros", "Álcool",
    "Natação", "Atleta", "Sair à noite", "Natureza", "Artista", "Trilha",
    "Escalada", "Caminhada", "Ver esportes", "Bordar", "Cartões postais",
    "Adesivos", "Colecionar cédulas", "Jardinagem", "Rolê", "Bar", "After",
    "Astrologia", "Esportes", "Astronomia", "Música", "Bate-Papo", "Natureza",
    "Tecnologia", "E-sports", "Filmes", "LifeStyle", "Conversar para afastar o tédio",
    "Conversar sobre a faculdade", "Gamer", "Netflix", "Moda", "Outros",
  ];
  List<String> _filters = <String>[];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Interesses",
          style: GoogleFonts.nunito(
              fontSize: 26,
              color: Colors.grey[700],
              fontWeight: FontWeight.w600
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text("${_filters.length}/5",
              style: GoogleFonts.nunito(
                  fontSize: 22,
                  color: _filters.length >= 5 ? Colors.lightGreen : Colors.red,
                  fontWeight: FontWeight.w600
              ),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.center,
                children: companyPosition.toList(),
              ),
            ),
          ),

          if(_filters.length == 5)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: CustomAnimatedButton(
                height: 60,
                widhtMultiply: 0.8,
                colorText: Colors.white,
                color: Colors.pinkAccent,
                text: "Salvar",
                onTap: (){
                  Modular.to.pop(_filters);
                },
            ),
          )
        ],
      ),
    );
  }

  Iterable<Widget> get companyPosition sync* {
    for (String company in _titles) {
      yield Padding(
        padding: const EdgeInsets.all(6.0),
        child: FilterChip(
          elevation: 8.0,
          backgroundColor: Colors.grey[200],
          label: Text(
            company,
            style: GoogleFonts.nunito(
                fontSize: 16,
                fontWeight: FontWeight.w500
            ),
          ),
          selected: _filters.contains(company),
          selectedColor: Colors.pinkAccent.shade100,
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                if(_filters.length < 5){
                  _filters.add(company);
                }
              } else {
                _filters.removeWhere((String name) {
                  return name == company;
                });
              }
            });
          },
        ),
      );
    }
  }

}

class ChipWidget {
  const ChipWidget(this.name);
  final String name;
}