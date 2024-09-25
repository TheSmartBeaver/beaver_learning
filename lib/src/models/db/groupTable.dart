import 'package:drift/drift.dart';

class Group extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get path => text().nullable()();
  TextColumn get tags => text().named('body')();
  IntColumn get parentId => integer().references(Group, #id).nullable()();
  DateTimeColumn get lastUpdated => dateTime()();
}
