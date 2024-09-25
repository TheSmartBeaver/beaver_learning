import 'package:beaver_learning/src/models/db/courseTable.dart';
import 'package:beaver_learning/src/models/db/fileContentsTable.dart';
import 'package:beaver_learning/src/models/db/groupTable.dart';
import 'package:beaver_learning/src/models/db/htmlContentTable.dart';
import 'package:drift/drift.dart';

class Topics extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get path => text().nullable()();
  TextColumn get title => text()();
  IntColumn get parentId => integer().references(Topics, #id).nullable()();
  IntColumn get parentCourseId => integer().references(Courses, #id)();
  IntColumn get groupId => integer().references(Group, #id).nullable()();
  IntColumn get fileId => integer().references(FileContents, #id).nullable()();
  IntColumn get htmlContentId => integer().references(HTMLContents, #id).nullable()();
  DateTimeColumn get lastUpdated => dateTime()();
}
