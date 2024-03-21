import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:archive/archive_io.dart';
import 'package:beaver_learning/src/dao/html_dao.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/models/db/groupTable.dart';
import 'package:beaver_learning/src/models/enum/card_displayer_type.dart';
import 'package:beaver_learning/src/utils/cards_functions.dart';
import 'package:beaver_learning/src/utils/classes/export_classes.dart';
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

class EntityNature {
  final ExportType type;
  final String path;
  Uint8List? bytes;

  String get name => path.split('/').last;

  EntityNature(this.path, this.type, {this.bytes});
}

String extractParentFolder(String fullPath) {
  List<String> paths = fullPath.split('/');
  return fullPath.substring(
                        0,
                        fullPath.length - paths[paths.length - 1].length - 1);
}

Future importReal(BuildContext context) async {
  try {
    var file_picker_result = await FilePicker.platform.pickFiles();
    if (file_picker_result != null) {
      for (var file in file_picker_result.files) {
        // Lire l'archive depuis le fichier
        final bytes = File(file.path!).readAsBytesSync();
        final archive = ZipDecoder().decodeBytes(bytes);

        Map<String, CardExport> cardExports = {};
        Map<String, GroupExport> groupExports = {};
        Map<String, EntityNature> entityNatures = {};

        createCardIfNotExists(String name) {
          if (!cardExports.containsKey(name)) {
            cardExports[name] = CardExport(
                content: HTMLContentExport(recto: "", verso: "", files: []));
          }
        }

        var cardReg = RegExp(r"card_\d+.*");
        var htmlReg = RegExp(r".*html");
        var deckName = "deck imported";

        // Parcourir récursivement les dossiers et fichiers
        for (final archEntity in archive) {
          List<String> paths = archEntity.name.split('/');

          if (archEntity.isFile) {
            print('Fichier : ${archEntity.name}');
            // Vous pouvez accéder au contenu du fichier avec file.content
            Uint8List bytes = archEntity.content as Uint8List;

            if (fileCanBeReadAsString(archEntity.name)) {
              String stringContent = utf8.decode(bytes);
              if (cardReg.hasMatch(paths[paths.length - 2])) {
                //createCardIfNotExists(paths[paths.length - 2]);
                if (htmlReg.hasMatch(paths[paths.length - 1]) &&
                    !paths[paths.length - 1].startsWith('.')) {
                  if (paths[paths.length - 1] == "recto.html") {
                    // cardExports[paths[paths.length - 2]]!.content.recto =
                    //     stringContent;
                    var cardName = extractParentFolder(archEntity.name);
                    entityNatures[cardName] = EntityNature(
                        cardName, ExportType.card,
                        bytes: bytes);
                    entityNatures[archEntity.name] = EntityNature(
                        archEntity.name, ExportType.rectoHtml,
                        bytes: bytes);
                  } else if (paths[paths.length - 1] == "verso.html") {
                    // cardExports[paths[paths.length - 2]]!.content.verso =
                    //     stringContent;
                    var cardName = extractParentFolder(archEntity.name);
                    entityNatures[cardName] = EntityNature(
                        cardName, ExportType.card,
                        bytes: bytes);
                    entityNatures[archEntity.name] = EntityNature(
                        archEntity.name, ExportType.versoHtml,
                        bytes: bytes);
                  }
                }
              } else if (paths[paths.length - 1] == "group_desc.json") {
                var groupDescriptor =
                    ExportDescriptor.fromJson(jsonDecode(stringContent));
                var groupName = extractParentFolder(archEntity.name);
                entityNatures[groupName] =
                    EntityNature(groupName, groupDescriptor.type, bytes: bytes);
                // if(groupDescriptor.type == ExportType.group && groupDescriptor.name != null){
                //   deckName = groupDescriptor.name!;
                // }
              }
            } else if (paths[paths.length - 1].contains('.') &&
                !paths[paths.length - 1].startsWith('.')) {
              entityNatures[archEntity.name] = EntityNature(
                  archEntity.name, ExportType.fileContent,
                  bytes: bytes);

              // cardExports[paths[paths.length - 2]]!.content.files.add(
              //     FileContentExport(paths[paths.length - 1].split('.')[0],
              //         paths[paths.length - 1].split('.')[1], bytes));

              var xdd = 0;
            }
          } else {
            print('Dossier : ${archEntity.name}');
            // Pour parcourir récursivement, vous pouvez appeler readArchive sur les sous-dossiers
          }
        }
        var issou = 1;

        // On crée tous les groupes
        for (var group in entityNatures.entries
            .where((element) => element.value.type == ExportType.group)) {
          var groupDesc = utf8.decode(group.value.bytes!);
          var groupDescriptor =
              ExportDescriptor.fromJson(jsonDecode(groupDesc));
          var groupExport = GroupExport(groupDescriptor.name!, [], []);
          groupExports[group.key] = groupExport;
        }

        // On crée les cartes
        for (var card in entityNatures.entries
            .where((element) => element.value.type == ExportType.card)) {
          createCardIfNotExists(card.key);
          // cardExports[card.key]!.content.recto = utf8.decode(File('${card.key}/recto.html').readAsBytesSync());
          // cardExports[card.key]!.content.recto = utf8.decode(File('${card.key}/verso.html').readAsBytesSync());
        }

        // On crée les rectos
        for (var rectoHtml in entityNatures.entries
            .where((element) => element.value.type == ExportType.rectoHtml)) {
          cardExports[extractParentFolder(rectoHtml.key)]!
              .content
              .recto = utf8.decode(rectoHtml.value.bytes!);
        }

        // On crée les versos
        for (var versoHtml in entityNatures.entries
            .where((element) => element.value.type == ExportType.versoHtml)) {
          List<String> paths = versoHtml.key.split('/');
          cardExports[extractParentFolder(versoHtml.key)]!
              .content
              .verso = utf8.decode(versoHtml.value.bytes!);
        }

        // On ajoute les fichiers aux cartes
        for (var file in entityNatures.entries
            .where((element) => element.value.type == ExportType.fileContent)) {
          List<String> paths = file.key.split('/');
          String cardKey = extractParentFolder(file.key);
          if (paths.length >= 2 && cardExports.containsKey(cardKey)) {
            cardExports[cardKey]!.content.files.add(FileContentExport(
                paths[paths.length - 1].split('.')[0],
                paths[paths.length - 1].split('.')[1],
                bytes));
          }
        }

        //On ajoute les cartes aux groupes
        for (var card in cardExports.entries) {
          List<String> paths = card.key.split('/');
          for (int index = paths.length - 2; index >= 0; index--) {
            var groupEntityNature = entityNatures.values
                .where((element) =>
                    element.name == paths[index] &&
                    element.type == ExportType.group)
                .firstOrNull;
            if (groupEntityNature != null) {
              groupExports[groupEntityNature.path]!.cards.add(card.value);
              break;
            }
          }
        }

        //On mets les groupes dans leurs groupe parent
        for (var group in entityNatures.entries
            .where((element) => element.value.type == ExportType.group)) {
          List<String> paths = group.key.split('/');
          for (int index = paths.length - 2; index >= 0; index--) {
            var groupEntityNature = entityNatures.values
                .where((element) =>
                    element.name == paths[index] &&
                    element.type == ExportType.group)
                .firstOrNull;
            if (groupEntityNature != null) {
              groupExports[groupEntityNature.path]!
                  .childGroups
                  .add(groupExports[group.key]!);
              groupExports.remove(group.key);
              break;
            }
          }
        }

        //GroupExport groupExport = GroupExport(deckName, [], cardExports.values.toList());
        for(var group in groupExports.entries){
          var groupExport = group.value;
          await saveGroupExportInDb(groupExport);
        }

        var issou2 = 1;

        //Le filePicker a un bug de cache qui fait qu'on ne prend pas le fichier le plus récent
        final cacheDirectory =
            Directory(file.path!.substring(0, file.path!.lastIndexOf('/')));

        if (await cacheDirectory.exists()) {
          await cacheDirectory.delete(recursive: true);
        }
      }
    }
  } catch (e) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Whooops !"),
              content: Text(e.toString()),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Okay'),
                ),
              ],
            ));
  }
}

