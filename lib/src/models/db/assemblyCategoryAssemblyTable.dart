import 'package:beaver_learning/src/models/db/cardTemplateTable.dart';
import 'package:drift/drift.dart';

class AssemblyCategoryAssembly extends Table {
  IntColumn get assemblyId => integer().autoIncrement()();
  IntColumn get templateId => integer().references(CardTemplate, #id)();
  DateTimeColumn get lastUpdated => dateTime()();
}
