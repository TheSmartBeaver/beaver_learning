import 'package:beaver_learning/src/models/db/courseTable.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/user_app.dart';
import 'package:beaver_learning/src/utils/cards_functions.dart';
import 'package:drift/drift.dart';

part 'user_app_dao.g.dart';

@DriftAccessor(tables: [UserApp])
class UserAppDao extends DatabaseAccessor<AppDatabase> with _$UserAppDaoMixin {
  final AppDatabase db;

  UserAppDao(this.db) : super(db);

  Future<int> create(UserAppCompanion userAppCompanion) async {
    var userAppId = await database.into(database.userApp).insert(userAppCompanion);
    return userAppId;
  }

  Future updateById(int id, UserAppCompanion userAppCompanion) {
    return (update(userApp)..where((t) => t.id.equals(id)))
        .write(userAppCompanion);
  }

  Future<UserAppData?> getById(int id) async {
    var entity = await ((select(userApp)..where((t) => t.id.equals(id)))
        .getSingleOrNull());
    return entity;
  }

  Future<bool> isUserAlreadyRegistered(String fbId) async {
    var user = await (select(userApp)..where((t) => t.fbId.equals(fbId))).getSingleOrNull();
    return user != null;
  }
}
