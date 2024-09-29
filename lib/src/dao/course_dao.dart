import 'package:beaver_learning/src/models/db/courseTable.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:drift/drift.dart';

part 'course_dao.g.dart';

@DriftAccessor(tables: [Courses])
class CourseDao extends DatabaseAccessor<AppDatabase> with _$CourseDaoMixin {
  final AppDatabase db;

  CourseDao(this.db) : super(db);

  Future updateById(int id, CoursesCompanion courseCompanion) {
    return (update(courses)..where((t) => t.id.equals(id)))
        .write(courseCompanion);
  }

  Future<Course?> getById(int id) async {
    var entity = await ((select(courses)..where((t) => t.id.equals(id))).getSingleOrNull());
    return entity;
  }

  Future updateBySku(String sku, CoursesCompanion companion) {
    return (update(courses)..where((t) => t.sku.equals(sku)))
        .write(companion);
  }

  Future<Course?> getBySku(String sku) async {
    var entity = await ((select(courses)..where((t) => t.sku.equals(sku))).getSingleOrNull());
    return entity;
  }

}
