import 'package:beaver_learning/src/widgets/shared/app_bar.dart';
import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/form-tools/my_queel_toolbar.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/form-tools/settings/embeds/timestamp_embed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill_extensions/embeds/widgets/image.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImageProvider;

import 'dart:io' as io show Directory, File;

import 'package:flutter/material.dart';
//import 'package:desktop_drop/desktop_drop.dart' show DropTarget;
import 'package:flutter_quill/extensions.dart' show isAndroid, isIOS, isWeb;
import 'package:flutter_quill/flutter_quill.dart';
import 'package:path/path.dart' as path;
import 'package:quill_html_converter/quill_html_converter.dart';

class MyQueelEditor extends ConsumerStatefulWidget {
  static const routeName = "/queel-editor";
  final bool isEditionMode;
  final String content;

  MyQueelEditor(this.content, {super.key, required this.isEditionMode});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _QueelEditorState();
  }
}

class _QueelEditorState extends ConsumerState<MyQueelEditor> {
  final _controller = QuillController.basic();
  final _editorScrollController = ScrollController();
  final _editorFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {

    //_controller.document.insert(0, widget.content);
    if(widget.content.isNotEmpty){
      _controller.document = Document.fromDelta(Document.fromHtml(widget.content));
    }
  
    return Scaffold(
        appBar: CustomAppBar(
          title: "widget.title",
          actions: [
            MenuAnchor(
            builder: (context, controller, child) {
              return IconButton(
                onPressed: () {
                  if (controller.isOpen) {
                    controller.close();
                    return;
                  }
                  controller.open();
                },
                icon: const Icon(
                  Icons.more_vert,
                ),
              );
            },
            menuChildren: [
              MenuItemButton(
                onPressed: () {
                  final html = _controller.document.toDelta().toHtml();
                  Navigator.of(context).pop(html);
                  //_controller.document = Document.fromDelta(Document.fromHtml(html));
                },
                child: const Text('Load with HTML'),
              ),
              // MenuItemButton(
              //   onPressed: () async {
              //     final pdfDocument = pw.Document();
              //     final pdfWidgets =
              //         await _controller.document.toDelta().toPdf();
              //     pdfDocument.addPage(
              //       pw.MultiPage(
              //         maxPages: 200,
              //         pageFormat: PdfPageFormat.a4,
              //         build: (context) {
              //           return pdfWidgets;
              //         },
              //       ),
              //     );
              //     await Printing.layoutPdf(
              //         onLayout: (format) async => pdfDocument.save());
              //   },
              //   child: const Text('Print as PDF'),
              // ),
            ],
          ),
          IconButton(
            tooltip: 'Share',
            onPressed: () {
              // final plainText = _controller.document.toPlainText(
              //   FlutterQuillEmbeds.defaultEditorBuilders(),
              // );
              // if (plainText.trim().isEmpty) {
              //   ScaffoldMessenger.of(context).showText(
              //     "We can't share empty document, please enter some text first",
              //   );
              //   return;
              // }
              // Share.share(plainText);
            },
            icon: const Icon(Icons.share),
          ),
          IconButton(
            tooltip: 'Print to log',
            onPressed: () {
              // print(
              //   jsonEncode(_controller.document.toDelta().toJson()),
              // );
              // ScaffoldMessenger.of(context).showText(
              //   'The quill delta json has been printed to the log.',
              // );
            },
            icon: const Icon(Icons.print),
          ),
          //const HomeScreenButton(),
          ],
        ),
        body: Column(children: [
          if(widget.isEditionMode) MyQuillToolbar(controller: _controller, focusNode: _editorFocusNode),
          Expanded(
              child:
          MyQuillEditor(
              configurations: QuillEditorConfigurations(
                sharedConfigurations: _sharedConfigurations,
                controller: _controller,
                readOnly: !widget.isEditionMode,
                showCursor: widget.isEditionMode,
                autoFocus: widget.isEditionMode,
              ),
              scrollController: _editorScrollController,
              focusNode: _editorFocusNode))
        ]),
        //drawer: const AppDrawer()
        );
  }
}

