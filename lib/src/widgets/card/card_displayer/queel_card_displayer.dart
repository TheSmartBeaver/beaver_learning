import 'dart:io';

import 'package:beaver_learning/src/dao/html_dao.dart';
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
    var db = MyDatabaseInstance.getInstance();
    final htmlDao = HtmlDao(MyDatabaseInstance.getInstance());
    var content = await htmlDao.getHtmlContents(widget.cardToRevise.htmlContent);
    recto = content.recto;
    verso = content.verso;

    var localServerUrl = await MyLocalServer.getLocalServerUrl();
  }

  @override
  Widget build(BuildContext context) {

    var content = '${widget.cardToRevise.htmlContent}\n${widget.cardToRevise.htmlContent} ';

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
