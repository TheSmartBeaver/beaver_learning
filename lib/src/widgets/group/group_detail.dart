import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:beaver_learning/data/constants.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/widgets/card/card_list.dart';
import 'package:beaver_learning/src/widgets/group/group_list.dart';
import 'package:beaver_learning/src/widgets/reviser/reviser.dart';
import 'package:beaver_learning/src/widgets/shared/app_bar.dart';
import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/form-tools/form-styles.dart';
import 'package:flutter/material.dart';
import 'package:archive/archive.dart';
import 'package:path/path.dart' as path;

class GroupDetail extends StatefulWidget {
  final String title = AppConstante.AppTitle;
  final GroupData group;
  const GroupDetail({Key? key, required this.group}) : super(key: key);

  @override
  _GroupDetailState createState() => _GroupDetailState();
}

class _GroupDetailState extends State<GroupDetail> {
  late List<GroupData> groups;

  init() async {
    final database = MyDatabaseInstance.getInstance();
    groups = await (database.select(database.group)
          ..where((group) => group.parentId.equals(widget.group.id)))
        .get();
  }

  Future<void> export() async {
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
    String zipFilePath = '${tempDir.path}/deck_${widget.group.id}.tar';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: widget.title,
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: Column(
          children: [
            Text(widget.group.title, style: const TextStyle(fontSize: 24)),
            ElevatedButton(
                onPressed: () async {
                  final database = MyDatabaseInstance.getInstance();
                  var cards = await (database.select(database.reviseCards)
                        ..where((card) => card.groupId.equals(widget.group.id)))
                      .get();

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => RevisorDisplayer(initialcards: cards),
                    ),
                  );
                },
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.lightGreen)),
                child: const Text("Revise cards",
                    style: TextStyle(color: Colors.black))),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => CardList(initialGroup: widget.group),
                    ),
                  );
                },
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.redAccent)),
                child: const Text("View cards",
                    style: TextStyle(color: Colors.black))),
            ElevatedButton(
                onPressed: export,
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.purple)),
                child: const Text("View cards",
                    style: TextStyle(color: Colors.black))),
            FutureBuilder(
                future: init(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Affichez un indicateur de chargement ou une vue de chargement tant que les opérations asynchrones ne sont pas terminées.
                    return const CircularProgressIndicator();
                  } else {
                    return Container(
                        margin: const EdgeInsets.all(4),
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: containerWithLabel(
                            label: "Child groups",
                            body: GroupList(groups: groups)));
                  }
                })
          ],
        ),
        drawer: const AppDrawer());
  }
}
