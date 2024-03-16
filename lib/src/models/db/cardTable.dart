import 'package:beaver_learning/src/models/db/groupTable.dart';
import 'package:beaver_learning/src/models/db/htmlContentTable.dart';
import 'package:beaver_learning/src/models/enum/card_displayer_type.dart';
import 'package:drift/drift.dart';

class ReviseCards extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get groupId => integer().references(Group, #id)();

  IntColumn get recto => integer().references(HTMLContents, #id)();
  IntColumn get verso => integer().references(HTMLContents, #id)();
  
  // TextColumn get recto => text()();
  // TextColumn get verso => text()();
  IntColumn get displayerType => intEnum<CardDisplayerType>()();
  TextColumn get tags => text().named('body')();

  // RealColumn get vhCoeff => real()();
  // RealColumn get hCoeff => real()();
  // RealColumn get eCoeff => real()();
  // RealColumn get veCoeff => real()();
  RealColumn get nextRevisionDateMultiplicator => real()();

  DateTimeColumn get nextRevisionDate => dateTime().nullable()();

  //IntColumn get categoryId => integer().references(TodoCategories, #id)();

  // TextColumn get generatedText => text().nullable().generatedAs(
  //     title + const Constant(' (') + content + const Constant(')'))();
}
