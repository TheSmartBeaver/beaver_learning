import 'package:beaver_learning/data/constants.dart';
import 'package:drift/drift.dart';

class UserApp extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sku => text().withDefault(const Constant(AppConstante.skuToBeDefined))();

  // Firebase Auth ID
  TextColumn get fbId => text()();
  DateTimeColumn get lastUpdated => dateTime()();
}
