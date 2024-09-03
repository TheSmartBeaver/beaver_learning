import 'package:beaver_learning/src/models/db/cardTable.dart';
import 'package:beaver_learning/src/models/db/cardTemplateTable.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/image_table.dart';
import 'package:drift/drift.dart';

part 'card_dao.g.dart';

@DriftAccessor(tables: [ReviseCards, CardTemplate])
class CardDao extends DatabaseAccessor<AppDatabase> with _$CardDaoMixin {
  final AppDatabase db;

  CardDao(this.db) : super(db);

  Future updateCard(ReviseCard card) => update(reviseCards).replace(card);
  Future deleteCard(ReviseCard card) => delete(reviseCards).delete(card);

  Future updateNextRevision(
      int cardId, double newCoeff, DateTime nextRevisionDate) {
    // for updates, we use the "companion" version of a generated class. This wraps the
    // fields in a "Value" type which can be set to be absent using "Value.absent()". This
    // allows us to separate between "SET category = NULL" (`category: Value(null)`) and not
    // updating the category at all: `category: Value.absent()`.
    return (update(reviseCards)..where((t) => t.id.equals(cardId))).write(
      ReviseCardsCompanion(
          nextRevisionDateMultiplicator: Value(newCoeff),
          nextRevisionDate: Value(nextRevisionDate)),
    );
  }

  Future updateMnemotechnicHint(int cardId, String mnemotechnicHint) {
    return (update(reviseCards)..where((t) => t.id.equals(cardId))).write(
        ReviseCardsCompanion(
          mnemotechnicHint: Value(mnemotechnicHint),
        ),
      );
  }

  Future updateCardTemplatedJson(int htmlContentId, String cardTemplatedJson) {
    return (update(hTMLContents)..where((t) => t.id.equals(htmlContentId))).write(
        HTMLContentsCompanion(
          cardTemplatedJson: Value(cardTemplatedJson),
        ),
      );
  }

  Future<CardTemplateData> getHtmlCardTemplate(int htmlCardTemplateId) async {

    CardTemplateData cardTemplateToReturn = await (select(cardTemplate)
          ..where((tbl) => tbl.id.equals(htmlCardTemplateId)))
        .getSingle();

    return cardTemplateToReturn;
  }

  Future<CardTemplateData> getHtmlCardTemplateByPath(String htmlCardTemplatePath) async {

    CardTemplateData cardTemplateToReturn = await (select(cardTemplate)
          ..where((tbl) => tbl.path.equals(htmlCardTemplatePath)))
        .getSingle();

    return cardTemplateToReturn;
  }
}
