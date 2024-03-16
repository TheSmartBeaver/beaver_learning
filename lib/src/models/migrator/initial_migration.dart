import 'dart:async';

import 'package:beaver_learning/src/models/db/cardTable.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/enum/card_displayer_type.dart';
import 'package:drift/drift.dart';

class DatabasesBatchInfos {
  final $GroupTable group;
  final $ReviseCardsTable reviseCards;
  final $ImagesTable images;
  final $CoursesTable courses;
  final $TopicsTable topics;
  final $FileContentsTable fileContents;
  final $HTMLContentsTable hTMLContents;
  final $HTMLContentFilesTable hTMLContentFiles;

  DatabasesBatchInfos(this.group, this.reviseCards, this.images, this.courses, this.topics, this.fileContents, this.hTMLContents, this.hTMLContentFiles);
}

Future<void> initial_migrate_batch(Batch batch, DatabasesBatchInfos dbInfos) async {
          batch.insertAll(dbInfos.courses, [
            CoursesCompanion.insert(id: const Value(1),title: 'Cours d\'Anglais ultime', description: 'Un cours d\'anglais pour les débutants avec des leçons de grammaire, de vocabulaire et de prononciation.', imageUrl: 'https://img.pixers.pics/pho_wat(s3:700/FO/40/70/37/94/700_FO40703794_f3c68522bf4a853d282896173902b992.jpg,450,700,cms:2018/10/5bd1b6b8d04b8_220x50-watermark.png,over,230,650,jpg)/coussins-decoratifs-drapeau-anglais-big-ben-verticale.jpg.jpg'),
          ]);

          batch.insertAll(dbInfos.topics, [
            TopicsCompanion.insert(id: const Value(1),title: 'Les bases de l\'anglais', parentCourseId: 1, groupId: const Value(1)),
            TopicsCompanion.insert(id: const Value(2),title: 'Les verbes irréguliers', parentCourseId: 1, parentId: const Value(1), groupId: const Value(2)),
            TopicsCompanion.insert(id: const Value(3),title: 'Les temps en anglais', parentCourseId: 1, parentId: const Value(1)),
            TopicsCompanion.insert(id: const Value(4),title: 'Le passé', parentCourseId: 1, parentId: const Value(3)),
            TopicsCompanion.insert(id: const Value(5),title: 'Le futur', parentCourseId: 1, parentId: const Value(3)),
            TopicsCompanion.insert(id: const Value(6),title: 'Le verbe être', parentCourseId: 1, parentId: const Value(2)),
            TopicsCompanion.insert(id: const Value(7),title: 'Pour aller plus loin', parentCourseId: 1, ),
            TopicsCompanion.insert(id: const Value(8),title: 'Rencontre des anglais sur VibeScopy', parentCourseId: 1, parentId: const Value(7)),
          ]);

          batch.insertAll(dbInfos.group, [
            GroupCompanion.insert(id: const Value(1),title: 'Bases anglais', tags: ''),
            GroupCompanion.insert(id: const Value(2),title: 'Les verbes irréguliers', tags: '', parentId: const Value(1)),
          ]);

          batch.insertAll(dbInfos.reviseCards, [
            ReviseCardsCompanion.insert(groupId: 1, recto: 'test', verso: 'ahhahaha', tags: '', displayerType: CardDisplayerType.queelEditor, nextRevisionDateMultiplicator: 0.2),
            ReviseCardsCompanion.insert(groupId: 1, recto: 'chien', verso: 'dog', tags: '', displayerType: CardDisplayerType.html, nextRevisionDateMultiplicator: 0.2),
            ReviseCardsCompanion.insert(groupId: 1, recto: 'chat', verso: 'cat', tags: '', displayerType: CardDisplayerType.html, nextRevisionDateMultiplicator: 0.2),
            ReviseCardsCompanion.insert(groupId: 1, recto: 'cuisine', verso: 'kitchen', tags: '', displayerType: CardDisplayerType.html, nextRevisionDateMultiplicator: 0.2),
            ReviseCardsCompanion.insert(groupId: 2, recto: 'devenir', verso: 'become\nbecame\nbecome', tags: '', displayerType: CardDisplayerType.html, nextRevisionDateMultiplicator: 0.2),
            ReviseCardsCompanion.insert(groupId: 2, recto: 'partir', verso: 'leave\nleft\nleft', tags: '', displayerType: CardDisplayerType.html, nextRevisionDateMultiplicator: 0.2)
          ]);

          // batch.insertAll(dbInfos.fileContents, [
          //   FileContentsCompanion.insert(name: name, format: format, content: content)
          // ]);

          // batch.insertAll(dbInfos.hTMLContents, [
          //   HTMLContentsCompanion.insert(name: name, content: content)
          // ]);

          // batch.insertAll(dbInfos.hTMLContentFiles, [
          //   HTMLContentFilesCompanion.insert(fileId: fileId, htmlContentParentId: htmlContentParentId)
          // ]);
}