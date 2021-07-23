import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:story/story_page_view/story_page_view.dart';
import 'package:uni_match/app/datas/party.dart';
import 'package:uni_match/widgets/swipe_up.dart';


class StoryPage extends StatelessWidget {
  final List<PartyModel> listParties;
  final int initIndex;

  const StoryPage({Key? key, required this.listParties, required this.initIndex}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryPageView(
          itemBuilder: (context, pageIndex, storyIndex) {
            final party = listParties[pageIndex];
            final story = party.stories[storyIndex];
            return Stack(
              children: [
                Positioned.fill(
                  child: Container(color: party.corFundo),
                ),
                Positioned.fill(
                    child: Image.network(
                      story,
                      fit: BoxFit.contain,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 44, left: 8),
                  child: Row(
                    children: [
                      Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(party.imageAthletic),
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        party.partyName,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          gestureItemBuilder: (context, pageIndex, storyIndex) {

            return SwipeUp(
              onSwipe: () async {

                if(listParties[pageIndex].stories.length -1 == storyIndex) {
                Modular.to.pushNamed('/party/partyScreen',
                    arguments: listParties[pageIndex]);
                }
              },
              showArrow: listParties[pageIndex].stories.length -1 == storyIndex ? true : false,
              color: Colors.white.withOpacity(0.6),
              child: Material(
                  color: Colors.white.withOpacity(0.6),
                  shadowColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18))
                  ),
                  child: listParties[pageIndex].stories.length -1 != storyIndex
                      ? Container()
                      : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Saiba mais', style: TextStyle(color: Colors.black, fontSize: 16)),
                      )),
              body: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    color: Colors.white,
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            );
          },
          pageLength: listParties.length,
          initialPage: initIndex,
          storyLength: (int pageIndex) {
            return listParties[pageIndex].stories.length;
          },
          onPageLimitReached: () {
            Navigator.pop(context);
          },
        ),
    );
  }
}