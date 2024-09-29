import 'package:beaver_learning/src/models/db/htmlContentTable.dart';
import 'package:drift/drift.dart';

class AssemblyCategoryAssembly extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get assemblyId => integer().references(HTMLContents, #id)();
  IntColumn get assemblyCategoryId => integer().references(AssemblyCategoryAssembly, #id)();
  //DateTimeColumn get lastUpdated => dateTime()();
}
