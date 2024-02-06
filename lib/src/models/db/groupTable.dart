import 'package:drift/drift.dart';

class Group extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get tags => text().named('body')();
  IntColumn get parentId => integer().references(Group, #id)();
}