class MyQuillEditor extends StatelessWidget {
  const MyQuillEditor({
    required this.configurations,
    required this.scrollController,
    required this.focusNode,
    super.key,
  });

  final QuillEditorConfigurations configurations;
  final ScrollController scrollController;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return QuillEditor(
      scrollController: scrollController,
      focusNode: focusNode,
      configurations: configurations.copyWith(
        elementOptions: const QuillEditorElementOptions(
          codeBlock: QuillEditorCodeBlockElementOptions(
            enableLineNumbers: true,
          ),
          orderedList: QuillEditorOrderedListElementOptions(),
          unorderedList: QuillEditorUnOrderedListElementOptions(
            useTextColorForDot: true,
          ),
        ),
        customStyles: const DefaultStyles(
          h1: DefaultTextBlockStyle(
            TextStyle(
              fontSize: 32,
              height: 1.15,
              fontWeight: FontWeight.w300,
            ),
            VerticalSpacing(16, 0),
            VerticalSpacing(0, 0),
            null,
          ),
          sizeSmall: TextStyle(fontSize: 9),
          subscript: TextStyle(
            fontFamily: 'SF-UI-Display',
            fontFeatures: [FontFeature.subscripts()],
          ),
          superscript: TextStyle(
            fontFamily: 'SF-UI-Display',
            fontFeatures: [FontFeature.superscripts()],
          ),
        ),
        scrollable: true,
        placeholder: 'Start writtingggg your notes...',
        padding: const EdgeInsets.all(16),
        onImagePaste: (imageBytes) async {
          if (isWeb()) {
            return null;
          }
          // We will save it to system temporary files
          final newFileName = '${DateTime.now().toIso8601String()}.png';
          final newPath = path.join(
            io.Directory.systemTemp.path,
            newFileName,
          );
          final file = await io.File(
            newPath,
          ).writeAsBytes(imageBytes, flush: true);
          return file.path;
        },
        embedBuilders: [
          ...(isWeb()
              ? FlutterQuillEmbeds.editorWebBuilders()
              : FlutterQuillEmbeds.editorBuilders(
                  imageEmbedConfigurations: QuillEditorImageEmbedConfigurations(
                    imageErrorWidgetBuilder: (context, error, stackTrace) {
                      return Text(
                        'Error while loading an image: ${error.toString()}',
                      );
                    },
                    imageProviderBuilder: (context, imageUrl) {
                      // cached_network_image is supported
                      // only for Android, iOS and web

                      // We will use it only if image from network
                      if (isAndroid(supportWeb: false) ||
                          isIOS(supportWeb: false) ||
                          isWeb()) {
                        if (isHttpBasedUrl(imageUrl)) {
                          return CachedNetworkImageProvider(
                            imageUrl,
                          );
                        }
                      }
                      return getImageProviderByImageSource(
                        imageUrl,
                        imageProviderBuilder: null,
                        context: context,
                        assetsPrefix: QuillSharedExtensionsConfigurations.get(
                                context: context)
                            .assetsPrefix,
                      );
                    },
                  ),
                )),
          TimeStampEmbedBuilderWidget(),
        ],
        builder: (context, rawEditor) {
          // The `desktop_drop` plugin doesn't support iOS platform for now
          if (isIOS(supportWeb: false)) {
            return rawEditor;
          }
          return rawEditor;
          // return DropTarget(
          //   onDragDone: (details) {
          //     final scaffoldMessenger = ScaffoldMessenger.of(context);
          //     final file = details.files.first;
          //     final isSupported = imageFileExtensions.any(file.name.endsWith);
          //     if (!isSupported) {
          //       scaffoldMessenger.showText(
          //         'Only images are supported right now: ${file.mimeType}, ${file.name}, ${file.path}, $imageFileExtensions',
          //       );
          //       return;
          //     }
          //     context.requireQuillController.insertImageBlock(
          //       imageSource: file.path,
          //     );
          //     scaffoldMessenger.showText('Image is inserted.');
          //   },
          //   child: rawEditor,
          // );
        },
      ),
    );
  }
}

QuillSharedConfigurations get _sharedConfigurations {
  return const QuillSharedConfigurations(
      // locale: Locale('en'),
      );
}
