/** TO DEVELOP
 * - carte basique (texte simple)
 * - carte langage multiple (plusieurs area avec des drapeaux) Le widget response est multiple du nombre de langues
 * - carte avec vidéo
 * - faire un gestionnaire de carte permettant de modifier html/javascript et css.
 * - En usant Webview on perds l'interaction avec Flutter. à utiliser pour quelques types de cartes
 */

import 'package:beaver_learning/src/widgets/card/card_displayer/html_card_displayer.dart';
import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardDisplayer extends StatefulWidget {
  const CardDisplayer({super.key});

  static const routeName = '/cardDisplayerScreen';

  @override
  State<CardDisplayer> createState() => _CardDisplayerState();
}

class _CardDisplayerState extends State<CardDisplayer> {
  bool isPrintAnswer = false;
  double revisorButtonHeight = 36.0;

  Widget getCorrectDisplayer() {
    return HTMLCardDisplayer(isPrintAnswer: isPrintAnswer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Card displayer")),
        body: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                padding: const EdgeInsets.only(left: 10),
                child: const Row(children: [
                  Text("35",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold)),
                  Text(" "),
                  Text("cards to repeat")
                ]),
              ),
              Container(
                padding: const EdgeInsets.only(right: 10),
                child: const Row(children: [
                  Text("14",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold)),
                  Text(" "),
                  Text("cards left")
                ]),
              )
            ]),
            Expanded(
              child: getCorrectDisplayer(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.blue[900]),
                  onPressed: () {},
                  child: Icon(FontAwesomeIcons.chartColumn),
                ),
                Container(
                  padding: EdgeInsets.all(7),
                  margin: EdgeInsets.only(top: 2, bottom: 2, right: 5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.blue[900]!,
                          style: BorderStyle.solid,
                          width: 3),
                      color: Colors.redAccent),
                  child: Icon(FontAwesomeIcons.lightbulb,
                      color: Colors.yellow[400]),
                )
              ],
            ),
            if (isPrintAnswer)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Container(
                          height: revisorButtonHeight,
                          color: Colors.grey,
                          alignment: Alignment.center,
                          child: Text("Very hard"))),
                  Expanded(
                      child: Container(
                          height: revisorButtonHeight,
                          alignment: Alignment.center,
                          color: Colors.red,
                          child: Text("Hard"))),
                  Expanded(
                      child: Container(
                          height: revisorButtonHeight,
                          color: Colors.green,
                          alignment: Alignment.center,
                          child: Text("Easy"))),
                  Expanded(
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isPrintAnswer = false;
                            });
                          },
                          child: Container(
                              height: revisorButtonHeight,
                              color: Colors.blue,
                              alignment: Alignment.center,
                              child: Text("Very Easy")))),
                ],
              )
            else
              GestureDetector(
                  onTap: () {
                    setState(() {
                      isPrintAnswer = true;
                    });
                  },
                  child: Container(
                      height: revisorButtonHeight,
                      color: Colors.grey,
                      alignment: Alignment.center,
                      child: const Text("Print Answer")))
          ],
        ),
        drawer: const AppDrawer());
  }
}
