import 'package:drift/drift.dart';

class AssemblyCategory extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get path => text().unique()();
  DateTimeColumn get lastUpdated => dateTime()();
}
