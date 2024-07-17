import 'dart:typed_data';

import 'package:beaver_learning/src/utils/classes/export_classes.dart';

class EntityNature {
  final ExportType type;
  final String path;
  Uint8List? bytes;

  String get name => path.split('/').last;

  EntityNature(this.path, this.type, {this.bytes});
}