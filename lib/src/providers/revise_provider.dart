/*** TO DEVELOP
 * - Interrogation BDD pour connaître comment réviser tel paquet
 * - Interrogation BDD pour statistiques des révisons
 ***/

import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/db/database.dart';

class ReviseNotifier extends StateNotifier<Object> {
  ReviseNotifier() : super([]);

  Future<List<ReviseCard>> getAllCardsToRevise() async {
    final database = MyDatabaseInstance.getInstance();
    DateTime now = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59);
    List<ReviseCard> allItems =
        await (database.select(database.reviseCards)..where((tbl) => tbl.nextRevisionDate.isSmallerThanValue(now) | tbl.nextRevisionDate.isNull())).get();
    return allItems;
  }
}

final reviseProvider = StateNotifierProvider<ReviseNotifier, Object>((ref) {
  return ReviseNotifier();
});
