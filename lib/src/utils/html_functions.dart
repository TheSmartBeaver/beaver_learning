import 'package:beaver_learning/src/widgets/card/card_displayer/html_displayer.dart';
import 'package:beaver_learning/src/widgets/shared/app_bar.dart';
import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:flutter/material.dart';

void printHtmlCode(BuildContext context, String htmlCode) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (ctx) => Scaffold(
        appBar: CustomAppBar(
          title: "HTML Code Viewer",
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_circle_left_sharp),
              onPressed: () async {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SelectableText(htmlCode),
            ),
          ),
        ),
        drawer: const AppDrawer(),
        persistentFooterButtons: [],
      ),
    ),
  );
}

void printHtml(BuildContext context, String htmlCode) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (ctx) => Scaffold(
        appBar: CustomAppBar(
          title: "HTML Viewer",
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_circle_left_sharp),
              onPressed: () async {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
        body: HTMLDisplayer(htmlContentString: htmlCode, fileContents: []),
        drawer: const AppDrawer(),
        persistentFooterButtons: [],
      ),
    ),
  );
}

