import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/modules/life/store/life_store.dart';
import 'package:uni_match/app/modules/life/widgets/custom_card.dart';
import 'package:uni_match/helpers/app_ad_helper.dart';

class LifePage extends StatefulWidget {
  const LifePage({Key? key}) : super(key: key);

  @override
  _LifePageState createState() => _LifePageState();
}

class _LifePageState extends ModularState<LifePage, LifeStore> {

  @override
  void initState() {
    super.initState();
    controller.getMovies();
    controller.getPlaces();
    AppAdHelper.showInterstitialAd();
  }

  @override
  void dispose() {
    AppAdHelper.disposeInterstitialAd();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            controller.i18n.translate("lifestyle")!,
            style: TextStyle(
                fontSize: 20,
                color: Colors.grey[600]
            ),
          ),
        ),
        body: Container(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10.0,),

                CustomCard(
                  title: "Filmes / Séries",
                  imagem: "movies.jpg",
                  onTap: (){Modular.to.pushNamed("/lifeStyle/movies");},
                ),

                CustomCard(
                  title: "Cafés",
                  imagem: "cafes.jpeg",
                  onTap: (){Modular.to.pushNamed("/lifeStyle/cafes");},
                ),

                CustomCard(
                  title: "Bares",
                  imagem: "pub.jpg",
                  onTap: (){Modular.to.pushNamed("/lifeStyle/bares");},
                ),

                CustomCard(
                  title: "Restaurantes",
                  imagem: "restaurant.jpg",
                  onTap: (){Modular.to.pushNamed("/lifeStyle/rest");},
                ),

                SizedBox(height: 10.0,),
              ],
            ),
          ),
        )
    );
  }
}
