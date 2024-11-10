import 'package:beaver_learning/src/exception/child_found_exception.dart';
import 'package:beaver_learning/src/models/db/cardTable.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/fileContentsTable.dart';
import 'package:beaver_learning/src/models/db/groupTable.dart';
import 'package:drift/drift.dart';

part 'group_dao.g.dart';

@DriftAccessor(tables: [Group, ReviseCards])
class GroupDao extends DatabaseAccessor<AppDatabase> with _$GroupDaoMixin {
  final AppDatabase db;

  GroupDao(this.db) : super(db);

  Future updateById(int id, GroupCompanion groupCompanion) {
    return (update(group)..where((t) => t.id.equals(id))).write(groupCompanion);
  }

  Future<GroupData?> getById(int id) async {
    var entity = await ((select(group)..where((t) => t.id.equals(id)))
        .getSingleOrNull());
    return entity;
  }

  Future deleteById(int id) async {
    try {
      var groupToDelete = await getById(id);
      if (groupToDelete != null) {
        var childGroups =
            await (select(group)..where((t) => t.parentId.equals(id))).get();
        if (childGroups.isNotEmpty) {
          throw ChildFoundException(
              "Group ${groupToDelete.title} ${groupToDelete.path} has children GROUPS");
        } else {
          var cardsAttachedToGroup = await (select(reviseCards)
                ..where((t) => t.groupId.equals(id)))
              .get();
          if (cardsAttachedToGroup.isNotEmpty) {
            throw ChildFoundException(
                "Group ${groupToDelete.title} ${groupToDelete.path} has children CARDS");
          } else {
            await ((delete(group)..where((t) => t.id.equals(id))).go());
          }
        }
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<GroupData?> getBySku(String sku) async {
    var entity = await ((select(group)..where((t) => t.sku.equals(sku)))
        .getSingleOrNull());
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
