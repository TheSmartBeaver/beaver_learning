import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/models/enum/card_displayer_type.dart';
import 'package:drift/drift.dart';

final database = MyDatabaseInstance.getInstance();

Future<CardCreatedReturns> createCardInDb(
    int groupId,
    CardDisplayerType displayerType,
    String? path,
    HTMLContentsCompanion hTMLContentsCompanion) async {
  var contentId =
      await database.into(database.hTMLContents).insert(hTMLContentsCompanion);

  var cardId = await database.into(database.reviseCards).insert(
      ReviseCardsCompanion.insert(
          path: Value(path),
          groupId: groupId,
          displayerType: displayerType,
          nextRevisionDateMultiplicator: 0.2,
          htmlContent: contentId,
          tags: 'toto;ahah'));
  return CardCreatedReturns(cardId, contentId);
}

class CardCreatedReturns {
  final int cardId;
  final int contentId;
  CardCreatedReturns(this.cardId, this.contentId);
}

Future<int> createGroupInDb(GroupCompanion groupCompanion) async {
  var id = await database.into(database.group).insert(groupCompanion);
  return id;
}

Future<void> createHtmlContentFileContentInDb(int htmlContentParentId,
    FileContentsCompanion fileContentsCompanion) async {
  var fileId =
      await database.into(database.fileContents).insert(fileContentsCompanion);
  await database.into(database.hTMLContentFiles).insert(
      HTMLContentFilesCompanion.insert(
          htmlContentParentId: htmlContentParentId, fileId: fileId));
}

Future<int> createTopicInDb(TopicsCompanion topicCompanion) async {
  var id = await database.into(database.topics).insert(topicCompanion);
  return id;
}

Future<int> createFileContentInDb(FileContentsCompanion fileContentsCompanion) async {
  var fileId =
      await database.into(database.fileContents).insert(fileContentsCompanion);
  return fileId;
}

Future<int> createHtmlContentInDb(HTMLContentsCompanion htmlContentsCompanion) async {
  var fileId =
      await database.into(database.hTMLContents).insert(htmlContentsCompanion);
  return fileId;
}

Future<int> createCourseInDb(CoursesCompanion courseCompanion) async {
  var id = await database.into(database.courses).insert(courseCompanion);
  return id;
}

Future<int> createHtmlTemplateInDb(CardTemplateCompanion htmlTemplateCompanion) async {
  var id = await database.into(database.cardTemplate).insert(htmlTemplateCompanion);
  return id;
}