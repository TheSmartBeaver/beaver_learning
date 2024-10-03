import 'dart:io';

import 'package:beaver_learning/src/dao/html_dao.dart';
import 'package:beaver_learning/src/dao/image_dao.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/utils/images_functions.dart';
import 'package:beaver_learning/src/utils/template_functions.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

WebViewController _buildController() {
  return WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    //..clearCache()
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

class HTMLCardDisplayer extends StatefulWidget {
  final bool isPrintAnswer;
  final int htmlContentId;
  _HTMLCardDisplayerState hTMLCardDisplayerState = _HTMLCardDisplayerState();

  HTMLCardDisplayer(
      {super.key, required this.isPrintAnswer, required this.htmlContentId});

  void refresh() {
    hTMLCardDisplayerState.refresh();
  }

  @override
  State<HTMLCardDisplayer> createState() {
    return hTMLCardDisplayerState;
  }
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

  void refresh() {
    setState(() {
      // Besoin de rien juste d'un nouveau get en BDD du recto et verso
    });
  }

  Future<void> init() async {
    final htmlDao = HtmlDao(MyDatabaseInstance.getInstance());
    var content = await htmlDao.getHtmlContents(widget.htmlContentId);
    recto = content.recto;
    verso = content.verso;

    var localServerUrl = await MyLocalServer.getLocalServerUrl();
    var customHtmlString = getCustomHtml(recto, verso, widget.isPrintAnswer);
    await writeHtmlToServerDirectory(
        customHtmlString, "index.html", content.files);
    //await controller.clearCache();
    await controller.clearLocalStorage();
    await controller.loadRequest(Uri.parse('$localServerUrl/index.html'));
    var test2 = await (await getTemporaryDirectory()).list().toList();
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
