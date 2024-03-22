import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/models/enum/card_displayer_type.dart';
final database = MyDatabaseInstance.getInstance();

Future<CardCreatedReturns> createCardInDb(int groupId, CardDisplayerType displayerType,
    HTMLContentsCompanion hTMLContentsCompanion) async {
  var contentId =
      await database.into(database.hTMLContents).insert(hTMLContentsCompanion);

  var cardId = await database.into(database.reviseCards).insert(
      ReviseCardsCompanion.insert(
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

Future<void> createFileContentInDb(int htmlContentParentId, FileContentsCompanion fileContentsCompanion) async {
  var fileId = await database.into(database.fileContents).insert(fileContentsCompanion);
  await database.into(database.hTMLContentFiles).insert(HTMLContentFilesCompanion.insert(htmlContentParentId: htmlContentParentId, fileId: fileId));
}