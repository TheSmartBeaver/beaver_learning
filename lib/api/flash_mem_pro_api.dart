import 'dart:io';
import 'package:beaver_learning/data/constants.dart';
import 'package:beaver_learning/generated_code/flash_mem_pro_api.swagger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/io_client.dart';

class CustomClient extends http.BaseClient {
  final http.Client _inner;

  CustomClient(this._inner);

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    String? token = null;

    // Ajouter le header 'Authorization' à chaque requête.
    try {
      token = await FirebaseAuth.instance.currentUser?.getIdToken();
    } on Exception catch (e) {
      // Ce cas arrive quand on fait une requête sans authent Firebase. Cela devrait-il arriver ??
    }

    if (token != null) {
      request.headers['Authorization'] = token;
    }

    //return _inner.send(request);
    try {
      final response = await _inner.send(request);

      // if (response.statusCode != 200) {
      //   final exceptionMessage =
      //       'Erreur HTTP ${response.statusCode}: ${response.reasonPhrase}';
      //   print('Exception: $exceptionMessage');
      //   var response2 = await http.Response.fromStream(response);
      //   print('response 2: ${response2.body}');
      //   print('Stack trace: ${StackTrace.current}');
      // }
      return response;
    } catch (e) {
      print('Erreur lors de la requête : $e');
      throw e;
    }
  }
}

SecurityContext securityContext = SecurityContext.defaultContext;
//securityContext.setTrustedCertificates('path/to/certificate.pem');
HttpClient httpClient = HttpClient(context: securityContext)
  ..badCertificateCallback = //TODO: A ne surtout pas passé en Prod !!!
      (X509Certificate cert, String host, int port) => true;
http.Client client = CustomClient(IOClient(httpClient));

final fmpApi = FlashMemProApi.create(
    baseUrl: Uri.https(AppConstante().ApiUrl),
    httpClient: client); // pour android
    //baseUrl: Uri.https("localhost:7299"),
    //httpClient: client);