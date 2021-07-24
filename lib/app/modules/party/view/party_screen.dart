import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/app/datas/party.dart';
import 'package:uni_match/app/models/user_model.dart';
import 'package:uni_match/app/modules/party/store/party_store.dart';
import 'package:uni_match/app/modules/party/view/athletic_screen.dart';
import 'package:uni_match/app/modules/party/view/maps_sheet.dart';
import 'package:uni_match/widgets/cicle_button.dart';
import 'package:uni_match/widgets/custom_animated_button.dart';
import 'package:uni_match/widgets/default_card_border.dart';
import 'package:uni_match/widgets/slimy_card.dart';
import 'package:uni_match/widgets/svg_icon.dart';
import 'package:url_launcher/url_launcher.dart';



class PartyScreen extends StatefulWidget {
  final PartyModel party;

  PartyScreen({Key? key, required this.party}) : super(key: key);

  @override
  _PartyScreenState createState() => _PartyScreenState();
}

class _PartyScreenState extends ModularState<PartyScreen, PartyStore> {
  final AppController i18n = Modular.get();

  DirectionsMode directionsMode = DirectionsMode.driving;

  double originLatitude = UserModel().user.userGeoPoint.latitude;
  double originLongitude = UserModel().user.userGeoPoint.longitude;
  String originTitle = 'Posição atual';


  @override
  void initState() {
    controller.dadosCache();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          i18n.translate("parties")!,
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Card(
              color: Theme.of(context).primaryColor,
              elevation: 4.0,
              shape: defaultCardBorder(),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        radius: 40,
                        child: Image.network(widget.party.imagemAtletica, fit: BoxFit.cover,),
                      ),
                    ),

                    SizedBox(width: 10),

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.party.siglaAtletica}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(height: 5),

                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgIcon(
                                      "assets/icons/location_point_icon.svg",
                                      color: Colors.white),
                                  SizedBox(width: 5),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // City
                                      Text(
                                          widget.party.universidadeAtletica.length <= 18
                                              ? widget.party.universidadeAtletica
                                              : widget.party.universidadeAtletica
                                              .substring(0, 15) +
                                              "...",
                                          style: TextStyle(
                                              color: Colors.white)),
                                      // Country
                                      Text(widget.party.cidadeAtletica.length <= 18
                                          ? widget.party.cidadeAtletica
                                          : widget.party.cidadeAtletica
                                          .substring(0, 15) +
                                          "...",
                                          style: TextStyle(
                                              color: Colors.white)),
                                    ],
                                  ),
                                ],
                              ),
                              // SizedBox(width: 10),

                              cicleButton(
                                bgColor: Theme.of(context).accentColor,
                                padding: 13,
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AthleticParty(party: widget.party,);
                                      }
                                    );
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
          SlimyCard(
            color: widget.party.corFundo,
            topCardHeight: 250,
            bottomCardHeight: 125,
            width: MediaQuery.of(context).size.width * 0.9,
            topCardWidget: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowGlow();
                return true; // or false
              },
              child: PageView(
                children: [
                  topCardWidget(),
                  topCardWidget2(),
                ],
                onPageChanged: (val) async {
                  if(val == 1 ) controller.mudarPreferencias("bool","tutorial", true);
                },
              ),
            ),
            bottomCardWidget: bottomCardWidget(),
            bottomCardFunction: () async {
              if (await canLaunch(widget.party.partyUrlIngresso)) {
                await launch(
                  widget.party.partyUrlIngresso,
                  forceSafariVC: false,
                  forceWebView: false,
                );
              } else {
                throw 'Could not launch ${widget.party.partyUrlIngresso}';
              }
            },
          ),


            SizedBox(
              height: 20.0,
            ),

            CustomAnimatedButton(
                iconText: true,
                icon: Icons.send,
                color: widget.party.corFundo,
                widhtMultiply: 0.9,
                height: 80,
                text: "Ir para festa",
                onTap: (){
                  MapsSheet.show(
                    context: context,
                    onMapTap: (map) {
                      map.showDirections(
                        destination: Coords(
                          widget.party.partyGeoPoint.latitude,
                          widget.party.partyGeoPoint.longitude,
                        ),
                        destinationTitle: widget.party.partyLocal,
                        origin: Coords(originLatitude, originLongitude),
                        originTitle: originTitle,
                        directionsMode: directionsMode,
                      );
                    },
                  );
                },
            )
          ],
        ),
      ),
    );
  }

  Widget topCardWidget() {
    return Column(
      children: [
        SizedBox(
          height: 5.0,
        ),
        Flexible(
          child: Text(
            widget.party.partyName,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    children: [
                      Icon(Icons.date_range_outlined),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Text(
                          widget.party.partyDate,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(.85),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Icon(Icons.access_time_rounded),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Text(
                          widget.party.partyTime,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(.85),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Text(
                          widget.party.partyLocal,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(.85),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Column(
              children: [
                SizedBox(
                  height: 30.0,
                ),
                  Observer(
                    builder:(_) => controller.valueShared == false
                      ? Lottie.asset("assets/lottie/swipe_left.json", width: 150)
                      : Icon(
                    Icons.arrow_right_outlined,
                    size: 35,
                ),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget topCardWidget2() {
    return Scaffold(
      backgroundColor: widget.party.corFundo,
      body: SafeArea(
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowGlow();
            return true; // or false
          },
          child: ListView(
            physics: ScrollPhysics(),
            children: [
              SizedBox(
                height: 5.0,
              ),
              Text(
                "Descrição",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                widget.party.partyDescricao,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(.85),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomCardWidget() {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Icon(
                Icons.sticky_note_2_outlined,
                size: 25,
                color: Colors.white
            )
        ),
        Expanded(
          flex: 3,
          child: Center(
            child: Text(
              'Comprar ingresso',
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
              ),
            ),
          ),
        ),

        Expanded(
            flex: 1,
            child: Icon(
                Icons.sticky_note_2_outlined,
                size: 25,
                color: Colors.white
            )
        ),
      ],
    );
  }
}


