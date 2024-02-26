import 'package:beaver_learning/src/models/db/groupTable.dart';
import 'package:drift/drift.dart';

class ReviseCards extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get groupId => integer().references(Group, #id)();
  TextColumn get recto => text()();
  TextColumn get verso => text()();
  TextColumn get tags => text().named('body')();
  //IntColumn get categoryId => integer().references(TodoCategories, #id)();

  // TextColumn get generatedText => text().nullable().generatedAs(
  //     title + const Constant(' (') + content + const Constant(')'))();
}
