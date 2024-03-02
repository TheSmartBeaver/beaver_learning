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

    // await database.into(database.reviseCards).insert(
    //     ReviseCardsCompanion.insert(
    //         title: 'todo: finish drift setup',
    //         content: const Value(
    //             'We can now write queries and define our own tables.'),
    //         tags: 'toto;ahah'));

    List<ReviseCard> allItems =
        await database.select(database.reviseCards).get();
    return allItems;
  }
}

final reviseProvider = StateNotifierProvider<ReviseNotifier, Object>((ref) {
  return ReviseNotifier();
});
