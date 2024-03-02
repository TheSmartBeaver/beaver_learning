import 'package:drift/drift.dart';

class Images extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get path => text().withLength(min: 1, max: 256)();
}