import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/utils/classes/export_classes.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart' as path;

Future export(GroupExport group) async {
  // Créer un répertoire temporaire pour l'export
  Directory tempDir = await Directory.systemTemp.createTemp('export_package');

  // Créer les dossiers pour les médias
  Directory imagesDir =
      await Directory(path.join(tempDir.path, 'images')).create();
  Directory audioDir =
      await Directory(path.join(tempDir.path, 'audio')).create();
  Directory videoDir =
      await Directory(path.join(tempDir.path, 'video')).create();

  // Copier les médias dans les dossiers appropriés
  // Vous devrez adapter cela en fonction de votre modèle de données
  // et de la manière dont vous stockez les chemins vers les médias.

  var cards = [];

  for (var card in cards) {
    // Copier les images, audio, vidéo vers les dossiers correspondants
  }

  // Créer des fichiers JSON pour les paquets, sous-paquets, cartes, etc.
  // Ces fichiers JSON devront contenir les métadonnées nécessaires.

  // Créer l'archive ZIP
  String zipFilePath = '${tempDir.path}/deck.tar';
  Archive archive = Archive();

  // Ajouter les fichiers JSON à l'archive
  // Ajouter les dossiers de médias à l'archive
  // Vous devrez adapter cela en fonction de votre structure de données.
  // Assurez-vous d'ajouter tous les fichiers et dossiers nécessaires.

  Directory sourceDirectory = Directory("sourceDir");
  List<FileSystemEntity> entities = sourceDirectory.listSync();

  List<int> fileContent = File("aPath").readAsBytesSync();
  ArchiveFile archiveFile =
      ArchiveFile("entityPath", fileContent.length, fileContent);
  archive.addFile(archiveFile);

  final tarData = TarEncoder().encode(archive);
  final tarBz2 = BZip2Encoder().encode(tarData);

  final fp = File(zipFilePath);
  fp.writeAsBytesSync(tarBz2);

  // Zip a directory to out.zip using the zipDirectory convenience method
  var encoder = ZipFileEncoder();
  await encoder.zipDirectoryAsync(Directory('out'), filename: 'out.zip');

  // Manually create a zip of a directory and individual files.
  encoder.create('out2.zip');
  encoder.addDirectory(Directory('out'));
  encoder.addFile(File('test.zip'));
  encoder.close();

  // Nettoyer les fichiers temporaires
  await tempDir.delete(recursive: true);

  print('Package exported successfully to: $zipFilePath');
}

Future<GroupExport> recursiveGroupDiscovery(GroupData deck) async {
  
  var db = MyDatabaseInstance.getInstance();
  List<GroupData> childrenGroups = await (db.select(db.group)..where((tbl) => tbl.parentId.equals(deck.id))).get();
  List<GroupExport> childGroups = [];
  for(var childGroup in childrenGroups){
    childGroups.add(await recursiveGroupDiscovery(childGroup));
  }
  List<ReviseCard> cards = await (db.select(db.reviseCards)..where((tbl) => tbl.groupId.equals(deck.id))).get();
  List<CardExport> cardExports = [];

  for(var card in cards){
    HTMLContent rectoContent = await (db.select(db.hTMLContents)
                              ..where((tbl) => tbl.id.equals(card.recto))).getSingle();
    HTMLContent versoContent = await (db.select(db.hTMLContents)
                              ..where((tbl) => tbl.id.equals(card.verso))).getSingle();
    
    CardExport cardExport = CardExport(
      recto: HTMLContentExport(rectoContent.content, []), 
      verso: HTMLContentExport(versoContent.content, []));
    cardExports.add(cardExport);
  }

  return GroupExport(deck.title, childGroups, cardExports);
}

