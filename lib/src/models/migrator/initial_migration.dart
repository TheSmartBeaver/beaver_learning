import 'dart:async';

import 'package:beaver_learning/data/constants.dart';
import 'package:beaver_learning/src/models/data/test_data.dart';
import 'package:beaver_learning/src/models/db/cardTable.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/enum/card_displayer_type.dart';
import 'package:beaver_learning/src/utils/images_functions.dart';
import 'package:beaver_learning/src/utils/synchronize_functions.dart';
import 'package:drift/drift.dart';

Future<void> initial_migrate_batch(Batch batch, AppDatabase dbInfos) async {
  var last_updated = getUpdateDateNow();

  // batch.insertAll(dbInfos.courses, [
  //   CoursesCompanion.insert(
  //       id: const Value(1),
  //       // sku: "ULTIMATE_ENGLISH_COURSE",
  //       title: 'Cours d\'Anglais ultime',
  //       description:
  //           'Un cours d\'anglais pour les débutants avec des leçons de grammaire, de vocabulaire et de prononciation.',
  //       imageUrl:
  //           'https://img.pixers.pics/pho_wat(s3:700/FO/40/70/37/94/700_FO40703794_f3c68522bf4a853d282896173902b992.jpg,450,700,cms:2018/10/5bd1b6b8d04b8_220x50-watermark.png,over,230,650,jpg)/coussins-decoratifs-drapeau-anglais-big-ben-verticale.jpg.jpg',
  //       lastUpdated: last_updated),
  // ]);

  // batch.insertAll(dbInfos.topics, [
  //   TopicsCompanion.insert(
  //       id: const Value(1),
  //       path: const Value("gtfredfrtgrfeyujij"),
  //       title: 'Les bases de l\'anglais',
  //       parentCourseId: 1,
  //       groupId: const Value(1),
  //       lastUpdated: last_updated),
  //   TopicsCompanion.insert(
  //       id: const Value(2),
  //       path: const Value('rtfedzsefrtf'),
  //       title: 'Les verbes irréguliers',
  //       parentCourseId: 1,
  //       parentId: const Value(1),
  //       groupId: const Value(2),
  //       lastUpdated: last_updated),
  //   TopicsCompanion.insert(
  //       id: const Value(3),
  //       path: const Value("rfdrfedztgfrgvfe"),
  //       title: 'Les temps en anglais',
  //       parentCourseId: 1,
  //       parentId: const Value(1),
  //       lastUpdated: last_updated),
  //   TopicsCompanion.insert(
  //       id: const Value(4),
  //       path: const Value("tgrfedzsqdfrgbthyu"),
  //       title: 'Le passé',
  //       parentCourseId: 1,
  //       parentId: const Value(3),
  //       lastUpdated: last_updated),
  //   TopicsCompanion.insert(
  //       id: const Value(5),
  //       path: const Value("htgrfedzertyuyhyjuh"),
  //       title: 'Le futur',
  //       parentCourseId: 1,
  //       parentId: const Value(3),
  //       lastUpdated: last_updated),
  //   TopicsCompanion.insert(
  //       id: const Value(6),
  //       path: const Value("ytgrfedzsfrtgyhjuyhgr"),
  //       title: 'Le verbe être',
  //       parentCourseId: 1,
  //       parentId: const Value(2),
  //       lastUpdated: last_updated),
  //   TopicsCompanion.insert(
  //       id: const Value(7),
  //       path: const Value("hrgfetyhgreffrtytggrgt"),
  //       title: 'Pour aller plus loin',
  //       parentCourseId: 1,
  //       lastUpdated: last_updated),
  //   TopicsCompanion.insert(
  //       id: const Value(8),
  //       path: const Value("tgfdsrgbthnyuhghyjuijyh"),
  //       title: 'Rencontre des anglais sur VibeScopy',
  //       parentCourseId: 1,
  //       parentId: const Value(7),
  //       lastUpdated: last_updated),
  // ]);

  // batch.insertAll(dbInfos.group, [
  //   GroupCompanion.insert(
  //       id: const Value(1),
  //       path: const Value("tgfdgh§hytgzehyg"),
  //       title: 'Bases anglais',
  //       tags: '',
  //       lastUpdated: last_updated),
  //   GroupCompanion.insert(
  //       id: const Value(2),
  //       path: const Value("gfdsrgthyugtgferdszsd"),
  //       title: 'Les verbes irréguliers',
  //       tags: '',
  //       parentId: const Value(1),
  //       lastUpdated: last_updated),
  // ]);

  // batch.insertAll(dbInfos.hTMLContents, [
  //   HTMLContentsCompanion.insert(
  //       id: const Value(1), recto: 'chien', verso: 'dog'),
  //   HTMLContentsCompanion.insert(
  //       id: const Value(2), recto: 'devenir', verso: 'become\nbecame\nbecome'),
  //   //HTMLContentsCompanion.insert(id: const Value(), content: '')
  //   HTMLContentsCompanion.insert(
  //       id: const Value(3),
  //       recto: 'TEST IMAGE',
  //       verso:
  //           "<ul><li>Salut, le monde !</li><li>Parce qu'ils ont peur d'être \"développés\" par le soleil !</li><li><img width='600' height='400' src=\"batman2.png\" /></li></ul>"),
  //   HTMLContentsCompanion.insert(
  //       id: const Value(4),
  //       recto: '<div>TEST Spidey</div>',
  //       verso:
  //           "<div>Tisseur de toile</div><img width='600' height='400' src=\"spiderman.jpg\" />")
  // ]);
  // var image = await downloadImageBytes(
  //     "https://image.api.playstation.com/vulcan/img/rnd/202010/2621/H9v5o8vP6RKkQtR77LIGrGDE.png",
  //     "batman2");
  // var image2 = await downloadImageBytes(
  //     "https://media.gqmagazine.fr/photos/6571d7e79779b8a3415b0a9b/16:9/w_2240,c_limit/Tom-Holland-Spiderman-what-we-know-so-far.jpg",
  //     "spiderman");
  // batch.insertAll(dbInfos.fileContents, [
  //   FileContentsCompanion.insert(
  //       id: const Value(1), name: "batman2", format: "png", content: image),
  //   FileContentsCompanion.insert(
  //       id: const Value(2), name: "spiderman", format: "jpg", content: image2)
  // ]);

  // batch.insertAll(dbInfos.hTMLContentFiles, [
  //   HTMLContentFilesCompanion.insert(fileId: 1, htmlContentParentId: 3),
  //   HTMLContentFilesCompanion.insert(fileId: 2, htmlContentParentId: 4)
  // ]);

  // batch.insertAll(dbInfos.reviseCards, [
  //   ReviseCardsCompanion.insert(
  //       groupId: 1,
  //       htmlContent: 1,
  //       tags: '',
  //       displayerType: CardDisplayerType.html,
  //       nextRevisionDateMultiplicator: 0.2),
  //   ReviseCardsCompanion.insert(
  //       groupId: 2,
  //       htmlContent: 2,
  //       tags: '',
  //       displayerType: CardDisplayerType.html,
  //       nextRevisionDateMultiplicator: 0.2),
  //   ReviseCardsCompanion.insert(
  //       groupId: 2,
  //       htmlContent: 3,
  //       tags: '',
  //       displayerType: CardDisplayerType.html,
  //       nextRevisionDateMultiplicator: 0.2),
  //   ReviseCardsCompanion.insert(
  //       groupId: 1,
  //       htmlContent: 4,
  //       tags: '',
  //       displayerType: CardDisplayerType.html,
  //       nextRevisionDateMultiplicator: 0.2),
  //   ReviseCardsCompanion.insert(
  //       groupId: 1,
  //       htmlContent: 5,
  //       tags: '',
  //       displayerType: CardDisplayerType.html,
  //       nextRevisionDateMultiplicator: 0.2),
  // ]);

  batch.insertAll(dbInfos.cardTemplate, [
    CardTemplateCompanion.insert(
        id: const Value(1),
        path: emptyTemplate_name,
        // sku: "EMPTY_TEMPLATE",
        template: htmlEmptyTemplate,
        lastUpdated: last_updated)
  ]);

  batch.insertAll(dbInfos.hTMLContents, [
    HTMLContentsCompanion.insert( // Pour card preview Editor
        id: const Value(1),
        path: const Value(AppConstante.templatedPreviewNameKey),
        cardTemplatedJson: Value(previewCardJson),
        isTemplated: const Value(true),
        isAssembly: const Value(false),
        lastUpdated: last_updated),
    HTMLContentsCompanion.insert( // Pour assembly preview Editor
        id: const Value(2),
        path: const Value(AppConstante.templatedPreviewNameKey),
        cardTemplatedJson: Value(previewCardJson),
        isTemplated: const Value(true),
        isAssembly: const Value(true),
        lastUpdated: last_updated),
    // HTMLContentsCompanion.insert(
    //     id: const Value(3),
    //     path: const Value("myTestPath"),
    //     cardTemplatedJson: Value(completeJsonCardTest),
    //     isTemplated: const Value(true),
    //     isAssembly: const Value(true),
    //     lastUpdated: last_updated),
  ]);
  batch.insertAll(dbInfos.reviseCards, [
    ReviseCardsCompanion.insert(
        id: const Value(1),
        path: const Value(AppConstante.templatedPreviewNameKey),
        groupId: -1,
        htmlContent: 1,
        tags: '',
        displayerType: CardDisplayerType.html,
        nextRevisionDateMultiplicator: -1,
        lastUpdated: last_updated)
  ]);
}
