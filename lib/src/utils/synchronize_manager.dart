import 'package:beaver_learning/service-agent/appuser_service_agent.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/providers/firebase_auth_provider.dart';
import 'package:beaver_learning/src/utils/cards_functions.dart';
import 'package:drift/drift.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';

class SynchronizeManager {
  final List<Exception> errors = [];
  late User currentUser;
  final BuildContext context;
  final WidgetRef ref;

  SynchronizeManager(this.context, this.ref) {
    if (ref.read(authProvider.notifier).checkIfUserLogged()) {
      User? currentUser = ref.read(authProvider.notifier).user;
      if (currentUser != null) {
        this.currentUser = currentUser;
      } else {
        throw Exception("User not logged corrrectly");
      }
    } else {
      throw Exception("User not logged");
    }
  }

  Future<void> createSkuForEveryElementWithoutOne() async {
    try {
      final database = MyDatabaseInstance.getInstance();
      final List<ReviseCard> cardsWithoutSku = await (database.select(database.reviseCards)
            ..where((tbl) => tbl.sku.isNull()))
          .get();

      for (ReviseCard card in cardsWithoutSku) {
        // card.sku = generateSku();
        // await database.update(database.reviseCards).replace(card);
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> synchronize() async {
    try {
      DateTime lastUpdated = await getLastSynchronizationDate();

      List<AssemblyCategoryData> assemblyCategoriesToSync =
          await (database.select(database.assemblyCategory)
                ..where((x) => x.lastUpdated.isBiggerThanValue(lastUpdated)))
              .get();

      List<ReviseCard> assemblyCardsToSync =
          await (database.select(database.reviseCards)
                ..where((x) => x.lastUpdated.isBiggerThanValue(lastUpdated)))
              .get();

      List<CardTemplateData> assemblyCardTemplatesToSync =
          await (database.select(database.cardTemplate)
                ..where((x) => x.lastUpdated.isBiggerThanValue(lastUpdated)))
              .get();

      
    } catch (e) {
      throw e;
    }
  }

  Future<DateTime> getLastSynchronizationDate() async {
    // final database = MyDatabaseInstance.getInstance();
    // //TODO: Faux chercher sur le serveur
    // UserAppData user = await (database.select(database.userApp)
    //       ..where((tbl) => tbl.fbId.equals(currentUser.uid)))
    //     .getSingle();
    
    //DateTime lastUpdated = user.lastUpdated;

    DateTime lastUpdated = await AppUserServiceAgent(context).getLastUserSyncDate();

    return lastUpdated;
  }
}
