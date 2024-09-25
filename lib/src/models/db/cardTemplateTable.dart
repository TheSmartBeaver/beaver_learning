import 'package:drift/drift.dart';

class CardTemplate extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sku => text()(); // Utile ? S'en servir comme espace de nom
  TextColumn get path => text()();
  TextColumn get template => text()();
  DateTimeColumn get lastUpdated => dateTime()();
}