import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/src/archive_file.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/models/enum/card_displayer_type.dart';
import 'package:beaver_learning/src/utils/cards_functions.dart';
import 'package:beaver_learning/src/utils/classes/export_classes.dart';
import 'package:beaver_learning/src/utils/classes/import_class_interfaces.dart';
import 'package:beaver_learning/src/utils/classes/import_classes.dart';
import 'package:beaver_learning/src/utils/classes/import_utils_functions.dart';
import 'package:drift/drift.dart';

class ImportManager extends ImportInterface {
  ImportManager() {
    super.cardExports = cardExports;
  }

  @override
  Future<int> createCourseInDB() async {
    //On crée le cours en BDD
      var course = entityNatures.entries
          .where((element) => element.value.type == ExportType.course)
          .first;
      var courseDescJson = utf8.decode(course.value.bytes!);
      var courseDescriptor =
          ExportDescriptor.fromJson(jsonDecode(courseDescJson));
      int courseId = await saveCourseExportInDb(courseDescriptor);
      return courseId;
  }

  @override
  Future<void> createGroupsInDB() async {
    //On crée en bdd tous les groupes
      for (var group in groupExports.entries) {
        GroupExport groupExport = group.value;
        await saveGroupExportInDb(groupExport);
      }
  }

  @override
  Future<void> createTopicsInDB(int courseId) async {
    //On crée en bdd tous les topics
      for (var topic in topicExports.entries) {
        var topicExport = topic.value;
        await saveTopicExportInDb(
            topicExport, groupExports.values.toList(), courseId);
      }
  }

  @override
  void fillAllCardExports() {
    // On crée les cartes
      for (MapEntry<String, EntityNature> card in entityNatures.entries
          .where((element) => element.value.type == ExportType.card)) {
        createCardInCardExportsIfNotExists(card.value.path);
      }
  }

  @override
  void fillAllCardExportsFiles() {
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
  }

  @override
  void fillAllCardExportsRecto() {
    // On crée les rectos
      for (var rectoHtml in entityNatures.entries
          .where((element) => element.value.type == ExportType.rectoHtml)) {
        cardExports[extractParentFolder(rectoHtml.key)]!.content.recto =
            utf8.decode(rectoHtml.value.bytes!);
      }
  }

  @override
  void fillAllCardExportsVerso() {
    // On crée les versos
      for (var versoHtml in entityNatures.entries
          .where((element) => element.value.type == ExportType.versoHtml)) {
        cardExports[extractParentFolder(versoHtml.key)]!.content.verso =
            utf8.decode(versoHtml.value.bytes!);
      }
  }

  @override
  void fillAllGroupExports() {
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
  }

  @override
  void fillAllTopicExports() {
    //On crée les topics
      for (var topic in entityNatures.entries
          .where((element) => element.value.type == ExportType.topic)) {
        var topicDescJson = utf8.decode(topic.value.bytes!);
        var topicDescriptor =
            ExportDescriptor.fromJson(jsonDecode(topicDescJson));
        topicExports[topic.key] =
            TopicExport(topicDescriptor.name!, [], path: topic.key);
      }
  }

  var cardReg = RegExp(r"card_\d+.*");
  var htmlReg = RegExp(r".*html");
  var supportReg = RegExp(r"support.*");
  var templatedJsonReg = RegExp(r"card_template\.json");

