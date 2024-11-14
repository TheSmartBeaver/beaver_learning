import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:beaver_learning/data/constants.dart';
import 'package:beaver_learning/generated_code/flash_mem_pro_api.swagger.dart';
import 'package:beaver_learning/service-agent/appuser_service_agent.dart';
import 'package:beaver_learning/src/dao/assembly_category_dao.dart';
import 'package:beaver_learning/src/dao/card_dao.dart';
import 'package:beaver_learning/src/dao/card_template_dao.dart';
import 'package:beaver_learning/src/dao/course_dao.dart';
import 'package:beaver_learning/src/dao/file_content_dao.dart';
import 'package:beaver_learning/src/dao/group_dao.dart';
import 'package:beaver_learning/src/dao/html_dao.dart';
import 'package:beaver_learning/src/dao/topic_dao.dart';
import 'package:beaver_learning/src/dao/user_app_dao.dart';
import 'package:beaver_learning/src/models/db/assemblyCategoryAssemblyTable.dart';
import 'package:beaver_learning/src/models/db/database.dart' as db;
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/models/enum/card_displayer_type.dart';
import 'package:beaver_learning/src/providers/firebase_auth_provider.dart';
import 'package:beaver_learning/src/utils/cards_functions.dart';
import 'package:beaver_learning/src/utils/classes/helper_classes.dart';
import 'package:beaver_learning/src/utils/exception_functions.dart';
import 'package:beaver_learning/src/utils/synchronize_functions.dart';
import 'package:drift/drift.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SynchronizeManager {
  final List<Exception> errors = [];
  late User currentUser;
  final BuildContext context;
  final WidgetRef ref;

  SynchronizeManager(this.context, this.ref);

  Future<SynchronizeManager> init() async {
    if (await ref.read(authProvider.notifier).checkIfUserLogged()) {
      User? currentUser = ref.read(authProvider.notifier).user;
      if (currentUser != null) {
        this.currentUser = currentUser;
      } else {
        throw Exception("User not logged corrrectly");
      }
    } else {
      throw Exception("User not logged");
    }
    return this;
  }

  Future<void> synchronize() async {
    try {
      await _createSkuForEveryElementWithoutOne();
      await _synchronizeElementsTowardsServerUpdate();
      await synchronizeElementsTowardsMobileUpdate();
      await _setNewSynchronizationDate();
      DialogStatic.showInfoInDialog(context, "Synchronization done");
    } catch (e) {
      dealWithExceptionError(context, e);
    }
  }

  Future<void> _createSkuForEveryElementWithoutOne() async {
    try {
      final database = MyDatabaseInstance.getInstance();

      ElementsWithoutSkuDto entryDto = ElementsWithoutSkuDto(
          assemblyCategories: [],
          assemblyLinkedToAssembCateg: [],
          cardTemplates: [],
          cards: [],
          courses: [],
          fileContentLinkedToHtmlContents: [],
          htmlContents: [],
          fileContents: [],
          groups: [],
          topics: []);

      //sync fileContents
      for (db.FileContent dbEntity
          in await (database.select(database.fileContents)
                ..where((tbl) => tbl.sku.isNull()))
              .get()) {
        entryDto.fileContents?.add(CreateEntityForSkuDto(frontId: dbEntity.id));
      }

      //sync htmlContent

      for (var dbEntity in await (database.select(database.hTMLContents)
            ..where((tbl) =>
                tbl.sku.isNull() &
                generateNoPrivateItemsWhereClauseForHtmlContent(tbl)))
          .get()) {
        entryDto.htmlContents?.add(CreateEntityForSkuDto(frontId: dbEntity.id));
      }

      //sync card template

      for (var dbEntity in await (database.select(database.cardTemplate)
            ..where((tbl) => tbl.sku.isNull()))
          .get()) {
        entryDto.cardTemplates
            ?.add(CreateEntityForSkuDto(frontId: dbEntity.id));
      }

      //sync assembly categories

      for (var dbEntity in await (database.select(database.assemblyCategory)
            ..where((tbl) => tbl.sku.isNull()))
          .get()) {
        entryDto.assemblyCategories
            ?.add(CreateEntityForSkuDto(frontId: dbEntity.id));
      }

      //sync group

      for (var dbEntity in await (database.select(database.group)
            ..where((tbl) => tbl.sku.isNull()))
          .get()) {
        entryDto.groups?.add(CreateEntityForSkuDto(frontId: dbEntity.id));
      }

      //sync cards
      for (db.ReviseCard dbEntity in await (database
              .select(database.reviseCards)
            ..where((tbl) =>
                tbl.sku.isNull() & generateNoTemplatedPreviewWhereClause(tbl)))
          .get()) {
        entryDto.cards?.add(CreateEntityForSkuDto(frontId: dbEntity.id));
      }

      //sync courses

      for (var dbEntity in await (database.select(database.courses)
            ..where((tbl) => tbl.sku.isNull()))
          .get()) {
        entryDto.courses?.add(CreateEntityForSkuDto(frontId: dbEntity.id));
      }

      //sync topic

      for (var dbEntity in await (database.select(database.topics)
            ..where((tbl) => tbl.sku.isNull()))
          .get()) {
        entryDto.topics?.add(CreateEntityForSkuDto(frontId: dbEntity.id));
      }

      // APPEL API -----------------------------
      ElementsWithoutSkuDto resultDto = await AppUserServiceAgent(context)
          .createElementsWithMissingSku(entryDto);

      //sync fileContents
      FileContentDao fileContentDao = FileContentDao(database);
      for (var dto in resultDto.fileContents!) {
        await fileContentDao.updateById(
            dto.frontId!, db.FileContentsCompanion(sku: Value(dto.sku)));
      }

      //sync htmlContent
      var dao = HtmlDao(database);
      for (var dto in resultDto.htmlContents!) {
        await dao.updateById(
            dto.frontId!, db.HTMLContentsCompanion(sku: Value(dto.sku)));
      }

      //sync card template

      var daoCardTemplate = CardTemplateDao(database);
      for (var dto in resultDto.cardTemplates!) {
        await daoCardTemplate.updateById(
            dto.frontId!, db.CardTemplateCompanion(sku: Value(dto.sku)));
      }

      //sync assembly categories

      var assemblyCategoryDao = AssemblyCategoryDao(database);
      for (var dto in resultDto.assemblyCategories!) {
        await assemblyCategoryDao.updateById(
            dto.frontId!, db.AssemblyCategoryCompanion(sku: Value(dto.sku)));
      }

      //sync group

      var groupDao = GroupDao(database);
      for (var dto in resultDto.groups!) {
        await groupDao.updateById(
            dto.frontId!, db.GroupCompanion(sku: Value(dto.sku)));
      }

      //sync cards

      var cardDao = CardDao(database);
      for (var dto in resultDto.cards!) {
        await cardDao.updateById(
            dto.frontId!, db.ReviseCardsCompanion(sku: Value(dto.sku)));
      }

      //sync courses

      var courseDao = CourseDao(database);
      for (var dto in resultDto.courses!) {
        await courseDao.updateById(
            dto.frontId!, db.CoursesCompanion(sku: Value(dto.sku)));
      }

      //sync topic

      var topicDao = TopicDao(database);
      for (var dto in resultDto.topics!) {
        await topicDao.updateById(
            dto.frontId!, db.TopicsCompanion(sku: Value(dto.sku)));
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> _synchronizeElementsTowardsServerUpdate() async {
    try {
      DateTime lastUpdated = await _getLastMobileSynchronizationDate();

      //sync fileContents

      List<db.FileContent> fileContentsToSync =
          await (database.select(database.fileContents)
                ..where((x) => x.lastUpdated.isBiggerThanValue(lastUpdated)))
              .get();

      var fileContentsToSyncDto = fileContentsToSync
          .map((e) => FileContentSyncDto(
              content: base64Encode(e.content),
              format: e.format,
              lastUpdated: e.lastUpdated,
              sku: e.sku,
              name: e.name,
              isMine: true // Comment le définir ?
              ))
          .toList();

      //sync htmlContent

      List<db.HTMLContent> htmlContentsToSync =
          await (database.select(database.hTMLContents)
                ..where((x) =>
                    x.lastUpdated.isBiggerThanValue(lastUpdated) &
                    generateNoPrivateItemsWhereClauseForHtmlContent(x)))
              .get();

      var htmlContentsToSyncDto = htmlContentsToSync
          .map((e) => HtmlContentSyncDto(
              recto: e.recto,
              verso: e.verso,
              lastUpdated: e.lastUpdated,
              cardTemplatedJson: e.cardTemplatedJson,
              isAssembly: e.isAssembly,
              isTemplated: e.isTemplated,
              path: e.path,
              sku: e.sku,
              isMine: true // Comment le définir ?
              ))
          .toList();

      //sync fileContents belonging to htmlContent

      Map<String, List<String?>>? fileContentLinkedToHtmlContents = {};

      for (var e in htmlContentsToSync) {
        List<HTMLContentFile> htmlContentFilesToSync =
            await (database.select(database.hTMLContentFiles)
                  ..where((x) => x.htmlContentParentId.equals(e.id)))
                .get();
        String? htmlContentSKU = (await HtmlDao(database).getById(e.id))?.sku;
        if (htmlContentSKU != null) {
          fileContentLinkedToHtmlContents[htmlContentSKU] = [];
          for (var e in htmlContentFilesToSync) {
            fileContentLinkedToHtmlContents[htmlContentSKU]
                ?.add((await FileContentDao(database).getById(e.fileId))?.sku);
          }
        }
      }

      //sync card template

      List<db.CardTemplateData> cardTemplatesToSync =
          await (database.select(database.cardTemplate)
                ..where((x) =>
                    x.lastUpdated.isBiggerThanValue(lastUpdated) &
                    generateNoHiddenTemplateCardWhereClause(x)))
              .get();

      var cardTemplatesToSyncDto = cardTemplatesToSync
          .map((e) => CardTemplateSyncDto(
              path: e.path,
              template: e.template,
              lastUpdated: e.lastUpdated,
              sku: e.sku))
          .toList();

      //sync assembly categories

      List<db.AssemblyCategoryData> assemblyCategoriesToSync =
          await (database.select(database.assemblyCategory)
                ..where((x) => x.lastUpdated.isBiggerThanValue(lastUpdated)))
              .get();

      var assemblyCategoriesToSyncDto = assemblyCategoriesToSync
          .map((e) => AssemblyCategorySyncDto(
              path: e.path, lastUpdated: e.lastUpdated, sku: e.sku))
          .toList();

      //sync assemblies belonging to categories

      Map<String, List<String?>>? assemblyCategoryLinkedToAssembly = {};

      for (var e in assemblyCategoriesToSync) {
        List<db.AssemblyCategoryAssemblyData> assemblyCategoryAssembliesToSync =
            await (database.select(database.assemblyCategoryAssembly)
                  ..where((x) => x.assemblyCategoryId.equals(e.id)))
                .get();
        String? assemblyCategorySKU =
            (await AssemblyCategoryDao(database).getById(e.id))?.sku;
        if (assemblyCategorySKU != null) {
          assemblyCategoryLinkedToAssembly[assemblyCategorySKU] = [];
          for (var e in assemblyCategoryAssembliesToSync) {
            assemblyCategoryLinkedToAssembly[assemblyCategorySKU]
                ?.add((await HtmlDao(database).getById(e.assemblyId))?.sku);
          }
        }
      }

      //sync group

      List<db.GroupData> groupsToSync = await (database.select(database.group)
            ..where((x) => x.lastUpdated.isBiggerThanValue(lastUpdated)))
          .get();

      List<GroupSyncDto> groupsToSyncDto = [];
      for (var e in groupsToSync) {
        groupsToSyncDto.add(GroupSyncDto(
            parentSKU: (await GroupDao(database).getById(e.id))?.sku,
            path: e.path,
            sku: e.sku,
            tags: e.tags,
            title: e.title,
            lastUpdated: e.lastUpdated,
            isMine: true // Comment le définir ?
            ));
      }

      //sync cards

      List<db.ReviseCard> cardsToSync =
          await (database.select(database.reviseCards)
                ..where((x) =>
                    x.lastUpdated.isBiggerThanValue(lastUpdated) &
                    generateNoTemplatedPreviewWhereClause(x)))
              .get();

      List<CardSyncDto> cardsToSyncDto = [];
      for (var e in cardsToSync) {
        cardsToSyncDto.add(CardSyncDto(
            sku: e.sku,
            nextRevisionDate: e.nextRevisionDate?.toUtc(),
            tags: e.tags,
            nextRevisionDateMultiplicator: e.nextRevisionDateMultiplicator,
            groupSKU: (await GroupDao(database).getById(e.groupId))?.sku,
            htmlContentSKU:
                (await HtmlDao(database).getById(e.htmlContent))?.sku,
            path: e.path,
            lastUpdated: e.lastUpdated,
            isMine: true // Comment le définir ?
            ));
      }

      //sync courses

      List<db.Course> coursesToSync = await (database.select(database.courses)
            ..where((x) => x.lastUpdated.isBiggerThanValue(lastUpdated)))
          .get();

      List<CourseSyncDto> coursesToSyncDto = [];
      for (var e in coursesToSync) {
        coursesToSyncDto.add(CourseSyncDto(
          // rootTopicSKU: (await TopicDao(database).getRootTopicByCourseId(e.id))?.sku,
          description: e.description,
          imageUrl: e.imageUrl,
          sku: e.sku,
          title: e.title,
          lastUpdated: e.lastUpdated,
          isMine: true, // Comment le définir ?
        ));
      }

      //sync topic

      List<db.Topic> topicToSync = await (database.select(database.topics)
            ..where((x) => x.lastUpdated.isBiggerThanValue(lastUpdated)))
          .get();

      List<TopicSyncDto> topicsToSyncDto = [];
      for (var e in topicToSync) {
        var test = 0;
        topicsToSyncDto.add(TopicSyncDto(
            parentCourseSKU:
                (await CourseDao(database).getById(e.parentCourseId))?.sku,
            fileSKU: e.fileId != null
                ? (await FileContentDao(database).getById(e.fileId!))?.sku
                : null,
            groupSKU: e.groupId != null
                ? (await GroupDao(database).getById(e.groupId!))?.sku
                : null,
            parentSKU: e.parentId != null
                ? (await TopicDao(database).getById(e.parentId!))?.sku
                : null,
            htmlContentSKU: e.htmlContentId != null
                ? (await HtmlDao(database).getById(e.htmlContentId!))?.sku
                : null,
            path: e.path,
            sku: e.sku,
            title: e.title,
            lastUpdated: e.lastUpdated));
      }

      ElementsToSyncDto elementsToSyncDto = ElementsToSyncDto(
          assemblyCategories: assemblyCategoriesToSyncDto,
          assemblyLinkedToAssembCateg: assemblyCategoryLinkedToAssembly,
          cards: cardsToSyncDto,
          cardTemplates: cardTemplatesToSyncDto,
          courses: coursesToSyncDto,
          fileContents: fileContentsToSyncDto,
          groups: groupsToSyncDto,
          htmlContents: htmlContentsToSyncDto,
          fileContentLinkedToHtmlContents: fileContentLinkedToHtmlContents,
          topics: topicsToSyncDto);

      var resultDto = await AppUserServiceAgent(context)
          .synchronizeElementsTowardsServerUpdate(elementsToSyncDto);
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> synchronizeElementsTowardsMobileUpdate() async {
    DateTime lastUpdated = await _getLastMobileSynchronizationDate();

    ElementsToSyncDto resultDto = await AppUserServiceAgent(context)
        .synchronizeElementsTowardsMobileUpdate(lastUpdated);

    //sync fileContents
    FileContentDao fileContentDao = FileContentDao(database);
    for (var dto in resultDto.fileContents!) {
      await fileContentDao.insertOrUpdateBySku(
          dto.sku!,
          db.FileContentsCompanion(
              sku: Value(dto.sku),
              content: Value(base64Decode(dto.content ?? "")),
              format: Value(dto.format ?? ""),
              name: Value(dto.name ?? ""),
              path: Value(dto.path ?? ""),
              lastUpdated: Value(getUpdateDateNow())));
    }

    //sync htmlContent
    var htmlDao = HtmlDao(database);
    for (var dto in resultDto.htmlContents!) {
      await htmlDao.insertOrUpdateBySku(
          dto.sku!,
          db.HTMLContentsCompanion(
              sku: Value(dto.sku),
              cardTemplatedJson: Value(dto.cardTemplatedJson ?? ""),
              isAssembly: Value(dto.isAssembly ?? false),
              isTemplated: Value(dto.isTemplated ?? false),
              lastUpdated: Value(getUpdateDateNow()),
              path: Value(dto.path ?? ""),
              recto: Value(dto.recto ?? ""),
              verso: Value(dto.verso ?? "")));
    }

    //sync fileContents belonging to htmlContent
    for (var dto in resultDto.fileContentLinkedToHtmlContents!.entries) {
      HTMLContent? htmlContent = await htmlDao.getBySku(dto.key);
      if (htmlContent != null) {
        for (String fileSKU in dto.value) {
          FileContent? file = await fileContentDao.getBySku(fileSKU);
          if (file != null) {
            await htmlDao.createHtmlContentFileContent(htmlContent.id, file.id);
          }
        }
      }
    }

    //sync card template

    var daoCardTemplate = CardTemplateDao(database);
    for (var dto in resultDto.cardTemplates!) {
      await daoCardTemplate.insertOrUpdateBySku(
          dto.sku!,
          db.CardTemplateCompanion(
              sku: Value(dto.sku),
              path: Value(dto.path ?? ""),
              template: Value(dto.template ?? ""),
              lastUpdated: Value(getUpdateDateNow())));
    }

    //sync assembly categories

    var assemblyCategoryDao = AssemblyCategoryDao(database);
    for (var dto in resultDto.assemblyCategories!) {
      await assemblyCategoryDao.insertOrUpdateBySku(
          dto.sku!,
          db.AssemblyCategoryCompanion(
              sku: Value(dto.sku),
              path: Value(dto.path ?? ""),
              lastUpdated: Value(getUpdateDateNow())));
    }

    //sync assemblies belonging to categories

    //

    //sync group

    var groupDao = GroupDao(database);
    for (var dto in resultDto.groups!) {
      await groupDao.insertOrUpdateBySku(
          dto.sku!,
          db.GroupCompanion(
            sku: Value(dto.sku),
            path: Value(dto.path ?? ""),
            tags: Value(dto.tags ?? ""),
            title: Value(dto.title ?? ""),
            lastUpdated: Value(getUpdateDateNow()),
            parentId: Value((await groupDao.getBySku(dto.parentSKU ?? ""))?.id),
          ));
    }

    //sync cards

    var cardDao = CardDao(database);
    for (var dto in resultDto.cards!) {
      await cardDao.insertOrUpdateBySku(
          dto.sku!,
          db.ReviseCardsCompanion(
              sku: Value(dto.sku),
              displayerType: const Value(CardDisplayerType.html),
              groupId: Value(
                  (await groupDao.getBySku(dto.groupSKU ?? ""))?.id ?? -123),
              htmlContent: Value(
                  (await htmlDao.getBySku(dto.htmlContentSKU ?? ""))?.id ??
                      -132),
              mnemotechnicHint: Value(dto.mnemotechnicHint ?? ""),
              nextRevisionDate: Value(dto.nextRevisionDate),
              nextRevisionDateMultiplicator:
                  Value(dto.nextRevisionDateMultiplicator ?? 0.2),
              path: Value(dto.path ?? ""),
              tags: Value(dto.tags ?? ""),
              lastUpdated: Value(getUpdateDateNow())));
    }

    //sync courses

    var courseDao = CourseDao(database);
    for (var dto in resultDto.courses!) {
      await courseDao.insertOrUpdateBySku(
          dto.sku!,
          db.CoursesCompanion(
              sku: Value(dto.sku),
              description: Value(dto.description ?? ""),
              imageUrl: Value(dto.imageUrl ?? ""),
              title: Value(dto.title ?? ""),
              lastUpdated: Value(getUpdateDateNow())));
    }

    //sync topic

    var topicDao = TopicDao(database);
    for (var dto in resultDto.topics!) {
      await topicDao.insertOrUpdateBySku(
          dto.sku!,
          db.TopicsCompanion(
              sku: Value(dto.sku),
              fileId:
                  Value((await fileContentDao.getBySku(dto.fileSKU ?? ""))?.id),
              groupId: Value((await groupDao.getBySku(dto.groupSKU ?? ""))?.id),
              htmlContentId:
                  Value((await htmlDao.getBySku(dto.htmlContentSKU ?? ""))?.id),
              parentCourseId: Value(
                  (await courseDao.getBySku(dto.parentCourseSKU ?? ""))?.id ??
                      -1),
              parentId:
                  Value((await topicDao.getBySku(dto.parentSKU ?? ""))?.id),
              path: Value(dto.path ?? ""),
              title: Value(dto.title ?? ""),
              lastUpdated: Value(getUpdateDateNow())));
    }
  }

  Future<DateTime> _getLastMobileSynchronizationDate() async {
    final database = MyDatabaseInstance.getInstance();
    //TODO: Faux chercher sur le serveur
    UserAppData user = await (database.select(database.userApp)
          ..where((tbl) => tbl.fbId.equals(currentUser.uid)))
        .getSingle();

    DateTime? lastUpdated = user.lastUpdated;

    // DateTime lastUpdated =
    //     await AppUserServiceAgent(context).getLastServerUserSyncDate();

    return lastUpdated ?? DateTime.fromMicrosecondsSinceEpoch(0);
  }

  Future<void> _setNewSynchronizationDate() async {
    DateTime new_sync_date = getUpdateDateNow();
    final database = MyDatabaseInstance.getInstance();

    await (database.update(database.userApp)
          ..where((tbl) => tbl.fbId.equals(currentUser.uid)))
        .write(UserAppCompanion(lastUpdated: Value(new_sync_date)));

    await AppUserServiceAgent(context).setLastServerUserSyncDate();
  }
}
