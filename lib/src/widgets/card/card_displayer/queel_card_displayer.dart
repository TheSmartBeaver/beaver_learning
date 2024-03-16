import 'dart:io';

import 'package:beaver_learning/src/dao/image_dao.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/utils/images_functions.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/form-tools/queel_editor.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class QueelCardDisplayer extends StatefulWidget {
  final bool isPrintAnswer;
  final ReviseCard cardToRevise;

  const QueelCardDisplayer({super.key, required this.isPrintAnswer, required this.cardToRevise});

  @override
  State<QueelCardDisplayer> createState() => _QueelCardDisplayerState();
}

class _QueelCardDisplayerState extends State<QueelCardDisplayer> {
  late String recto;
  late String verso;

  Future<void> init() async {
    recto = widget.cardToRevise.recto;
    verso = widget.cardToRevise.verso;

    var localServerUrl = await MyLocalServer.getLocalServerUrl();
    // await writeHtmlToServerDirectory(_getCustomHtml(recto, verso, widget.isPrintAnswer),"index.html");
    // await controller.loadRequest(Uri.parse('$localServerUrl/index.html'));
    //serverProps.server.close(force: true);
  }

  @override
  Widget build(BuildContext context) {

    // controller
    //     .loadHtmlString(_getCustomHtml(recto, verso, widget.isPrintAnswer));

    var content = '${widget.cardToRevise.recto}\n${widget.cardToRevise.verso} ';

    return FutureBuilder(
      future: init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          return MyQueelEditor(content, isEditionMode: false);
        }
      });
  }
}
