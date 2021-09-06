import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:uni_match/app/modules/life/store/life_store.dart';
import 'package:uni_match/widgets/default_card_border.dart';
import 'package:uni_match/widgets/no_data.dart';
import 'package:uni_match/widgets/processing.dart';

class MoviesScreen extends StatefulWidget {
  final String tipoFilme;
  MoviesScreen({Key? key, required this.tipoFilme}) : super(key: key);

  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final LifeStore controller = Modular.get();

  @override
  void initState() {
    controller.filtrarFilmes(widget.tipoFilme);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.tipoFilme,
          style: TextStyle(
              fontSize: 20,
              color: Colors.grey[600]
          ),
        ),
      ),
      body: Observer(
          builder:(_) {
            return controller.carregandoValores == true
                ? Processing(text: controller.i18n.translate("loading")!)
                : controller.listaFilmesFiltrados.isEmpty
                ? NoData(
                svgName: 'info_icon',
                text: controller.i18n.translate("no_add")!)
                : ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.listaFilmesFiltrados.length,
                  itemBuilder: ((context, index) {
                    /// Show notification
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 575),
                      child: SlideAnimation(
                        verticalOffset: 150.0,
                        child: FadeInAnimation(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: () {
                                //adicionar nova feature para click
                              },
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                elevation: 10.0,
                                margin: EdgeInsets.all(10),
                                color: Colors.pinkAccent.shade200,
                                shape: defaultCardBorder(),
                                child: Container(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Row(
                                          children: [Icon(
                                              Icons.play_arrow_outlined,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              '${controller.listaFilmesFiltrados[index].nomeFilme}',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.local_movies,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 5),
                                          Expanded(
                                            child: Text(
                                              controller.listaFilmesFiltrados[index].localFilme,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                              maxLines: 1,
                                              overflow:
                                              TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(width: 0, height: 0),
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
                )
            );
          }
      ),
    );
  }
}