Future<void> saveGroupExportInDb(GroupExport groupExport, {int? parentId}) async {
  int groupId = await createGroupInDb(
      GroupCompanion.insert(title: groupExport.title, tags: "", parentId: Value(parentId)));
  for (var card in groupExport.cards) {
    CardCreatedReturns cardReturns = await createCardInDb(
        groupId,
        CardDisplayerType.html,
        HTMLContentsCompanion.insert(
            recto: card.content.recto, verso: card.content.verso));
    for (var file in card.content.files) {
      await createFileContentInDb(
          cardReturns.contentId,
          FileContentsCompanion.insert(
              name: file.name, format: file.format, content: file.content));
    }
  }
  for (var childGroup in groupExport.childGroups) {
    await saveGroupExportInDb(childGroup, parentId: groupId);
  }
}

bool fileCanBeReadAsString(String filePath) {
  List<String> paths = filePath.split('/');
  if ((filePath.contains(".json") ||
          filePath.contains(".html") ||
          filePath.contains(".css") ||
          filePath.contains(".js") ||
          filePath.contains(".txt") ||
          filePath.contains(".md") ||
          filePath.contains(".csv") ||
          filePath.contains(".xml")) &&
      paths[paths.length - 1].contains('.') &&
      !paths[paths.length - 1].startsWith('.')) {
    return true;
  }
  return false;
}

