import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String imagem;
  final Function onTap;

  const CustomCard({Key? key, required this.title, required this.imagem, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){ onTap(); },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 8.0,
          margin: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(28.0))),
          child: Container(
            height: 180,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      "assets/images/$imagem"),
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
              padding: const EdgeInsets.only(left: 12.0, bottom: 5.0),

              child: Text(title,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
