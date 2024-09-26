import 'package:drift/drift.dart';

class AssemblyCategory extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sku => text().nullable()();
  TextColumn get path => text().unique()();
  DateTimeColumn get lastUpdated => dateTime()();
}
