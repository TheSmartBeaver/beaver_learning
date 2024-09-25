import 'package:beaver_learning/src/models/db/groupTable.dart';
import 'package:drift/drift.dart';

class FileContents extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get format => text()();
  BlobColumn get content => blob()();
  DateTimeColumn get lastUpdated => dateTime()();
}
