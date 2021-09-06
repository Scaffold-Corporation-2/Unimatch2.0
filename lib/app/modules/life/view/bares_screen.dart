import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:uni_match/app/modules/life/store/life_store.dart';
import 'package:uni_match/widgets/default_card_border.dart';
import 'package:uni_match/widgets/no_data.dart';
import 'package:uni_match/widgets/processing.dart';

class BaresScreen extends StatelessWidget {
  BaresScreen({Key? key}) : super(key: key);
  final LifeStore controller = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.i18n.translate("pubs")!,
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
                : controller.listaBares.isEmpty
                ? NoData(
                svgName: 'info_icon',
                text: controller.i18n.translate("no_add")!)
                : ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.listaBares.length,
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
                                Modular.to.pushNamed("/lifeStyle/details", arguments: controller.listaBares[index]);
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
                                            controller.listaBares[index].imagens[0]),
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
                                            '${controller.listaBares[index].lifeStyleNome}',
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
                                              controller.listaBares[index]
                                                  .horarioAberto[DateFormat('EEEE').format(DateTime.now())] != "Fechado"
                                                  ? Icons.check : Icons.error_outline,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 5),
                                            Expanded(
                                              child: Text(
                                                controller.listaBares[index].horarioAberto[DateFormat('EEEE').format(DateTime.now())],
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
      ),
    );
  }
}
