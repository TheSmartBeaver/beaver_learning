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

Future importReal() async {
  var file_picker_result = await FilePicker.platform.pickFiles();
  if (file_picker_result != null) {
    for (var file in file_picker_result.files) {
      // Lire l'archive depuis le fichier
      final bytes = File(file.path!).readAsBytesSync();
      final archive = ZipDecoder().decodeBytes(bytes);

      Map<String, CardExport> cardExports = {};

      createCardIfNotExists(String name) {
        if (!cardExports.containsKey(name)) {
          cardExports[name] = CardExport(
              content: HTMLContentExport(recto: "", verso: "", files: []));
        }
      }

      var cardReg = RegExp(r"card_\d+.*");
      var htmlReg = RegExp(r".*html");

      // Parcourir récursivement les dossiers et fichiers
      for (final archEntity in archive) {
        List<String> paths = archEntity.name.split('/');
        if (archEntity.isFile) {
          print('Fichier : ${archEntity.name}');
          // Vous pouvez accéder au contenu du fichier avec file.content
          Uint8List bytes = archEntity.content as Uint8List;

          if (cardReg.hasMatch(paths[paths.length - 2])) {
            createCardIfNotExists(paths[paths.length - 2]);
            if (fileCanBeReadAsString(archEntity.name)) {
              if(htmlReg.hasMatch(paths[paths.length - 1]) && !paths[paths.length - 1].startsWith('.')){
                String stringContent = utf8.decode(bytes);
                if (paths[paths.length - 1] == "recto.html") {
                  cardExports[paths[paths.length - 2]]!.content.recto =
                      stringContent;
                } else if (paths[paths.length - 1] == "verso.html") {
                  cardExports[paths[paths.length - 2]]!.content.verso =
                      stringContent;
                }
              }
            } else if(paths[paths.length - 1].contains('.') && !paths[paths.length - 1].startsWith('.')) {
              cardExports[paths[paths.length - 2]]!.content.files.add(
                  FileContentExport(paths[paths.length - 1].split('.')[0],
                      paths[paths.length - 1].split('.')[1], bytes));

              var xdd = 0;
            }
          }
        } else {
          print('Dossier : ${archEntity.name}');
          // Pour parcourir récursivement, vous pouvez appeler readArchive sur les sous-dossiers
        }
      }
      var issou = 1;

      GroupExport groupExport = GroupExport("deck imported", [], cardExports.values.toList());
      await saveGroupExportInDb(groupExport);
      var issou2 = 1;
    }
  }
}

Future<void> saveGroupExportInDb(GroupExport groupExport) async {
  int groupId = await createGroupInDb(GroupCompanion.insert(title: groupExport.title, tags: ""));
  for(var card in groupExport.cards){
    CardCreatedReturns cardReturns = await createCardInDb(groupId, CardDisplayerType.html, HTMLContentsCompanion.insert(recto: card.content.recto, verso: card.content.verso));
    for(var file in card.content.files){
      await createFileContentInDb(cardReturns.contentId, FileContentsCompanion.insert(name: file.name, format: file.format, content: file.content));
    }
  }
}

bool fileCanBeReadAsString(String filePath) {
  if (filePath.contains(".json") ||
      filePath.contains(".html") ||
      filePath.contains(".css") ||
      filePath.contains(".js") ||
      filePath.contains(".txt") ||
      filePath.contains(".md") ||
      filePath.contains(".csv") ||
      filePath.contains(".xml")) {
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