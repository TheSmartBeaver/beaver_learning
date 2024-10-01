import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/fileContentsTable.dart';
import 'package:beaver_learning/src/models/db/topicTable.dart';
import 'package:drift/drift.dart';

part 'topic_dao.g.dart';

@DriftAccessor(tables: [Topics])
class TopicDao extends DatabaseAccessor<AppDatabase> with _$TopicDaoMixin {
  final AppDatabase db;

  TopicDao(this.db) : super(db);

  Future updateById(int id, TopicsCompanion topicCompanion) {
    return (update(topics)..where((t) => t.id.equals(id)))
        .write(topicCompanion);
  }

  Future<Topic?> getById(int id) async {
    var entity = await ((select(topics)..where((t) => t.id.equals(id))).getSingleOrNull());
    return entity;
  }

  Future insertOrUpdateBySku(String sku, TopicsCompanion companion) async {
    var entity = await getBySku(sku);

    if (entity == null) {
      return into(topics).insert(companion);
    } else {
      return await (update(topics)..where((t) => t.sku.equals(sku)))
          .write(companion);
    }
  }

  Future<Topic?> getBySku(String sku) async {
    var entity = await ((select(topics)..where((t) => t.sku.equals(sku))).getSingleOrNull());
    return entity;
  }

  // Future<Topic?> getRootTopicByCourseId(int courseId) async {
  //   var test = await ((select(topics)..where((t) => t.parentCourseId.equals(courseId))).get());
  //   var entity = await ((select(topics)..where((t) => t.parentCourseId.equals(courseId) & t.parentId.isNull())).getSingleOrNull());
  //   return entity;
  // }
}