Future export(GroupExport group) async {
  // Créer un répertoire temporaire pour l'export
  Directory tempDir = await Directory.systemTemp.createTemp('export_package');

  // Créer les dossiers pour les médias
  Directory imagesDir =
      await Directory(path.join(tempDir.path, 'images')).create();
  Directory audioDir =
      await Directory(path.join(tempDir.path, 'audio')).create();
  Directory videoDir =
      await Directory(path.join(tempDir.path, 'video')).create();

  // Copier les médias dans les dossiers appropriés
  // Vous devrez adapter cela en fonction de votre modèle de données
  // et de la manière dont vous stockez les chemins vers les médias.

  var cards = [];

  for (var card in cards) {
    // Copier les images, audio, vidéo vers les dossiers correspondants
  }

  // Créer des fichiers JSON pour les paquets, sous-paquets, cartes, etc.
  // Ces fichiers JSON devront contenir les métadonnées nécessaires.

  // Créer l'archive ZIP
  String zipFilePath = '${tempDir.path}/deck.zip';
  Archive archive = Archive();

  // Ajouter les fichiers JSON à l'archive
  // Ajouter les dossiers de médias à l'archive
  // Vous devrez adapter cela en fonction de votre structure de données.
  // Assurez-vous d'ajouter tous les fichiers et dossiers nécessaires.

  Directory sourceDirectory = Directory("sourceDir");
  List<FileSystemEntity> entities = sourceDirectory.listSync();

  List<int> fileContent = File("aPath").readAsBytesSync();
  ArchiveFile archiveFile =
      ArchiveFile("entityPath", fileContent.length, fileContent);
  archive.addFile(archiveFile);

  final tarData = TarEncoder().encode(archive);
  final tarBz2 = BZip2Encoder().encode(tarData);

  final fp = File(zipFilePath);
  fp.writeAsBytesSync(tarBz2);

  // Zip a directory to out.zip using the zipDirectory convenience method
  var encoder = ZipFileEncoder();
  await encoder.zipDirectoryAsync(Directory('out'), filename: 'out.zip');

  // Manually create a zip of a directory and individual files.
  encoder.create('out2.zip');
  encoder.addDirectory(Directory('out'));
  encoder.addFile(File('test.zip'));
  encoder.close();

  // Nettoyer les fichiers temporaires
  await tempDir.delete(recursive: true);

  print('Package exported successfully to: $zipFilePath');
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

  for (var card in cards) {
    // HTMLContent htmlContent = await (db.select(db.hTMLContents)
    //                           ..where((tbl) => tbl.id.equals(card.htmlContent))).getSingle();

    final htmlDao = HtmlDao(MyDatabaseInstance.getInstance());
    var content = await htmlDao.getHtmlContents(card.htmlContent);

    CardExport cardExport = CardExport(
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
