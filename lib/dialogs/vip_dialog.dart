import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/app/models/app_model.dart';
import 'package:uni_match/app/models/user_model.dart';
import 'package:uni_match/widgets/store_products.dart';


class VipDialog extends StatelessWidget {
  final AppController i18n = Modular.get();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    children: <Widget>[
                      /// User image
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Image.asset('assets/images/crow_badge.png'),
                        ) 
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(i18n.translate("vip_account")!,
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundColor: Theme.of(context).primaryColor,
                          backgroundImage: NetworkImage(UserModel().user.userProfilePhoto),
                        ),
                        title: Text(
                            '${i18n.translate("hello")} ${UserModel().user.userFullname.split(' ')[0]}, '
                            '${i18n.translate("become_a_vip_member_and_enjoy_the_benefits_below")}',
                            style:
                                TextStyle(fontSize: 18, color: Colors.white),
                            textAlign: TextAlign.center),
                      ),
                      SizedBox(height: 8)
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  child: IconButton(
                      icon: Icon(Icons.cancel, color: Colors.white, size: 35),
                      onPressed: () {
                        /// Close Dialog
                        Navigator.of(context).pop();
                      }),
                )
              ],
            ),

            /// VIP Plans
            Container(
              color: Colors.grey.withAlpha(70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(i18n.translate("vip_subscriptions")!,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  Divider(height: 10, thickness: 1),
                  /// VIP Subscriptions
                  StoreProducts(
                    priceColor: Colors.green,
                    icon: Image.asset('assets/images/crow_badge.png',
                        width: 50, height: 50),
                  ),
                  Divider(thickness: 1),
                ],
              ),
            ),
            Divider(),

            /// VIP Benefits
            Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(i18n.translate("benefits")!,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  Divider(height: 10, thickness: 1),

                  // Passport
                  ListTile(
                    leading: CircleAvatar(
                      radius: 18,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Icon(Icons.flight,
                              color: Colors.white),
                    ),
                    title: Text(i18n.translate("passport")!,
                        style: TextStyle(fontSize: 18)),
                    subtitle: Text(i18n.translate("travel_to_any_country_or_city_and_match_with_people_there")!),
                  ),
                  Divider(height: 10, thickness: 1),

                  // Discover more people around you
                  ListTile(
                    leading: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.purple,
                      child: Icon(Icons.location_on_outlined, 
                      color: Colors.white),
                    ),
                    title: Text(i18n.translate("discover_more_people")!,
                        style: TextStyle(fontSize: 18)),
                    subtitle: Text("${i18n.translate('get')} "
                      "${AppModel().appInfo.vipAccountMaxDistance} km " 
                      "${i18n.translate('radius_away')}"),
                  ),
                  Divider(height: 10, thickness: 1),

                  ListTile(
                    leading: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.grey[300],
                      child: Icon(Icons.favorite_border,
                          size: 28,
                          color: Theme.of(context).primaryColor),
                    ),
                    title: Text(i18n.translate("unlimited")!,
                        style: TextStyle(fontSize: 18)),

                    subtitle: Text(i18n.translate("have_a_thousand_unlimited_likes_to_integrate_with_everyone")!),
                  ),
                  Divider(height: 10, thickness: 1),

                  // Add more pictures
                  ListTile(
                    leading: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.green,
                      child: Icon(Icons.camera_alt, 
                      color: Colors.white),
                    ),
                    title: Text(i18n.translate("add_more_pictures_on_your_profile_gallery")!,
                        style: TextStyle(fontSize: 18)),
                    subtitle: Text(i18n.translate("make_your_profile_attractive_by_adding_more_photos")!),
                  ),
                  Divider(height: 10, thickness: 1),

                  /// See who liked you
                  ListTile(
                    leading: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.pinkAccent,
                      child: Icon(Icons.favorite, color: Colors.white),
                    ),
                    title: Text(i18n.translate("see_people_who_liked_you")!,
                        style: TextStyle(fontSize: 18)),
                    subtitle: Text(i18n.translate(
                        "unravel_the_mystery_and_find_out_who_liked_you")!),
                  ),
                  Divider(height: 10, thickness: 1),

                  /// See who visited you
                  ListTile(
                    leading: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.remove_red_eye, color: Colors.white),
                    ),
                    title: Text(
                        i18n.translate("see_people_who_visited_your_profile")!,
                        style: TextStyle(fontSize: 18)),
                    subtitle: Text(i18n.translate(
                        "unravel_the_mystery_and_find_out_who_visited_your_profile")!),
                  ),
                  Divider(height: 10, thickness: 1),

                  /// See disliked profiles
                  ListTile(
                    leading: CircleAvatar(
                      radius: 18,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Icon(Icons.close, color: Colors.white),
                    ),
                    title: Text(
                        i18n.translate("see_people_you_have_rejected")!,
                        style: TextStyle(fontSize: 18)),
                    subtitle: Text(
                        i18n.translate("retrieve_and_review_all_profiles")!),
                  ),
                  Divider(height: 10, thickness: 1),

                  /// Verified account badge
                  ListTile(
                    leading: Image.asset('assets/images/verified_badge.png',
                        width: 40, height: 40),
                    title: Text(i18n.translate("verified_account_badge")!,
                        style: TextStyle(fontSize: 18)),
                    subtitle: Text(i18n.translate(
                        "let_other_users_know_that_you_are_a_real_person")!),
                  ),
                  Divider(height: 10, thickness: 1),

                  /// No Ads
                  ListTile(
                    leading: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.red,
                      child: Icon(Icons.block, color: Colors.white),
                    ),
                    title: Text(i18n.translate("no_ads")!,
                        style: TextStyle(fontSize: 18)),
                    subtitle:
                        Text(i18n.translate("have_a_unique_experience")!),
                  ),
                  Divider(height: 10, thickness: 1),
                  SizedBox(height: 15)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
 }
