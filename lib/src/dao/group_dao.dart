import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/fileContentsTable.dart';
import 'package:beaver_learning/src/models/db/groupTable.dart';
import 'package:drift/drift.dart';

part 'group_dao.g.dart';

@DriftAccessor(tables: [Group])
class GroupDao extends DatabaseAccessor<AppDatabase> with _$GroupDaoMixin {
  final AppDatabase db;

  GroupDao(this.db) : super(db);

  Future updateById(int id, GroupCompanion groupCompanion) {
    return (update(group)..where((t) => t.id.equals(id)))
        .write(groupCompanion);
  }

  Future<GroupData?> getById(int id) async {
    var entity = await ((select(group)..where((t) => t.id.equals(id))).getSingleOrNull());
    return entity;
  }

  Future<GroupData?> getBySku(String sku) async {
    var entity = await ((select(group)..where((t) => t.sku.equals(sku))).getSingleOrNull());
    return entity;
  }

  Future insertOrUpdateBySku(String sku, GroupCompanion companion) async {
    var entity = await getBySku(sku);

    if (entity == null) {
      return into(group).insert(companion);
    } else {
      return await (update(group)..where((t) => t.sku.equals(sku)))
          .write(companion);
    }
  }
}
