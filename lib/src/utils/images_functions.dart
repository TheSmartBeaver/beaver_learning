import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_static/shelf_static.dart';

Future<File> downloadAndSaveImage(String url, String filename) async {
  final directory = await getApplicationDocumentsDirectory();
  final path = '${directory.path}/$filename';
  final dio = Dio();
  await dio.download(url, path);
  return File(path);
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
  final directory = await getApplicationDocumentsDirectory();
  final handler = createStaticHandler(directory.path);

  final server = await io.serve(handler, 'localhost', 0);
  return ServerProps('http://${server.address.host}:${server.port}', server);
}

Future<File> copyImageToServerDirectory(String imagePath, String filename) async {
  final directory = await getApplicationDocumentsDirectory();
  final path = '${directory.path}/$filename';
  final imageFile = File(imagePath);
  return imageFile.copy(path);
}

Future<File> writeHtmlToServerDirectory(String html, String filename) async {
  final directory = await getApplicationDocumentsDirectory();
  final path = '${directory.path}/$filename';
  final htmlFile = File(path);
  return htmlFile.writeAsString(html);
}