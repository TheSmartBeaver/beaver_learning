import 'package:beaver_learning/src/models/db/cardTemplateTable.dart';
import 'package:drift/drift.dart';

class AssemblyCategory extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get categoryName => text().unique()();
  IntColumn get templateId => integer().references(CardTemplate, #id)();
}
