import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/models/user_model.dart';
import 'package:uni_match/app/modules/home/view/menu/dialog_menu.dart';
import 'package:uni_match/app/modules/profile/view/profile_screen.dart';
import 'package:uni_match/widgets/cicle_button.dart';
import 'package:uni_match/widgets/default_card_border.dart';
import 'package:uni_match/widgets/svg_icon.dart';

class ProfileBasicInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Initialization
    // Get User Birthday
    final DateTime userBirthday = DateTime(
        UserModel().user.userBirthYear,
        UserModel().user.userBirthMonth,
        UserModel().user.userBirthDay);
    // Get User Current Age
    final int userAge = UserModel().calculateUserAge(userBirthday);

    return Card(
      color: Theme.of(context).primaryColor,
      elevation: 4.0,
      shape: defaultCardBorder(),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width - 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Profile image
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                          user: UserModel().user, showButtons: false, myUser: true,)));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 40,
                      backgroundImage:
                          NetworkImage(UserModel().user.userProfilePhoto),
                    ),
                  ),
                ),

                SizedBox(width: 10),

                /// Profile details
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${UserModel().user.userFullname.split(' ')[0]}, "
                      "${userAge.toString()}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 5),

                    /// Location
                    Row(
                      children: [
                        SvgIcon("assets/icons/location_point_icon.svg",
                            color: Colors.white),
                        SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // City
                            Text("${UserModel().user.userLocality},",
                                style: TextStyle(color: Colors.white)),
                            // Country
                            Text("${UserModel().user.userCountry}",
                                style: TextStyle(color: Colors.white)),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),

            /// Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                cicleButton(
                  bgColor: Theme.of(context).accentColor,
                  padding: 13,
                  icon: SvgIcon("assets/icons/settings_icon.svg",
                      color: Colors.white, width: 30, height: 30),
                  onTap: () {
                    /// Go to profile settings
                    Modular.to.pushNamed("/profile/settings");
                  },
                ),
                cicleButton(
                  bgColor: Theme.of(context).accentColor,
                  padding: 13,
                  icon:  Icon(Icons.edit, color: Colors.white, size: 30,),
                  onTap: () {
                    Modular.to.pushNamed('/profile/edit');
                  },
                ),

                cicleButton(
                  bgColor: Theme.of(context).accentColor,
                  padding: 13,
                  icon: Icon(Icons.workspaces_filled, color: Colors.white, size: 30,),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => DialogMenu(),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 5.0,)
          ],
        ),
      ),
    );
  }
}
