import 'package:beaver_learning/src/models/db/fileContentsTable.dart';
import 'package:beaver_learning/src/models/db/htmlContentTable.dart';
import 'package:drift/drift.dart';

class HTMLContentFiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get fileId => integer().references(FileContents, #id)();
  IntColumn get htmlContentParentId => integer().references(HTMLContents, #id)();
  DateTimeColumn get lastUpdated => dateTime()(); // Utile ????
}
