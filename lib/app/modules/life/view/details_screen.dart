import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:uni_match/app/datas/lifeStyle.dart';
import 'package:uni_match/app/models/user_model.dart';
import 'package:uni_match/helpers/app_helper.dart';
import 'package:uni_match/plugins/carousel_pro/carousel_pro.dart';
import 'package:uni_match/widgets/badge.dart';
import 'package:uni_match/widgets/custom_animated_button.dart';
import 'package:uni_match/widgets/gallery/galleryimage.dart';
import 'package:uni_match/widgets/svg_icon.dart';

import 'maps_sheet.dart';

class DetailsScreen extends StatelessWidget {
  final LifeStyleModel lifeStyleModel;
 DetailsScreen({Key? key, required this.lifeStyleModel}) : super(key: key);

  final AppHelper _appHelper = AppHelper();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final DirectionsMode directionsMode = DirectionsMode.driving;
  final double originLatitude = UserModel().user.userGeoPoint.latitude;
  final double originLongitude = UserModel().user.userGeoPoint.longitude;
  final String originTitle = 'Posição atual';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                /// Carousel Profile images
                AspectRatio(
                  aspectRatio: 1.15 / 1,
                  child: Carousel(
                      autoplay: false,
                      dotBgColor: Colors.transparent,
                      dotIncreasedColor: Theme.of(context).primaryColor,
                      images: lifeStyleModel.imagens
                          .map((url) => NetworkImage(url))
                          .toList()),
                  ),
                if(lifeStyleModel.cardapio.isNotEmpty)
                GalleryImage(
                  titleGallery: lifeStyleModel.lifeStyleNome,
                  imageUrls: lifeStyleModel.cardapio
                ),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// Full Name
                          Expanded(
                            child: Text(
                              '${lifeStyleModel.lifeStyleNome}',
                              style: GoogleFonts.nunito(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),

                          /// Location distance
                          Badge(
                              icon: SvgIcon(
                                  "assets/icons/location_point_icon.svg",
                                  color: Colors.white,
                                  width: 15,
                                  height: 15),
                              text:
                              '${_appHelper.getDistanceBetweenUsers(userLat: lifeStyleModel.lifeStyleGeoPoint.latitude, userLong: lifeStyleModel.lifeStyleGeoPoint.longitude)}km')
                        ],
                      ),
                      SizedBox(height: 5),

                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                        leading: Icon(Icons.alarm_outlined,
                            color: Theme.of(context).primaryColor,
                            size: 25),

                        title: Text("${lifeStyleModel.horarioAberto[DateFormat('EEEE').format(DateTime.now())]}",
                            style: TextStyle(fontSize: 19)),
                      ),


                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                        leading: Icon(Icons.attach_money_outlined,
                            color: Theme.of(context).primaryColor,
                            size: 25),

                        title: Text("R\$ ${lifeStyleModel.lifeStylePreco} (média para 2 pessoas)",
                            style: TextStyle(fontSize: 19)),
                      ),

                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                        leading: SvgIcon(
                            "assets/icons/location_point_icon.svg",
                            color: Theme.of(context).primaryColor,
                            width: 25,
                            height: 25),
                        title: Text("${lifeStyleModel.lifeStyleLocal}", style: TextStyle(fontSize: 19)),
                      ),

                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Descrição",
                            style: TextStyle(
                                fontSize: 22,
                                color: Theme.of(context).primaryColor)),
                      ),
                      Text(lifeStyleModel.lifeStyleDescricao,
                          style: TextStyle(fontSize: 18, color: Colors.grey)),

                      SizedBox(height: 30.0,),
                      CustomAnimatedButton(
                        iconText: true,
                        icon: Icons.send,
                        color: Colors.pink.shade400,
                        widhtMultiply: 0.9,
                        height: 65,
                        text: "Partiu ${lifeStyleModel.lifeStyleNome.split(' ')[0]}",
                        onTap: (){
                          MapsSheet.show(
                            context: context,
                            onMapTap: (map) {
                              map.showDirections(
                                destination: Coords(
                                  lifeStyleModel.lifeStyleGeoPoint.latitude,
                                  lifeStyleModel.lifeStyleGeoPoint.longitude,
                                ),
                                destinationTitle: lifeStyleModel.lifeStyleNome,
                                origin: Coords(originLatitude, originLongitude),
                                originTitle: originTitle,
                                directionsMode: directionsMode,
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
