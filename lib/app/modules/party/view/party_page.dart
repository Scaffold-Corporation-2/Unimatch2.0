import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:uni_match/app/datas/party.dart';
import 'package:uni_match/app/modules/party/store/party_store.dart';
import 'package:uni_match/app/modules/party/view/party_story.dart';
import 'package:uni_match/constants/constants.dart';
import 'package:uni_match/widgets/default_card_border.dart';
import 'package:uni_match/widgets/no_data.dart';
import 'package:uni_match/widgets/processing.dart';

class PartyPage extends StatefulWidget {
  const PartyPage({Key? key}) : super(key: key);

  @override
  _PartyPageState createState() => _PartyPageState();
}

class _PartyPageState extends ModularState<PartyPage, PartyStore> {

  @override
  void initState() {
    super.initState();
    controller.getParties();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            controller.i18n.translate("parties")!,
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
                : controller.listaFestas.isEmpty
                ? NoData(
                    svgName: 'info_icon',
                    text: controller.i18n.translate("no_party")!)
                : ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.listaFestas.length,
                  itemBuilder: ((context, index) {
                    /// Get notification DocumentSnapshot
                    final List partiesAll = controller.listaFestas;
                    final DocumentSnapshot parties = controller.listaFestas[index];
                    List<String> listaStory = [];
                    List<PartyModel> listaFestas = [];

                    for (var dadosFesta in partiesAll) {
                      for (var images in dadosFesta[IMAGES_PARTY]) {
                        listaStory.add(images);
                      }
                      PartyModel party = PartyModel.fromDoc(dadosFesta, listaStory);
                      listaFestas.add(party);
                      listaStory = [];
                    }

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
                              int valor = listaFestas[index].quantidadeVisualizacao;
                              valor++;
                              controller.atualizarVisualizacoes(
                                  partyId: listaFestas[index].partyId,
                                  data: {'$QUANT_PARTY': valor});

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return StoryPage(
                                      listParties: listaFestas,
                                      initIndex: index,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              elevation: 4.0,
                              margin: EdgeInsets.all(0),
                              shape: defaultCardBorder(),
                              child: Container(
                                height: 180,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          parties[IMAGES_PARTY][0]),
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.2),
                                          BlendMode.srcATop),
                                      fit: BoxFit.cover),
                                ),
                                child: Container(
                                  alignment: Alignment.bottomLeft,
                                  decoration: BoxDecoration(

                                    gradient: LinearGradient(
                                        begin: Alignment.bottomRight,
                                        colors: [
                                          Theme.of(context).primaryColor,
                                          Colors.transparent
                                        ]),
                                  ),
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          '${parties[NAME_PARTY]}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.alarm_outlined,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 5),
                                          Expanded(
                                            child: Text(
                                              parties[DATE_PARTY] +
                                                  " - " +
                                                  parties[TIME_PARTY],
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
                    ),
                  );
                }
                )
            );
          }
        )
    );
  }
}
