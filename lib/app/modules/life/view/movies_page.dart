import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/modules/life/store/life_store.dart';
import 'package:uni_match/app/modules/life/widgets/custom_card.dart';

class MoviePage extends StatelessWidget {
  MoviePage({Key? key}) : super(key: key);

  final LifeStore controller = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            controller.i18n.translate("movies")!,
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
                  title: "Românticos",
                  imagem: "romance.jpg",
                  onTap: (){
                    Modular.to.pushNamed(
                        "/lifeStyle/moviesScreen",
                        arguments: "Românticos");
                  },
                ),

                CustomCard(
                  title: "Barulhentos",
                  imagem: "barulho.jpg",
                  onTap: (){
                    Modular.to.pushNamed(
                        "/lifeStyle/moviesScreen",
                        arguments: "Barulhentos");
                  },
                ),

                CustomCard(
                  title: "Apimentados",
                  imagem: "hot.jpg",
                  onTap: (){
                    Modular.to.pushNamed(
                        "/lifeStyle/moviesScreen",
                        arguments: "Apimentados");
                  },
                ),

                CustomCard(
                  title: "Divertidos",
                  imagem: "comedia.jpg",
                  onTap: (){
                    Modular.to.pushNamed(
                        "/lifeStyle/moviesScreen",
                        arguments: "Divertidos");
                  },
                ),

                SizedBox(height: 10.0,),
              ],
            ),
          ),
        )
    );
  }
}
