import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:archive/archive_io.dart';
import 'package:beaver_learning/src/dao/html_dao.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/models/db/groupTable.dart';
import 'package:beaver_learning/src/models/enum/card_displayer_type.dart';
import 'package:beaver_learning/src/utils/cards_functions.dart';
import 'package:beaver_learning/src/utils/classes/export_classes.dart';
import 'package:beaver_learning/src/utils/classes/import_class_interfaces.dart';
import 'package:beaver_learning/src/utils/classes/import_classes.dart';
import 'package:beaver_learning/src/utils/classes/import_manager.dart';
import 'package:beaver_learning/src/utils/classes/import_utils_functions.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

Future exportReal(GroupExport group) async {
  // Créer un répertoire temporaire pour l'export
  Directory tempDir2 = await Directory.systemTemp.createTemp('export_package');
  Directory tempDir = Directory('${tempDir2.path}/export_package');
  tempDir.create(recursive: true);

  var groupDescFile = File('${tempDir.path}/desc.json');
  await groupDescFile.create(recursive: true);
  var groupDescFileJson = jsonEncode(
      ExportDescriptor(ExportType.group, name: group.title).toJson());
  groupDescFile.writeAsString(groupDescFileJson);

  var counter = 1;
  for (var card in group.cards) {
    var rectoFile = File('${tempDir.path}/card_$counter/recto.html');
    await rectoFile.create(recursive: true);
    rectoFile.writeAsString(card.content.recto);

    var versoFile = File('${tempDir.path}/card_$counter/verso.html');
    await versoFile.create(recursive: true);
    versoFile.writeAsString(card.content.verso);

    var cardDescFile = File('${tempDir.path}/card_$counter/desc.json');
    await cardDescFile.create(recursive: true);
    var cardDescFileJson =
        jsonEncode(ExportDescriptor(ExportType.card).toJson());
    cardDescFile.writeAsString(cardDescFileJson);

    for (var file in card.content.files) {
      var fileContent =
          File('${tempDir.path}/card_$counter/${file.name}.${file.format}');
      await fileContent.create(recursive: true);
      fileContent.writeAsBytes(file.content);
    }

    counter++;
  }

  // Zip a directory to out.zip using the zipDirectory convenience method
  var encoder = ZipFileEncoder();

  String? deckDestinationDirectory =
      await FilePicker.platform.getDirectoryPath();
  if (deckDestinationDirectory != null) {
    /*await*/ encoder.zipDirectory(tempDir,
        filename: '$deckDestinationDirectory/deck.zip');

    void listFilesAndFolders(Directory directory) {
      directory.list(recursive: true).listen((FileSystemEntity entity) {
        if (entity is File) {
          print('File: ${entity.path}');
          encoder.addFile(entity);
        } else if (entity is Directory) {
          print('Folder: ${entity.path}');
          encoder.addDirectory(entity);
        }
      });
    }

    //encoder.create('$deckDestinationDirectory/deck2.tar');
    // encoder.create('$deckDestinationDirectory/deck2.tar');
    // listFilesAndFolders(tempDir);
    //encoder.close();

    // encoder.create('$deckDestinationDirectory/deck2.tar');
    // encoder.addDirectory(tempDir);
    // encoder.addFile(File('test.zip'));
    // encoder.close();
  }
  cleanTempDirectory(tempDir.path);
  //final appDocDir = await getApplicationDocumentsDirectory();
}

Future deleteCardsFromGroupTest() async {
  var db = MyDatabaseInstance.getInstance();

  try {
    var test = await db.select(db.group).get();
    var ehoh = 9;
    // await (db.delete(db.reviseCards)
    //       ..where((tbl) => tbl.groupId.isIn([12, 13, 14])))
    //     .go();
    // await (db.delete(db.group)..where((tbl) => tbl.id.isIn([12, 13, 14]))).go();
  } catch (e) {
    var ahahha = 0;
  }
}

Future importReal(BuildContext context) async {
  // try {

  //await deleteCardsFromGroupTest();

  var file_picker_result = await FilePicker.platform.pickFiles();
  if (file_picker_result != null) {
    for (var file in file_picker_result.files) {
      // Lire l'archive depuis le fichier
      final pickedFileBytes = File(file.path!).readAsBytesSync();
      final archive = ZipDecoder().decodeBytes(pickedFileBytes);

      //Le filePicker a un bug de cache qui fait qu'on ne prend pas le fichier le plus récent
      final cacheDirectory =
          Directory(file.path!.substring(0, file.path!.lastIndexOf('/')));

      if (await cacheDirectory.exists()) {
        await cacheDirectory.delete(recursive: true);
      }

      ImportInterface import = ImportManager();

      // Parcourir récursivement les dossiers et fichiers
      for (final archEntity in archive) {
        import.fillEntityNatures(archEntity);
      }
      var issou = 1;

      import.fillAllGroupExports();
      import.fillAllHtmlTemplatesExports();
      import.fillAllCardExports();
      import.fillAllCardRegularExportsRecto();
      import.fillAllCardRegularExportsVerso();
      import.fillAllJsonCardExportsTemplated();
      import.fillAllCardExportsFiles();
      import.linkAllCardExportsToGroupExports();      
      import.fillAllTopicExports();
      import.linkAllGroupExportsToTopicExports();
      import.linkAllSupportsToTopicExports();
      import.linkAllTopicExportsToParentTopicExports();
      import.linkAllGroupExportsToParentGroupExports();

      await import.createHtmlTemplatesInDb();
      await import.createGroupsInDB();
      int courseId = await import.createCourseInDB();
      await import.createTopicsInDB(courseId);

      var issou2 = 1;
    }
  }
  // } catch (e) {
  //   showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //             title: const Text("Whooops !"),
  //             content: Text(e.toString()),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: const Text('Okay'),
  //               ),
  //             ],
  //           ));
  // }
}


Future<GroupExport> recursiveGroupDiscovery(GroupData deck) async {
  var db = MyDatabaseInstance.getInstance();
  List<GroupData> childrenGroups = await (db.select(db.group)
        ..where((tbl) => tbl.parentId.equals(deck.id)))
      .get();
  List<GroupExport> childGroups = [];
  for (var childGroup in childrenGroups) {
    childGroups.add(await recursiveGroupDiscovery(childGroup));
  }
  List<ReviseCard> cards = await (db.select(db.reviseCards)
        ..where((tbl) => tbl.groupId.equals(deck.id)))
      .get();
  List<CardExport> cardExports = [];

  for (ReviseCard card in cards) {
    // HTMLContent htmlContent = await (db.select(db.hTMLContents)
    //                           ..where((tbl) => tbl.id.equals(card.htmlContent))).getSingle();

    final htmlDao = HtmlDao(MyDatabaseInstance.getInstance());
    var content = await htmlDao.getHtmlContents(card.htmlContent);

    CardExport cardExport = CardExport(
        path: card.path,
        content: HTMLContentExport(
            recto: content.recto,
            verso: content.verso,
            files: content.files
                .map((e) => FileContentExport(
                    e.name, e.format, e.file.readAsBytesSync()))
                .toList()));
    cardExports.add(cardExport);
  }

  return GroupExport(deck.title, childGroups, cardExports);
}

void cleanTempDirectory(String path) async {
  final dir = Directory(path);

  if (await dir.exists()) {
    await dir.delete(recursive: true);
    print('Dossier temporaire nettoyé : $path');
  } else {
    print('Le dossier temporaire n\'existe pas : $path');
  }
}
