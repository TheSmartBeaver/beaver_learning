import 'dart:io';

import 'package:beaver_learning/src/dao/image_dao.dart';
import 'package:beaver_learning/src/models/db/cardTable.dart';
import 'package:beaver_learning/src/models/db/courseTable.dart';
import 'package:beaver_learning/src/models/db/fileContentsTable.dart';
import 'package:beaver_learning/src/models/db/groupTable.dart';
import 'package:beaver_learning/src/models/db/htmlContentFilesTable.dart';
import 'package:beaver_learning/src/models/db/htmlContentTable.dart';
import 'package:beaver_learning/src/models/db/image_table.dart';
import 'package:beaver_learning/src/models/db/topicTable.dart';
import 'package:beaver_learning/src/models/enum/card_displayer_type.dart';
import 'package:beaver_learning/src/models/migrator/initial_migration.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  ReviseCards,
  Group,
  Images,
  Courses,
  FileContents,
  HTMLContents,
  HTMLContentFiles,
  Topics
], views: [], daos: [
  ImageDao
])

class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();

        //Add a bunch of default items in a batch
        await batch((b) async {
          DatabasesBatchInfos dbInfos = DatabasesBatchInfos(group, reviseCards, images, courses, topics, fileContents, hTMLContents, hTMLContentFiles);
          await initial_migrate_batch(b, dbInfos);
        });
      },
      onUpgrade: (migrator, from, to) async {
          if (from < 4) {
            await migrator.addColumn(
              reviseCards,
              reviseCards.mnemotechnicHint,
            );
          }
        },
    );
  }

  // The TodoItem class has been generated by drift, based on the TodoItems
  // table description.
  //
  // In drift, queries can be watched by using .watch() in the end.
  // For more information on queries, see https://drift.simonbinder.eu/docs/getting-started/writing_queries/
  //Stream<List<TodoItem>> get allItems => select(todoItems).watch();
}

deleteFile(File file) {
  try {
    if (file.existsSync()) {
      file.deleteSync(); // Supprimez le fichier de manière synchrone.
      print('Le fichier a été supprimé avec succès.');
    } else {
      print('Le fichier n\'existe pas.');
    }
  } catch (e) {
    print('Une erreur s\'est produite lors de la suppression du fichier : $e');
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    var file = File(p.join(dbFolder.path, 'db.sqlite'));
    deleteFile(file);
    file = File(p.join(dbFolder.path, 'db.sqlite'));

    // Also work around limitations on old Android versions
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    // Make sqlite3 pick a more suitable location for temporary files - the
    // one from the system may be inaccessible due to sandboxing.
    final cachebase = (await getTemporaryDirectory()).path;
    // We can't access /tmp on Android, which sqlite3 would try by default.
    // Explicitly tell it about the correct temporary directory.
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
