import 'package:drift/drift.dart';

class ReviseCards extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get content => text().nullable()();
  TextColumn get tags => text().named('body')();
  //IntColumn get categoryId => integer().references(TodoCategories, #id)();

  TextColumn get generatedText => text().nullable().generatedAs(
      title + const Constant(' (') + content + const Constant(')'))();
}
