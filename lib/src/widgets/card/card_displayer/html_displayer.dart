import 'dart:io';

import 'package:beaver_learning/src/dao/html_dao.dart';
import 'package:beaver_learning/src/dao/image_dao.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/utils/images_functions.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

WebViewController _buildController() {
  return WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..addJavaScriptChannel(
                  'ConsoleLog',
                  onMessageReceived: (JavaScriptMessage message) {
                    print(message.message);
                  },
                )
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

class HTMLDisplayer extends StatefulWidget {
  _HTMLDisplayerState hTMLCardDisplayerState= _HTMLDisplayerState();
  String htmlContentString;
  List<FileContent> fileContents;

  HTMLDisplayer({super.key, required this.htmlContentString, required this.fileContents});

  @override
  State<HTMLDisplayer> createState(){ 
    return hTMLCardDisplayerState;
  }
}

class _HTMLDisplayerState extends State<HTMLDisplayer> {
  WebViewController controller = _buildController();
  
  Future<void> init() async {
    final htmlDao = HtmlDao(MyDatabaseInstance.getInstance());

    var localServerUrl = await MyLocalServer.getLocalServerUrl();
    await controller.clearLocalStorage();
    await controller.clearCache();
    await deleteFiles(await getTemporaryDirectory());
    await writeHtmlToServerDirectory(widget.htmlContentString,"index.html", widget.fileContents);
    //var files = await listFiles(await getTemporaryDirectory());
    // await deleteFiles(await getTemporaryDirectory());
    // var files2 = await listFiles(await getTemporaryDirectory());
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