import 'package:beaver_learning/src/models/db/groupTable.dart';
import 'package:beaver_learning/src/models/db/htmlContentTable.dart';
import 'package:beaver_learning/src/models/enum/card_displayer_type.dart';
import 'package:drift/drift.dart';

class ReviseCards extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sku => text().nullable()();
  IntColumn get groupId => integer().references(Group, #id)();

  IntColumn get htmlContent => integer().references(HTMLContents, #id)();
  IntColumn get displayerType => intEnum<CardDisplayerType>()();
  TextColumn get tags => text().named('body')();

  RealColumn get nextRevisionDateMultiplicator => real()();
  DateTimeColumn get nextRevisionDate => dateTime().nullable()();

  TextColumn get path => text().nullable()();

  TextColumn get mnemotechnicHint => text().nullable()();

  DateTimeColumn get lastUpdated => dateTime()();
}
