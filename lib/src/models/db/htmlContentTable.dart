import 'package:drift/drift.dart';

class HTMLContents extends Table {
  IntColumn get id => integer().autoIncrement()();
  //TextColumn get name => text()();
  TextColumn get recto => text().withDefault(const Constant(""))();
  TextColumn get verso => text().withDefault(const Constant(""))();
  BoolColumn get isTemplated => boolean().withDefault(const Constant(false))();
  TextColumn get cardTemplatedJson => text().withDefault(const Constant(""))();
  BoolColumn get isAssembly => boolean().withDefault(const Constant(false))();
}
