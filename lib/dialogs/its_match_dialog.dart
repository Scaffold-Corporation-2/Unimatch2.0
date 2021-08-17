import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/app/datas/user.dart';
import 'package:uni_match/plugins/swipe_stack/swipe_stack.dart';

// ignore: must_be_immutable
class ItsMatchDialog extends StatelessWidget {
  // Variables
  final GlobalKey<SwipeStackState>? swipeKey;
  final Usuario matchedUser;
  final bool showSwipeButton;

  ItsMatchDialog(
      {required this.matchedUser, this.swipeKey, this.showSwipeButton = true});
  AppController i18n = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(.55),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /// Matched User image
              CircleAvatar(
                radius: 75,
                backgroundColor: Theme.of(context).primaryColor,
                backgroundImage: NetworkImage(matchedUser.userProfilePhoto),
              ),
              SizedBox(height: 10),

              /// Matched User first name
              Text(matchedUser.userFullname.split(" ")[0],
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 10),

              Text(i18n.translate("likes_you_too")!,
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 10),

              Text(
                  "${i18n.translate("you_and")} "
                  "${matchedUser.userFullname.split(" ")[0]} "
                  "${i18n.translate("liked_each_other")}",
                  style: TextStyle(fontSize: 18, color: Colors.grey)),
              SizedBox(height: 10),

              /// Send a message button
              SizedBox(
                  height: 47,
                  width: double.maxFinite,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          )
                        )
                      ),
                      child: Text(i18n.translate("send_a_message")!,
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                      onPressed: () {
                        /// Close it's match dialog  first
                        Navigator.of(context).pop();

                        /// Go to chat screen

                        Modular.to.pushNamed('/chat', arguments: matchedUser);
                      })),
              SizedBox(height: 20),

              /// Keep swiping button
              if (showSwipeButton)
                SizedBox(
                  height: 45,
                  width: double.maxFinite,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
                        textStyle: MaterialStateProperty.all<TextStyle>(
                          TextStyle(color: Colors.white)
                        ),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                            side: BorderSide(
                                color: Theme.of(context).primaryColor, width: 2)
                          )
                        )
                      ),
                      child: Text(i18n.translate("keep_passing")!,
                          style: TextStyle(fontSize: 18)),
                      onPressed: () {
                        /// Close it's match dialog 
                        Navigator.of(context).pop();

                        /// Swipe right
                        //todo testar 
                        // swipeKey!.currentState!.swipeRight();
                      })),
                  

            ],
          ),
        ),
      ),
    );
  }
}