  @override
  void fillEntityNatures(ArchiveFile archEntity) {
    List<String> paths = archEntity.name.split('/');

    if (archEntity.isFile) {
      print('Fichier : ${archEntity.name}');
      // Vous pouvez accéder au contenu du fichier avec file.content
      Uint8List bytes = archEntity.content as Uint8List;

      if (fileCanBeReadAsString(archEntity.name)) {
        String stringContent = utf8.decode(bytes);
        if (cardReg.hasMatch(paths[paths.length - 2])) {
          var cardName = extractParentFolder(archEntity.name);

          if(templatedJsonReg.hasMatch(paths[paths.length - 1])){
            //On identifie en temps que carte templated
              entityNatures[cardName] =
                  EntityNature(cardName, ExportType.cardTemplated, bytes: bytes);
              entityNatures[archEntity.name] = EntityNature(
                  archEntity.name, ExportType.cardJsonTemplated,
                  bytes: bytes);
          } else {
            // On identifie en tant que carte qui se construit avec html recto verso sans template
          if (htmlReg.hasMatch(paths[paths.length - 1]) &&
              !paths[paths.length - 1].startsWith('.')) {
            if (paths[paths.length - 1] == "recto.html") {
              // On identifie en tant que recto d'une carte
              entityNatures[cardName] =
                  EntityNature(cardName, ExportType.card, bytes: bytes);
              entityNatures[archEntity.name] = EntityNature(
                  archEntity.name, ExportType.rectoHtml,
                  bytes: bytes);
            } else if (paths[paths.length - 1] == "verso.html") {
              // On identifie en tant que verso d'une carte
              entityNatures[cardName] =
                  EntityNature(cardName, ExportType.card, bytes: bytes);
              entityNatures[archEntity.name] = EntityNature(
                  archEntity.name, ExportType.versoHtml,
                  bytes: bytes);
            }
          }
          }
        } else if (paths[paths.length - 1] == "group_desc.json") {
          // On identifie en tant que descripteur d'un groupe
          var groupDescriptor =
              ExportDescriptor.fromJson(jsonDecode(stringContent));
          var groupName = extractParentFolder(archEntity.name);
          entityNatures[groupName] =
              EntityNature(groupName, groupDescriptor.type, bytes: bytes);
        } else if (paths[paths.length - 1] == "course_desc.json") {
          // On identifie en tant que descripteur d'un cours
          var courseName = extractParentFolder(archEntity.name);
          entityNatures[courseName] =
              EntityNature(courseName, ExportType.course, bytes: bytes);
        } else if (paths[paths.length - 1] == "topic_desc.json") {
          // On identifie en tant que descripteur d'un topic
          var topicName = extractParentFolder(archEntity.name);
          entityNatures[topicName] =
              EntityNature(topicName, ExportType.topic, bytes: bytes);
        } else if (paths.length > 2 && paths[1] == "templates" && htmlReg.hasMatch(paths[paths.length - 1])) {
          // On identifie en tant que template HTML d'une carte
          var htmlTemplateNameName = archEntity.name;
          entityNatures[htmlTemplateNameName] =
              EntityNature(htmlTemplateNameName, ExportType.cardHtmlTemplated, bytes: bytes);
        }
      } else if (paths[paths.length - 1].contains('.') &&
          !paths[paths.length - 1].startsWith('.')) {
        if (cardReg.hasMatch(paths[paths.length - 2])) {
          // On identifie en tant que fileContent d'une carte
          entityNatures[archEntity.name] = EntityNature(
              archEntity.name, ExportType.fileContent,
              bytes: bytes);
        } else if (supportReg.hasMatch(paths[paths.length - 1])) {
          // On identifie en tant que support d'un topic
          entityNatures[archEntity.name] =
              EntityNature(archEntity.name, ExportType.support, bytes: bytes);
        }
      }
    } else {
      print('Dossier : ${archEntity.name}');
      // Pour parcourir récursivement, vous pouvez appeler readArchive sur les sous-dossiers
    }
  }

  @override
  void linkAllCardExportsToGroupExports() {
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
  }

  @override
  void linkAllGroupExportsToParentGroupExports() {
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
  }

  @override
  void linkAllGroupExportsToTopicExports() {
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
  }

  @override
  void linkAllSupportsToTopicExports() {
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
  }

  @override
  void linkAllTopicExportsToParentTopicExports() {
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
  }

  @override
  void createCardInCardExportsIfNotExists(String name) {
    if (!cardExports.containsKey(name)) {
      cardExports[name] = CardExport(
          path: name,
          content: HTMLContentExport(recto: "", verso: "", files: []));
    }
  }

  Future<void> saveGroupExportInDb(GroupExport groupExport,
    {int? parentId}) async {
  try {
    var db = MyDatabaseInstance.getInstance();
    var matchingGroups = await (db.select(db.group)
          ..where((tbl) => tbl.path.equals(groupExport.path!)))
        .get();
    late int groupId;
    // Si le groupe existe déjà, on le met à jour
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
}
