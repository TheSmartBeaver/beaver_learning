import 'package:beaver_learning/src/models/db/cardTemplateTable.dart';
import 'package:beaver_learning/src/models/db/courseTable.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:drift/drift.dart';

part 'card_template_dao.g.dart';

@DriftAccessor(tables: [CardTemplate])
class CardTemplateDao extends DatabaseAccessor<AppDatabase> with _$CardTemplateDaoMixin {
  final AppDatabase db;

  CardTemplateDao(this.db) : super(db);

  Future updateById(int id, CardTemplateCompanion cardTemplateCompanion) {
    return (update(cardTemplate)..where((t) => t.id.equals(id)))
        .write(cardTemplateCompanion);
  }

  Future<CardTemplateData?> getBySku(String sku) async {
    var entity = await ((select(cardTemplate)..where((t) => t.sku.equals(sku))).getSingleOrNull());
    return entity;
  }

  Future insertOrUpdateBySku(String sku, CardTemplateCompanion companion) async {
    var entity = await getBySku(sku);

    if (entity == null) {
      return into(cardTemplate).insert(companion);
    } else {
      return await (update(cardTemplate)..where((t) => t.sku.equals(sku)))
          .write(companion);
    }
  }

}
