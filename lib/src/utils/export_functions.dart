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
      0, fullPath.length - paths[paths.length - 1].length - 1);
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

      Map<String, CardExport> cardExports = {};
      Map<String, GroupExport> groupExports = {};
      Map<String, EntityNature> entityNatures = {};
      Map<String, TopicExport> topicExports = {};

      createCardIfNotExists(String name) {
        if (!cardExports.containsKey(name)) {
          cardExports[name] = CardExport(
              path: name,
              content: HTMLContentExport(recto: "", verso: "", files: []));
        }
      }

      var cardReg = RegExp(r"card_\d+.*");
      var htmlReg = RegExp(r".*html");
      var supportReg = RegExp(r"support.*");

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
              if (htmlReg.hasMatch(paths[paths.length - 1]) &&
                  !paths[paths.length - 1].startsWith('.')) {
                if (paths[paths.length - 1] == "recto.html") {
                  var cardName = extractParentFolder(archEntity.name);
                  entityNatures[cardName] =
                      EntityNature(cardName, ExportType.card, bytes: bytes);
                  entityNatures[archEntity.name] = EntityNature(
                      archEntity.name, ExportType.rectoHtml,
                      bytes: bytes);
                } else if (paths[paths.length - 1] == "verso.html") {
                  var cardName = extractParentFolder(archEntity.name);
                  entityNatures[cardName] =
                      EntityNature(cardName, ExportType.card, bytes: bytes);
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
            } else if (paths[paths.length - 1] == "course_desc.json") {
              var courseName = extractParentFolder(archEntity.name);
              entityNatures[courseName] =
                  EntityNature(courseName, ExportType.course, bytes: bytes);
            } else if (paths[paths.length - 1] == "topic_desc.json") {
              var topicName = extractParentFolder(archEntity.name);
              entityNatures[topicName] =
                  EntityNature(topicName, ExportType.topic, bytes: bytes);
            }
          } else if (paths[paths.length - 1].contains('.') &&
              !paths[paths.length - 1].startsWith('.')) {
            if (cardReg.hasMatch(paths[paths.length - 2])) {
              entityNatures[archEntity.name] = EntityNature(
                  archEntity.name, ExportType.fileContent,
                  bytes: bytes);
            } else if (supportReg.hasMatch(paths[paths.length - 1])) {
              entityNatures[archEntity.name] = EntityNature(
                  archEntity.name, ExportType.support,
                  bytes: bytes);
            }
          }
        } else {
          print('Dossier : ${archEntity.name}');
          // Pour parcourir récursivement, vous pouvez appeler readArchive sur les sous-dossiers
        }
      }
      var issou = 1;

      var groupEntityNatures = entityNatures.entries
          .where((element) => element.value.type == ExportType.group);
      // On crée tous les groupes
      for (var group in groupEntityNatures) {
        var groupDesc = utf8.decode(group.value.bytes!);
        var groupDescriptor = ExportDescriptor.fromJson(jsonDecode(groupDesc));
        var groupExport =
            GroupExport(groupDescriptor.name!, [], [], path: group.key);
        groupExports[group.key] = groupExport;
      }

      // On crée les cartes
      for (MapEntry<String, EntityNature> card in entityNatures.entries
          .where((element) => element.value.type == ExportType.card)) {
        createCardIfNotExists(card.value.path);
      }

      // On crée les rectos
      for (var rectoHtml in entityNatures.entries
          .where((element) => element.value.type == ExportType.rectoHtml)) {
        cardExports[extractParentFolder(rectoHtml.key)]!.content.recto =
            utf8.decode(rectoHtml.value.bytes!);
      }

      // On crée les versos
      for (var versoHtml in entityNatures.entries
          .where((element) => element.value.type == ExportType.versoHtml)) {
        List<String> paths = versoHtml.key.split('/');
        cardExports[extractParentFolder(versoHtml.key)]!.content.verso =
            utf8.decode(versoHtml.value.bytes!);
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
              file.value.bytes!));
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

      //On crée les topics
      for (var topic in entityNatures.entries
          .where((element) => element.value.type == ExportType.topic)) {
        var topicDescJson = utf8.decode(topic.value.bytes!);
        var topicDescriptor =
            ExportDescriptor.fromJson(jsonDecode(topicDescJson));
        topicExports[topic.key] =
            TopicExport(topicDescriptor.name!, [], path: topic.key);
      }

      //On mets les groupes dans leur topic
      for (var group in groupExports.entries) {
        List<String> paths = group.key.split('/');
        for (int index = paths.length - 2; index >= 0; index--) {
          var topicEntityNature = entityNatures.values
              .where((element) =>
                  element.name == paths[index] &&
                  element.type == ExportType.topic)
              .firstOrNull;
          if (topicEntityNature != null) {
            topicExports[topicEntityNature.path]!.group = group.value;
            break;
          }
        }
      }

      //On mets les support dans leur topic
      for (var support in entityNatures.entries
          .where((element) => element.value.type == ExportType.support)) {
        List<String> paths = support.key.split('/');
        for (int index = paths.length - 2; index >= 0; index--) {
          var topicEntityNature = entityNatures.values
              .where((element) =>
                  element.name == paths[index] &&
                  element.type == ExportType.topic)
              .firstOrNull;
          if (topicEntityNature != null) {
            topicExports[topicEntityNature.path]!.topicSupportBytes =
                support.value.bytes;
            break;
          }
        }
      }

      //On mets les topics dans les topics parents
      for (var topic in entityNatures.entries
          .where((element) => element.value.type == ExportType.topic)) {
        List<String> paths = topic.key.split('/');
        for (int index = paths.length - 2; index >= 0; index--) {
          var topicEntityNature = entityNatures.values
              .where((element) =>
                  element.name == paths[index] &&
                  element.type == ExportType.topic)
              .firstOrNull;
          if (topicEntityNature != null) {
            topicExports[topicEntityNature.path]!
                .childTopics
                .add(topicExports[topic.key]!);
            topicExports.remove(topic.key);
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

      //On crée en bdd tous les groupes
      for (var group in groupExports.entries) {
        GroupExport groupExport = group.value;
        await saveGroupExportInDb(groupExport);
      }

      //On crée le cours en BDD
      var course = entityNatures.entries
          .where((element) => element.value.type == ExportType.course)
          .first;
      var courseDescJson = utf8.decode(course.value.bytes!);
      var courseDescriptor =
          ExportDescriptor.fromJson(jsonDecode(courseDescJson));
      int courseId = await saveCourseExportInDb(courseDescriptor);

      //On crée en bdd tous les topics
      for (var topic in topicExports.entries) {
        var topicExport = topic.value;
        await saveTopicExportInDb(
            topicExport, groupExports.values.toList(), courseId);
      }

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

Future<void> saveGroupExportInDb(GroupExport groupExport,
    {int? parentId}) async {
  try {
    var db = MyDatabaseInstance.getInstance();
    var matchingGroups = await (db.select(db.group)
          ..where((tbl) => tbl.path.equals(groupExport.path!)))
        .get();
    late int groupId;
    if (matchingGroups.isNotEmpty) {
      groupExport.dbId = matchingGroups.first.id;
      groupId = groupExport.dbId!;
    } else {
      groupId = await createGroupInDb(GroupCompanion.insert(
          title: groupExport.title,
          tags: "",
          parentId: Value(parentId),
          path: Value(groupExport.path!)));
      groupExport.dbId = groupId;
    }

    for (var card in groupExport.cards) {
      var matchingCards = await (database.select(database.reviseCards)
            ..where((tbl) => tbl.path.equals(card.path!)))
          .get();

      late int contentId;

      if (matchingCards.isNotEmpty) {
        contentId = matchingCards.first.htmlContent;
        // supprimer fichiers du htmlContent
        await (db.delete(db.hTMLContentFiles)
              ..where((tbl) => tbl.htmlContentParentId.equals(contentId)))
            .go();

        var test = await (db.select(db.hTMLContents)
              ..where((tbl) => tbl.id.equals(contentId)))
            .get();

        // mettre à jour le htmlContent
        await (db.update(db.hTMLContents)
              ..where((tbl) => tbl.id.equals(contentId)))
            .write(HTMLContentsCompanion.insert(
                recto: card.content.recto, verso: card.content.verso));

        var test2 = await (db.select(db.hTMLContents)
              ..where((tbl) => tbl.id.equals(contentId)))
            .get();
        var issou = 0;
      } else {
        var cardReturns = await createCardInDb(
            groupId,
            CardDisplayerType.html,
            card.path!,
            HTMLContentsCompanion.insert(
                recto: card.content.recto, verso: card.content.verso));

        contentId = cardReturns.contentId;
      }

      for (var file in card.content.files) {
        await createHtmlContentFileContentInDb(
            contentId,
            FileContentsCompanion.insert(
                name: file.name, format: file.format, content: file.content));
      }
    }
    for (var childGroup in groupExport.childGroups) {
      await saveGroupExportInDb(childGroup, parentId: groupId);
    }
  } catch (e) {
    print(e);
  }
}

Future<int> saveCourseExportInDb(ExportDescriptor courseExport) async {
  var db = MyDatabaseInstance.getInstance();

  //Faire la requête pour voir si le cours existe déjà
  var matchingCourses = await (db.select(db.courses)
        ..where((tbl) => tbl.sku.equals(courseExport.sku!)))
      .get();
  if (matchingCourses.isNotEmpty) {
    return matchingCourses.first.id;
  } else {
    int courseId = await createCourseInDb(CoursesCompanion.insert(
        sku: courseExport.sku!,
        title: courseExport.name!,
        description: courseExport.learnAbouts!.join("\n"),
        imageUrl: courseExport.imgUrl!));
    return courseId;
  }
}

Future<void> saveTopicExportInDb(
    TopicExport topicExport, List<GroupExport> groups, int parentCourseId,
    {int? parentId}) async {
  int? groupId = groups
      .where((element) => element.path == topicExport.group?.path)
      .firstOrNull
      ?.dbId;
  int? supportId;
  late int topicId;
  var db = MyDatabaseInstance.getInstance();

  Future<void> createFileContent() async {
    if (topicExport.topicSupportBytes != null) {
      supportId = await createFileContentInDb(FileContentsCompanion.insert(
          name: "support",
          format: "pdf",
          content: topicExport.topicSupportBytes!));
    }
  }

  // Faire suppression de l'ancien fichier / Trouver topic parent en 1er
  var existingTopic = await (db.select(db.topics)
        ..where((tbl) => tbl.path.equals(topicExport.path!)))
      .getSingleOrNull();
  if (existingTopic != null) {
    if (existingTopic.fileId != null) {
      var existingSupport = await (db.select(db.fileContents)
            ..where((tbl) => tbl.id.equals(existingTopic.fileId!)))
          .getSingleOrNull();
      if (existingSupport != null) {
        await (db.delete(db.fileContents)
              ..where((tbl) => tbl.id.equals(existingSupport.id)))
            .go();
      }
    }
    await createFileContent();
    topicId = existingTopic.id;
    await (db.update(db.topics)..where((tbl) => tbl.id.equals(topicId))).write(
        TopicsCompanion.insert(
            path: Value(topicExport.path!),
            title: topicExport.title,
            parentCourseId: parentCourseId,
            groupId: Value(groupId),
            fileId: Value(supportId),
            parentId: Value(parentId)));
  } else {
    await createFileContent();
    topicId = await createTopicInDb(TopicsCompanion.insert(
        path: Value(topicExport.path!),
        title: topicExport.title,
        parentCourseId: parentCourseId,
        groupId: Value(groupId),
        fileId: Value(supportId),
        parentId: Value(parentId)));
  }
  for (var childTopic in topicExport.childTopics) {
    await saveTopicExportInDb(childTopic, groups, parentCourseId,
        parentId: topicId);
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
