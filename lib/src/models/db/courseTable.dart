import 'package:drift/drift.dart';

class Courses extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sku => text()();
  TextColumn get imageUrl => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  DateTimeColumn get lastUpdated => dateTime()();
}
