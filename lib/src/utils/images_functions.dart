import 'dart:io';
import 'dart:typed_data';
import 'package:beaver_learning/src/dao/html_dao.dart';
import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/htmlContentFilesTable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_static/shelf_static.dart';

Future<File> downloadAndSaveImage(String url, String filename) async {
  final directory = await getTemporaryDirectory();
  final path = '${directory.path}/$filename';
  final dio = Dio();
  await dio.download(url, path);
  return File(path);
}

Future<Uint8List> downloadImageBytes(String url, String filename) async {
  final directory = await getTemporaryDirectory();
  final path = '${directory.path}/$filename';
  final dio = Dio();
  await dio.download(url, path);
  var file = File(path);
  Uint8List fileBytes = await file.readAsBytes();
  return fileBytes;
}

class ServerProps {
  final String url;
  final HttpServer server;
  ServerProps(this.url, this.server);
}

class MyLocalServer {
  static ServerProps? serverprops;

  static Future<String> getLocalServerUrl() async {
    serverprops ??= await startLocalHttpServer();
    return serverprops!.url;
  }
}

Future<ServerProps> startLocalHttpServer() async {
  //TODO: SHIT TEST pour voir des fichiers localement à partir d'un serveur
  final directory = await getTemporaryDirectory();
  final handler = createStaticHandler(directory.path);

  final server = await io.serve(handler, 'localhost', 0);
  return ServerProps('http://${server.address.host}:${server.port}', server);
}

Future<File> copyImageToServerDirectory(
    String imagePath, String filename) async {
  final directory = await getTemporaryDirectory();
  final path = '${directory.path}/$filename';
  final imageFile = File(imagePath);
  return imageFile.copy(path);
}

Future<File> copyImageToServerDirectory2(File fileToCopy, String filename) async {
  final directory = await getTemporaryDirectory();
  final path = '${directory.path}/$filename';
  return fileToCopy.copySync(path);
}

Future<File> writeHtmlToServerDirectory(String html, String filename, List<FileContent> fileContents) async {
  final directory = await getTemporaryDirectory();
  final path = '${directory.path}/$filename';
  final htmlFile = File(path);

  for(FileContent fileContent in fileContents) {
    await writeFileContentToFile(fileContent, directory);
  }

  return htmlFile.writeAsString(html);
}

Future<void> writeFileContentToFile(FileContent fileContent, Directory directory) async {
  File file = await File('${directory.path}/${fileContent.name}.${fileContent.format}').create();
  file.writeAsBytesSync(fileContent.content);
}

Future<void> cleanDirectory(Directory directory) async {
  if (await directory.exists()) {
    await directory.delete(recursive: true);
  }
}

//Liste tous les fichiers du répertoire
Future<List<FileSystemEntity>> listFiles(Directory directory) async {
  List<FileSystemEntity> files = [];
  await for (FileSystemEntity entity in directory.list()) {
    files.add(entity);
  }
  return files;
}

//Supprime tous les fichiers du répertoire
Future<void> deleteFiles(Directory directory) async {
  try {
    await for (FileSystemEntity entity in directory.list()) {
      if (entity is File) {
        await entity.delete();
      }
    }
  } catch (e) {
    print(e);
  }
}