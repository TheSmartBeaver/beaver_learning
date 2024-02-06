/** TO DEVELOP
 * - carte basique (texte simple)
 * - carte langage multiple (plusieurs area avec des drapeaux) Le widget response est multiple du nombre de langues
 * - carte avec vidéo
 * - faire un gestionnaire de carte permettant de modifier html/javascript et css.
 * - En usant Webview on perds l'interaction avec Flutter. à utiliser pour quelques types de cartes
 */

import 'dart:ffi';

import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardDisplayer extends StatefulWidget {
  const CardDisplayer({super.key});

  static const routeName = '/cardDisplayerScreen';

  @override
  State<CardDisplayer> createState() => _CardDisplayerState();
}

String _getCustomHtml(String color) {
  return '''
      <!DOCTYPE html>
      <html>
      <head>
        <style>
          body {
            margin: 0; /* Supprime les marges par défaut du corps de la page */
            padding: 0; /* Supprime les espacements internes par défaut du corps de la page */
            display: flex; /* Utilise un affichage flex pour organiser les éléments en ligne */
            flex-direction: column; /* Organise les éléments de haut en bas */
            height: 100vh; /* Utilise la hauteur de la fenêtre visible */
          }

          .recto {
            background-color: blue; /* Arrière-plan bleu pour la partie "recto" */
            display: flex;
            justify-content: center; /* Centre le contenu horizontalement */
            align-items: center; /* Centre le contenu verticalement */
          }

          .verso {
            background-color: red; /* Arrière-plan rouge pour la partie "verso" */
            display: flex;
            flex-grow: 1; /* Permet à la partie "recto" de s'étendre pour remplir l'espace restant */
            justify-content: center; /* Centre le contenu horizontalement */
            align-items: center; /* Centre le contenu verticalement */
          }

          .texte {
            font-size: 34px; /* Augmente la taille de la police à 24 pixels */
          }
        </style>
      </head>
      <body>
        <div class='recto texte'><ul><li>Hello, World!</li><li>Hello, World!</li><li>Hello, World!</li></ul></div>
        <div class='verso texte'>Hello, c'est le verso</div>
        <script>
          function sayHello() {
            alert('Hello from JavaScript!');
          }
        </script>
      </body>
      </html>
    ''';
}

WebViewController _buildController() {
  return WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  //..loadRequest(Uri.parse('https://flutter.dev'));
  //..loadHtmlString(customHtml);
}

class _CardDisplayerState extends State<CardDisplayer> {
  WebViewController controller = _buildController();
  WebViewController controller2 = _buildController();

  double revisorButtonHeight = 36.0;

  @override
  Widget build(BuildContext context) {
    controller.loadHtmlString(_getCustomHtml("lightblue"));
    return Scaffold(
        appBar: AppBar(title: const Text("Card displayer")),
        body: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Row(children: [
                  Text("35",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold)),
                  Text(" "),
                  Text("cards to repeat")
                ]),
              ),
              Container(
                padding: EdgeInsets.only(right: 10),
                child: Row(children: [
                  Text("14",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold)),
                  Text(" "),
                  Text("cards left")
                ]),
              )
            ]),
            Expanded(
              child: WebViewWidget(controller: controller),
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
                    child: Container(
                        height: revisorButtonHeight,
                        color: Colors.blue,
                        alignment: Alignment.center,
                        child: Text("Very Easy"))),
              ],
            )
          ],
        ),
        drawer: const AppDrawer());
  }
}
