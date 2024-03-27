import 'dart:io';

import 'package:beaver_learning/src/dao/html_dao.dart';
import 'package:beaver_learning/src/dao/image_dao.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/utils/images_functions.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

void test() {
  final imageDao = ImageDao(MyDatabaseInstance.getInstance());
  // final imagePath = await imageDao.getImagePathForCard(cardId);

  // final imageFile = File(imagePath);
  // final imageWidget = Image.file(imageFile);
}

WebViewController _buildController() {
  return WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..clearCache()
    ..clearLocalStorage()
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('http://localhost')) {
            return NavigationDecision.navigate;
          }
          return NavigationDecision.prevent;
        },
      ),
    );
  //..loadRequest(Uri.parse('https://flutter.dev'));
  //..loadHtmlString(customHtml);
}

String _getCustomHtml(String recto, String verso, bool isPrintAnswer) {
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
            display: flex;
            justify-content: center; /* Centre le contenu horizontalement */
            align-items: center; /* Centre le contenu verticalement */
            flex-direction: column; /* Organise les éléments de haut en bas */
            padding: 10px; /* Ajoute une padding de 6 pixels */
          }

          .verso {
            display: flex;
            flex-grow: 1; /* Permet à la partie "recto" de s'étendre pour remplir l'espace restant */
            justify-content: center; /* Centre le contenu horizontalement */
            align-items: center; /* Centre le contenu verticalement */
            flex-direction: column; /* Organise les éléments de haut en bas */
            padding: 10px; /* Ajoute une padding de 6 pixels */
          }

          .texte {
            font-size: 34px; /* Augmente la taille de la police à 24 pixels */
          }

          .separateur {
            width: 100%;
            height: 2px;
            background-color: black;
            margin: 10px 0;
          }
        </style>
      </head>
      <body>
        <div class='recto texte'>$recto</div>
        <div class='separateur'></div>
        ${isPrintAnswer ? "<div class='verso texte'>$verso</div>" : ""}
        <script>
          function sayHello() {
            alert('Hello from JavaScript!');
          }
        </script>
      </body>
      </html>
    ''';
}

class HTMLCardDisplayer extends StatefulWidget {
  final bool isPrintAnswer;
  final ReviseCard cardToRevise;

  const HTMLCardDisplayer({super.key, required this.isPrintAnswer, required this.cardToRevise});

  @override
  State<HTMLCardDisplayer> createState() => _HTMLCardDisplayerState();
}

class _HTMLCardDisplayerState extends State<HTMLCardDisplayer> {
  WebViewController controller = _buildController();
  late String recto;
  late String verso;
  // https://img-4.linternaute.com/s-R4pIq7BydGotKb7_D83E_ViXM=/1500x/smart/fde5024007754647b344329e6a8ca64b/ccmcms-linternaute/33631821.jpg
  // var recto =
  //       "<ul><li>Hello, World!</li><li>Pourquoi les vampires ne peuvent-ils pas être de bons photographes</li></ul>";
  //   var verso =
  //       "<ul><li>Salut, le monde !</li><li>Parce qu'ils ont peur d'être \"développés\" par le soleil !</li><li><img width='600' height='400' src=\"batman2.png\" /></li></ul>";
  

  
  Future<void> init() async {
    final htmlDao = HtmlDao(MyDatabaseInstance.getInstance());
    var content = await htmlDao.getHtmlContents(widget.cardToRevise.htmlContent);
    recto = content.recto;
    verso = content.verso;

    var localServerUrl = await MyLocalServer.getLocalServerUrl();
    await writeHtmlToServerDirectory(_getCustomHtml(recto, verso, widget.isPrintAnswer),"index.html");
    await controller.clearCache();
    await controller.clearLocalStorage();
    await controller.loadRequest(Uri.parse('$localServerUrl/index.html'));
    var test2 = await(await getTemporaryDirectory()).list().toList();
    //await controller.loadHtmlString(_getCustomHtml(recto, verso, widget.isPrintAnswer));
    //serverProps.server.close(force: true);
  }

  @override
  Widget build(BuildContext context) {

    // controller
    //     .loadHtmlString(_getCustomHtml(recto, verso, widget.isPrintAnswer));

    return FutureBuilder(
      future: init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          return WebViewWidget(controller: controller);
        }
      });
  }
}