import 'package:flutter/material.dart';
import 'package:uni_match/app/datas/party.dart';

class AthleticParty extends StatelessWidget {
  final PartyModel party;

  const AthleticParty({Key? key, required this.party}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: AlertDialog(
        backgroundColor: Theme.of(context).primaryColor,
        contentPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        content: Container(
          width: MediaQuery.of(context).size.width,
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowGlow();
              return true; // or false
            },
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // physics: ScrollPhysics(),
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        disabledColor: Colors.transparent,
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () {Navigator.of(context).pop();}
                    ),
                  ),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 100,
                      child: Image.network(party.imagemAtletica),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.people_alt_outlined, size: 30),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Text(
                                party.nomeAtletica,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white.withOpacity(.85),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.0,),

                        Row(
                          children: [
                            Icon(Icons.wysiwyg_outlined, size: 30),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Text(
                                party.cursoAtletica,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white.withOpacity(.85),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.0,),

                        Row(
                          children: [
                            Icon(Icons.account_balance, size: 30),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Text(
                                party.universidadeAtletica,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white.withOpacity(.85),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.0,),

                        Row(
                          children: [
                            Icon(Icons.location_on_outlined, size: 30),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Text(
                                party.cidadeAtletica,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white.withOpacity(.85),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0,),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
