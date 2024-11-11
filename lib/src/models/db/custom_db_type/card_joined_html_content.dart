import 'package:beaver_learning/src/models/db/database.dart';

class ReviseCardJoinHtmlContentResult {
  final dynamic data;

  ReviseCardJoinHtmlContentResult({required this.data});

  // factory ReviseCardJoinHtmlContentResult.fromData2(Map<String, dynamic> data) {
  //   return ReviseCardJoinHtmlContentResult(
  //     id: data['id'] as int,
  //     name: data['name'] as String,
  //   );
  // }

  int getReviseCardId(Map<String, dynamic> data) {
    return data['id'];
  }
}