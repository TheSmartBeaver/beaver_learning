import 'package:beaver_learning/src/dao/html_dao.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/utils/classes/helper_classes.dart';
import 'package:beaver_learning/src/utils/images_functions.dart';
import 'package:beaver_learning/src/utils/template_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:translator/translator.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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
}

void _buildInAppController(InAppWebViewController webViewController) {
  webViewController.setOptions(
      options: InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      javaScriptEnabled: true,
      clearCache: true,
      useShouldOverrideUrlLoading: true,
      useOnLoadResource: true,
      useOnDownloadStart: true,
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  ));

  webViewController.addJavaScriptHandler(
    handlerName: 'ttsHandler',
    callback: (args) async {
      // Utile pour plus tard dès que je voudrais mettre à jour des cartes pour les traduires automatiquement !
      // final translator = GoogleTranslator();
      // translator.translate(args[0], from: 'fr', to: 'en').then(print);

      String targetLanguage = args[0];
      String textToSpeak = args[1];

      FlutterTts flutterTts = FlutterTts();
      await flutterTts.awaitSpeakCompletion(true);
      await flutterTts.awaitSynthCompletion(true);

      List<dynamic> languages = await flutterTts.getLanguages;
      await flutterTts.setLanguage(targetLanguage);
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.setVolume(1.0);
      await flutterTts.setPitch(1.0);
      //var isLanguageAvailable = await flutterTts.isLanguageAvailable("en-US");

      var aahahah = await flutterTts.speak(textToSpeak);
      var toto = 0;
    },
  );
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
  //WebViewController controller = _buildController();
  late InAppWebViewController webViewController;
  late String recto;
  late String verso;
  late String initialUrl;
  void refresh() {
    setState(() {});
  }

  Future<void> init() async {
    try {
      final htmlDao = HtmlDao(MyDatabaseInstance.getInstance());
      var content = await htmlDao.getHtmlContents(widget.htmlContentId);
      recto = content.recto;
      verso = content.verso;
      String target_file = "index${content.id}.html";

      var localServerUrl = await MyLocalServer.getLocalServerUrl();
      await deleteFiles(await getTemporaryDirectory());
      var customHtmlString = getCustomHtml(recto, verso, widget.isPrintAnswer);
      await writeHtmlToServerDirectory(
          customHtmlString, target_file, content.files);
      var files = await listFiles(await getTemporaryDirectory());
      //await controller.clearCache();
      //await controller.clearLocalStorage();
      //await controller.loadRequest(Uri.parse('$localServerUrl/$target_file'));
      //webViewController.clearCache();
      initialUrl = '$localServerUrl/$target_file';
      var test2 = await (await getTemporaryDirectory()).list().toList();
    } catch (e) {
      print(e);
      DialogStatic.showInfoInDialog(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: FutureBuilder(
              future: init(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  return InAppWebView(
                    initialUrlRequest: URLRequest(url: Uri.parse(initialUrl)),
                    onWebViewCreated: (controller) {
                      _buildInAppController(controller);
                      webViewController = controller;
                    },
                    onLoadStart: (controller, url) {
                      print("Started loading: $url");
                    },
                    onLoadStop: (controller, url) async {
                      print("Finished loading: $url");
                    },
                    onProgressChanged: (controller, progress) {
                      // Update loading bar.
                    },
                    onConsoleMessage: (controller, consoleMessage) {
                      print("Console message: ${consoleMessage.message}");
                    },
                    onLoadError: (controller, url, code, message) {
                      print(
                          "Error loading: $url, code: $code, message: $message");
                    },
                    shouldOverrideUrlLoading:
                        (controller, navigationAction) async {
                      var uri = navigationAction.request.url!;
                      if (uri.toString().startsWith('http://localhost')) {
                        return NavigationActionPolicy.ALLOW;
                      }
                      return NavigationActionPolicy.CANCEL;
                    },
                  );
                }
              }))
    ]);
  }
}
