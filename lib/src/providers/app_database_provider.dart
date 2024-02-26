import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupNotifier extends StateNotifier<Object> {
  final database = MyDatabaseInstance.getInstance();

  GroupNotifier() : super([]);

  Future<List<GroupData>> getAllGroups() async {
    List<GroupData> allItems = await database.select(database.group).get();
    return allItems;
  }
}

final appDatabaseProvider = StateNotifierProvider<GroupNotifier, Object>((ref) {
  return GroupNotifier();
});
