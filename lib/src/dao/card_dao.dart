import 'package:beaver_learning/src/dao/html_dao.dart';
import 'package:beaver_learning/src/exception/item_not_found_exception.dart';
import 'package:beaver_learning/src/models/db/cardTable.dart';
import 'package:beaver_learning/src/models/db/cardTemplateTable.dart';
import 'package:beaver_learning/src/models/db/custom_db_type/card_joined_html_content.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/htmlContentTable.dart';
import 'package:beaver_learning/src/models/db/image_table.dart';
import 'package:beaver_learning/src/utils/synchronize_functions.dart';
import 'package:drift/drift.dart';

part 'card_dao.g.dart';

@DriftAccessor(tables: [ReviseCards, CardTemplate, HTMLContents])
class CardDao extends DatabaseAccessor<AppDatabase> with _$CardDaoMixin {
  final AppDatabase db;

  CardDao(this.db) : super(db);

  Future updateCard(ReviseCard card) => update(reviseCards).replace(card);
  Future deleteCard(ReviseCard card) => delete(reviseCards).delete(card);

  Future deleteById(int id) async {
    var cardToDelete = await getCardById(id);
    HtmlDao htmlDao = HtmlDao(db);
    await htmlDao.deleteById(cardToDelete.htmlContent);
    await ((delete(reviseCards)..where((t) => t.id.equals(id)))).go();
  }

  Future updateNextRevision(
      int cardId, double newCoeff, DateTime nextRevisionDate) {
    // for updates, we use the "companion" version of a generated class. This wraps the
    // fields in a "Value" type which can be set to be absent using "Value.absent()". This
    // allows us to separate between "SET category = NULL" (`category: Value(null)`) and not
    // updating the category at all: `category: Value.absent()`.
    return (update(reviseCards)..where((t) => t.id.equals(cardId))).write(
      ReviseCardsCompanion(
          nextRevisionDateMultiplicator: Value(newCoeff),
          nextRevisionDate: Value(nextRevisionDate),
          lastUpdated: Value(getUpdateDateNow())),
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
    return (update(hTMLContents)..where((t) => t.id.equals(htmlContentId)))
        .write(
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

  Future<HTMLContent> getHtmlContentByCardId(int cardId) async {
    ReviseCard card = await (select(reviseCards)
          ..where((tbl) => tbl.id.equals(cardId)))
        .getSingle();

    HTMLContent htmlContentToReturn = await (select(hTMLContents)
          ..where((tbl) => tbl.id.equals(card.htmlContent)))
        .getSingle();

    return htmlContentToReturn;
  }

  Future<ReviseCard> getCardById(int cardId) async {
    ReviseCard cardToReturn = await (select(reviseCards)
          ..where((tbl) => tbl.id.equals(cardId)))
        .getSingle();

    return cardToReturn;
  }

  Future<CardTemplateData> getHtmlCardTemplateByPath(
      String htmlCardTemplatePath) async {
    try {
      CardTemplateData? cardTemplateToReturn = await (select(cardTemplate)
            ..where((tbl) => tbl.path.equals(htmlCardTemplatePath)))
          .getSingleOrNull();

      if (cardTemplateToReturn == null) {
        throw ItemNotFoundException(
            "No card template found for path $htmlCardTemplatePath");
      }

      return cardTemplateToReturn;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future insertAssembly(
      HTMLContent htmlContent, int assemblyCategoryId, bool bool) async {
    await into(hTMLContents).insert(htmlContent);
    await into(hTMLContents).insert(htmlContent);
  }

  Future updateAssembly(HTMLContent htmlContent, int templateCategoryId) async {
    await update(hTMLContents).replace(htmlContent);
  }

  Future updateById(int id, ReviseCardsCompanion cardCompanion) {
    return (update(reviseCards)..where((t) => t.id.equals(id)))
        .write(cardCompanion);
  }

  Future<ReviseCard?> getBySku(String sku) async {
    var entity = await ((select(reviseCards)..where((t) => t.sku.equals(sku)))
        .getSingleOrNull());
    return entity;
  }

  Future insertOrUpdateBySku(String sku, ReviseCardsCompanion companion) async {
    var entity = await getBySku(sku);

    if (entity == null) {
      return into(reviseCards).insert(companion);
    } else {
      return await (update(reviseCards)..where((t) => t.sku.equals(sku)))
          .write(companion);
    }
  }

  SimpleSelectStatement<$ReviseCardsTable, ReviseCard>
      generateWordWhereClauseRequestForCard(String word) {
    return select(reviseCards)
      ..join([
        innerJoin(
            hTMLContents, hTMLContents.id.equalsExp(reviseCards.htmlContent))
      ]);

      
      // ..where((tbl) =>
      //     hTMLContents.cardTemplatedJson.like('%$word%') | (hTMLContents.path.like('%$word%')));
  }

  Future<List<ReviseCard>> removeCardsWithoutProperWordWhereClause(List<ReviseCard> reviseCards, String word) async {
    List<ReviseCardJoinHtmlContentResult> joinResult = await customJoinRequest(word);
    var finalResult = [...reviseCards];
    List<int> validIds = joinResult.map<int>((e) => e.getReviseCardId(e.data)).toList();
    for (var card in reviseCards) {
      if (!validIds.contains(card.id)) {
        finalResult.remove(card);
      }
    }
    return finalResult;
  }

  Future<List<ReviseCardJoinHtmlContentResult>> customJoinRequest(String word) async {
    // h_t_m_l_contents
    // revise_cards
    final query = '''SELECT RC.* FROM revise_cards RC
    JOIN h_t_m_l_contents HC ON RC.html_content = HC.id
    WHERE HC.card_templated_json LIKE '%$word%'
    ''';
    // List<QueryRow> results = await customSelect(query, variables: [Variable.withString('some_value')]).get();
    List<QueryRow> results = await customSelect(query, variables: []).get();
    final result = results.map((row) => ReviseCardJoinHtmlContentResult(data: row.data)).toList();
    return result;
  } 
}
