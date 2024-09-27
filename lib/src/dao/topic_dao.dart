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

  Future<Topic?> getRootTopicByCourseId(int courseId) async {
    var entity = await ((select(topics)..where((t) => t.parentCourseId.equals(courseId))).getSingleOrNull());
    return entity;
  }
}
