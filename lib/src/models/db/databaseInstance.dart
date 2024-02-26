import 'package:beaver_learning/src/models/db/database.dart';

class MyDatabaseInstance {
  // Instance unique de la classe
  static AppDatabase _instance = AppDatabase();

  // Méthode statique pour récupérer l'instance unique
  static AppDatabase getInstance() {
    return _instance;
  }
}
