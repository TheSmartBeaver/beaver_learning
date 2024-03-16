import 'package:drift/drift.dart';

class HTMLContents extends Table {
  IntColumn get id => integer().autoIncrement()();
  //TextColumn get name => text()();
  TextColumn get content => text().named('body')();
}
